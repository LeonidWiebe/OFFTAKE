Attribute VB_Name = "mWord"
'--------------------------------------------------------------------------------------------------
'   МОДУЛЬ экспорта данных из Offtake в таблицу документа MS Word
'
'Примечание:
'   способ вставки данных - через буфер обмена Windows, т.к. оказался наиболее производительным
'
'---------------------------------------------------------------------------------------------------

Declare Function ActivateKeyboardLayout Lib "user32" (ByVal HKL As Long, ByVal flags As Long) As Long

Public Const kb_lay_ru As Long = 68748313
Public Const kb_lay_en As Long = 67699721

'Переключить на русский язык
'X = ActivateKeyboardLayout&(kb_lay_ru, 0)
'
'Переключить на английский язык
'X = ActivateKeyboardLayout&(kb_lay_en, 0)

Private Enum WordEnum
    wdReplaceAll = 2
End Enum

Public Sub exportWord()
   On Error GoTo exportWord_Err

    Dim WordApp As Object

    If Config.fgTabViews.exists(F1.tbSimData.CurrTab) Then
    'проверка/инициализация сеанса Word и подключение шаблона:
    
        F1.SB.Panels("status").text = "Экспорт в Word..."
    
        Dim fgDyn As VSFlexGrid: Set fgDyn = Config.fgTabs(F1.tbSimData.CurrTab)
        Dim oView As clsConfigSimView: Set oView = Config.fgTabViews(F1.tbSimData.CurrTab)
 
        Dim fso As FileSystemObject: Set fso = New FileSystemObject
        If fso.FileExists(oView.Word_TemplatePath) Then

            Set WordApp = CreateObject("Word.Application")
                       
            Dim IsActive As Boolean:
            IsActive = False
            With WordApp
                .ScreenUpdating = IsActive
                .DisplayAlerts = IsActive
                .Visible = IsActive
            End With
            
            Call WordApp.Documents.Open(oView.Word_TemplatePath, ReadOnly:=True)
            Call ActivateKeyboardLayout&(kb_lay_ru, 0) 'активация раскладки клавиатуры RU
            
            Dim text As String, tbl As Object, rng As Object
            Dim MergeRowsColl As Collection
            Dim AreaRowsColl As Collection
            Dim CurRow%
            CurRow = oView.Word_TableStartRow 'учитываем начальную строку
            
            'Таблица:
            Set tbl = WordApp.ActiveDocument.Tables(oView.Word_TableIndex)
            Set rng = tbl.Range
            
            'Скрываемые столбцы:
            Dim HiddenGroupColumns As Dictionary
            Set HiddenGroupColumns = New Dictionary
            For Each GroupClmn In oView.Word_GroupColumnsColl
                If GroupClmn.Hidden Then
                    Dim re As RegExp
                    Set re = New RegExp
                    re.Pattern = GroupClmn.Column
                    For j = 0 To fgDyn.cols - 1
                        iClmnKey = fgDyn.ColKey(j)
                        If re.Test(iClmnKey) Then
                            HiddenGroupColumns.Add iClmnKey, iClmnKey
                        End If
                    Next
                End If
            Next
            
            'столбец площади:
            Dim AreaClmn%: AreaClmn = 0
            For j = 0 To fgDyn.cols - 1
                iClmnKey = fgDyn.ColKey(j)
                jj = jj + 1
                If jj > tbl.Columns.Count Then Exit For
                If iClmnKey = "area" And Not fgDyn.ColHidden(j) And Not HiddenGroupColumns.exists(iClmnKey) Then
                    AreaClmn = j
                End If
            Next
                        
            Dim tot_vol As Double: tot_vol = 0# 'суммарная площадь по всем помещениям
            
            'ПОЛУЧЕНИЕ СГРУППИРОВАННЫХ ДАННЫХ
            Call FillGroupDataRows(F1.tbSimData.CurrTab, WordApp, CurRow, tot_vol, HiddenGroupColumns:=HiddenGroupColumns, _
                MergeRows:=MergeRowsColl, text:=text, AreaClmn:=AreaClmn, AreaRows:=AreaRowsColl)
            
           ' Dim t0 As Boolean: t0 = WriteLogToFile("file0", text)
            
            Dim Position As Integer
            Position = InStr(text, "room")
            If Position > 0 Then
              text = text & vbTab & "Total area " & vbTab & str(tot_vol) & vbTab & vbCrLf
              text = Replace(text, "Площадь помещений на отметке", "Total level area")
            Else
              text = text & vbTab & "Общая площадь " & vbTab & str(tot_vol) & vbTab & vbCrLf
            End If
            
           'Dim t1 As Boolean: t1 = WriteLogToFile("file1", text)
            
            CurRow = CurRow + 1

            text = Replace(text, "-", "@#$") 'учитываем особенности MSWord2003 при вставке текста из буфера обмена в таблицу


            
            If Not F1.PB.Visible Then F1.PB.Visible = True
            F1.PB.Min = 0
            F1.PB.Max = 2 + tbl.Columns.Count + MergeRowsColl.Count + 1
            F1.PB.Value = 1
            
            With tbl
                If .Rows.Count < oView.Word_TableStartRow Then
                    Call .Rows(.Rows.Count).Select
                    Call WordApp.Selection.InsertRowsBelow(oView.Word_TableStartRow - .Rows.Count)
                End If
            End With
            
            Dim StartRow As Integer: StartRow = oView.Word_TableStartRow
            
            'подготовка таблицы
            tbl.Rows(StartRow).Select
            WordApp.Selection.InsertRowsBelow CurRow - StartRow 'вставляем необходимое кол-во строк
            
            'результирующее кол-во вставляемых строк
            Dim TotalInsertRows As Integer: TotalInsertRows = CurRow - StartRow
            
            Call rng.setRange(tbl.Cell(StartRow + 1, 1).Range.start, tbl.Cell(CurRow, tbl.Columns.Count).Range.End)
            rng.Select
           
            F1.PB.Value = F1.PB.Value + 1
            
            'Для пердачи данных в таблицу используется метод записи из буфера обмена, как показавший наилучшее быстродействие,
            'при этом могут возникать нюансы чтения буфера ранними версиями Word (например Word 2003), их необходимо обрабатывать, см. далее
           
            Clipboard.Clear: Clipboard.SetText text
            
          ' Dim t2 As Boolean: t2 = WriteLogToFile("file2", text)
            Call ActivateKeyboardLayout&(kb_lay_ru, 0) 'активация раскладки клавиатуры RU
            WordApp.Selection.Paste
            Clipboard.Clear
                        
            'Восстановление данных:
            If Len(oView.Word_NewRowKey) > 0 Then
                With WordApp
                    .Selection.Find.ClearFormatting
                    .Selection.Find.Replacement.ClearFormatting
                    With .Selection.Find
                        .text = oView.Word_NewRowKey
                        .Replacement.text = "^l"
                        .Forward = True
                        .Wrap = wdFindContinue
                        .Format = False
                        .MatchCase = False
                        .MatchWholeWord = False
                        .MatchWildcards = False
                        .MatchSoundsLike = False
                        .MatchAllWordForms = False
                        
                        WordApp.Selection.Find.Execute Replace:=wdReplaceAll
                        
                        .text = "@#$" 'учитываем особенности MSWord2003 при вставке текста из буфера обмена в таблицу
                        .Replacement.text = "-"
                        
                        WordApp.Selection.Find.Execute Replace:=wdReplaceAll
                    End With
                End With
            End If
            
            'Наследование форматов от ячеек начальной строки для каждого столбца
            Dim Clmn As Object 'Column
            Dim remAlign%
            For j = 1 To tbl.Columns.Count
                tbl.Cell(StartRow, j).Select
'                WordApp.Selection.CopyFormat
                With WordApp.Selection
                    .CopyFormat
                    remAlign = .ParagraphFormat.Alignment
                End With
                'remAlign = WordApp.Selection.ParagraphFormat.Alignment
                
                Call rng.setRange(tbl.Cell(StartRow + 1, j).Range.start, tbl.Cell(CurRow, j).Range.End)
                rng.Select
                With WordApp.Selection
                    .PasteFormat
                    .Font.Name = "Times New Roman"
                    .ParagraphFormat.Alignment = remAlign
                End With
                
'                rng.Select
'                WordApp.Selection.PasteFormat
'                WordApp.Selection.Font.Name = "Times New Roman"
'                WordApp.Selection.ParagraphFormat.Alignment = remAlign
                F1.PB.Value = F1.PB.Value + 1
            Next
            
            'обработка заголовков
            Dim bl As Boolean
            bl = False
            Dim indx1 As Integer
            For Each ind In MergeRowsColl
                With tbl.Rows(CInt(ind))
                    .cells(1).Select
                    WordApp.Selection.CopyFormat
                    .cells.Merge
                    .Select
                    WordApp.Selection.PasteFormat
                    .Select
                    
                    WordApp.Selection.Font.bOld = True
                    WordApp.Selection.ParagraphFormat.Alignment = 1 'wdAlignParagraphCenter
                    WordApp.Selection.cells.VerticalAlignment = 1 'wdCellAlignVerticalCenter
                End With
                F1.PB.Value = F1.PB.Value + 1
            Next
                        
            For Each ind In AreaRowsColl
                tbl.Rows(ind).Select
                'WordApp.Selection.Font.bOld = true
                tbl.Cell(ind, 1).Select
                WordApp.Selection.ExtendMode = True
                WordApp.Selection.Expand Unit:=12
                WordApp.Selection.MoveRight Unit:=1, Count:=1, Extend:=1
                WordApp.Selection.cells.Merge
                WordApp.Selection.ParagraphFormat.Alignment = 0
                WordApp.Selection.ExtendMode = False
            Next
                        
            'дополнительная обработка последней строки
            'итоговой площади
            With tbl.Rows(CInt(tbl.Rows.Count))
                    .cells(1).Select
                    WordApp.Selection.CopyFormat
                    .Select
                    WordApp.Selection.PasteFormat
                    WordApp.Selection.Font.bOld = True
            End With
            
            tbl.Cell(CInt(tbl.Rows.Count), 1).Select
            WordApp.Selection.ExtendMode = True
            WordApp.Selection.Expand Unit:=12
            WordApp.Selection.MoveRight Unit:=1, Count:=1, Extend:=1
            WordApp.Selection.cells.Merge
            WordApp.Selection.ParagraphFormat.Alignment = 0
            WordApp.Selection.ExtendMode = False
            
            'удаление первой строки, хранящей форматы столбцов
            tbl.Rows(StartRow).Select
            tbl.Rows(StartRow).Delete
            
            tbl.Range.Select
            
            F1.PB.Value = F1.PB.Value + 1 'прогрессбар
            
            'Удаление последней страницы, ! при активации следует следить за автоформатированием колонтитулов, особенно, если было всего 2 страницы
            'Dim pageCount%: pageCount = ActiveWindow.ActivePane.Pages.Count
            'Call Selection.GoTo(Word.WdGoToItem.wdGoToPage, Word.WdGoToDirection.wdGoToAbsolute, pageCount, 2) 'Word.WdGoToItem.wdGoToPage = 1, Word.WdGoToDirection.wdGoToAbsolut = 1
            'Call Selection.Bookmarks("\Page").Select
            'Call Selection.Delete
            
            'ставим курсор в самое начало документа
            Call rng.setRange(WordApp.ActiveDocument.Range.start, WordApp.ActiveDocument.Range.start)
            rng.Select
                        
            MsgBox "Экспорт в Word успешно завершён", vbInformation + vbOKOnly
            F1.SB.Panels("status").text = "Экспорт в Word успешно завершён."
            F1.PB.Value = 0
           
L_CANCEL:
            With WordApp
                .ScreenUpdating = True
                .DisplayAlerts = True
                .Visible = True
            End With
        Else
            MsgBox "Файл '" & oView.Word_TemplatePath & "' не найден, проверьте конфигурацию" & vbNewLine & "Команда не выполнена", vbCritical, ""
        End If
    End If
    
Exit Sub
    
exportWord_Err:
    MsgBox "Не удалось корректно завершить экспорт в Word", vbCritical + vbOKOnly
    WordApp.Quit
    Set WordApp = Nothing
    
End Sub

Function WriteLogToFile(Name As String, txt As String)
  Dim intFile As Integer
  Dim strFile As String
  strFile = "c:\" & Name & ".txt"
  intFile = FreeFile
  Open strFile For Output As #intFile
    Print #intFile, txt
  Close #intFile
  WriteLogToFile1 = True
End Function


'Получение сгруппированной структуры строк данных
Public Sub FillGroupDataRows(ByVal TabIndex As Integer, WordApp As Object, ByRef CurRow As Integer, ByRef tot_vol As Double, Optional ByVal Level As Integer = 1, _
                                 Optional ByVal Rows As Collection = Nothing, Optional ByRef HiddenGroupColumns As Dictionary = Nothing, _
                                 Optional ByRef MergeRows As Collection, Optional ByRef text As String = vbNullString, _
                                 Optional AreaClmn As Integer = 0, Optional ByRef AreaRows As Collection)
    
    Dim fgDyn As VSFlexGrid: Set fgDyn = Config.fgTabs(TabIndex)
    Dim oView As clsConfigSimView: Set oView = Config.fgTabViews(TabIndex)
    
    Dim iGroupRowsColl As cl_SortedList: Set iGroupRowsColl = New cl_SortedList
    
    Dim i%, j%, Row, ColKey$, KEY
    Dim re As RegExp, re_Level As RegExp:
    Set re = New RegExp: Set re_Level = New RegExp
    
    Dim GroupClmn As clsConfigWordGrClmn
    
    If MergeRows Is Nothing Then Set MergeRows = New Collection
    If AreaRows Is Nothing Then Set AreaRows = New Collection
    
    Set GroupClmn = oView.Word_GroupColumnsColl.Item(Level)
    re.Pattern = GroupClmn.Column
    
    If Rows Is Nothing Then Set Rows = New Collection
    If Rows.Count = 0 Then
        For i = 1 To fgDyn.Rows - 1
            If Not (fgDyn.RowHidden(i) Or fgDyn.IsSubtotal(i)) Then
                Rows.Add i
            End If
        Next
    End If

    For j = 0 To fgDyn.cols - 1
        ColKey = fgDyn.ColKey(j)
        If re.Test(ColKey) Then
        
            re.Pattern = GroupClmn.GroupExpression
            re_Level.Pattern = "^([0-9]{1,2})([A-Z]{3})(9[0-9]+)"
            
            If GroupClmn.Hidden And Not HiddenGroupColumns.exists(ColKey) Then
                HiddenGroupColumns.Add ColKey, ColKey
            End If
            
            For Each Row In Rows
                KEY = fgDyn.TextMatrix(Row, j)
                                
                re.Pattern = GroupClmn.GroupExpression
                If re.Test(KEY) Then
                    KEY = re.Execute(KEY)(0)
                    
                    'проверка на столбец kks
                    If re_Level.Test(KEY) Then
                        Dim lvl$, bld$, MatchColl As MatchCollection
                        Set MatchColl = re_Level.Execute(KEY)
                        With re_Level.Execute(KEY)(0)
                            bld = .SubMatches(1)
                            lvl = .SubMatches(2)
                        End With
                        'например отметку '99' приобразуем в '!01', '94' - '!06', '997' - '!003'
                        KEY = Replace(KEY, bld & lvl, bld & "!" & Format$(10 ^ (Len(lvl)) - CInt(lvl), Replace(10 ^ (Len(lvl)), "1", "")))
'                    Else
'                        Key = re.Execute(Key)(0)
                    End If
                End If
                
                If Not iGroupRowsColl.ContainsKey(KEY) Then iGroupRowsColl.Add KEY, New Collection
                iGroupRowsColl.Item(KEY).Add Row
            Next
            Exit For
        End If
    Next
    
    Dim tbl As Object: Set tbl = WordApp.ActiveDocument.Tables(oView.Word_TableIndex)
    Dim rng As Object
    
    'строка отступов
    'учитываем особенности MSWord2003 при вставке текста из буфера обмена в таблицу
    Dim TitleTabText As String
    For j = 0 To fgDyn.cols - 2
        TitleTabText = TitleTabText & vbTab
    Next
    
    'уровень подгруппы
    For Each KEY In iGroupRowsColl.Keys
        'tbl.Rows(CurRow).Select
        
        Set Rows = iGroupRowsColl.Item(KEY)
        
        If GroupClmn.TitleRowsCount > 0 Then 'вставка заголовочных строк
            Dim icnt%: icnt = CurRow + GroupClmn.TitleRowsCount
            Do While CurRow < icnt
                CurRow = CurRow + 1
                MergeRows.Add (CurRow)
            Loop
            
            re.Pattern = "%value%"
            re.IgnoreCase = True
            
            text = text & re.Replace(GroupClmn.TitleText, KEY) & TitleTabText & vbCrLf
            
            re.IgnoreCase = False
            
           ' MergeRows.Add (CurRow - 1)
            'MergeRows.Add CurRow
        End If
                
        Dim ii, jj%, iClmnKey$
        
        If Level < oView.Word_GroupColumnsColl.Count Then
            Call FillGroupDataRows(TabIndex, WordApp, CurRow, tot_vol, Level + 1, Rows, HiddenGroupColumns, MergeRows, text)
        Else
            'нижний уровень сгруппированных данных
            For Each ii In Rows
                jj = 0
                
                rtxt = vbNullString
                For j = 0 To fgDyn.cols - 1
                    iClmnKey = fgDyn.ColKey(j)
                    If Not fgDyn.ColHidden(j) And Not HiddenGroupColumns.exists(iClmnKey) Then
                        jj = jj + 1
                        If jj > tbl.Columns.Count Then Exit For
                        
                        If rtxt = vbNullString Then
                            rtxt = Replace(fgDyn.TextMatrix(ii, j), vbLf, "")
                        Else
                            rtxt = rtxt & vbTab & Replace(fgDyn.TextMatrix(ii, j), vbLf, "")
                        End If
                    End If
                Next
                text = text & rtxt & vbCrLf
            Next
            CurRow = CurRow + Rows.Count
        End If
        
        If AreaClmn > 0 And ColKey = "kks" Then
        'Вычисление площади
            Dim count_area#: count_area = 0#
            For Each ii In Rows
                Dim tm1 As String
                Dim tm2 As Double
                tm1 = Replace(fgDyn.TextMatrix(ii, AreaClmn), ",", ".")
                tm2 = Val(tm1)
                count_area = count_area + tm2
                tot_vol = tot_vol + tm2
            Next
                
            text = text & vbTab & "Площадь помещений на отметке " & vbTab & str(count_area) & TitleTabText & vbCrLf
            CurRow = CurRow + 1 'добавляем значение ячейки для площади
            AreaRows.Add CurRow
        End If
        
    Next
    
End Sub

Function Min(ParamArray Values() As Variant) As Variant
   Dim minValue, Value As Variant
   minValue = Values(0)
   For Each Value In Values
       If Value < minValue Then minValue = Value
   Next
   Min = minValue
End Function

Function Max(ParamArray Values() As Variant) As Variant
   Dim maxValue, Value As Variant
   maxValue = Values(0)
   For Each Value In Values
       If Value > maxValue Then maxValue = Value
   Next
   Max = maxValue
End Function

