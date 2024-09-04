VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSR"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public prnt As colSU

Private offsetY As Double

Public originY As Double
Public row_height As Double

Public cells As Collection
'Public fields As Collection
'Public lines As Collection

Public msapp As Object

Public iLevelCount As Integer

'/******************************************************************************
Public Function getWidth(Optional iStartCol As Integer = 1, Optional iEndCol As Integer = 7) As Double
'/******************************************************************************

    On Error GoTo getWidth_ERR
    
    Dim w As Double
    
    Dim i As Integer
    For i = iStartCol To iEndCol
        w = w + arSpecCol(i)
    Next i
    
    getWidth = w

Exit Function

getWidth_ERR:
    getWidth = w

End Function


Public Function addLevel(iLev As Integer, Optional rowspecconfig As clsSCfg = Nothing)

    Dim c As clsSRU
    Dim bFree As Boolean
    
    Set cells = New Collection
    
    Set c = New clsSRU
    c.setParams arSpecCol(1), 0#, 0#, Me, iLev
    cells.Add c, iLev & ":1"
    
    Dim SC As clsSCfg
    
    If rowspecconfig Is Nothing And curSpecCfg Is Nothing Then
        Exit Function
    ElseIf rowspecconfig Is Nothing Then
        Set SC = curSpecCfg
        bFree = True
    ElseIf curSpecCfg Is Nothing Then
        Set SC = rowspecconfig
        bFree = True
    End If
    
    If SC.iColCnt > 1 Then
        Set c = New clsSRU
        c.setParams arSpecCol(2), 0#, arSpecCol(1), Me, iLev
        cells.Add c, iLev & ":2"
    End If
    
    If SC.iColCnt > 2 Then
        Set c = New clsSRU
        c.setParams arSpecCol(3), 0#, arSpecCol(1) + arSpecCol(2), Me, iLev
        cells.Add c, iLev & ":3"
    End If
        
    If SC.iColCnt > 3 Then
        Set c = New clsSRU
        c.setParams arSpecCol(4), 0#, arSpecCol(1) + arSpecCol(2) + arSpecCol(3), Me, iLev
        cells.Add c, iLev & ":4"
    End If
        
    If SC.iColCnt > 4 Then
        Set c = New clsSRU
        c.setParams arSpecCol(5), 0#, arSpecCol(1) + arSpecCol(2) + arSpecCol(3) + arSpecCol(4), Me, iLev
        cells.Add c, iLev & ":5"
    End If
        
    If SC.iColCnt > 5 Then
        Set c = New clsSRU
        c.setParams arSpecCol(6), 0#, arSpecCol(1) + arSpecCol(2) + arSpecCol(3) + arSpecCol(4) + arSpecCol(5), Me, iLev
        cells.Add c, iLev & ":6"
    End If
        
    If SC.iColCnt > 6 Then
        Set c = New clsSRU
        c.setParams arSpecCol(7), 0#, arSpecCol(1) + arSpecCol(2) + arSpecCol(3) + arSpecCol(4) + arSpecCol(5) + arSpecCol(6), Me, iLev
        cells.Add c, iLev & ":7"
    End If
        
    If SC.iColCnt > 7 Then
        Set c = New clsSRU
        c.setParams arSpecCol(8), 0#, arSpecCol(1) + arSpecCol(2) + arSpecCol(3) + arSpecCol(4) + arSpecCol(5) + arSpecCol(6) + arSpecCol(7), Me, iLev
        cells.Add c, iLev & ":8"
    End If
    
    Set c = Nothing
    
    If bFree Then Set SC = Nothing

    iLevelCount = iLevelCount + 1

End Function

Private Sub Class_Initialize()
    
    
    row_height = dSpecRowHeight
    
    Set msapp = getMS
    
    Set cells = New Collection
'    Set fields = New Collection
'    Set lines = New Collection
    
    addLevel 0
    

    
    
End Sub

Private Sub Class_Terminate()

    Set msapp = Nothing

    Set cells = Nothing
'    Set fields = Nothing
'    Set lines = Nothing
    

End Sub



'/******************************************************************************
Public Function setOffsetY(Y As Double) As Double
'/******************************************************************************

    On Error GoTo setOffset_ERR

    offsetY = Y
    
    Dim c As clsSRU
    
    Dim d As Double
    Dim offs As Double
    
    If Not prnt Is Nothing Then
        d = prnt.originY
    End If
    
    offs = d + Y
    
    For Each c In cells
        c.sru_offsetY = offs
    Next c
    



setOffset_ERR:
    setOffsetY = Y + row_height

End Function



'/******************************************************************************
Public Sub setOffset(Y As Double)
'/******************************************************************************

    On Error GoTo setOffset_ERR

    offsetY = Y
    
    Dim c As clsSRU
    
    Dim d As Double
    
    If Not prnt Is Nothing Then
        d = prnt.originY
    End If
    
    For Each c In cells
        c.sru_offsetY = d + Y
    Next c


Exit Sub

setOffset_ERR:

End Sub


'/******************************************************************************
Public Sub drawRow(orY As Double, Optional bBottom As Boolean = False)
'/******************************************************************************
    
    
    On Error GoTo draw_ERR
    
    originY = orY
    
    Dim c As clsSRU
    Dim Y As Double
    
    For Each c In cells
        c.drawRowUnit False, False, False
        Y = mspoint.Y - c.sru_offsetY
    Next c
    
    
    Dim X(1) As Double
    
    X(0) = Me.prnt.offsetX + mspoint.X
    X(1) = Me.prnt.offsetX + mspoint.X + getWidth(1, cells.Count)
    
    Call drawLineXY(msapp, X(0), Y, X(1), Y, curSpecCfg.spec_h_line_wdt)

    If bBottom Then
        Call drawLineXY(msapp, X(0), Y - row_height, X(1), Y - row_height, curSpecCfg.spec_v_line_wdt) ' bottom line wieght like vertical
    End If
    
    Exit Sub
    
draw_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "drawRow - Error"
    
End Sub
