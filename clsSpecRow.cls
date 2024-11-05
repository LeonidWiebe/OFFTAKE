VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSpecRow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public prnt As colSU

Public iRowColPos As Integer ' position in rows collection

Public textfields As Collection
Public hlines As Collection
Public vlines As Collection

Public bIsTop As Boolean
Public bIsBot As Boolean

Public bTextShift As Boolean
Public dTextShift As Double

Public dRowHeight As Double ' ïàðàìåòð, ÎÏÐÅÄÅËßÞÙÈÉ âûñîòó ñòðîêè

' ÏÐÈ ÄÎÁÀÂËÅÍÈÈ ÏÀÐÀÌÅÒÐÎÂ ÍÅ ÇÀÁÛÂÀÒü ÏÐÎ INIT

Public Sub Init(srow As clsSpecRow)

    Set prnt = srow.prnt
    
    iRowColPos = srow.iRowColPos
    
    dRowHeight = srow.dRowHeight
    
    bTextShift = False
    dTextShift = 0
    
    Dim stxt As clsSpecText
    Dim slin As clsSpecLine
    
    Dim stxt2 As clsSpecText
    Dim slin2 As clsSpecLine
    
    Set textfields = New Collection
    For Each stxt In srow.textfields
        Set stxt2 = New clsSpecText
        stxt2.Init stxt, Me
        textfields.Add stxt2
        Set stxt2 = Nothing
    Next
    
    Set hlines = New Collection
    For Each slin In srow.hlines
        Set slin2 = New clsSpecLine
        slin2.Init slin, Me
        hlines.Add slin2
        Set slin2 = Nothing
    Next
    
    Set vlines = New Collection
    For Each slin In srow.vlines
        Set slin2 = New clsSpecLine
        slin2.Init slin, Me
        vlines.Add slin2
        Set slin2 = Nothing
    Next
    
    bIsTop = srow.bIsTop
    bIsBot = srow.bIsBot
    

End Sub



Public Property Get SPECROW_POINT_UNIT() As clsSpecLine

    Dim retpt As New clsSpecLine
'    Y = 0 äëÿ âñåõ þíèòîâ
'    X = 0 äëÿ ïåðâîãî þíèòà


    Set SPECROW_POINT_UNIT = retpt

    If iRowColPos = 0 Or prnt Is Nothing Then
        Exit Property
    End If
    
    Dim sr As clsSpecRow
    
    
    For Each sr In prnt
        If sr.iRowColPos = iRowColPos Then Exit For
        retpt.lin_endY = retpt.lin_endY - sr.dRowHeight
        retpt.lin_startY = retpt.lin_startY - sr.dRowHeight
    Next sr
    
    
    If Not prnt Is Nothing Then
    
        retpt.lin_startX = retpt.lin_startX + prnt.originX
        retpt.lin_startY = retpt.lin_startY + prnt.originY
    
        retpt.lin_endX = retpt.lin_endX + prnt.originX
        retpt.lin_endY = retpt.lin_endY + prnt.originY
    
    End If
    
    

    Set SPECROW_POINT_UNIT = retpt



End Property



'/******************************************************************************
Public Property Get getWidth(Optional iStartCol As Integer = 0, Optional iEndCol As Integer = 0) As Double
'/******************************************************************************

    On Error GoTo getWidth_ERR
    
    getWidth = 0#
    
    If vlines Is Nothing Then Exit Property
    If vlines.Count = 0 Then Exit Property
    
    Dim ln1 As clsSpecLine
    Dim ln2 As clsSpecLine
    
    If iStartCol > 0 And iEndCol > 0 And iEndCol >= iStartCol And iEndCol <= vlines.Count Then
        Set ln1 = vlines(iStartCol)
        Set ln2 = vlines(iEndCol)
    Else
        Set ln1 = vlines(1)
        Set ln2 = vlines(vlines.Count)
    End If
    
    
    getWidth = ln2.lin_startX - ln1.lin_startX

Exit Property

getWidth_ERR:
    getWidth = 0#

End Property



Private Sub Class_Initialize()
    
    
    
    Set textfields = New Collection
    Set vlines = New Collection
    Set hlines = New Collection
    
    
    
End Sub

Private Sub Class_Terminate()



    Set textfields = Nothing
    Set vlines = Nothing
    Set hlines = Nothing
    

End Sub




'/******************************************************************************
Public Sub drawSpecRow()
'/******************************************************************************
    
    
    On Error GoTo draw_ERR
    

    
    Exit Sub
    
draw_ERR:
    
End Sub
