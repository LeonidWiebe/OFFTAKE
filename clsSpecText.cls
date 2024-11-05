VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSpecText"
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
  Public maxwdt As Double
  
  Public iMaxTextLength As Integer
  
  Public sValueType As String
  Public sValueSource As String
  Public sElemType As String
  
  Public sLevelDep As String
  Public sShiftDep As String
  
  Private dTextRightX As Double
  
  Private width As Double
  
  
  Public rtSuffix As clsSpecText
  
  Public stlines As Collection
  
  Public prntRow As clsSpecRow
  
  Public txtoriginX As Double
  Public txtoriginY As Double
  Public txtoriginZ As Double
  
  Public dTextShift As Double
  Public bTextShift As Boolean
  

Public txtTemplate As TextElement


Public colDopText As New Collection

' œ–» ƒŒ¡¿¬À≈Õ»» œ¿–¿Ã≈“–Œ¬ Õ≈ «¿¡€¬¿“¸ œ–Œ INIT


Private Sub Class_Initialize()
    
    just = cc
    dScaleX = 0.5
    dScaleY = 0.5
    
    iMaxTextLength = 300

    Set stlines = New Collection
    
End Sub


Private Sub Class_Terminate()

    Set rtSuffix = Nothing
    
    Set stlines = Nothing

End Sub


 Sub Init(stin As clsSpecText, sr As clsSpecRow)
 
    Set prntRow = sr
 
    KEY = stin.KEY
    sText = stin.sText
    bDopText = stin.bDopText
    sCellSymbol = stin.sCellSymbol
    just = stin.just
    dScaleX = stin.dScaleX ' relative to cell width and height
    dScaleY = stin.dScaleY ' relative to cell width and height
    dTextHeight = stin.dTextHeight
    dTextWidth = stin.dTextWidth
    bPress = stin.bPress
    bUnderLine = stin.bUnderLine
    bOverLine = stin.bOverLine
    bIsNumber = stin.bIsNumber
    bForceDots = stin.bForceDots
    
    txtoriginX = stin.txtoriginX
    txtoriginY = stin.txtoriginY
    txtoriginZ = stin.txtoriginZ
    
    sValueType = stin.sValueType
    sValueSource = stin.sValueSource
    
    maxwdt = stin.maxwdt
    iMaxTextLength = stin.iMaxTextLength

   
    If Not stin.rtSuffix Is Nothing Then
        Set rtSuffix = New clsSpecText
        rtSuffix.Init stin.rtSuffix, sr
    End If
    
    
    Dim st As New clsSpecText
    Dim st2 As New clsSpecText
    
    Set stlines = New Collection
    For Each st In stin.stlines
        Set st2 = New clsSpecText
        st2.Init st, sr
        stlines.Add st2
        Set st2 = Nothing
    Next
    
    Set Me.txtTemplate = stin.txtTemplate
    


End Sub


Public Function createFromMSText(txt As TextElement, sr As clsSpecRow, Optional pOffset As clsSpecLine = Nothing) As Boolean
    
    If txt Is Nothing Then Exit Function
    
    KEY = txt.text
    sText = txt.text
    
    just = txt.TextStyle.Justification
    dTextHeight = txt.TextStyle.height
    dTextWidth = txt.TextStyle.width
    bUnderLine = txt.TextStyle.IsUnderlined
    bOverLine = txt.TextStyle.IsOverlined
    If Me.sValueType = "directshift" Then Me.iMaxTextLength = Len(txt.text)
    
    Dim dOffsX As Double
    Dim dOffsY As Double
    Dim dOffsZ As Double
    
    Set prntRow = sr
    
    If Not pOffset Is Nothing Then
        dOffsX = pOffset.lin_endX
        dOffsY = pOffset.lin_endY
        dOffsZ = pOffset.lin_endZ
    End If
    
    txtoriginX = txt.origin.X - dOffsX
    txtoriginY = txt.origin.Y - dOffsY
    txtoriginZ = txt.origin.z - dOffsZ
    
    Set Me.txtTemplate = txt.Clone()
    
    
'    bIsNumber=
'    bForceDots=

End Function

Public Function createFromMSTextNode(txtnode As TextNodeElement, sr As clsSpecRow, Optional pOffset As clsSpecLine = Nothing) As Boolean

    If txtnode Is Nothing Then Exit Function
    
    Dim ee As ElementEnumerator
    Dim ele As Element
    
    Set prntRow = sr
    
    If txtnode.TextLinesCount = 1 Then
        Set ee = txtnode.GetSubElements
        ee.MoveNext
        Set ele = ee.Current
        If ele.IsTextElement Then
            createFromMSTextNode = Me.createFromMSText(ele, sr, pOffset)
        End If
    ElseIf txtnode.TextLinesCount > 1 Then
        Set ee = txtnode.GetSubElements
        Do While ee.MoveNext
            Set ele = ee.Current
            If ele.IsTextElement Then
            
                Dim st As New clsSpecText
                If st.createFromMSText(ele, sr, pOffset) Then
                    stlines.Add st
                End If
                Set st = Nothing
            
            End If
        Loop
        createFromMSTextNode = CBool(stlines.Count > 0)
    End If
    


End Function

'
'
''/******************************************************************************
'Private Function drawSpecTextRein(stxt As String, p As Point3d, mw As Double, bLast As Boolean) As Boolean
''/******************************************************************************
'
'    On Error GoTo drawReinText_ERR
'
'    Dim dTR As Double
'    Dim dMW As Double
'
'
'    If maxwdt > 0# And maxwdt < mw Then
'        dMW = maxwdt
'    Else
'        dMW = mw
'    End If
'
'
'    ' sTxt ÏÓÊÂÚ ÒÓ‰ÂÊ‡Ú¸ ‡Á‰ÂÎËÚÂÎ¸ ',' ÔÓ˝ÚÓÏÛ ÓÌ ÌÂ ‚ıÓ‰ËÚ ‚ Replace
'
'    If curSpecCfg.spcfgUseDots And Me.bForceDots Then stxt = Replace(stxt, ",", ".")
'
'    msapp.CadInputQueue.SendMessageToApplication strReinSpec, "dt" _
'                                                 & ";" & stxt _
'                                                 & ";" & Replace(p.X _
'                                                 & ";" & p.Y _
'                                                 & ";" & dTextHeight _
'                                                 & ";" & dTextWidth _
'                                                 & ";" & (dTextHeight + dTextHeight / 2) _
'                                                 & ";" & just _
'                                                 & ";" & Abs(CInt(bUnderLine And Not bLast)) _
'                                                 & ";" & Abs(CInt(bOverLine)) _
'                                                 & ";" & (dTextHeight / 3#) _
'                                                 & ";" & (dTextHeight / 3#) _
'                                                 & ";" & iTextLevel _
'                                                 & ";" & scfgCmn.spec_text_clr _
'                                                 & ";" & dMW _
'                                                 & ";" & msapp.CurrentGraphicGroup _
'                                                 & ";" & curSpecCfg.iTextFont, ",", ".")
'
'    dTR = msapp.GetCExpressionValue("trx", strReinSpec)
'
'    If dTR > dTextRightX Then dTextRightX = dTR
'
'
'    drawSpecTextRein = True
'
'    Exit Function
'
'drawReinText_ERR:
'
'End Function



''/******************************************************************************
'Public Sub drawSpecText(X As Double, Y As Double, w As Double, h As Double)
''/******************************************************************************
'
'
'
'
'    On Error GoTo draw_ERR
'
'    Dim txt As TextElement
'    Dim txtn As TextNodeElement
'    Dim p As Point3d
'    Dim a As Integer
'    Dim dMaxWidth As Double
'
'    Dim j As TextJustification
'    Dim jn As TextJustification
'    Dim ls As Double
'    Dim lst As MsdTextNodeLineSpacingType
'    Dim ul As Boolean
'    Dim ol As Boolean
'
'    width = w
'
'    Dim ar() As String
'
'
'    dMaxWidth = width - width * 0.05
'
'    p.Y = Y
'
'    If just = lc Then           ' #define     TXTJUST_LC          1   /* Left Center */
'        p.X = X + dScaleX
'        dMaxWidth = dMaxWidth - dScaleX
'    ElseIf just = rc Then      ' #define     TXTJUST_RC          13  /* Right Center */
'        p.X = X + width - dScaleX
'    ElseIf just = lt Then
'        p.X = X + dScaleX
'        p.Y = Y + h / 2# - dScaleX
'    ElseIf just = rb Then
'        p.X = X + width - dScaleX
'        p.Y = Y - h / 2# + dScaleX
'    Else                                                    ' #define     TXTJUST_CC          7   /* Center Center */ (default)
'        just = cc
'        p.X = X + width * dScaleX
'    End If
'
'
''    If dMaxWidth < 0 Then
''    Debug.Print ""
''    End If
'
'    ' cell
'    If Len(sCellSymbol) > 0 Then
'
'        Dim ps As Point3d
'        ps.X = dTextHeight * 1000# / ActiveModelReference.MasterUnit.UnitsPerBaseNumerator
'        ps.Y = dTextHeight * 1000# / ActiveModelReference.MasterUnit.UnitsPerBaseNumerator
'
'        Dim cel As CellElement
'        Set cel = CreateCellElement2(sCellSymbol, p, ps, True, msapp.Matrix3dIdentity)
'        cel.GraphicGroup = msapp.CurrentGraphicGroup
'        cel.LineWeight = 1
'        cel.Color = scfgCmn.spec_text_clr
'        setLevel cel, iTextLevel, msapp
'        msapp.ActiveModelReference.AddElement cel
'        cel.redraw msdDrawingModeNormal
'
'        p.X = p.X + dTextHeight * 1.5
'    End If
'
'
'    ' text
''    If bUseCoreText Then
'
'        Dim iRows As Integer
'        Dim i As Integer
'        Dim p2 As Point3d
'
'        ar = Split(sText, vbNewLine)
'
'        If UBound(ar) = 0 Then
'            ar = Split(sText, "|")
'        End If
'
''        If UBound(ar) = 0 Then
''            ar = Split(sText, "/")
''        End If
'
'        iRows = UBound(ar) + 1
'
'        If iRows > 1 Then
'            dTextHeight = dTextHeight * dSpecTextScale ^ (iRows - 1)
'            dTextWidth = dTextWidth * dSpecTextScale ^ (iRows - 1)
'        End If
'
'        dTextRightX = p.X
'
'        If iRows = 1 And bDopText Then
'            drawLineXY msapp, p.X - w + dScaleX, p.Y - dScaleX, p.X + dScaleX, p.Y + h - dScaleX
'        End If
'
'        For i = 0 To UBound(ar)
'            p2.X = p.X
'            p2.Y = p.Y + h / 2# - (h / iRows * i + h / iRows / 2#)
'            If Not drawSpecTextRein(ar(i), p2, dMaxWidth, CBool(i > 0) And CBool(i = UBound(ar))) Then
'                Set txt = CreateTextElement1(Nothing, "Œÿ»¡ ¿!", p2, Matrix3dIdentity)
'                txt.LineWeight = 2
'                txt.Color = 3
'                txt.GraphicGroup = msapp.CurrentGraphicGroup
'                txt.redraw msdDrawingModeNormal
'                msapp.ActiveModelReference.AddElement txt
'            Else
'                Set txt = ActiveModelReference.GetLastValidGraphicalElement
'                If txt.IsTextElement Then
''                    Set txt.TextStyle.Font = ActiveDesignFile.Fonts.Find(msdFontTypeWindowsTrueType, "Arial")
''                    txt.Rewrite
'                End If
'            End If
'        Next i
'
'
''    Else
''
'''        j = msapp.ActiveSettings.TextStyle.Justification
'''        jn = msapp.ActiveSettings.TextStyle.NodeJustification
'''        ls = msapp.ActiveSettings.TextStyle.NodeLineSpacing
'''        lst = msapp.ActiveSettings.TextStyle.NodeLineSpacingType
'''        ul = msapp.ActiveSettings.TextStyle.IsUnderlined
'''        ol = msapp.ActiveSettings.TextStyle.IsOverlined
'''
'''        msapp.ActiveSettings.TextStyle.Justification = just
'''        msapp.ActiveSettings.TextStyle.NodeJustification = just
'''        msapp.ActiveSettings.TextStyle.NodeLineSpacing = dTextHeight + dTextHeight / 2
'''        msapp.ActiveSettings.TextStyle.NodeLineSpacingType = msdTextNodeLineSpacingTypeExactFromLineTop
'''        msapp.ActiveSettings.TextStyle.IsUnderlined = bUnderLine
'''        msapp.ActiveSettings.TextStyle.IsOverlined = bOverLine
'''        msapp.ActiveSettings.TextStyle.OverlineOffset = dTextHeight / 3#
'''        msapp.ActiveSettings.TextStyle.UnderlineOffset = dTextHeight / 3#
'''
'''
'''        Set txt = CreateTextElement1(Nothing, sText, p, Matrix3dIdentity)
'''        txt.LineWeight = 1
'''        txt.Color = scfgCmn.spec_text_clr
'''        setLevel txt, iTextLevel
'''
'''
'''        ar = Split(sText, vbNewLine)
'''
'''        If (UBound(ar) = 0) Then
'''            changeTextProps txt, True, X
'''            txt.GraphicGroup = msapp.CurrentGraphicGroup
'''            msapp.ActiveModelReference.AddElement txt
'''        Else
'''
'''            Set txtn = CreateTextNodeElement1(txt, p, Matrix3dIdentity)
'''
'''            For A = 0 To UBound(ar)
'''                txtn.AddTextLine ar(A)
'''            Next A
'''
'''            Dim ee As ElementEnumerator
'''            Set ee = txtn.GetSubElements
'''
'''            txtn.GraphicGroup = msapp.CurrentGraphicGroup
'''
'''            msapp.ActiveModelReference.AddElement txtn
'''
'''            Do While ee.MoveNext
'''                Set txt = ee.Current
'''                changeTextProps txt, True, X
'''                txt.Rewrite
'''            Loop
'''
'''        End If
'''
'''        msapp.ActiveSettings.TextStyle.Justification = j
'''        msapp.ActiveSettings.TextStyle.NodeJustification = jn
'''        msapp.ActiveSettings.TextStyle.NodeLineSpacing = ls
'''        msapp.ActiveSettings.TextStyle.NodeLineSpacingType = lst
'''        msapp.ActiveSettings.TextStyle.IsUnderlined = ul
'''        msapp.ActiveSettings.TextStyle.IsOverlined = ol
''
''    End If
'
'
'
'
'
'
'
'
'
'
'
'
'
'    If Not rtSuffix Is Nothing Then
'
'        rtSuffix.bForceDots = Me.bForceDots
'
'        rtSuffix.drawSpecText dTextRightX + dTextWidth / 2#, Y, width, h
'
'    End If
'
'
'
'    Exit Sub
'
'draw_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "draw - Error"
'
'End Sub


'/******************************************************************************
Private Sub changeSpecTextProps(ByRef txt As TextElement, bRedraw As Boolean, X As Double)
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
Public Function setSpecTextSuffix(rut As clsSpecText, dOtstup As Double) As Boolean
'/******************************************************************************
    
    On Error GoTo setSuffix_ERR
    
    If rtSuffix Is Nothing Then
        If rut.just = lc Then
            rut.dScaleX = dOtstup ' ÓÚÒÚÛÔ ÓÚ Ì‡‰ÔËÒË ÒÎÂ‚‡
            Set rtSuffix = rut
        Else
        End If
    Else
        rtSuffix.setSpecTextSuffix rut, dOtstup
    End If
    
    setSpecTextSuffix = True
    
    Exit Function
    
setSuffix_ERR:
    '    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setSuffix - Error"
    
End Function



Public Function createMSText(ByRef msapp As Object) As TextElement

    Dim txt As TextElement
    Dim txt2 As TextElement
    
    Dim p1 As Point3d
    
    Dim p As clsSpecLine
    
    Set p = Me.prntRow.SPECROW_POINT_UNIT
    

    
    p1.X = p.lin_startX + Me.txtoriginX
    p1.Y = p.lin_startY + Me.txtoriginY
    p1.z = p.lin_startZ + Me.txtoriginZ
    
    
    
    
    
    Set txt = msapp.CreateTextElement1(Me.txtTemplate, Me.sText, p1, msapp.Matrix3dIdentity)
    
'    txt.Color = Me.msColor
'    txt.LineWeight = Me.msWeight

'    txt.TextStyle.Font = ActiveDesignFile.Fonts.Find(msdFontTypeWindowsTrueType, "Arial Narrow")

'    txt.TextStyle.Height = Me.dTextHeight
'    txt.TextStyle.width = Me.dTextWidth
'    txt.TextStyle.Justification = Me.just

    txt.GraphicGroup = msapp.CurrentGraphicGroup


    Dim str As String
    Dim i As Integer
    For i = 1 To colDopText.Count
        str = colDopText(i)
        p1.Y = p1.Y - Me.dTextHeight * dSpecNextRowParam
        Set txt2 = msapp.CreateTextElement1(Me.txtTemplate, str, p1, msapp.Matrix3dIdentity)
        txt2.GraphicGroup = msapp.CurrentGraphicGroup
        msapp.ActiveModelReference.AddElement txt2
    Next i


    
    Set createMSText = txt


End Function
