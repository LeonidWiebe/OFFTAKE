Attribute VB_Name = "mExcel"
Const C_HEADER As String = "HEADER"
Const C_FOOTER As String = "FOOTER"
Const C_AUTOGENAREA As String = "AUTOGENAREA"

Private ViewMode As Integer

Private Enum acEnum
    ScreenUpdating = 0
    Calculation = 1
    View = 2
    Events = 3
    PageBreaks = 4
    DisplayAlerts = 5
    DisplayStatusBar = 6
    BackgroundChecking = 7
    TextDate = 8
    last = 9
End Enum

'Константы Excel для варианта с поздним связыванием
'библиотеки Microsoft.Excel.ObjectLibrary 12.0
Public Enum ExcelEnum
    xlFormulas = -4123 '(&HFFFFEFE5)
    xlValues = -4163 '(&HFFFFEFBD)
    
    xlPart = 2
    XlReferenceStyle_xlA1 = 1
    
    xlDown = -4121 '(&HFFFFEFE7)
    xlToLeft = -4159 '(&HFFFFEFC1)
    xlToRight = -4161 '(&HFFFFEFBF)
    xlUp = -4162 '(&HFFFFEFBE)
    
    xlByRows = 1
    xlPrevious = 2
    xlCalculationManual = -4135
    xlNormalView = 1 '"Обычный" режим
End Enum

'ГЛАВНАЯ ФУНКЦИЯ ЭКСПОРТА
Public Sub exportExcel(Optional sFName As String = "")
    Dim oExcel As Object
    Dim oBook As Object
    Dim oSheet As Object
    Dim rng As Object
    
    Dim FlCloseExcel As Boolean: FlCloseExcel = True
    Dim RegExp As RegExp: Set RegExp = New RegExp
    Dim KKSUnit As String, OutRootDir As String
    
    Dim WrdArray() As String 'для обработки имени всего здания

    Dim i%, j%, ii%, RemRefStyle%, KEY
    Dim fso As FileSystemObject: Set fso = New FileSystemObject
        
    If Not Config.fgTabViews.exists(F1.tbSimData.CurrTab) Then
        'если конфиг-файл не описывает правила экспорта для выборки данных, то
        'используем встроенную выгрузку в Excel:
        If F1.tbSimData.CurrTab = 1 Then
            Call GridExcelExport(F1.fgSim, sFName)
        ElseIf F1.tbSimData.CurrTab = 2 Then
            Call GridExcelExport(F1.fgSimVol, sFName)
        End If
'Выход
        Exit Sub
    End If

    'проверка/инициализация сеанса Excel и подключение шаблона:
        
    Dim fgDyn As VSFlexGrid: Set fgDyn = Config.fgTabs(F1.tbSimData.CurrTab)
    Dim oView As clsConfigSimView: Set oView = Config.fgTabViews(F1.tbSimData.CurrTab)
    
    Dim getfulllpath As String: getfullpath = F1.tvWise.SelectedItem.FullPath
    WrdArray() = Split(getfullpath, "\")
    
    If Len(oView.Excel_TemplatePath) = 0 Then
        GridExcelExport fgDyn, sFName
        GoTo LCancel
    End If
    
    'Сканирование шаблона на наличие функциональных полей и полей свойств на заполнение
    Dim Coll_Props As Dictionary: Set Coll_Props = New Dictionary
    Set oExcel = CreateObject("Excel.Application")
    oExcel.Visible = False
   
    Set oBook = oExcel.Workbooks.Open(oView.Excel_TemplatePath, ReadOnly:=True)
    Set oSheet = oBook.Worksheets(1)
    
    RegExp.Pattern = "\$\[[^\[\]]+\]" 'маска ключевых полей для заполнения пользователем
    
    Dim FRng As Object, FirstAdr$, prop$, Value$
    Set FRng = oSheet.cells.Find("$[*]", LookIn:=xlFormulas, lookat:=xlPart)
    Do While Not FRng Is Nothing
        If Len(FirstAdr) = 0 Then
            FirstAdr = FRng.Address
        ElseIf FRng.Address = FirstAdr Then
            Exit Do
        End If
        
        Value = FRng.Value
        Dim Coll As MatchCollection: Set Coll = RegExp.Execute(Value)
        
        While RegExp.Test(Value)
            prop = RegExp.Execute(Value)(0).Value
            Value = RegExp.Replace(Value, vbNullString)

            If Not Coll_Props.exists(prop) Then
                Coll_Props.Add prop, FRng.Address
            Else: Coll_Props(prop) = Coll_Props(prop) & FRng.Address & ","
            End If
        Wend
        Set FRng = oSheet.cells.FindNext(FRng)
    Loop
    
    
    If (Coll_Props.Count > 0) Then

        Dim f As frmExcelExport: Set f = New frmExcelExport
        Set f.ExcelApp = oExcel
        f.txtFolder = oView.Excel_SavePath
        If Len(f.txtFolder.text) = 0 Then
            f.btnBrows.Enabled = False
            f.txtFolder.Enabled = False
            f.bFolder = 1
        End If
        
        With f.fgProps
            .AutoResize = True
            .AutoSizeMode = flexAutoSizeColWidth
            .Rows = 1
            .ColWidth(1) = 500
            
            .TextMatrix(0, 0) = "Поле"
            .TextMatrix(0, 1) = "Значение"
            .Cell(flexcpFontBold, 0, 0, 0, 1) = True
            .Cell(flexcpAlignment, 0, 0, 0, 1) = flexAlignCenterCenter
            
            i = 0
            
            Dim iLabel$, iPop
            For Each iProp In Coll_Props.Keys
                i = i + 1
                iLabel = Mid(iProp, 3, Len(iProp) - 3)
                
                Select Case iLabel
                    Case "pg", "pgs"
                    Case Else
                        .Rows = .Rows + 1
                        .TextMatrix(i, 0) = iLabel
                        .TextMatrix(i, 1) = GetSetting("Offtake2", "ExcelExport", iLabel, "")
                End Select
            Next
            .AutoSize (0)
        End With
        
        Dim PropVal, Replacement$
        If f.fgProps.Rows > 1 Then 'если найдены поля для заполнения
            Call f.Show(1, OwnerForm:=F1)
            If Not f.Result Then GoTo LCancel 'ВЫХОД если указанные поля шаблона не заполнены
            
            'сообщение в статус бар:
            F1.SB.Panels("status").text = "Экспорт в Excel ..."
            
            'указанная папка выгрузки
            OutRootDir = f.txtFolder.text
            
            For i = 1 To f.fgProps.Rows - 1
                Coll_Props("$[" & f.fgProps.TextMatrix(i, 0) & "]") = f.fgProps.TextMatrix(i, 1)
            Next
            
            For Each PropVal In Coll_Props.Keys
                Select Case PropVal
                    Case "$[pg]", "$[pgs]"
                    Case Else
                        SaveSetting "Offtake2", "ExcelExport", Mid(PropVal, 3, Len(PropVal) - 3), Coll_Props(PropVal)
                End Select
            Next
            
            Dim HelpRng As Object
            Set HelpRng = oSheet.cells(oSheet.Rows.Count, oSheet.Columns.Count)
            
            'Предварительное заполнение функциональных полей (номера страниц заполняются в конце общей процедуры после обработки всех страниц)
               For Each PropVal In Coll_Props.Keys
                Select Case PropVal
                    Case "$[pg]", "$[pgs]":
                    Case Else:
                        Replacement = Coll_Props(PropVal)
                        Set FRng = oSheet.cells.Find(PropVal, LookIn:=xlFormulas, lookat:=xlPart)
                        While Not FRng Is Nothing
                            FRng.Value = Replace(FRng.Value, PropVal, Replacement)
                            'АВТО-коррекция высоты строки
                            If FRng.MergeCells Then
                                Dim Alerts As Boolean: Alerts = oExcel.DisplayAlerts
                                oExcel.DisplayAlerts = False
                                Dim h#, w#: w = 0
                                For Each Clmn In FRng.MergeArea.Columns
                                    w = w + Clmn.ColumnWidth
                                Next
                                HelpRng.Value = FRng.Value
                                HelpRng.ColumnWidth = w
                                HelpRng.Rows.AutoFit
                                h = FRng.EntireRow.RowHeight
                                FRng.EntireRow.RowHeight = oExcel.WorksheetFunction.Max(h, HelpRng.RowHeight)
                                oExcel.DisplayAlerts = Alerts
                            End If
                            Set FRng = oSheet.cells.FindNext(FRng)
                        Wend
                End Select
            Next
            
            HelpRng.Clear
            Set HelpRng = Nothing
        End If
        
    Else 'Проверка пути вне формы свойств
        OutRootDir = oView.Excel_SavePath
        
        If Len(OutRootDir) > 0 And Not fso.FolderExists(OutRootDir) Then
            Select Case MsgBox("Путь не найден:" & vbLf & "'" & OutRootDir & "'" & vbLf & "Указать другую дирректорию?", vbOKCancel + vbExclamation)
                Case VbMsgBoxResult.vbOK
                    f.btnBrows_Click
                    OutRootDir = f.txtFolder.text
            End Select
            If Not fso.FolderExists(OutRootDir) Then GoTo LCancel
        End If
    End If
    
    'Коллекция строк данных сгруппированных по указанному столбцу GroupCol
    Dim Coll_GroupData As Dictionary: Set Coll_GroupData = New Dictionary
              
    With fgDyn
        Dim GroupCol%: GroupCol = -1
        For j = 0 To .cols - 1
            If .ColHidden(j) Then GoTo NextCol
            Select Case .ColKey(j)
                Case oView.Excel_GroupBy:
                    GroupCol = j
                Case "KKS здания":
                    KKSUnit = .TextMatrix(1, j)
            End Select
NextCol:    Next

        For i = 1 To .Rows - 1
            If GroupCol >= 0 Then KEY = .TextMatrix(i, GroupCol) Else KEY = ""
            If .RowHidden(i) Then GoTo LNextRow
            
            
            If Not Coll_GroupData.exists(KEY) Then Call Coll_GroupData.Add(KEY, New Collection)
            
            Dim CurData As Collection: Set CurData = Coll_GroupData(KEY)
            CurData.Add i
LNextRow:   Next
    End With
        
    'окончательный путь экспорта:
    Dim dltr$: dltr = "\"
    If Len(OutRootDir) > 0 Then
        Dim OutSubPath$: OutSubPath = KKSUnit & dltr & oView.Name & dltr & oView.Title & dltr & Format$(Now, "YYYY_MM_DD#hh.mm.ss")
        Dim OutDir$, SubDir
        OutDir = OutRootDir
        'создание всех необходимых подпапок:
        For Each SubDir In Split(OutSubPath, "\")
            OutDir = fso.BuildPath(OutDir, SubDir)
            If Not fso.FolderExists(OutDir) Then fso.CreateFolder OutDir
        Next
        
        If Not fso.FolderExists(OutDir) Then
            MsgBox "Не удалось создать папку для экспорта: " & vbLf & "'" & OutDir & "'", vbOKOnly + vbExclamation
            GoTo LCancel
        End If
    End If
    
    'заголовки таблицы с учётом скрытых столбцов:
    Dim Headers As Dictionary: Set Headers = New Dictionary
    Dim jj%: jj = 0
    For j = 0 To fgDyn.cols - 1
        If Not fgDyn.ColHidden(j) Then
           jj = jj + 1
           Call Headers.Add(fgDyn.TextMatrix(0, j), jj)
        End If
    Next
    
    If oExcel Is Nothing Then 'инициализация сеанса Excel, если не был запущен
        Set oExcel = CreateObject("Excel.Application")
        Set oBook = oExcel.Workbooks.Open(oView.Excel_TemplatePath, ReadOnly:=True)
        Set oSheet = oBook.Worksheets(1)
    End If
    oExcel.Visible = False
    
    'возможные меры по ускорению выпольнения операций в Excel
    Dim ExcelAccelerator As clsExcelAcceleration: Set ExcelAccelerator = New clsExcelAcceleration
    Call ExcelAccelerator.AccelerateExcel(oExcel)
   
    RemRefStyle = oExcel.ReferenceStyle
    oExcel.ReferenceStyle = XlReferenceStyle_xlA1

    Dim rstart%, rend%, cstart%, rjump%, rcnt%, ccnt%, dirty As Boolean
    With oView
        rstart = .Excel_StartRow
        rend = .Excel_EndPageRow
        cstart = .Excel_StrartColumn
        rjump = Abs(.Excel_Jump)
    End With

    ccnt = Headers.Count 'кол-во столбцов
    
    Dim Arr() As Variant, ColKey
   
    For Each KEY In Coll_GroupData.Keys
        Dim CollData As Collection
        Set CollData = Coll_GroupData(KEY)
        
        rcnt = CollData.Count 'кол-во строк данных
        
        ReDim Arr(1 To CollData.Count, 1 To ccnt)
        
        i = 0
        Dim iRow
        For Each iRow In CollData
            i = i + 1
            j = 0
            For Each ColKey In Headers.Keys
                j = j + 1
                
                Select Case fgDyn.ColDataType(j)
                Case flexDTSingle, flexDTDouble, flexDTDecimal ' 2019.07.21 добавлена проверка на тип с плав. запятой
                    ', flexDTLong, flexDTLong8, flexDTShort,
                    Arr(i, j) = fgDyn.ValueMatrix(iRow, fgDyn.ColIndex(ColKey))
                Case Else
                    Arr(i, j) = fgDyn.TextMatrix(iRow, fgDyn.ColIndex(ColKey))
                End Select
            Next
        Next
        
        'Вставка необходимого числа строк для заополнения их данными (стартовая строка тоже идёт под заполнение)
        Set rng = oSheet.cells(rstart, cstart).Resize(1, ccnt)
        If rcnt > 1 Then

            'создаём условия для правильного наследования формата ячеек:
            rng.Offset(1).Insert xlDown
            rng.copy rng.Offset(1)
                       
            Dim StartRng As Object: Set StartRng = rng
            
            Set rng = rng.Offset(1).Resize(rcnt - 1, ccnt)
            rng.Insert xlDown, CopyOrigin:=0
            
            Set rng = StartRng.Offset(1).Resize(rng.Rows.Count + 1)
            'Rng.Select
            StartRng.Delete xlUp
        End If
        
        'Rng.Select
        
        'запись данных:
        rng.Value = Arr
        rng.Rows.AutoFit 'автокоррекция высот строк
        
        'Расстановка колонтитулов:
        Dim RngColontituls As Object: Set RngColontituls = Nothing
        
        F1.SB.Panels("status").text = "Экспорт в Excel: Расстановка колонтитулов..."
        
        Dim footerMng As clsExcelFooters: Set footerMng = New clsExcelFooters
        Call footerMng.placeFooters(oSheet, F1.PB, RngColontituls)
        
        'Создание листа-копии данных без колонтитулов:
        If Not RngColontituls Is Nothing Then
            Dim RemVis As Boolean: RemVis = oExcel.Visible
            'oExcel.ScreenUpdating = False
        
            'Простая копия листа с данными без колонтитулов
            Dim CopySheet As Object
            oSheet.copy before:=oBook.Worksheets(1)
            Set CopySheet = oBook.Worksheets(1)
            CopySheet.Name = "_data"
            CopySheet.Move after:=oSheet
            
            CopySheet.Range(rng.Address).Rows.AutoFit 'автокоррекция высот строк
        
            'удаление сгенерированного диапазона на листе-копии
            With oBook.Worksheets(1)
                Dim oName
                For Each oName In CopySheet.Names
                    With oName
                        If InStr(UCase(.Name), UCase(C_AUTOGENAREA)) > 0 Then
                            GetRange(CopySheet, .RefersTo).Delete xlUp
                            Exit For
                        End If
                    End With
LNext:
                Next
            End With
            
            CopySheet.cells(1, 1).Select
            
            oSheet.Activate
            oExcel.ScreenUpdating = RemVis
        End If
        
        'переопределяем диапазон
         Set rng = oSheet.cells(rstart, cstart).Resize(LastRowIndex(oSheet) - rstart, ccnt)
        
'!!!!!!!!!!!!! TODO лучше вынести в отдельную процедуру объединение ячеек !!!!!!!!!!!!!!!!!!!!!!

        If Len(oView.MergeColumns) > 0 Then
            F1.SB.Panels("status").text = "Экспорт в Excel: Группировка данных..."
            
            Dim Coll_MergeRef As Dictionary: Set Coll_MergeRef = New Dictionary
            Dim baseCol$, refCol$, baseColKey$, refColKey$
            
            'Зависимости объядинения столбцов
            'такие столбцы объединяют ячейки в соответствии с объединениями другого столбца,
            'на который ссылаются, и не зависят от собственного контекста
            If Len(oView.MergeRef) > 0 Then
                For Each ref In Split(oView.MergeRef, "|")
                    baseCol = Trim(Split(ref, "=")(0))
                    refCol = Trim(Split(ref, "=")(1))
                    
                    'сброс
                    baseColKey = vbNullString
                    refColKey = vbNullString
                    
                    RegExp.Pattern = baseCol
                    For Each ColKey In Headers.Keys
                        If RegExp.Test(ColKey) Then
                            baseColKey = ColKey: Exit For
                        End If
                    Next
                    
                    RegExp.Pattern = refCol
                    For Each ColKey In Headers.Keys
                        If RegExp.Test(ColKey) Then
                            refColKey = ColKey
                            'зависимых столбцов может быть несколько, поэтому для каждого найденного:
                            If Len(baseColKey) > 0 And Len(refColKey) > 0 Then
                                If Not Coll_MergeRef.exists(baseColKey) Then Call Coll_MergeRef.Add(baseColKey, New Collection)
                                Coll_MergeRef(baseColKey).Add refColKey
                            End If
                        End If
                    Next
                Next
            End If
                    
            '! объединение ячеек Merge-столбцов, !важно проводить после расстановки колонтитулов:
            Dim MergeAdr, buf$, Shift%, RngMerge As Object
            'MergeAdr = vbNullString: MergeAdr2 = vbNullString
            Dim MergeAdrArr() As String 'массив для попеременной записи адресов ячеек во избежание коолизий рядом стоящих диапазонов на объединение
            Dim iter% 'индекс текущего буфера адресов ячеек
            Dim lmind% 'последняя ячеека на объединение
            
            Shift = rng.Row - 1
            Dim AutoGenRows As Dictionary: Set AutoGenRows = New Dictionary
                      
            If Not RngColontituls Is Nothing Then
                For Each Row In RngColontituls.Rows
                    Call AutoGenRows.Add(Row.Row, Empty)
                Next
            End If
            
            Arr = rng.Value
            
            'Отключение запросов Excel
            Dim RemDispAlerts As Boolean: RemDispAlert = oExcel.DisplayAlerts
            oExcel.DisplayAlerts = False
           
            For Each ColKey In Headers.Keys
                'сброс
                ReDim MergeAdrArr(0 To 1)
                iter = 0
                lmind = -1
                
                RegExp.Pattern = oView.MergeColumns
                
                If RegExp.Test(ColKey) Then
                    j = Headers(ColKey)
                    buf = vbNullString
                    
                    RegExp.Pattern = oView.MergeColumns
                    
                    For i = LBound(Arr) + 1 To UBound(Arr)
                        If Not AutoGenRows.exists(i + Shift) Then
                            If Arr(i, j) = Arr(i - 1, j) Then
                                If Len(buf) = 0 Then
                                    buf = rng.cells(i - 1, j).Address
                                    If (i - 1) = (lmind + 1) Then
                                        iter = Abs(iter - 1) 'переключение между '0' и '1'
                                    End If
                                End If
                            ElseIf Len(buf) > 0 Then
                                MergeAdrArr(iter) = MergeAdrArr(iter) & "," & buf & ":" & rng.cells(i - 1, j).Address
                                buf = vbNullString
                                lmind = i - 1
                            End If
                        Else
                            If Len(buf) > 0 Then
                                MergeAdrArr(iter) = MergeAdrArr(iter) & "," & buf & ":" & rng.cells(i - 1, j).Address
                                buf = vbNullString
                                lmind = i - 1
                            End If
                        End If
                    Next
                    
                    If Len(buf) > 0 Then
                        MergeAdrArr(iter) = MergeAdrArr(iter) & "," & buf & ":" & rng.cells(i - 1, j).Address
                        buf = vbNullString
                    End If
                End If
                
                Dim MergeRng As Object, refKeyCol
                For Each MergeAdr In MergeAdrArr
                    If Len(MergeAdr) > 0 Then
                        MergeAdr = right$(MergeAdr, Len(MergeAdr) - 1)
                        Set MergeRng = GetRange(oSheet, CStr(MergeAdr))
                        MergeRng.MergeCells = True 'операция объединения ячеек с одинаковым содержимым для указанных столбцов
                        
                        Dim iCol%
                        If Coll_MergeRef.exists(ColKey) Then
                            For Each refKeyCol In Coll_MergeRef(ColKey)
                                iCol% = Headers(refKeyCol) - Headers(ColKey)
                                For Each Area In MergeRng.Areas
                                    oSheet.Range(Area.cells(1, 1).Offset(0, iCol).Address & ":" & Area.cells(Area.Rows.Count, 1).Offset(0, iCol).Address).MergeCells = True
                                Next
                            Next
                        End If
                    End If
                Next
            Next
            
            oExcel.DisplayAlerts = RemDispAlerts 'восстановление оповещений Excel
            For Each iKey In Coll_MergeRef.Keys
                Set Coll_MergeRef(iKey) = Nothing
            Next
            Set Coll_MergeRef = Nothing
            Set AutoGenRows = Nothing
        End If
        
        'прокрутка в верхнюю часть листа
        oSheet.cells(1, 1).Select
        
        'Заполнение функциональных полей
        If Coll_Props.Count > 0 Then
            F1.SB.Panels("status").text = "Экспорт в Excel: Заполнение функциональных полей..."
            
            For Each PropVal In Coll_Props.Keys
                Set FRng = oSheet.cells.Find(PropVal, LookIn:=xlFormulas, lookat:=xlPart)
                
                Select Case PropVal
                    Case "$[pg]"
                        While Not FRng Is Nothing
                                For i = 1 To oSheet.HPageBreaks.Count
                                    If FRng.Row < oSheet.HPageBreaks(i).Location.Row Then
                                        Replacement = i: Exit For
                                    End If
                                Next
                        
                            FRng.Value = Replace(FRng.Value, PropVal, Replacement)
                            Set FRng = oSheet.cells.FindNext(FRng)
                        Wend
                        
                    Case "$[pgs]"
                        Replacement = oSheet.HPageBreaks.Count
                    Case Else: Replacement = Coll_Props(PropVal)
                End Select
    
                While Not FRng Is Nothing
                    FRng.Value = Replace(FRng.Value, PropVal, Replacement)
                    Set FRng = oSheet.cells.FindNext(FRng)
                Wend
            Next
        End If
        
        'Для обработки вкладки Paks-2. Задает имя здания
        If Len(KEY) = 0 And UBound(WrdArray) > 3 Then KEY = WrdArray(3)

        If Len(KEY) > 0 Then
            'экспорт данных
            oBook.SaveCopyAs fso.BuildPath(OutDir, KEY & ".xls")
            
            'удаляем заполненные данные - восстанавливаем шаблон
            rng.ClearContents
            If rng.Rows.Count > 1 Then
                rng.Offset(1).Resize(rng.Rows.Count - 1).Delete Shift:=xlUp
            End If
           
            FlCloseExcel = True 'флаг для закрытия Excel после выгрузки, т.к. все книги сохранены
        Else
            FlCloseExcel = False
            oExcel.Visible = True
        End If
    Next

    MsgBox "Экспорт в Excel успешно завершён.", vbExclamation + vbOKOnly
    F1.SB.Panels("status").text = "Экспорт в Excel успешно завершён."
    
    'открываем проводником Windows папку куда был произведён экспорт
    If FlCloseExcel Then Shell "explorer.exe " & OutDir, vbNormalFocus
    
LCancel:
    On Error Resume Next

    Call ExcelAccelerator.disAccelerateExcel

    If FlCloseExcel And Not oExcel Is Nothing Then
        Set rng = Nothing
        Set oSheet = Nothing
        Set oBook = Nothing
        oExcel.DisplayAlerts = False
        oExcel.ReferenceStyle = RemRefStyle
        oExcel.Quit
    End If
    
    'освобождение памяти и ресурсов:
    Set oExcel = Nothing
    Set RegExp = Nothing
    Set fso = Nothing
    Set Coll_Props = Nothing
    Set f = Nothing
    
    For Each KEY In Coll_GroupData.Keys
        Set Coll_GroupData(KEY) = Nothing
    Next
    Set Coll_GroupData = Nothing
    
    Set Headers = Nothing
End Sub

Public Function saveExcelGrid(sFileName As String, FG As VSFlexGrid, bFixedCells As Boolean) As Long
On Error GoTo err
    If bFixedCells Then
        FG.SaveGrid sFileName, flexFileExcel, flexXLSaveFixedCells
    Else
        FG.SaveGrid sFileName, flexFileExcel
    End If
    saveExcelGrid = 0
Exit Function
err:
    saveExcelGrid = err.Number

End Function


Public Sub GridExcelExport(fgDyn As VSFlexGrid, Optional sFName As String = "")
        If fgDyn.Rows = 1 Then Exit Sub 'выход, если только заголовок


        Dim sFileName As String

        If Len(sFName) > 0 Then
        
            sFileName = sFName
        
        Else
            Dim OFN As OPENFILENAME
            With OFN
                .lStructSize = Len(OFN)
                .hWndOwner = F1.hwnd
                .hInstance = App.hInstance
                .lpstrFilter = "Excel Files (*.xls)" + Chr$(0) + "*.xls" + Chr$(0) + "All Files (*.*)" + Chr$(0) + "*.*" + Chr$(0)
                .lpstrFile = Space$(254)
                .nMaxFile = 255
                .lpstrFileTitle = Space$(254)
                .nMaxFileTitle = 255
                .lpstrInitialDir = CurDir
                .lpstrTitle = "Сохранить файл"
                .flags = 0
            End With
    
            If (GetSaveFileName(OFN)) Then
            
                sFileName = LCase(Trim$(OFN.lpstrFile))
            Else
                Exit Sub
            End If
    
            If Asc(right(sFileName, 1)) = 0 Then sFileName = left(sFileName, Len(sFileName) - 1)
        End If


        If Not right(sFileName, 4) = ".xls" Then
            sFileName = sFileName & ".xls"
        End If
        
        If saveExcelGrid(sFileName, fgDyn, True) > 0 Then
            MsgBox "Ошибка сохранения. Проверьте пожалуйста, не открыт ли файл"
        Else
            Shell "explorer.exe " & sFileName, vbNormalFocus
        End If
        
        
        'MsgBox "Экспорт в Excel успешно завершён", vbExclamation + vbOKOnly
End Sub

Public Function LastRowIndex(wSheet As Object) As Integer
    With wSheet.UsedRange.Find("*", wSheet.cells(1, 1), xlValues, xlPart, xlByRows, xlPrevious, False)
        LastRowIndex = .CurrentRegion.Rows(.CurrentRegion.Rows.Count).Row
    End With
End Function

Public Sub moveToRow(ByRef rng As Object, ByVal Row As Integer)
    If rng.Row = Row Then Exit Sub
    
'    Dim ScrState As Boolean: ScrState = Rng.Worksheet.parent.Application.ScreenUpdating
'    Rng.Worksheet.parent.Application.ScreenUpdating = False
    
    If rng.Row < Row Then
        Row = Row + rng.Rows.Count
'        If Not Intersect(Rng.EntireRow, Rng.Worksheet.Rows(Row)) Is Nothing Then
'            Row = Row - 1
'        End If
    End If
    
    Dim NewRng: Set NewRng = InsertCopy(rng, Row, FormatsOnly:=True)
    
    Dim oldAdr$: oldAdr = rng.Address
    rng.Cut NewRng
    rng.Worksheet.Range(oldAdr).EntireRow.Delete Shift:=xlUp
    'Rng.Select

    Set NewRng = Nothing
    
    'Rng.Worksheet.parent.Application.ScreenUpdating = ScrState
    rng.Select
End Sub

Public Function InsertCopy(ByVal rng As Object, ByVal Row As Integer, Optional ByVal FormatsOnly As Boolean = False) As Object
    'On Error GoTo LErr

'    Dim ScrState As Boolean: ScrState = Rng.Worksheet.parent.Application.ScreenUpdating
'    Rng.Worksheet.parent.Application.ScreenUpdating = False

    Dim NewRng As Object, oldAdr$, i%
    
    Dim Area As Object, iRow As Object, rcnt%: rcnt = 0
    
    Dim Coll_RowsHeights As Dictionary: Set Coll_RowsHeights = New Dictionary
    
    i = 0
    For Each Area In rng.Areas
        rcnt = rcnt + Area.Rows.Count
        For Each iRow In Area.Rows
            i = i + 1
            Coll_RowsHeights.Add i, iRow.RowHeight
        Next
    Next
    Set Area = Nothing

    Set NewRng = rng.Worksheet.Range(rng.Worksheet.cells(Row, rng.Column).Address & ":" & rng.Worksheet.cells(Row + rcnt - 1, rng.Columns(rng.Columns.Count).Column).Address)
    
    rng.Worksheet.Range(NewRng.Rows.Address).Insert xlDown  'выделяем место для вставки
    'NewRng.EntireRow.Insert xlDown 'выделяем место для вставки
    
    Set NewRng = NewRng.Offset(-NewRng.Rows.Count)
  
    i = 0
    For Each iRow In NewRng.Rows
        i = i + 1
        iRow.RowHeight = Coll_RowsHeights(i)
    Next
    Set Coll_RowsHeights = Nothing
    
'    i = 1
'    For Each Area In Rng.Areas
'        For Each iRow In Area.Rows
'            NewRng.Rows(i).RowHeight = iRow.RowHeight
'            i = i + 1
'        Next
'    Next

    If Not FormatsOnly Then
        rng.copy NewRng
    End If
    'NewRng.Select

    Set InsertCopy = NewRng
    
    Set NewRng = Nothing

'    Rng.Worksheet.parent.Application.ScreenUpdating = ScrState
    InsertCopy.Select
    
    Exit Function
LErr:
    Dim s$: s = err.Description
    
End Function

Public Function GetRange(wsh As Object, ByVal Address As String) As Object
    If Len(Address) = 0 Then Exit Function
    
    Const MAXSIZE = 255
    Dim rng As Object, adr, buf$, i%, dltr$
    
    
'Определение разделителя адресов диапазонов
On Error GoTo LAdrError
    dltr = ","
    buf = wsh.Range(wsh.cells(1, 1).Address & dltr & wsh.cells(3, 3).Address).Address
    GoTo LContinue
LAdrError:
    dltr = ";"
LContinue:
    
    
    On Error GoTo LCancel
   
    Address = Replace(Address, ",", dltr)
    Address = Replace(Address, ";", dltr)
    
    If left(Address, 1) = dltr Then Address = right(Address, Len(Address) - 1)
    
    If Len(Address) > MAXSIZE Then 'диапазоны Range(Address) не принимают в качестве адреса строки длиной больше 255/256 символов
        i = 0:  buf = ""
        Dim Addresses() As String: ReDim Addresses(0)
        
        For Each adr In Split(Address, dltr)
            i = i + 1 + Len(adr) 'с учётом запятой
            If i > MAXSIZE Then
                ReDim Preserve Addresses(UBound(Addresses) + 1)
                buf = right(buf, Len(buf) - 1)
                Addresses(UBound(Addresses) - 1) = buf
                buf = ""
                i = 1 + Len(adr)
            End If
            buf = buf & dltr & adr
        Next
                
        If Len(buf) > 0 Then
            buf = right(buf, Len(buf) - 1)
            Addresses(UBound(Addresses)) = buf
        Else
            ReDim Preserve Addresses(UBound(Addresses) - 1)
        End If
        
        Set rng = Nothing
        For Each adr In Addresses
            If rng Is Nothing Then
                Set rng = wsh.Range(adr)
            Else:
                Set rng = wsh.parent.Application.Union(rng, wsh.Range(adr))
            End If
        Next
    Else
        Set rng = wsh.Range(Address)
    End If

    Set GetRange = rng
    
LCancel:
    'Clipboard.SetText Address
End Function

Public Sub mergeCellsOnPages(oSheet As Object, RngReserved As Object)
    'TODO вынести сюда операции по объединению ячеек
End Sub



