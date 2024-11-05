VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsExcelAcceleration"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
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

Private App_ As Object
Private States() As Variant

Private Sub Initialize(ExcelApp As Object)
    Call Class_Terminate

    If IsExcelApp(ExcelApp) Then
        Set App_ = ExcelApp
    Else
        Set App_ = Nothing
    End If
End Sub

Private Sub Class_Terminate()
    If Not App_ Is Nothing Then
        Call disAccelerateExcel
    End If
End Sub

Public Sub AccelerateExcel(ExcelApp As Object)
    Call Initialize(ExcelApp)

    If App_ Is Nothing Then Exit Sub

    With App_
        ReDim States(acEnum.last)
       
        Dim i As Integer
        For i = 0 To UBound(States)
            Select Case i
                'Видимость изменений/обновлений экрана
                Case acEnum.ScreenUpdating: States(i) = .ScreenUpdating
                                               .ScreenUpdating = False 'не применяется т.к. вызывает сбой в Excel при постраничном режиме
                'Автоматизация вычислений
                Case acEnum.Calculation: States(i) = .Calculation
                                                     .Calculation = -4135 ' xlCalculationManual 'вычисления переводим в ручной режим
                'Режим отображения (таблица, постраничный)
                Case acEnum.View: States(i) = .ActiveWindow.View
                                              .ActiveWindow.View = 1 '=xlNormalView - режим "Обычный"
                'События
                Case acEnum.Events: States(i) = .EnableEvents
                                                .EnableEvents = False
                'Пересчёт разрывов страниц
                Case acEnum.PageBreaks: States(i) = .ActiveWorkbook.ActiveSheet.DisplayPageBreaks
                                                    .ActiveWorkbook.ActiveSheet.DisplayPageBreaks = False
                'Оповещения
                Case acEnum.DisplayAlerts: States(i) = .DisplayAlerts
                                                       .DisplayAlerts = False
                'Статус-бар
                Case acEnum.DisplayStatusBar: States(i) = .DisplayStatusBar
                                                          .DisplayStatusBar = False
                'Фоновый поск ошибок:
                Case acEnum.BackgroundChecking: States(i) = .ErrorCheckingOptions.BackgroundChecking
                                                            .ErrorCheckingOptions.BackgroundChecking = False
                'Обработка даты введённая в текстовом формате
                Case acEnum.TextDate: States(i) = .ErrorCheckingOptions.TextDate
                                                  .ErrorCheckingOptions.TextDate = False
            End Select
        Next
    End With
End Sub

Public Sub disAccelerateExcel()

    If App_ Is Nothing Then Exit Sub
    
    On Error Resume Next
    
    With App_
         Dim i%
         For i = LBound(States) To UBound(States)
             Select Case i
                 'Видимость изменений/обновлений экрана
                 Case acEnum.ScreenUpdating: .ScreenUpdating = States(i)
                 'Автоматизация вычислений
                 Case acEnum.Calculation: .Calculation = States(i)
                 'Режим отображения (таблица, постраничный)
                 Case acEnum.View: .ActiveWindow.View = States(i)
                 'События
                 Case acEnum.Events: .EnableEvents = States(i)
                 'Пересчёт разрывов страниц
                 Case acEnum.PageBreaks: .ActiveWorkbook.ActiveSheet.DisplayPageBreaks = States(i)
                 'Оповещения
                 Case acEnum.DisplayAlerts: .DisplayAlerts = States(i)
                 'Статус-бар
                 Case acEnum.DisplayStatusBar: .DisplayStatusBar = States(i)
                 'Фоновый поск ошибок:
                 Case acEnum.BackgroundChecking: .ErrorCheckingOptions.BackgroundChecking = States(i)
                 'Обработка даты введённая в текстовом формате
                 Case acEnum.TextDate: .ErrorCheckingOptions.TextDate = States(i)
             End Select
         Next
     End With
End Sub

Function IsExcelApp(obj As Object) As Boolean
    If typeName(obj) = "Application" Then
        If obj.Name = "Microsoft Excel" Then
            IsExcelApp = True
            Exit Function
        End If
    End If
    IsExcelApp = False
End Function
