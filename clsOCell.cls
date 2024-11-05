VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsOCell"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public sText As String
Public offt_cell_width As Double
Public offt_cell_height As Double
Private origin As Point3d
Public iLevel As Integer

Private aText() As String
Public iTextCount As Integer

Public dTxtHeight As Double
Public dTxtWidth As Double

Public iTextColorOver As Long

Dim msapp As Object

Public tbl As colOG

Private Sub Class_Initialize()
'

    'dTxtHeight = 3# * dSpecCmnScale
    'dTxtWidth = 2.4 * dSpecCmnScale
    
    If curSpecCfg.dTextHgt > 0 Then
        dTxtHeight = curSpecCfg.dTextHgt * dSpecCmnScale
    Else
        dTxtHeight = 3# * dSpecCmnScale
    End If
    
    If curSpecCfg.dTextWdt > 0 Then
        dTxtWidth = curSpecCfg.dTextWdt * dSpecCmnScale
    Else
        dTxtWidth = 2.4 * dSpecCmnScale
    End If
    
    iTextColorOver = -1
    
    Set msapp = getMS


End Sub

Private Sub Class_Terminate()
    Set msapp = Nothing
'
End Sub

''/******************************************************************************
'Public Sub addText(txt As String)
''/******************************************************************************
'
''    'On Error GoTo addText90_ERR
'
'    iTextCount = iTextCount + 1
'    ReDim Preserve aText(1 To iTextCount)
'    aText(iTextCount) = txt
'
'
'
'Exit Sub
'
'addText90_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "addText90 - Error"
'
'End Sub


'/******************************************************************************
Public Sub setOriginXY(X As Double, Y As Double)
'/******************************************************************************

    On Error GoTo setOrigin_ERR


    
    origin.X = X
    origin.Y = Y


Exit Sub

setOrigin_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setOrigin - Error"

End Sub

'/******************************************************************************
Public Sub setOriginY(Y As Double)
'/******************************************************************************

    On Error GoTo setOriginY_ERR

    origin.Y = Y


Exit Sub

setOriginY_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setOriginY - Error"

End Sub



'/******************************************************************************
Public Sub setOriginX(X As Double)
'/******************************************************************************

    On Error GoTo setOriginX_ERR

    origin.X = X


Exit Sub

setOriginX_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setOriginX - Error"

End Sub



'/******************************************************************************
Public Sub setOriginP(p As Point3d)
'/******************************************************************************

    On Error GoTo setOriginP_ERR


    origin.X = p.X
    origin.Y = p.Y
    origin.z = p.z


Exit Sub

setOriginP_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setOriginP - Error"

End Sub


'/******************************************************************************
Public Property Get ORGN() As Point3d
'/******************************************************************************

    On Error GoTo ORGN_ERR

    ORGN = origin

Exit Property

ORGN_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "ORGN - Error"

End Property

'/******************************************************************************
Public Sub drawOfftCell_old()
'/******************************************************************************
    
    On Error GoTo draw_ERR
    
    If msapp Is Nothing Then Exit Sub
    
    Dim ee As ElementEnumerator
    
    Dim bSep As Boolean
    
    Dim po As Point3d
    Dim ar() As String
    
    If Not tbl Is Nothing Then
        po = tbl.ORGN
    End If
    
    
    Dim dTHrem As Double
    Dim dTWrem As Double
    
    
    
    
'    dTHrem = msapp.ActiveSettings.TextStyle.height
'    dTWrem = msapp.ActiveSettings.TextStyle.width

'    Debug.Print dTextHeight + dTextHeight / 2

    'If left(Me.sText, 5) = "“руба" Then
    'Debug.Print
    'End If
  
    msapp.ActiveSettings.TextStyle.Justification = msdTextJustificationCenterCenter
    msapp.ActiveSettings.TextStyle.NodeJustification = msdTextJustificationCenterCenter
    msapp.ActiveSettings.TextStyle.NodeLineSpacingType = msdTextNodeLineSpacingTypeExact
    msapp.ActiveSettings.TextStyle.NodeLineSpacing = dTxtHeight + dTxtHeight / 2
    msapp.ActiveSettings.TextStyle.height = dTxtHeight
    msapp.ActiveSettings.TextStyle.width = dTxtWidth
    
    
    Dim txtn As TextNodeElement
    Dim p As Point3d
    
    p.X = po.X + origin.X + offt_cell_width / 2
    p.Y = po.Y + origin.Y - offt_cell_height / 2
    p.z = 0#
    
    If Not drawLineXY(msapp, po.X + origin.X, _
               po.Y + origin.Y, _
               po.X + origin.X + offt_cell_width, _
               po.Y + origin.Y) Then Exit Sub
    If Not drawLineXY(msapp, po.X + origin.X, _
               po.Y + origin.Y - offt_cell_height, _
               po.X + origin.X + offt_cell_width, _
               po.Y + origin.Y - offt_cell_height) Then Exit Sub
    
    If Not drawLineXY(msapp, po.X + origin.X, _
               po.Y + origin.Y, _
               po.X + origin.X, _
               po.Y + origin.Y - offt_cell_height) Then Exit Sub
    If Not drawLineXY(msapp, po.X + origin.X + offt_cell_width, _
               po.Y + origin.Y, _
               po.X + origin.X + offt_cell_width, _
               po.Y + origin.Y - offt_cell_height) Then Exit Sub
    
    If Len(Trim(Me.sText)) = 0 Then Exit Sub
    
    Dim i As Integer
    
    
    ar = Split(Me.sText, "!")
    
    If UBound(ar) > 0 Then ' многоуровнева€ выборка
    
        For i = 0 To UBound(ar)
        
            If Not drawLineXY(msapp, po.X + origin.X, _
                       po.Y + origin.Y - offt_cell_height / (UBound(ar) + 1) * (i + 1), _
                       po.X + origin.X + offt_cell_width, _
                       po.Y + origin.Y - offt_cell_height / (UBound(ar) + 1) * (i + 1)) Then Exit Sub
        
        Next i
        
        msapp.ActiveSettings.TextStyle.NodeLineSpacing = offt_cell_height / (UBound(ar) + 1) - dTxtHeight
        msapp.ActiveSettings.TextStyle.NodeLineSpacingType = msdTextNodeLineSpacingTypeExact
        bSep = True
        
    End If
    
    
    
    
    Dim txt As TextElement
    Set txt = CreateTextElement1(Nothing, Me.sText, p, Matrix3dIdentity)
    txt.TextStyle.Justification = msdTextJustificationCenterCenter
    txt.TextStyle.NodeJustification = msdTextJustificationCenterCenter
    txt.LineWeight = 1
    
    If iTextColorOver = -1 Then
        txt.Color = scfgCmn.spec_text_clr
    Else
        txt.Color = iTextColorOver
    End If
    
    
    
    If UBound(ar) = 0 Then ar = Split(Me.sText, vbCrLf)
    
    
    
    
    
    Set txtn = CreateTextNodeElement1(txt, p, Matrix3dIdentity)
    
    Dim j As Integer
    
    
    For i = 0 To UBound(ar)
        txtn.AddTextLine Replace(ar(i), "|", " ")
    Next i
    

    
    
    Dim h As Double
    Dim w As Double
    Dim dScX As Double
    Dim dScY As Double
    
    w = Abs(txtn.Range.high.X - txtn.Range.low.X)
    h = Abs(txtn.Range.high.Y - txtn.Range.low.Y)
    
    If w > offt_cell_width Then
    
        If bSep = False Then msapp.ActiveSettings.TextStyle.NodeLineSpacing = dTxtHeight / 2
        
        Set txtn = CreateTextNodeElement1(txt, p, Matrix3dIdentity)

    
        For i = 0 To UBound(ar)
        
            Dim Arr() As String
            
            Arr = Split(ar(i), "|")
            
            If UBound(Arr) > 0 Then
                For j = 0 To UBound(Arr)
                    txtn.AddTextLine Trim(Arr(j))
                Next j
            Else
                txtn.AddTextLine ar(i)
            End If
            
        Next i
    
    End If
    
    
    txtn.Level = ActiveDesignFile.Levels.FindByCode(iTextLevel)
    txtn.GraphicGroup = msapp.CurrentGraphicGroup
    
    msapp.ActiveModelReference.AddElement txtn
    
    
    
    
    w = Abs(txtn.Range.high.X - txtn.Range.low.X)
    h = Abs(txtn.Range.high.Y - txtn.Range.low.Y)
    
    If w > offt_cell_width Then
        dScX = offt_cell_width / w * 0.95
    Else
        dScX = 1#
    End If
    
    If h > offt_cell_height Then
        dScY = offt_cell_height / h
    Else
        dScY = 1#
    End If
    
    
    
    
    
    If dScX < 1 Or dScY < 1 Then
        txtn.ScaleAll p, dScX, dScY, 1#
        txtn.Rewrite
    End If
    
    txtn.redraw msdDrawingModeNormal
    
    Exit Sub
    
draw_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "draw - Error"
    
End Sub



'/******************************************************************************
Public Sub drawOfftCell()
'/******************************************************************************
    
    On Error GoTo draw_ERR
    
    If msapp Is Nothing Then Exit Sub
    
    Dim ee As ElementEnumerator
    
    Dim bSep As Boolean
    
    Dim po As Point3d
    Dim ar() As String
    Dim art() As String
    
    If Not tbl Is Nothing Then
        po = tbl.ORGN
    End If
    
    
    Dim dTHrem As Double
    Dim dTWrem As Double
    
    
'    dTHrem = msapp.ActiveSettings.TextStyle.height
'    dTWrem = msapp.ActiveSettings.TextStyle.width

'    Debug.Print dTextHeight + dTextHeight / 2

    'If left(Me.sText, 5) = "“руба" Then
    'Debug.Print
    'End If
  
    msapp.ActiveSettings.TextStyle.Justification = msdTextJustificationCenterCenter
    msapp.ActiveSettings.TextStyle.NodeJustification = msdTextJustificationCenterCenter
    msapp.ActiveSettings.TextStyle.NodeLineSpacingType = msdTextNodeLineSpacingTypeExact
    msapp.ActiveSettings.TextStyle.NodeLineSpacing = dTxtHeight + dTxtHeight / 2
    msapp.ActiveSettings.TextStyle.height = dTxtHeight
    msapp.ActiveSettings.TextStyle.width = dTxtWidth
    
'    If curSpecCfg.iTextFont = 226 Then
'        msapp.ActiveSettings.TextStyle.Font = ActiveDesignFile.Fonts.Find(msdFontTypeMicroStation, "romandw")
'    ElseIf curSpecCfg.iTextFont = 1024 Then
'        msapp.ActiveSettings.TextStyle.Font = ActiveDesignFile.Fonts.Find(msdFontTypeWindowsTrueType, "Arial")
'    End If
    
    
    
    Dim txtn As TextNodeElement
    Dim p As Point3d
    
    p.X = po.X + origin.X + offt_cell_width / 2
    p.Y = po.Y + origin.Y - offt_cell_height / 2
    p.z = 0#
    
    If Not drawLineXY(msapp, po.X + origin.X, _
               po.Y + origin.Y, _
               po.X + origin.X + offt_cell_width, _
               po.Y + origin.Y) Then Exit Sub
    If Not drawLineXY(msapp, po.X + origin.X, _
               po.Y + origin.Y - offt_cell_height, _
               po.X + origin.X + offt_cell_width, _
               po.Y + origin.Y - offt_cell_height) Then Exit Sub
    
    If Not drawLineXY(msapp, po.X + origin.X, _
               po.Y + origin.Y, _
               po.X + origin.X, _
               po.Y + origin.Y - offt_cell_height) Then Exit Sub
    If Not drawLineXY(msapp, po.X + origin.X + offt_cell_width, _
               po.Y + origin.Y, _
               po.X + origin.X + offt_cell_width, _
               po.Y + origin.Y - offt_cell_height) Then Exit Sub
    
    If Len(Trim(Me.sText)) = 0 Then Exit Sub
    
    Dim i As Integer
    Dim txt As TextElement
    
    
    ar = Split(Me.sText, "!") ' разбивка по уровн€м (если есть)
    
    
    For i = 0 To UBound(ar)
    
        Dim hht As Double
        
        hht = offt_cell_height / (UBound(ar) + 1) * (i + 1)
    
        If Not drawLineXY(msapp, po.X + origin.X, _
                   po.Y + origin.Y - hht, _
                   po.X + origin.X + offt_cell_width, _
                   po.Y + origin.Y - hht) Then Exit Sub
    
        If (UBound(ar) = 0) Then
            p.Y = po.Y + origin.Y - hht + offt_cell_height / 2
        Else
            p.Y = po.Y + origin.Y - hht + (offt_cell_height / (UBound(ar) + 1)) / 2
        End If
    
        Set txt = CreateTextElement1(Nothing, ar(i), p, Matrix3dIdentity)
        txt.TextStyle.Justification = msdTextJustificationCenterCenter
        txt.TextStyle.NodeJustification = msdTextJustificationCenterCenter
        txt.LineWeight = 1
    
        If iTextColorOver = -1 Then
            txt.Color = curSpecCfg.spec_text_clr
        Else
            txt.Color = iTextColorOver
        End If
        
        Debug.Print txt.Color
        
        
        art = Split(ar(i), vbCrLf)
    
        Set txtn = CreateTextNodeElement1(txt, p, Matrix3dIdentity)
    
        Dim j As Integer
        Dim k As Integer
        
        ' дл€ вы€снени€ габаритов
        For k = 0 To UBound(art)
            txtn.AddTextLine Replace(art(k), "|", " ")
        Next k
        
        Dim h As Double
        Dim w As Double
        Dim dScX As Double
        Dim dScY As Double
        
        w = Abs(txtn.Range.high.X - txtn.Range.low.X)
        h = Abs(txtn.Range.high.Y - txtn.Range.low.Y)
        
        If w > offt_cell_width Then
        
            msapp.ActiveSettings.TextStyle.NodeLineSpacing = dTxtHeight / 2
            
            Set txtn = CreateTextNodeElement1(txt, p, Matrix3dIdentity)
    
        
            For k = 0 To UBound(art)
            
                Dim Arr() As String
                
                Arr = Split(art(k), "|")
                
                If UBound(Arr) = 0 Then Arr = Split(art(k), "/")
                
                If UBound(Arr) > 0 Then
                    For j = 0 To UBound(Arr)
                        txtn.AddTextLine Trim(Arr(j))
                    Next j
                Else
                    txtn.AddTextLine art(k)
                End If
                
            Next k
        
        End If
        
        
        txtn.Level = ActiveDesignFile.Levels.FindByCode(iTextLevel)
        txtn.GraphicGroup = msapp.CurrentGraphicGroup
        
        
'        If iTextColorOver = -1 Then
'            txtn.Color = curSpecCfg.spec_text_clr
'        Else
'            txtn.Color = iTextColorOver
'        End If
        
        msapp.ActiveModelReference.AddElement txtn
        
        
        
        
        w = Abs(txtn.Range.high.X - txtn.Range.low.X)
        h = Abs(txtn.Range.high.Y - txtn.Range.low.Y)
        
        If w > offt_cell_width Then
            dScX = offt_cell_width / w * 0.95
        Else
            dScX = 1#
        End If
        
        If h > offt_cell_height Then
            dScY = offt_cell_height / h
        Else
            dScY = 1#
        End If
        
        
        
        If dScX < 1 Or dScY < 1 Then
            txtn.ScaleAll p, dScX, dScY, 1#
            txtn.Rewrite
        End If
        
        txtn.redraw msdDrawingModeNormal
        
    Next i
    
    
    Exit Sub
    
draw_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "draw - Error"
    
End Sub
