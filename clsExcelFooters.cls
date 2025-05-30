VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsExcelFooters"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'--------------------------------------------------------------------------------------------------
'   ����� ����������� �� ���������� ��������� ������ �������� ���������� ��������� ��������
'
'����������:
'   � �������� �������� ����������� ������������ ������������ ������ ������
'
'������� �����������:
'   � ����� clsExcelAcceleration
'   � ������ mExcelUtils
'---------------------------------------------------------------------------------------------------

Const C_HEADER As String = "HEADER"
Const C_FOOTER As String = "FOOTER"
Const C_AUTOGENAREA As String = "AUTOGENAREA"

Private rngHeader As Object
Private rngFooter As Object
Private rngAUTOGEN As Object

Private DataStartRowIndex As Integer

Private IsOnFirstPage As Boolean
Private IsOnLastPage As Boolean
Private AutoGenAdr As String '������ ���������������� ��������� ������ ������������

Private FooterHeight As Double

Private oBook As Object
Private sheetFooter As Object
Private sheetBuffer As Object

'��������� Excel ��� �������� � ������� �����������
'���������� Microsoft.Excel.ObjectLibrary 12.0
Public Enum xlEnum
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
    xlNormalView = 1 '"�������" �����
End Enum
'+
Private Enum xlPastType
    xlPasteAll = -4104
    xlPasteFormats = -4122
    xlPasteColumnWidths = 8
End Enum

Private Sub Class_Terminate()
    If Not sheetFooter Is Nothing Then
        sheetFooter.Delete
        Set sheetFooter = Nothing
    End If
    If Not sheetBuffer Is Nothing Then
        sheetBuffer.Delete
        Set sheetBuffer = Nothing
    End If
End Sub

'�������� ��������� ���������� ������������
Public Sub placeFooters(oSheet As Object, Optional ProgBar As Object = Nothing, Optional ByRef FootersRange As Object = Nothing)
    If Not Scan(oSheet) Then Exit Sub
   
    Dim AC As clsExcelAcceleration: Set AC = New clsExcelAcceleration
    Call AC.AccelerateExcel(oSheet.Application)
    
    Call Prepair(oSheet)

    sheetBuffer.Activate
    sheetBuffer.DisplayPageBreaks = False
    oSheet.Application.ActiveWindow.View = 1
       
    '������ �� ������ ��� ������� ��������� ��������
    Dim targetRow As Object: Set targetRow = oSheet.Rows(1)
    
    Dim Page As Object, IsOnLastPage As Boolean
    
    Dim FooterRowsCount%: FooterRowsCount = rngFooter.Rows.Count
    
    If Not ProgBar Is Nothing Then '��������� ������������
        ProgBar.Min = 0
        ProgBar.Max = LastRowIndex(sheetBuffer) + FooterRowsCount
        ProgBar.Value = 0
        ProgBar.Refresh
    End If
    
    Do While GetPageNext(Page)
        '����������� ��������������� ��������:
        Call FullCopyRange(Page, targetRow)
        Set targetRow = targetRow.Offset(Page.Rows.Count)
        
        AutoGenAdr = AutoGenAdr & "," & targetRow.Offset(-FooterRowsCount).Resize(FooterRowsCount).Address
        
        If Not ProgBar Is Nothing Then '��������� ��������
            ProgBar.Value = Abs(ProgBar.Max - LastRowIndex(sheetBuffer))
        End If
        
        If Not IsOnFirstPage Then
            Page.EntireRow.Delete
        Else
            IsOnFirstPage = False '����� ����� ������ ��������
            If Not rngHeader Is Nothing Then
                '���������� �������� ������
                oSheet.PageSetup.PrintTitleRows = rngHeader.EntireRow.Address
            
                '��� ����������� ������� ��������������� ������� ���������� ������:
                Dim hcnt%, pcnt%
                hcnt = rngHeader.Rows.Count
                pcnt = Page.Rows.Count
                
                With sheetBuffer
                    If Not rngHeader.Row = 1 Then
                        Call InsertFullCopyRange(rngHeader, .Rows(1))
                        Dim rcnt%: rcnt = rngHeader.Rows.Count
                        rngHeader.Delete
                        Set rngHeader = .Rows(1).Resize(rcnt)
                        .PageSetup.PrintTitleRows = rngHeader.Address
                    End If
                    .Range((rngHeader.Rows.Count + 1) & ":" & pcnt).Delete
                End With
            Else
                Page.EntireRow.Delete
            End If
        End If
        
        If IsOnLastPage Then Exit Do '����� ���� ���� ���������� ��������� ��������
    Loop
    
    If Not ProgBar Is Nothing Then '��������� ��������
        ProgBar.Value = ProgBar.Max
    End If
    
    If Len(AutoGenAdr) > 0 Then
        Set FootersRange = GetRange(oSheet, AutoGenAdr)
        FootersRange.Name = C_AUTOGENAREA
    End If
        
    '����������� �� ������:
    oSheet.Activate
    oSheet.cells(1, 1).Select
    
    oSheet.DisplayPageBreaks = True
    Class_Terminate
End Sub


'������������ ��������� �������� ������
Private Function GetPageNext(ByRef Page As Object) As Boolean
    Set Page = Nothing
    
    If IsOnLastPage Then GoTo L_CANCEL
    
    With sheetBuffer
        DataStartRowIndex = 1
        If .PageSetup.PrintTitleRows <> "" Then
            Dim rng As Object: Set rng = .Range(.PageSetup.PrintTitleRows)
            DataStartRowIndex = rng.Row + rng.Rows.Count
        End If
        'End If
    End With
    
    '����� ���������� ���������� ��������� ������ ��������
    Dim rngLastPageBreakMarker As Object
        
    With sheetBuffer
        If .UsedRange Is Nothing Then GoTo L_CANCEL '���
        
        '������������ ������ �����:
        If .HPageBreaks.Count = 0 Then
            .Rows(DataStartRowIndex).EntireRow.Resize(.UsedRange.Rows.Count).AutoFit '� �������
        Else
            '������ �� ������� ��������
            .Rows(DataStartRowIndex).EntireRow.Resize(.HPageBreaks(1).Location.Row).AutoFit
        End If
        
        '������ �� ��������� ������� ������
        Dim LastDataRowIndex%: LastDataRowIndex = LastRowIndex(.cells.Worksheet)
        
        If Not rngFooter Is Nothing Then
        '������ ����������:
            If .HPageBreaks.Count = 0 Then
                '����� ������� ������� �������:
                Set rngLastPageBreakMarker = .cells(LastRowIndex(.cells.Worksheet) + 1, 1)
                rngLastPageBreakMarker.Value = "!"
                While .HPageBreaks.Count = 0
                    rngLastPageBreakMarker.Cut rngLastPageBreakMarker.Offset(rngLastPageBreakMarker.Row)
                Wend
            End If
            
            Dim height As Double:
            height = FooterHeight
            
            Dim rindex% ' ����������� ������ ������ ��� ������� �����������
            rindex% = .HPageBreaks(1).Location.Row
            Do While height > 0 And rindex > 0
                rindex = rindex - 1
                height = height - .Rows(rindex).RowHeight
            Loop
            
            Dim footer As Object:
            Set footer = InsertFullCopyRange(rngFooter, .Rows(rindex))
            
            'TODO ���������:
            Dim delta%: delta = footer.Row - (.HPageBreaks(1).Location.Row - footer.Rows.Count)
            Dim repeat%: repeat = 0
            Do While delta <> 0
                If repeat > 5 Then Exit Do '����� �� ������������ �����
                repeat = repeat + 1
                
                rindex = rindex - delta
                
                footer.EntireRow.Delete
                Set footer = InsertFullCopyRange(rngFooter, .Rows(rindex))
                
                delta = footer.Row - (.HPageBreaks(1).Location.Row - footer.Rows.Count)
                
            'TODO ��������� �� ����������� ������������ �����
            'TODO ������� ������� �����������
            Loop
            
            '�������� ������ ���������� ��������� ��������:
            IsOnLastPage = footer.Row > LastDataRowIndex
        End If
        
        If .HPageBreaks.Count > 0 Then
            If IsOnFirstPage Then
                '������ ��������:
                Set Page = .Range(1 & ":" & (.HPageBreaks(1).Location.Row - 1))
            Else
                '��� �������� �����:
                Set Page = .Range(DataStartRowIndex & ":" & (.HPageBreaks(1).Location.Row - 1))
            End If
        Else
            '���
            Set Page = .Rows(DataStartRowIndex).Resize(.UsedRange.Rows.Count - DataStartRowIndex + 1)
            IsOnLastPage = True
        End If
        
    End With
    
    
L_CANCEL:
    If Not rngLastPageBreakMarker Is Nothing Then
        rngLastPageBreakMarker.Delete: Set rngLastPageBreakMarker = Nothing
    End If
    
    GetPageNext = Not Page Is Nothing
   
End Function


'������ �����
Private Function Scan(oSheet As Object) As Boolean
    If (oSheet Is Nothing Or typeName(oSheet) <> "Worksheet") Then Exit Function
    
    Dim oBook As Object: Set oBook = oSheet.parent
    
    '����������� ������� ������������:
    On Error GoTo LNext
    Dim oNamesArr(1) As Object, oNames As Variant, oName As Object
    Set oNamesArr(0) = oBook.Names: Set oNamesArr(1) = oSheet.Names
    For Each oNames In oNamesArr
        'If Not rngHeader Is Nothing And Not rngFooter Is Nothing Then Exit For
        For Each oName In oNames
            With oName
                Select Case UCase(.Name)
                    Case UCase(C_HEADER), UCase(oSheet.Name & "!" & C_HEADER), UCase("'" & oSheet.Name & "'!" & C_HEADER):
                        If .RefersToRange.Worksheet Is oSheet Then Set rngHeader = .RefersToRange
                        
                    Case UCase(C_FOOTER), UCase(oSheet.Name & "!" & C_FOOTER), UCase("'" & oSheet.Name & "'!" & C_FOOTER):
                        If .RefersToRange.Worksheet Is oSheet Then Set rngFooter = .RefersToRange
                        
                    Case UCase(C_AUTOGENAREA), UCase(oSheet.Name & "!" & C_AUTOGENAREA), UCase("'" & oSheet.Name & "'!" & C_AUTOGENAREA):
                        Set rngAUTOGEN = GetRange(oSheet, .RefersTo)
                End Select
            End With
LNext:
        Next
    Next
    
    If Not rngFooter Is Nothing Then
        Scan = True
    Else
        Scan = False
    End If
End Function

'���������� ������
Private Sub Prepair(oSheet As Object)
    Set oBook = oSheet.parent
    '��� �������� ��������� ��� ������������ ������� ��������
    Set sheetFooter = CopySheet(oSheet)
    Set sheetBuffer = CopySheet(oSheet)
    
    sheetFooter.Visible = oSheet.Application.Visible
    sheetBuffer.Visible = oSheet.Application.Visible
    
    sheetFooter.cells.Clear
    
    sheetFooter.Name = "__FOOTER__"
    sheetBuffer.Name = "__BUFFER__"
    
    AutoGenAdr = ""
    
    If (Not rngFooter Is Nothing) Then
        sheetBuffer.Range(rngFooter.Address).EntireRow.Delete
        Set rngFooter = InsertFullCopyRange(rngFooter, sheetFooter.cells(1, 1))
        
        FooterHeight = 0
        For Each Row In rngFooter.Rows
            FooterHeight = FooterHeight + Row.RowHeight
        Next
    End If
    
    With sheetBuffer
        '����������� ��������� �������� �����������:
        If (Not rngHeader Is Nothing) Then
            '������ �������� ����������� ���������� �������� ������������ ������ (�������� ������)
            If Len(.PageSetup.PrintTitleRows) > 0 Then
                Set rngHeader = Union(rngHeader, .Range(.PageSetup.PrintTitleRows))
            End If
            .Range(rngHeader.Address).EntireRow.Delete
            Set rngHeader = InsertFullCopyRange(rngHeader, sheetFooter.cells(1, 1))
            
        ElseIf Len(.PageSetup.PrintTitleRows) > 0 Then
            Set rngHeader = .Range(.PageSetup.PrintTitleRows)
        End If
    End With
    
    '����� ������ ������ ������:
    IsOnFirstPage = True
    IsOnLastPage = False
    
    DataStartRowIndex = 1
    If Not rngHeader Is Nothing Then
        DataStartRowIndex = rngHeader.Rows(rngHeader.Rows.Count).Row + 1
    End If
    
    '��������� ������� ���������� ����� �������� ������������ ������:
    With sheetBuffer
        .PageSetup.PrintTitleRows = ""
        If Not rngHeader Is Nothing Then
            .PageSetup.PrintTitleRows = rngHeader.Address
        End If
    End With
    
    oSheet.cells.Clear
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

Public Function Union(rng1 As Object, rng2 As Object) As Object
    Dim rmin%: rmin = Min(rng1.Row, rng2.Row)
    Dim rmax%: rmax = Max(rng1.Row + rng1.Rows.Count - 1, rng2.Row + rng2.Rows.Count - 1)
    Set Union = rng1.Worksheet.Range(rmin & "&" & rmax)
End Function


Function CopySheet(oSheet As Object) As Object
    If oSheet Is Nothing Then Exit Function
    oSheet.copy before:=oSheet
    Set CopySheet = oSheet.Previous
End Function

'������ ����� � ������������� �������������� � ������ ����� � ����� ��������
Function FullCopyRange(source As Object, destination As Object, Optional ByVal FormatsOnly As Boolean = False) As Object
    '! ������� ������������ � �� �� ������ ��������, ��� � � �������� ���������

    Dim start As Object: Set start = destination.cells(1, 1)
    Dim last As Object: Set last = start.Offset(source.Rows.Count - 1, source.Columns.Count - 1)
            
    source.EntireRow.copy 'EntireRow  - ��� �������� ������ �����
    
    Dim resRng As Object
    Set resRng = destination.Resize(source.Rows.Count, source.Columns.Count).EntireRow
        
    '���������� ������ �����:
    resRng.EntireRow.PasteSpecial xlPasteFormats ', xlPasteSpecialOperationNone, False, False
    If Not FormatsOnly Then
        '������� ������:
        resRng.PasteSpecial xlPasteAll ', xlPasteSpecialOperationNone, False, False
    End If

    '���������� ������ ��������:
    resRng.PasteSpecial xlPasteColumnWidths ', xlPasteSpecialOperationNone, False, False
    
    Set FullCopyRange = resRng
End Function

'������� ����� ���������
Function InsertFullCopyRange(source As Object, destination As Object, Optional ByVal FormatsOnly As Boolean = False) As Object
    Dim Address As String: Address = destination.Address
    Dim rng As Object: Set rng = destination.Resize(source.Rows.Count, source.Columns.Count).EntireRow '!����� .EntireRow - � ����� �����
    rng.Insert xlDown
    Set InsertFullCopyRange = FullCopyRange(source, destination.Worksheet.Range(Address), FormatsOnly)
End Function

Function GetRange(wsh As Object, ByVal Address As String) As Object
    If Len(Address) = 0 Then Exit Function
    
    Const MAXSIZE = 255
    Dim rng As Object, adr, buf$, i%, dltr$
        
        
'����������� ����������� ������� ����������
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
    
    If Len(Address) > MAXSIZE Then '��������� Range(Address) �� ��������� � �������� ������ ������ ������ ������ 255/256 ��������
        i = 0:  buf = ""
        Dim Addresses() As String: ReDim Addresses(0)
        
        For Each adr In Split(Address, dltr)
            i = i + 1 + Len(adr) '� ������ �������
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
End Function

Public Function LastRowIndex(wSheet As Object) As Integer
    With wSheet.UsedRange.Find("*", wSheet.cells(1, 1), xlValues, xlPart, xlByRows, xlPrevious, False)
        LastRowIndex = .CurrentRegion.Rows(.CurrentRegion.Rows.Count).Row
    End With
End Function


