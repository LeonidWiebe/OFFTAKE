VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSRUT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

  Public KEY As String
  Public sText As String
  Public bDopText As Boolean
  Public sCellSymbol As String
  Public just As TextJustification
  Public dScaleX As Double  ' relative to cell width and height
  Public dScaleY As Double  ' relative to cell width and height
  Public dTextHeight As Double
  Public dTextWidth As Double
  Public bPress As Boolean
  Public bUnderLine As Boolean
  Public bOverLine As Boolean
  Public bIsNumber As Boolean
  Public bForceDots As Boolean
  
  Public sValueType As String
  Public sValueSource As String
  
  Private dTextRightX As Double
  
  Private width As Double
  
  Public maxwdt As Double
  
  Public rtSuffix As clsSRUT
  
  Dim msapp As Object
  

Private Sub Class_Initialize()
    
    just = cc
    dScaleX = 0.5
    dScaleY = 0.5
    dTextHeight = dSpecTextHeight
    dTextWidth = dSpecTextWidth

    Set msapp = getMS
    
End Sub

'/******************************************************************************
Private Function drawReinText(stxt As String, p As Point3d, mw As Double, bLast As Boolean) As Boolean
'/******************************************************************************
    
    On Error GoTo drawReinText_ERR
    
    Dim dTR As Double
    Dim dMW As Double
    
    
    If maxwdt > 0# And maxwdt < mw Then
        dMW = maxwdt
    Else
        dMW = mw
    End If
    
    
    ' sTxt может содержать разделитель ',' поэтому он не входит в Replace
    
    If curSpecCfg.spcfgUseDots And Me.bForceDots Then stxt = Replace(stxt, ",", ".")
    
    msapp.CadInputQueue.SendMessageToApplication strReinSpec, "dt" _
                                                 & ";" & stxt _
                                                 & ";" & Replace(p.X _
                                                 & ";" & p.Y _
                                                 & ";" & dTextHeight _
                                                 & ";" & dTextWidth _
                                                 & ";" & (dTextHeight + dTextHeight / 2) _
                                                 & ";" & just _
                                                 & ";" & Abs(CInt(bUnderLine And Not bLast)) _
                                                 & ";" & Abs(CInt(bOverLine)) _
                                                 & ";" & (dTextHeight / 3#) _
                                                 & ";" & (dTextHeight / 3#) _
                                                 & ";" & iTextLevel _
                                                 & ";" & scfgCmn.spec_text_clr _
                                                 & ";" & dMW _
                                                 & ";" & msapp.CurrentGraphicGroup _
                                                 & ";" & curSpecCfg.iTextFont, ",", ".")
    
    dTR = msapp.GetCExpressionValue("trx", strReinSpec)
    
    If dTR > dTextRightX Then dTextRightX = dTR
    
    Dim el As Element
    Set el = ActiveModelReference.GetLastValidGraphicalElement
    If el.IsTextElement Then
        Call el.AsTextElement.GetTextTileSize(dTextWidth, dTextHeight)
    End If

    
    drawReinText = True
    
    Exit Function
    
drawReinText_ERR:
    
End Function



'/******************************************************************************
Public Sub drawTextUnit(X As Double, Y As Double, w As Double, h As Double)
'/******************************************************************************
    
    
    
    
    On Error GoTo draw_ERR
    
    Dim txt As TextElement
    Dim txtn As TextNodeElement
    Dim p As Point3d
    Dim a As Integer
    Dim dMaxWidth As Double
    
    Dim j As TextJustification
    Dim jn As TextJustification
    Dim ls As Double
    Dim lst As MsdTextNodeLineSpacingType
    Dim ul As Boolean
    Dim ol As Boolean
    
    width = w
    
    Dim ar() As String
    
    
    dMaxWidth = width - width * 0.05
    
    p.Y = Y
    
    If just = lc Then           ' #define     TXTJUST_LC          1   /* Left Center */
        p.X = X + dScaleX
        dMaxWidth = dMaxWidth - dScaleX
    ElseIf just = rc Then      ' #define     TXTJUST_RC          13  /* Right Center */
        p.X = X + width - dScaleX
    ElseIf just = lt Then
        p.X = X + dScaleX
        p.Y = Y + h / 2# - dScaleX
    ElseIf just = rb Then
        p.X = X + width - dScaleX
        p.Y = Y - h / 2# + dScaleX
    Else                                                    ' #define     TXTJUST_CC          7   /* Center Center */ (default)
        just = cc
        p.X = X + width * dScaleX
    End If
    
    
'    If dMaxWidth < 0 Then
'    Debug.Print ""
'    End If
    
    ' cell
    If Len(sCellSymbol) > 0 Then
        
        Dim ps As Point3d
        ps.X = dTextHeight * 1000# / ActiveModelReference.MasterUnit.UnitsPerBaseNumerator
        ps.Y = dTextHeight * 1000# / ActiveModelReference.MasterUnit.UnitsPerBaseNumerator
        
        Dim cel As CellElement
        Set cel = msapp.CreateCellElement2(sCellSymbol, p, ps, True, msapp.Matrix3dIdentity)
        cel.GraphicGroup = msapp.CurrentGraphicGroup
        cel.LineWeight = 1
        cel.Color = scfgCmn.spec_text_clr
        setLevel cel, iTextLevel, msapp
        msapp.ActiveModelReference.AddElement cel
        cel.redraw msdDrawingModeNormal
        
        p.X = p.X + dTextHeight * 1.5
    End If
    
    
    ' text
'    If bUseCoreText Then
    
        Dim iRows As Integer
        Dim i As Integer
        Dim p2 As Point3d
        
        ar = Split(sText, vbNewLine)
        
        If UBound(ar) = 0 Then
            ar = Split(sText, "|")
        End If
        
'        If UBound(ar) = 0 Then
'            ar = Split(sText, "/")
'        End If
        
        iRows = UBound(ar) + 1
        
        If iRows > 1 Then
            dTextHeight = dTextHeight * dSpecTextScale ^ (iRows - 1)
            dTextWidth = dTextWidth * dSpecTextScale ^ (iRows - 1)
        End If
        
        dTextRightX = p.X
        
        If iRows = 1 And bDopText Then
            drawLineXY msapp, p.X - w + dScaleX, p.Y - dScaleX, p.X + dScaleX, p.Y + h - dScaleX
        End If
        
        For i = 0 To UBound(ar)
            p2.X = p.X
            p2.Y = p.Y + h / 2# - (h / iRows * i + h / iRows / 2#)
            If Not drawReinText(ar(i), p2, dMaxWidth, CBool(i > 0) And CBool(i = UBound(ar))) Then
                Set txt = CreateTextElement1(Nothing, "ОШИБКА!", p2, Matrix3dIdentity)
                txt.LineWeight = 2
                txt.Color = 3
                txt.GraphicGroup = msapp.CurrentGraphicGroup
                txt.redraw msdDrawingModeNormal
                msapp.ActiveModelReference.AddElement txt
            Else
'                Set txt = ActiveModelReference.GetLastValidGraphicalElement
'                If txt.IsTextElement Then
'                    Set txt.TextStyle.Font = ActiveDesignFile.Fonts.Find(msdFontTypeWindowsTrueType, "Arial")
'                    txt.Rewrite
'                End If
            End If
        Next i
        
    
'    Else
'
''        j = msapp.ActiveSettings.TextStyle.Justification
''        jn = msapp.ActiveSettings.TextStyle.NodeJustification
''        ls = msapp.ActiveSettings.TextStyle.NodeLineSpacing
''        lst = msapp.ActiveSettings.TextStyle.NodeLineSpacingType
''        ul = msapp.ActiveSettings.TextStyle.IsUnderlined
''        ol = msapp.ActiveSettings.TextStyle.IsOverlined
''
''        msapp.ActiveSettings.TextStyle.Justification = just
''        msapp.ActiveSettings.TextStyle.NodeJustification = just
''        msapp.ActiveSettings.TextStyle.NodeLineSpacing = dTextHeight + dTextHeight / 2
''        msapp.ActiveSettings.TextStyle.NodeLineSpacingType = msdTextNodeLineSpacingTypeExactFromLineTop
''        msapp.ActiveSettings.TextStyle.IsUnderlined = bUnderLine
''        msapp.ActiveSettings.TextStyle.IsOverlined = bOverLine
''        msapp.ActiveSettings.TextStyle.OverlineOffset = dTextHeight / 3#
''        msapp.ActiveSettings.TextStyle.UnderlineOffset = dTextHeight / 3#
''
''
''        Set txt = CreateTextElement1(Nothing, sText, p, Matrix3dIdentity)
''        txt.LineWeight = 1
''        txt.Color = scfgCmn.spec_text_clr
''        setLevel txt, iTextLevel
''
''
''        ar = Split(sText, vbNewLine)
''
''        If (UBound(ar) = 0) Then
''            changeTextProps txt, True, X
''            txt.GraphicGroup = msapp.CurrentGraphicGroup
''            msapp.ActiveModelReference.AddElement txt
''        Else
''
''            Set txtn = CreateTextNodeElement1(txt, p, Matrix3dIdentity)
''
''            For A = 0 To UBound(ar)
''                txtn.AddTextLine ar(A)
''            Next A
''
''            Dim ee As ElementEnumerator
''            Set ee = txtn.GetSubElements
''
''            txtn.GraphicGroup = msapp.CurrentGraphicGroup
''
''            msapp.ActiveModelReference.AddElement txtn
''
''            Do While ee.MoveNext
''                Set txt = ee.Current
''                changeTextProps txt, True, X
''                txt.Rewrite
''            Loop
''
''        End If
''
''        msapp.ActiveSettings.TextStyle.Justification = j
''        msapp.ActiveSettings.TextStyle.NodeJustification = jn
''        msapp.ActiveSettings.TextStyle.NodeLineSpacing = ls
''        msapp.ActiveSettings.TextStyle.NodeLineSpacingType = lst
''        msapp.ActiveSettings.TextStyle.IsUnderlined = ul
''        msapp.ActiveSettings.TextStyle.IsOverlined = ol
'
'    End If
    
    
    
    
    
    
    
    
    
    
    
    
    
    If Not rtSuffix Is Nothing Then
    
        rtSuffix.bForceDots = Me.bForceDots
    
        rtSuffix.drawTextUnit dTextRightX + dTextWidth / 2#, Y, width, h
    
    End If
    
    
    
    Exit Sub
    
draw_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "draw - Error"
    
End Sub


'/******************************************************************************
Private Sub changeTextProps(ByRef txt As TextElement, bRedraw As Boolean, X As Double)
'/******************************************************************************
    
    On Error GoTo changeTextProps_ERR
    
    
    Dim r As Range3d
    Dim w As Double
    
    Dim dTextLeft As Double
    Dim dDeltaLeft As Double
    Dim dDeltaRight As Double
    Dim dScale As Double
    Dim dGap As Double
    
    dScale = 1#
    
    dGap = width * 0.02
    
    txt.TextStyle.height = dTextHeight
    txt.TextStyle.width = dTextWidth
    txt.TextStyle.IsUnderlined = bUnderLine
    
    
    r = txt.Range
    w = r.high.X - r.low.X
    
    
    If just = lc Then
        dTextLeft = X + dScaleX
    ElseIf just = rc Then
        dTextLeft = X + width - dScaleX - w
    Else ' center default
        dTextLeft = X + width * dScaleX - w / 2#
    End If
    
    dTextRightX = dTextLeft + w
    
    If dTextLeft < X + dGap Then dDeltaLeft = X + dGap - dTextLeft
    If dTextRightX > X + width - dGap Then dDeltaRight = dTextRightX - (X + width - dGap)
    
    
    If dDeltaLeft > 0# Or dDeltaRight > 0# Then
        dScale = (w - (dDeltaLeft + dDeltaRight)) / w
    Else
        dScale = 1#
    End If
    
    If bPress And dScale <> 1# Then
        txt.ScaleAll txt.origin, dScale, 1#, 1#
    End If
    
    '    txt.Rewrite
    If bRedraw Then txt.redraw msdDrawingModeNormal
    
    
    
    Exit Sub
    
changeTextProps_ERR:
    '    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "changeTextProps - Error"
    
End Sub


'/******************************************************************************
Public Function setSuffix(rut As clsSRUT, dOtstup As Double) As Boolean
'/******************************************************************************
    
    On Error GoTo setSuffix_ERR
    
    If rtSuffix Is Nothing Then
        If rut.just = lc Then
            rut.dScaleX = dOtstup ' отступ от надписи слева
            Set rtSuffix = rut
        Else
        End If
    Else
        rtSuffix.setSuffix rut, dOtstup
    End If
    
    setSuffix = True
    
    Exit Function
    
setSuffix_ERR:
    '    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setSuffix - Error"
    
End Function



Private Sub Class_Terminate()

    Set rtSuffix = Nothing
    
    Set msapp = Nothing

End Sub
