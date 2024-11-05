VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "colSU"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Collection" ,"clsSR"
Attribute VB_Ext_KEY = "Member0" ,"clsSR"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'local variable to hold collection
Private mCol As Collection

Public curStd As clsStd
Public curMat As clsMat
Public curPartDef As String

Public dHeadHeight As Double

Public curMatID As Long
Public curStdID As Long
Public curPartDefID As Long
Public curPrntPartDefID As Long
Public curPartID As Long
Public curSrtmID As Long
Public curPosMatID As Long
Public curPosName As String

Public cap As clsSR ' top row (old)

Public toprow As clsSpecRow ' top row
Public botrow As clsSpecRow ' bottom row

Public offsetX As Double

Public originX As Double
Public originY As Double

Public maxRows As Long

Public width As Double

Public dKftTH As Double

Public msapp As Object

Public Function Add(Optional sKey As String) As clsSR
    'create a new object
    Dim objNewMember As clsSR
    Set objNewMember = New clsSR

    Set objNewMember.prnt = Me

    'set the properties passed into the method
    If Len(sKey) = 0 Then
        mCol.Add objNewMember
    Else
        mCol.Add objNewMember, sKey
    End If


    'return the object created
    Set Add = objNewMember
    Set objNewMember = Nothing


End Function

Public Function AddRow(specRow As clsSR, Optional sKey As String = "") As Boolean
    
    On Error GoTo m1
    
    AddRow = False
    
    Set specRow.prnt = Me
    
    'set the properties passed into the method
    If Len(sKey) = 0 Then
        mCol.Add specRow
    Else
        mCol.Add specRow, sKey
    End If
    
    If mCol.Count = maxRows Then
        AddRow = False
    Else
        AddRow = True
    End If
    
    
    Exit Function
m1:
    AddRow = False
    
End Function


Public Function AddSpecRow(specRow As clsSpecRow, Optional sKey As String = "") As Boolean
    
    On Error GoTo m1
    
    AddSpecRow = False
    
    Set specRow.prnt = Me
    
    specRow.iRowColPos = mCol.Count + 1
    
    'set the properties passed into the method
    If Len(sKey) = 0 Then
        mCol.Add specRow
    Else
        mCol.Add specRow, sKey
    End If
    
    If mCol.Count = maxRows Then
        AddSpecRow = False
    Else
        AddSpecRow = True
    End If
    
    
    Exit Function
m1:
    AddSpecRow = False
    
End Function


Public Property Get Item(vntIndexKey As Variant) As IUnknown
Attribute Item.VB_UserMemId = 0
    'used when referencing an element in the collection
    'vntIndexKey contains either the Index or Key to the collection,
    'this is why it is declared as a Variant
    'Syntax: Set foo = x.Item(xyz) or Set foo = x.Item(5)
  Set Item = mCol(vntIndexKey)
End Property



Public Property Get Count() As Long
    'used when retrieving the number of elements in the
    'collection. Syntax: Debug.Print x.Count
    Count = mCol.Count
End Property


Public Sub Remove(vntIndexKey As Variant)
    'used when removing an element from the collection
    'vntIndexKey contains either the Index or Key, which is why
    'it is declared as a Variant
    'Syntax: x.Remove(xyz)


    mCol.Remove vntIndexKey
End Sub


Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
    'this property allows you to enumerate
    'this collection with the For...Each syntax
    Set NewEnum = mCol.[_NewEnum]
End Property

'/******************************************************************************
Public Sub createHead()
'/******************************************************************************

    On Error GoTo createHead_ERR
    
    Dim c As clsSRU
    
    dHeadHeight = dSpecHeadHeight

    Set cap = New clsSR
    Set cap.prnt = Me
    cap.row_height = dSpecHeadHeight
    
    
    Set c = New clsSRU
    c.setParams width, dSpecHeadHeight, 0#, cap
    c.sCellName = strSpecCapCellName
    
    Set cap.cells = New Collection
    cap.cells.Add c
    
    Set c = Nothing


Exit Sub

createHead_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "createHead - Error"

End Sub



'/******************************************************************************
Private Sub Class_Initialize()
'/******************************************************************************

    On Error GoTo Class_Initialize_ERR

    'creates the collection when this class is created
    Set mCol = New Collection
    
    Set msapp = getMS
    
    maxRows = 300
    
    width = dSpecWidth
    
    
Exit Sub

Class_Initialize_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "Class_Initialize - Error"

End Sub


Private Sub Class_Terminate()
    'destroys collection when this class is terminated
    Set mCol = Nothing
    Set msapp = Nothing
End Sub


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



'/******************************************************************************
Public Sub drawSpecUnit()
'/******************************************************************************
    
    
    On Error GoTo draw_ERR
    Dim i As Integer
    
    Dim s As ShapeElement
    Dim vtcs(1 To 4) As Point3d
    
    vtcs(1).X = mspoint.X + offsetX
    vtcs(2).X = mspoint.X + offsetX + width
    vtcs(3).X = mspoint.X + offsetX + width
    vtcs(4).X = mspoint.X + offsetX
    
    vtcs(1).Y = mspoint.Y
    vtcs(2).Y = mspoint.Y
    vtcs(3).Y = mspoint.Y - getHeight
    vtcs(4).Y = mspoint.Y - getHeight
    
    Set s = CreateShapeElement1(Nothing, vtcs, msdFillModeNotFilled)
    s.LineWeight = scfgCmn.spec_h_line_wdt
    s.Color = scfgCmn.spec_h_line_clr
    s.LineStyle = ActiveDesignFile.LineStyles("0")
    setLevel s, iLineLevel, msapp
    
    Dim X As Double
    Dim Y As Double
    
    X = mspoint.X + offsetX
    Y = mspoint.Y - dHeadHeight
    
'    If cap Is Nothing Then
    drawLineXY msapp, X, Y, X, mspoint.Y - getHeight, curSpecCfg.spec_v_line_wdt
    
    
    For i = 1 To curSpecCfg.iColCnt - 1
        drawLineXY msapp, X + getWidth(, i), Y, X + getWidth(, i), mspoint.Y - getHeight, curSpecCfg.spec_v_line_wdt
    Next i
    
'    If cap Is Nothing Then
    drawLineXY msapp, X + getWidth(, 7), Y, X + getWidth(, 7), mspoint.Y - getHeight, curSpecCfg.spec_v_line_wdt

    
    s.GraphicGroup = msapp.CurrentGraphicGroup
    
    
    
    If Not cap Is Nothing Then
        cap.drawRow 0#
        s.redraw msdDrawingModeNormal
        msapp.ActiveModelReference.AddElement s
    End If
    
    Dim r As clsSR
    
    i = 0
    For Each r In mCol
        i = i + 1
        r.drawRow originY, CBool(i = mCol.Count)
    Next r
    
    
    Exit Sub
    
draw_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "drawSpecUnit - Error"
    
End Sub


'/******************************************************************************
Public Function getHeight() As Double
'/******************************************************************************

    On Error GoTo getHeight_ERR

    getHeight = (mCol.Count) * dSpecRowHeight + originY
    



Exit Function

getHeight_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getHeight - Error"

End Function


'/******************************************************************************
Public Function addCmnSpecPartRows(part As clsPart) As Integer ' возвр. кол-во добавленных строк
'/******************************************************************************

    Dim qty As Integer ' количество добавленных строк

    If part Is Nothing Then Exit Function

    Dim r As clsSR
    
    Dim u As clsSRU
    Dim rt As clsSRUT
    
    ' parent part definition
    '######################################
    If usrCurrent.depID = 1 Then
        If globPartDefs(CStr(part.partdefID)).parentID <> curPrntPartDefID Then
        
            Set r = New clsSR
            Set r.prnt = Me
            
            Dim sParentPD As String
            Dim iParentPD As Long
            
            iParentPD = globPartDefs(CStr(part.partdefID)).parentID
            sParentPD = globPartDefs(CStr(iParentPD)).partdefNameMulti
        
            If Len(sParentPD) > 0 Then
                If Me.Count + 2 < Me.maxRows Then
                    Set rt = New clsSRUT
                    rt.sText = getTrans(sParentPD, , curSpecCfg.iTrans)
                    rt.bUnderLine = curSpecCfg.bUnderLineHeader
                    Set u = r.cells(3)
                    u.rtc.Add rt
                End If
            
                If Not Me.AddRow(r) Then
                    addCmnSpecPartRows = -1
                    Exit Function
                End If
        
                qty = qty + 1
                
                Me.curPrntPartDefID = globPartDefs(CStr(part.partdefID)).parentID
                Me.curStdID = 0
                Me.curMatID = 0
                Me.curPartDefID = 0
                
            End If
        
        End If
    End If
    
    ' part definition
    '######################################
    If part.partdefID <> curPartDefID Then
    
        Set r = New clsSR
        Set r.prnt = Me

        If Me.Count + 1 < Me.maxRows Then
        
            Set rt = New clsSRUT
            
            rt.sText = getTrans(part.partdefName, , curSpecCfg.iTrans)
            
            'If usrCurrent.depID = 1 Then
                rt.bUnderLine = curSpecCfg.bUnderLineHeader
            'Else
            '    rt.bUnderLine = True
            'End If
            
            Set u = r.cells(3)
            u.rtc.Add rt
        End If

        If Not Me.AddRow(r) Then
            addCmnSpecPartRows = -1
            Exit Function
        End If


        qty = qty + 1

        Me.curPartDefID = part.partdefID
        Me.curStdID = 0
        Me.curMatID = 0
        
    End If
    
    ' part
    '######################################
    Set r = New clsSR
    Set r.prnt = Me
    
    '===================================
    ' Марка
    Set rt = New clsSRUT
    If curSpecCfg.get_spec_row_numbers = 1 Then
        rt.sText = part.iSpecNumber
        rt.bPress = True
    ElseIf curSpecCfg.get_spec_row_numbers = 2 Then
        rt.dTextHeight = rt.dTextHeight * 0.75
        rt.dTextWidth = rt.dTextWidth * 0.75
        rt.sText = part.partName
        rt.bPress = True
    Else
        If globPartDefs(CStr(part.partdefID)).bUsePositions Then rt.sText = part.partName Else rt.sText = ""
        rt.bPress = True
    End If
    Set u = r.cells(1)
    If Len(rt.sText) > 0 Then u.rtc.Add rt

    '===================================
    ' Обозначение
    Set rt = New clsSRUT
    rt.just = lc
    rt.dScaleX = 1.2 * dSpecCmnScale
    rt.dTextHeight = rt.dTextHeight
    rt.dTextWidth = rt.dTextWidth
    
    'rt.sText = part.PART_DESCR ' см ниже
    
    Dim dscr As String
    If curSpecCfg.iTrans Then
        Dim ar() As String
        dscr = curSpecCfg.getPartDescr(part.PART_DESCR)
        ar = Split(dscr, "$")
        If UBound(ar) > 0 Then
            Dim a As Integer
            dscr = ""
            For a = 0 To UBound(ar)
                ar(a) = getTrans(ar(a), " / ", curSpecCfg.iTrans)
                dscr = dscr & ar(a)
            Next a
        End If
    Else
        dscr = curSpecCfg.getPartDescr(part.PART_DESCR)
    End If
    
    dscr = Replace(dscr, "$", "") ' то что в нутри $$ - переводится
    ' see getPartDescr
    'rt.sText = Replace(dscr, "[dscr]", part.PART_DESCR)
    rt.sText = dscr
        
    If Len(Trim(part.partSheet)) > 0 Then
        rt.sText = Replace(rt.sText, "[sht]", part.partSheet)
        
'        rt.sText = rt.sText & "|лист " & part.partSheet
'        If curSpecCfg.iTrans Then
'            rt.sText = rt.sText & getTrans("лист", " / ") & " " & part.partSheet
'        Else
'        End If
    End If
    rt.bPress = True
    Set u = r.cells(2)
    u.rtc.Add rt

    
    
    
    
    '===================================
    ' погонные метры если есть
    Dim sRunMet As String
    If Len(curSpecCfg.sRunMetOver) > 0 Then
        sRunMet = curSpecCfg.sRunMetOver
    'ElseIf usrCurrent.depID = 1 Then
    '    sRunMet = "погонные м"
    Else
        sRunMet = globMassCalcs("2").mcSign
    End If
    
    If part.bRunMet And Not part.bIsByPrm And curSpecCfg.iColCnt > 6 Then
            
        Set rt = New clsSRUT
        rt.bPress = True
        
        'If usrCurrent.depID = 1 Then
        '    rt.just = cc ' справа
        '    rt.dScaleX = 0.5
        '    Set u = r.cells(7)
        'Else
            rt.just = lc ' справа
            rt.dScaleX = arSpecCol(3) - Len(sRunMet) * dSpecTextWidth - 3# * dSpecCmnScale
            If rt.dScaleX < arSpecCol(3) / 2# Then rt.dScaleX = arSpecCol(3) / 2#
            rt.maxwdt = arSpecCol(3) / 2# - 3# * dSpecCmnScale
            Set u = r.cells(3)
        'End If
        
        rt.sText = getTrans(sRunMet, , curSpecCfg.iTrans)
        u.rtc.Add rt
        
    End If
    
    '===================================
    ' Наименование
    Dim rtn As New clsSRUT
    rtn.just = lc
    rtn.dScaleX = 1.5 * dSpecCmnScale
    rtn.sText = part.specPrefix & part.partName
    'rtn.sText = part.specPrefix & part.getPartNameForSpec(curSpecCfg) ' & part.partName
    'If part.parttypeID = 52 Then r.row_height = r.row_height * 3
    'rtn.bPress = True
    If part.bRunMet And Not part.bIsByPrm Then rtn.maxwdt = rt.dScaleX - 3# * dSpecCmnScale
    Set u = r.cells(3)
    u.rtc.Add rtn
    
    '===================================
    ' Кол-во
    Set rt = New clsSRUT
    If part.bRunMet And Not part.bIsByPrm Then
        rt.sText = Format(part.partQty, sFmt0)
    Else
        rt.sText = Round(part.partQty, 1)
    End If
    rt.bPress = True
    rt.bIsNumber = True
    rt.bForceDots = True
    Set u = r.cells(4)
    u.rtc.Add rt
    
    '===================================
    ' Ед.Масса
    Set rt = New clsSRUT
    rt.sText = Format(part.massCommon, sFmt0)
    rt.bPress = True
    rt.bIsNumber = True
    rt.bForceDots = True
    Set u = r.cells(5)
    u.rtc.Add rt
    
    '===================================
    ' Общ.Масса
    If curSpecCfg.get_spec_col_cmass > 0 Then
        Set rt = New clsSRUT
        
'        rt.sText = Round(part.partQty * part.massCommon, 3)
        
'        If part.bRunMet Then
            rt.sText = Format(part.partQty * part.massCommon, sFmt0)
'        Else
'            rt.sText = Round(part.partQty * part.massCommon, 1)
'        End If
        
        rt.bPress = True
        rt.bIsNumber = True
        rt.bForceDots = True
        Set u = r.cells(curSpecCfg.get_spec_col_cmass)
        u.rtc.Add rt
    End If
    
    Set rt = Nothing
    
    
    If Not Me.AddRow(r) Then
        addCmnSpecPartRows = 0
        Exit Function
    End If
    
    qty = qty + 1
    
    addCmnSpecPartRows = qty



End Function


Public Function addCmnSpecPosRows(pos As clsPos, spt As spectype, Optional doppos As clsPos = Nothing) As Integer ' возвр. кол-во добавленных строк
    
    
    On Error GoTo err
    
    Dim sRunMet As String
    If Len(curSpecCfg.sRunMetOver) > 0 Then
        sRunMet = curSpecCfg.sRunMetOver
    Else
        sRunMet = globMassCalcs("2").mcSign
    End If
    
    Dim qty As Integer ' количество добавленных строк
    
    Dim part As clsPart
    Dim prop As clsProp
    
    Dim i As Integer
    
    If pos Is Nothing Then Exit Function
    
    Dim r As clsSR
    
    Dim u As clsSRU
    Dim rt As clsSRUT
    Dim rtPrev As clsSRUT
    
    Dim sWidth As String
    Dim dLength As Double
    
    Dim iCellNum As Integer
    
    Dim bNoMass As Boolean
    Dim mu As clsMU
    
    Dim bCatPos As Boolean
    
    Set part = pos.parentPart
    
    
    pos.bTranslateStdType = CBool(curSpecCfg.iTrans = 2)
    
    
    
    ' наименование изделия
    If curSpecCfg.bNewRowPartName And spt = stPart Then
    
        If pos.POS_SRTM.srtmID > 0 And pos.parentPart.partID <> curPartID Then
            Set r = New clsSR
            Set r.prnt = Me
            
            If Me.Count + 3 < Me.maxRows Then
                Set rt = New clsSRUT
                rt.sText = part.partName
                rt.bUnderLine = curSpecCfg.bUnderLineHeader
                Set u = r.cells(3)
                u.rtc.Add rt
            End If
            
            If Not Me.AddRow(r) Then
                addCmnSpecPosRows = -1
                Exit Function
            End If
            
            
            qty = qty + 1
            
            Me.curPartID = part.partID
            Me.curStdID = 0
            Me.curMatID = 0
            Me.curPartDefID = 0
            
        End If
        
        part.partdefID = 5 ' чтобы печатался заголовок "Детали"
        part.partdefName = part.PARTDEF.partdefNameMulti ' over
    
    End If
    
    
    
    If Not pos.parentPart Is Nothing Then
    
        bCatPos = pos.parentPart.bIsCat
    
        If pos.parentPart.bIsCat And pos.parentPart.partdefID <> curPartDefID Then
            Dim rrr As New clsSR
            Set rrr.prnt = Me
            
            If Not Me.AddRow(rrr) Then
                addCmnSpecPosRows = -1
                Exit Function
            End If
            
            qty = qty + 1
        End If
    End If
    
    
    
    ' part definition
    '######################################
    If curSpecCfg.bNewRowPartDef And pos.POS_SRTM.srtmID > 0 And part.partdefID <> curPartDefID Then
        Set r = New clsSR
        Set r.prnt = Me
        
        If Me.Count + 2 < Me.maxRows Then
            Set rt = New clsSRUT
            rt.sText = getTrans(part.partdefName, , curSpecCfg.iTrans)
            rt.bUnderLine = curSpecCfg.bUnderLineHeader
            Set u = r.cells(3)
            u.rtc.Add rt
        End If
        
        If Not Me.AddRow(r) Then
            addCmnSpecPosRows = -1
            Exit Function
        End If
        
        
        qty = qty + 1
        
        Me.curPartDefID = part.partdefID
        Me.curStdID = 0
        Me.curMatID = 0
        
    End If
    
    
'    If pos.POS_PD.bMassCommon Then
'
'        Set r = New clsSR
'        Set r.prnt = Me
'
'        If Me.Count + 2 < Me.maxRows Then
'            Set rt = New clsSRUT
'            rt.sText = getTrans(pos.POS_PD.PD_NAME, , curSpecCfg.iTrans)
'            rt.bUnderLine = curSpecCfg.bUnderLineHeader
'            Set u = r.cells(3)
'            u.rtc.Add rt
'        End If
'
'        If Not Me.AddRow(r) Then
'            addCmnSpecPosRows = -1
'            Exit Function
'        End If
'
'        qty = qty + 1
'    End If
    
    
    ' pos mat & std
    '######################################
    
    Dim bDop As Boolean
    Dim bDopEmpty As Boolean
    Dim rdop As clsSR
    
    If pos.POS_SRTM.srtmID > 0 And pos.getStandardID <> curStdID Then
        bDop = True
        bDopEmpty = curSrtmID > 0 And blnSortDiam
    End If
    
    If pos.POS_SRTM.srtmID > 0 And pos.getMatID <> curMatID Then
        bDop = True
        bDopEmpty = curSrtmID > 0 And blnSortDiam
    End If
    
    If blnSortDiam And pos.POS_SRTM.srtmID > 0 And pos.POS_SRTM.srtmID <> curSrtmID Then
        bDopEmpty = curSrtmID > 0
    End If
    
    
    If Not pos.parentPart Is Nothing Then
        If pos.parentPart.bIsCat Then bDopEmpty = False
    End If
    
    
    If curSpecCfg.bNewRowMatStd And bDopEmpty Then
    
        Dim rrrr As New clsSR
        Set rrrr.prnt = Me
        
        If Not Me.AddRow(rrrr) Then
            addCmnSpecPosRows = -1
            Exit Function
        End If
        
        qty = qty + 1
        
    End If
    
    
    If curSpecCfg.bNewRowMatStd And bDop And pos.parentPart.partdefID <> 15 Then ' (15) - материалы
        
        Set rdop = New clsSR
        Set rdop.prnt = Me
        
        If Me.Count + 1 < Me.maxRows And pos.POS_PD.mustDrawSrtmName() Then
            
            Dim rts As New clsSRUT ' standard
            Dim rtm As New clsSRUT ' material
            rts.bPress = True
            rtm.bPress = True
            
            Dim bDrawStd As Boolean
            Dim bDrawMat As Boolean
            
            bDrawStd = True
            bDrawMat = curSpecCfg.bNewRowMat
            
            If Len(Trim(pos.POS_MAT.matName)) = 0 Then bDrawMat = False
            
            If pos.getStandardID = 0 Then
                bDrawStd = False
            Else
                rts.sText = pos.POS_STD_FULLNUMBER
            End If
            
            
            If pos.getMatID = 0 Then
                bDrawMat = False
            Else
                rtm.sText = Trim(pos.POS_MAT.getReinMatName(pos.bTranslateStdType) & " " & pos.POS_MAT_STD_FULLNUMBER)
            End If
            
            If rtm.sText = rts.sText Then
                bDrawMat = False
            End If
            
            If Len(Trim(rtm.sText)) = 0 Then
                bDrawMat = False
            End If
            
            ' класс будет в строке позиции, дублировать материал не нужно
            If Len(pos.POS_MAT.ARM_CLASS.armClassName) > 0 Then
                If pos.POS_MAT.MAT_STD.stdID = pos.POS_STD.stdID Then
                    bDrawMat = False
                End If
            End If
            
            
            If bDrawStd And bDrawMat Then
                rts.dScaleY = 0.25
                rts.dTextHeight = rts.dTextHeight * 0.8
                rts.dTextWidth = rts.dTextWidth * 0.8
                rtm.dScaleY = 0.75
                rtm.dTextHeight = rtm.dTextHeight * 0.8
                rtm.dTextWidth = rtm.dTextWidth * 0.8
                rtm.bOverLine = True
            ElseIf bDrawStd Then
                rts.bUnderLine = curSpecCfg.bUnderLineHeader
            ElseIf bDrawMat Then
                rtm.bUnderLine = curSpecCfg.bUnderLineHeader
            End If
            
            
            Set u = rdop.cells(3)
            If bDrawStd Then u.rtc.Add rts
            If bDrawMat Then u.rtc.Add rtm
            
        End If
        
        
        If Not Me.AddRow(rdop) Then
            addCmnSpecPosRows = -1
            Exit Function
        End If
        
        
        Set rts = Nothing
        Set rtm = Nothing
        
        
        qty = qty + 1
        
        Me.curStdID = pos.getStandardID
        Me.curMatID = pos.getMatID
        
        Set rdop = Nothing
        
    End If
    
    
    ' width =====================
    sWidth = ""
    If pos.POS_MCALC.mcTable = "massvolume" Then
        If pos.pos_props.existsProperty("width") Then
            Set prop = pos.pos_props("width")
            If prop.bEditable And pos.pos_props("width").hasValue Then
                sWidth = "x" & prop.PVAL
            End If
        End If
    End If
    
    ' (override if radiusout)
    If pos.POS_MCALC.mcID = 8 Then
        If pos.pos_props.existsProperty("radiusout") Then
            Set prop = pos.pos_props("radiusout")
            If prop.bEditable And pos.pos_props("radiusout").hasValue Then
                sWidth = "x" & prop.PVAL * 2
                dLength = prop.PVAL * 2
            End If
        End If
    End If
    
    If pos.POS_MCALC.mcID = 11 Then
        If pos.pos_props.existsProperty("diamout") Then
            Set prop = pos.pos_props("diamout")
            If prop.bEditable And pos.pos_props("diamout").hasValue Then
                sWidth = "x" & prop.PVAL
                dLength = prop.PVAL
            End If
        End If
    End If
    
    
    Set r = New clsSR
    Set r.prnt = Me
    
    
    ' Марка ===================================
    
    Set rt = New clsSRUT
    If spt = stPart Then
        If pos.posNumber > 0 Then rt.sText = pos.posNumber
    Else
        Dim pn As Integer
        pn = Val(part.partName)
        
        If pn > 0 Then
            rt.sText = part.partName
            
            'If usrCurrent.depID = 1 And cattypes(cCats(CStr(pos.parentPart.catID)).catTypeID).ctEnum = ctRein And pos.bSketch Then
            '    rt.sText = rt.sText & "*"
            'End If
            
            rt.dTextHeight = rt.dTextHeight
            rt.dTextWidth = rt.dTextWidth
        End If
    
    End If
    rt.bPress = True
    Set u = r.cells(1)
    If Len(rt.sText) > 0 Then u.rtc.Add rt

    
    
    
    
    If pos.POS_SRTM.srtmID = 0 Then
    
        ' unavailable ==================
        Set rt = New clsSRUT
        rt.sText = getTrans("Отсутствует", , curSpecCfg.iTrans)
        Set u = r.cells(2)
        u.rtc.Add rt
        
    Else
        
        ' sketch ==================
        If usrCurrent.depID <> 1 And cattypes(cCats(CStr(pos.parentPart.catID)).catTypeID).ctEnum = ctRein And pos.bSketch Then
            Set rt = New clsSRUT
            rt.sText = getTrans("Эскиз", " / ", curSpecCfg.iTrans)
            Set u = r.cells(2)
            u.rtc.Add rt
        ElseIf bCatPos And pos.POS_PD.pdID = 96 Then ' бетон
            Set rt = New clsSRUT
            Dim txt(4) As String
            
            rt.just = lc
            rt.dScaleX = 3# * dSpecCmnScale
            
            txt(0) = pos.POS_STD_FULLNUMBER
            txt(2) = getTrans(txt(0), "", 2)
            
            If pos.pos_props.existsProperty("thickness") Then
                If pos.pos_props("thickness").hasValue Then
                    txt(1) = ", " & "толщ." & " " & pos.pos_props("thickness").PVAL & pos.pos_props("thickness").PROP_MU.muShortName
                    txt(3) = ", " & getTrans("толщ.", "", 2) & " " & pos.pos_props("thickness").PVAL & _
                                                            getTrans(pos.pos_props("thickness").PROP_MU.muShortName, "", 2)
                End If
            End If
            
            rt.sText = txt(0) & txt(1)
            
            If curSpecCfg.iTrans = 1 Then
                rt.sText = rt.sText & vbNewLine & txt(2) & txt(3)
            ElseIf curSpecCfg.iTrans = 2 Then
                rt.sText = txt(2) & txt(3)
            End If
            
            Set u = r.cells(2)
            u.rtc.Add rt
        ElseIf curSpecCfg.bPosSignStd Then ' обозначение - стандарт
            Set rt = New clsSRUT
            rt.sText = pos.POS_STD_FULLNUMBER
            
            If pos.POS_PD.bSpecSign Then rt.sText = pos.POS_SRTM.srtmName & " " & rt.sText
            
            If pos.pos_props.existsProperty("article") Then
                If pos.pos_props("article").propValue > 0 Then
                    rt.sText = rt.sText & vbNewLine & pos.pos_props("article").propDescr & " " & pos.pos_props("article").PVAL
                End If
            End If
            
            rt.bPress = True
            rt.just = lc
            rt.dScaleX = rt.dTextWidth
            Set u = r.cells(2)
            u.rtc.Add rt
        End If
        ' =======================
        
        
        
        Set u = r.cells(3)
        
        '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        
        
        ' srtm name ============================
        Set rt = New clsSRUT
        rt.just = lc
        rt.dScaleX = 3# * dSpecCmnScale
        rt.bForceDots = True
        
        If curSpecCfg.bPosdefIsText Then
        
            Dim strPDN As String
            
            strPDN = pos.POS_PD_NAME
            
            If Len(strPDN) > 12 Then
                strPDN = strPDN & vbNewLine
            Else
                strPDN = strPDN & " "
            End If
        
            If pos.pos_props.existsProperty("length") And pos.pos_props.existsProperty("width") Then
                If pos.pos_props("width").bEditable And pos.pos_props("length").bEditable Then
                    rt.sText = strPDN & pos.POS_SRTM.srtmName & " " & pos.pos_props("length").PVAL & "x" & pos.pos_props("width").PVAL
                ElseIf pos.pos_props("length").bEditable Then
                    If pos.pos_props("length").hasValue Then
                        rt.sText = strPDN & pos.POS_SRTM.srtmName & ", L=" & pos.pos_props("length").PVAL
                    Else
                        rt.sText = strPDN & pos.POS_SRTM.srtmName & ", " & sRunMet
                    End If
                Else
                    rt.sText = strPDN & pos.POS_SRTM.srtmName
                End If
            ElseIf pos.pos_props.existsProperty("length") Then
                If pos.pos_props("length").bEditable Then
                    If pos.pos_props("length").hasValue Then
                        rt.sText = strPDN & pos.POS_SRTM.srtmName & ", L=" & pos.pos_props("length").PVAL
                    Else
                        rt.sText = strPDN & pos.POS_SRTM.srtmName & ", " & sRunMet
                    End If
                Else
                    rt.sText = strPDN & pos.POS_SRTM.srtmName
                End If
            Else
                rt.sText = strPDN & pos.POS_SRTM.srtmName
            End If
            
            If curSpecCfg.bPosSignStd And pos.POS_PD.bSpecSign Then rt.sText = pos.POS_PD_NAME
        
'            If pos.pos_props("length").hasValue Or pos.pos_props("width").hasValue Then
'            ElseIf pos.pos_props("length").hasValue Or Not pos.pos_props("width").hasValue Then
'            Else
'            End If
        
        ElseIf pos.POS_PD.bDrawName Or pos.POS_MCALC.mcID = 5 Then
            
            rt.sText = getTrans(pos.POS_PD_NAME, , curSpecCfg.iTrans)
            
            'must draw srtm Name
            If pos.POS_PD.mustDrawSrtmName() Then
            
                Dim rtt As New clsSRUT
                rtt.just = lc
                If pos.POS_STDPD.bUseDrawSgn Then rtt.sCellSymbol = pos.POS_PD.pdDrawSymbol
                rtt.sText = pos.POS_PD.pdDrawSrtmPrefix & pos.POS_SRTM.srtmName & sWidth
                rtt.maxwdt = arSpecCol(3) - 5# * dSpecCmnScale - Len(pos.POS_PD_NAME) * dSpecTextWidth
                rtt.bPress = True
                
    '            If bCatPos Then
    '                If pos.pos_props.existsProperty("thickness") Then
    '                    If pos.pos_props("thickness").hasValue Then rtt.sText = rtt.sText & vbNewLine & "толщ. " & pos.pos_props("thickness").PVAL & pos.pos_props("thickness").PROP_MU.muShortName
    '                End If
    '            End If
                
                rt.setSuffix rtt, rt.dTextWidth / 2#
                
                Set rtt = Nothing
                
            End If
            
        Else
            
            If pos.POS_STDPD.bUseDrawSgn Then rt.sCellSymbol = pos.POS_PD.pdDrawSymbol
            rt.sText = pos.POS_PD.pdDrawSrtmPrefix & pos.POS_SRTM.srtmName & sWidth & " " & pos.POS_MAT.getClass(curSpecCfg.bNewAC, curSpecCfg.bOldAC)
            
            If pos.pos_props.existsProperty("length") Then
                If Len(curSpecCfg.spcfgLevVar) > 0 Then
                    rt.maxwdt = (40 - Len(curSpecCfg.spcfgLevVar)) * dSpecCmnScale
                Else
                    rt.maxwdt = 24# * dSpecCmnScale
                End If
            End If
            
        End If
            
            
'        Debug.Assert pos.POS_PD.pdID <> 13


        
        Dim sPosText As String
        If Not rt.rtSuffix Is Nothing Then
        sPosText = rt.sText & rt.rtSuffix.sText
        Else
        sPosText = rt.sText
        End If
            
        If (curSpecCfg.spec_skip_bar = 1 And (curPosName <> sPosText Or curPosMatID <> pos.getMatID)) Or curSpecCfg.spec_skip_bar <> 1 Or bCatPos Then
            
            u.rtc.Add rt
            
            Set rtPrev = u.rtc(u.rtc.Count)
            
            curSrtmID = pos.POS_SRTM.srtmID
            curPosMatID = pos.getMatID
            curPosName = sPosText
            
            ' class ======================
            If (pos.POS_PD.bDrawName Or pos.POS_MCALC.mcID = 5) And pos.getMatID > 0 Then
                If Len(pos.POS_MAT.getClass(curSpecCfg.bNewAC, curSpecCfg.bOldAC)) > 0 Then
                    Set rt = New clsSRUT
                    rt.just = lc
                    rt.dScaleX = 15# * dSpecCmnScale
                    rt.sText = pos.POS_MAT.getClass(curSpecCfg.bNewAC, curSpecCfg.bOldAC)
                    Set u = r.cells(3)
                    u.rtc.Add rt
                    curPosName = curPosName & sPosText
                End If
            End If
            
            
        
        End If
        '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        
        bNoMass = False
        
        Dim bAdd As Boolean
        
        If Not curSpecCfg.bPosdefIsText Then
        
            Dim bLap As Boolean
            
            ' length ========================
            Set rt = New clsSRUT
            rt.just = lc
            rt.dScaleX = 33# * dSpecCmnScale
            rt.maxwdt = 15# * dSpecCmnScale
            rt.bForceDots = True
            If pos.POS_MCALC.mcID = 9 Then
                If pos.pos_props("length").hasValue Or pos.pos_props("width").hasValue Then
                    rt.sText = pos.pos_props("length").PVAL & "x" & pos.pos_props("width").PVAL
                    bAdd = True ' u.rtc.Add rt
                End If
            ElseIf pos.POS_MCALC.mcID = 12 Then ' бетон
                Set mu = globMUnits("7") ' объем
                Dim Arr() As String
                Arr = Split(mu.muSpecName, "^")
                If UBound(Arr) = 0 Then
                    rt.sText = mu.muSpecName
                    rt.dScaleX = 1# * dSpecCmnScale
                    rt.just = rc
                    bAdd = True ' u.rtc.Add rt
                Else
                
                    If Not curSpecCfg.iTrans Then ' rt.sText = rt.sText & getTrans(pos.POS_PD_NAME)
                        Set rt = New clsSRUT
                        rt.sText = Arr(0)
                        rt.dScaleX = 1# * dSpecCmnScale + dSpecTextWidth * 0.7
                        rt.just = rc
                        u.rtc.Add rt
                        Set rt = New clsSRUT
                        rt.sText = Arr(1)
                        rt.just = rc
                        rt.dScaleX = 1# * dSpecCmnScale
                        rt.dScaleY = 0.4
                        rt.dTextHeight = rt.dTextHeight * 0.5
                        rt.dTextWidth = rt.dTextWidth * 0.5
                        bAdd = True ' u.rtc.Add rt
                    Else
                        Set rt = New clsSRUT
                        rt.sText = Arr(0)
                        rt.dScaleX = 1# * dSpecCmnScale + dSpecTextWidth
                        rt.just = rc
                        rt.dScaleY = 0.4
                        rt.dTextHeight = rt.dTextHeight * 0.7
                        rt.dTextWidth = rt.dTextWidth * 0.7
                        u.rtc.Add rt
                        Set rt = New clsSRUT
                        rt.sText = Arr(1)
                        rt.just = rc
                        rt.dScaleX = 1# * dSpecCmnScale
                        rt.dScaleY = 0.3
                        rt.dTextHeight = rt.dTextHeight * 0.5
                        rt.dTextWidth = rt.dTextWidth * 0.5
                        u.rtc.Add rt
                        
                        Arr = Split(getTrans(mu.muSpecName, "", 2), "^")
                        If UBound(Arr) > 0 Then
                            Set rt = New clsSRUT
                            rt.sText = Arr(0)
                            rt.just = rc
                            rt.dScaleX = 1# * dSpecCmnScale + dSpecTextWidth / 2#
                            rt.dScaleY = 0.7
                            rt.dTextHeight = rt.dTextHeight * 0.7
                            rt.dTextWidth = rt.dTextWidth * 0.7
                            u.rtc.Add rt
                            Set rt = New clsSRUT
                            rt.sText = Arr(1)
                            rt.just = rc
                            rt.dScaleX = 1# * dSpecCmnScale
                            rt.dScaleY = 0.6
                            rt.dTextHeight = rt.dTextHeight * 0.5
                            rt.dTextWidth = rt.dTextWidth * 0.5
                            bAdd = True ' u.rtc.Add rt
                        End If
                        
                    End If
                
                End If
            ElseIf pos.POS_MCALC.mcID <> 1 Then
                If pos.pos_props.existsProperty("volume") Then
                    If Not pos.pos_props("volume").hasValue Then
                        bNoMass = True
                        Set mu = globMUnits("7") ' объем
                        rt.sText = mu.muSpecName
                        rt.dScaleX = 3# * dSpecCmnScale
                        rt.just = rc
                        bAdd = True ' u.rtc.Add rt
                    End If
'                ElseIf pos.pos_props.existsProperty("length") And pos.pos_props.existsProperty("width") And pos.pos_props.existsProperty("thickness") Then
'                    If Not pos.pos_props("length").hasValue And Not pos.pos_props("width").hasValue And Not pos.pos_props("thickness").hasValue Then
'                        bNoMass = True
'                        Set mu = globMUnits("7") ' объем
'                        rt.sText = mu.muSpecName
'                        rt.dScaleX = 3# * dSpecCmnScale
'                        rt.just = rc
'                        bAdd = True ' u.rtc.Add rt
'                    End If
                ElseIf pos.pos_props.existsProperty("length") Then
                    Set prop = pos.pos_props("length")
                    If prop.hasValue Then
                    
                        Call pos.getPosLength(pos.bCalcLap, bLap) ' получаем  bLap
                        
                        'If usrCurrent.depID = 1 And cattypes(cCats(CStr(pos.parentPart.catID)).catTypeID).ctEnum = ctRein And bLap Then
                        '    rt.sText = "**" & "L=" & pos.getPosLength(False, bLap)
                        '    rt.dScaleX = 30# * dSpecCmnScale
                        '    rt.maxwdt = 18# * dSpecCmnScale
                        'ElseIf...
                        If pos.pos_props.existsProperty("lenmin") And pos.pos_props.existsProperty("lenmax") And Not pos.pos_props.existsProperty("lenmid") Then
                            rt.dScaleX = 30# * dSpecCmnScale
                            rt.maxwdt = 18# * dSpecCmnScale
'                            rt.sText = "Lср=" & pos.getPosLength(pos.bCalcLap, bLap)
                            rt.sText = Replace(curSpecCfg.spcfgLevVar, "[lenmin]", pos.pos_props("lenmin").PVAL)
                            rt.sText = Replace(rt.sText, "[lenmax]", pos.pos_props("lenmax").PVAL)
                            rt.sText = Replace(rt.sText, "[lenmid]", pos.getPosLength(pos.bCalcLap, bLap))
                        Else
                            rt.sText = "L=" & pos.getPosLength(pos.bCalcLap, bLap)
                        End If
                        
                        bAdd = True ' u.rtc.Add rt
                    Else
                        rt.sText = getTrans(sRunMet, , curSpecCfg.iTrans)
                        bAdd = True ' u.rtc.Add rt
                    End If
                ElseIf dLength > 0 Then
                    rt.sText = "L=" & dLength
                    bAdd = True ' u.rtc.Add rt
                End If
            End If
            
            If bAdd Then
                If Not rtPrev Is Nothing Then
                    If Not rtPrev.rtSuffix Is Nothing And Len(rt.sText) > 0 Then
                        If rt.just = rc Then
                            rtPrev.rtSuffix.maxwdt = arSpecCol(3) - rt.dScaleX - Len(rt.sText) * dSpecTextWidth - Len(pos.POS_PD_NAME) * dSpecTextWidth
                            If curSpecCfg.iTrans Then rtPrev.rtSuffix.maxwdt = rtPrev.rtSuffix.maxwdt - 12# * dSpecCmnScale
                        Else
                            rtPrev.rtSuffix.maxwdt = rt.dScaleX - Len(pos.POS_PD_NAME) * dSpecTextWidth - 5# * dSpecCmnScale
                        End If
                    End If
                End If
                u.rtc.Add rt
            End If
        
        End If
        
        ' q-ty, mass =======================
        
        Dim qt As Double
        Dim um As Double
        Dim cm As Double
        Dim cat As clsCat
        Set cat = cCats(CStr(pos.parentPart.catID))
        
        If spt = stList And cattypes(cat.catTypeID).ctEnum = ctEmb Then
            qt = Round(pos.parentPart.partQty, 3)
            um = pos.posCMass
            cm = pos.posCMass * qt
        Else
            qt = pos.posQty
            um = pos.posUMass
            cm = pos.posCMass
        End If
        
        
        iCellNum = 4
        
        ' quantity
        If pos.POS_MCALC.bSpecQty Then
        
            Set rt = New clsSRUT
            If pos.isInRunMet Then
                rt.sText = Format(qt, sFmt0)
            Else
                rt.sText = Round(qt, 2)
            End If
            rt.bPress = True
            rt.bIsNumber = True
            rt.bForceDots = True
            Set u = r.cells(iCellNum)
            u.rtc.Add rt
    
        End If
        
        iCellNum = iCellNum + 1
        
        
        If curSpecCfg.iColCnt > 7 Then
        
            ' material
            If pos.POS_MAT.matID > 0 Then
            
                Set rt = New clsSRUT
                
                Dim str1 As String
                Dim str2 As String
                
                If pos.POS_MAT.MAT_STD.stdID > 0 Then str1 = pos.POS_MAT.MAT_STD.FULLNUMBER Else str1 = ""
                
                
                If curSpecCfg.bUseMatScnd Then
                    If pos.POS_MAT.MAT_SCND.MAT_STD.stdID > 0 Then str2 = pos.POS_MAT.MAT_SCND.MAT_STD.FULLNUMBER Else str2 = ""
                    rt.sText = pos.POS_MAT.matName & " " & str1
                    If Len(str2) > 0 Then
                        rt.sText = rt.sText & vbNewLine & pos.POS_MAT.MAT_SCND.matName & " " & str2
                    ElseIf Len(rt.sText) > 15 And Len(Trim(str1)) > 0 Then
                        rt.sText = pos.POS_MAT.matName & vbNewLine & str1
                    ElseIf Len(rt.sText) > 15 And Len(Trim(str1)) = 0 Then
                        rt.sText = stringSplit(rt.sText)
                    End If
                Else
                    rt.sText = pos.POS_MAT.matName & " " & str1
                    If Len(rt.sText) > 15 And Len(Trim(str1)) > 0 Then
                        rt.sText = pos.POS_MAT.matName & vbNewLine & str1
                    ElseIf Len(rt.sText) > 15 And Len(Trim(str1)) = 0 Then
                        rt.sText = stringSplit(rt.sText)
                    End If
                End If
                

                rt.bPress = True
                rt.just = lc
                rt.bIsNumber = False
                rt.dScaleX = rt.dTextWidth / 2#
                Set u = r.cells(iCellNum)
                u.rtc.Add rt
            
            End If
            
            iCellNum = iCellNum + 1
        
        End If
        
        
        
        ' unit mass
        If pos.POS_MCALC.bSpecUMass And pos.POS_MCALC.mcID <> -1 And bNoMass = False And Round(pos.posUMass, 3) > 0 Then
        
            If doppos Is Nothing Then
                Set rt = New clsSRUT
                rt.sText = FormatNum(um, pos.numDigits, 1)
                rt.bPress = True
                rt.bIsNumber = True
                rt.bForceDots = True
                Set u = r.cells(iCellNum)
                u.rtc.Add rt
            Else
                Set rt = New clsSRUT
                rt.sText = FormatNum(pos.posUMass, pos.numDigits, 1)
                rt.bPress = True
                rt.bIsNumber = True
                rt.bForceDots = True
                rt.just = lt
                rt.dScaleX = rt.dTextWidth / 5#
                Set u = r.cells(iCellNum)
                u.rtc.Add rt
                
                Set rt = New clsSRUT
                rt.sText = FormatNum(doppos.posUMass, pos.numDigits, 1)
                rt.bPress = True
                rt.bIsNumber = True
                rt.bForceDots = True
                rt.bDopText = True
                rt.just = rb
                rt.dScaleX = rt.dTextWidth / 5#
                Set u = r.cells(iCellNum)
                u.rtc.Add rt
            End If
        
        End If
        
        iCellNum = iCellNum + 1
        
        
        ' common mass
        If pos.POS_MCALC.bSpecCMass And pos.POS_MCALC.mcID <> -1 And bNoMass = False And Round(pos.posCMass, 3) > 0 Then
        
            If doppos Is Nothing Then
                Set rt = New clsSRUT
                rt.sText = FormatNum(cm, pos.numDigits, 1)
                rt.bPress = True
                rt.bIsNumber = True
                rt.bForceDots = True
                Set u = r.cells(iCellNum)
                u.rtc.Add rt
            Else
                Set rt = New clsSRUT
                rt.sText = FormatNum(pos.posCMass, pos.numDigits, 1)
                rt.bPress = True
                rt.bIsNumber = True
                rt.bForceDots = True
                rt.just = lt
                rt.dScaleX = rt.dTextWidth / 5#
                Set u = r.cells(iCellNum)
                u.rtc.Add rt
                
                Set rt = New clsSRUT
                rt.sText = FormatNum(doppos.posCMass, pos.numDigits, 1)
                rt.bPress = True
                rt.bIsNumber = True
                rt.bForceDots = True
                rt.bDopText = True
                rt.just = rb
                rt.dScaleX = rt.dTextWidth / 5#
                Set u = r.cells(iCellNum)
                u.rtc.Add rt
            End If
    
        End If
        
        
        
        
        ' примечание (posNote)
        If Len(Trim(pos.posNote)) > 0 Then
        
            iCellNum = iCellNum + 1
            
            Set rt = New clsSRUT
            rt.just = lc
            rt.sText = pos.posNote
            rt.bPress = True
            Set u = r.cells(iCellNum)
            u.rtc.Add rt
        
        ElseIf usrCurrent.pdsID > 0 And curSpecCfg.iColCnt = 8 Then

            iCellNum = iCellNum + 1
            
            If pos.POS_MCALC.mcID = 1 And pos.pos_props.existsProperty("length") Then
            
                If pos.pos_props("length").bEditable Then
                    Set rt = New clsSRUT
                    rt.just = lc
                    rt.sText = "Обрезать" & vbNewLine & "на монтаже"
                    rt.bPress = True
                    Set u = r.cells(iCellNum)
                    u.rtc.Add rt
                End If
            
            End If

        End If
        
        
    End If
    
    
    
    Set rt = Nothing
    
    
    If Not Me.AddRow(r) Then
        addCmnSpecPosRows = 0
        Exit Function
    End If
    
    qty = qty + 1
    
    addCmnSpecPosRows = qty
    
    Exit Function
err:
    
    addCmnSpecPosRows = qty
    'Resume Next
    
End Function


'/******************************************************************************
Public Function addCommonMass(part As clsPart, Optional sMass As String = "", Optional bItog As Boolean = False) As Integer
'/******************************************************************************

    On Error GoTo addCommonMass_ERR

    Dim rt As clsSRUT
    Dim r As New clsSR
    Dim u As clsSRU
    
    Set r.prnt = Me
    
    If bItog Then
    
        Set rt = New clsSRUT
        
        rt.sText = "Итого"
        rt.dScaleX = rt.dTextWidth
        rt.just = rc
        Set u = r.cells(curSpecCfg.iColCnt - 3)
        u.rtc.Add rt
    
    End If
    
    Set rt = New clsSRUT
    
    If part Is Nothing Then
        If Len(sMass) = 0 Then Exit Function
        rt.sText = sMass
    Else
        rt.sText = part.getCommonMassString("/") ' PART_CMASS
    End If
    rt.bOverLine = Not bItog
    rt.bIsNumber = True
    rt.bForceDots = True
    Set u = r.cells(curSpecCfg.iColCnt - 1)
    u.rtc.Add rt
    
    
    If Me.AddRow(r) Then addCommonMass = 1
    
    
    



Exit Function

addCommonMass_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "addCommonMass - Error"

End Function



Public Sub createMSElements()


On Error GoTo err:

    Dim sr As clsSpecRow
    Dim sln As clsSpecLine
    Dim stxt As clsSpecText
    
    
    
    Dim elCell As CellElement
    Dim elLine As LineElement
    Dim elText As TextElement
    
    
    Dim pt As Point3d
    
    Dim msapp As Object
    
    Set msapp = getMS
    
    If msapp Is Nothing Then
        
'        F1.SB.Panels("status").text = "Откройте требуемый файл"
        Call MsgBox("Откройте требуемый файл и выполните команду заново", vbOK, "")
        
        Exit Sub
        
    End If
    
    
    

        
        
    
'    If MsgBox("Перейдите в приложение для установки таблицы и укажите точку размещений спецификации", vbOKCancel, "") = vbCancel Then
'        GoTo alles
'    End If
    

    
    Dim Message As CadInputMessage
    Set Message = msapp.CadInputQueue.GetInput(msdCadInputTypeDataPoint, msdCadInputTypeReset)
    
    If Message.InputType = msdCadInputTypeDataPoint Then
    
        Dim p As Point3d
        p = Message.Point
        
    '    Set elCell = msapp.CreateCellElement3("123", pt, False)
    
        Me.originX = p.X
        Me.originY = p.Y
        
        
        Dim flags As MsdTransientFlags
        flags = msdTransientFlagsOverlay + msdTransientFlagsSnappable
        
'        If Not tec1 Is Nothing Then tec1.Reset
'        Set tec1 = CreateTransientElementContainer1(Nothing, flags, msdViewAll, msdDrawingModeNormal)
'
        
        msapp.UpdateGraphicGroupNumber
        
'       Call msapp.SetCExpressionValue("tabletrans", tec1.MdlTransientDescrP, "simdgc")
        
        
        
        ' проход по строчкам таблицы
        For Each sr In Me
        
            For Each sln In sr.vlines
                Set elLine = sln.createMSLine(msapp)
                msapp.ActiveModelReference.AddElement elLine
'                tec1.AppendCopyOfElement elLine
'                elCell.AppendToCellOfCurrentElement elLine
            Next
            For Each sln In sr.hlines
                Set elLine = sln.createMSLine(msapp)
                msapp.ActiveModelReference.AddElement elLine
'                tec1.AppendCopyOfElement elLine
'                elCell.AppendToCellOfCurrentElement elLine
            Next
            For Each stxt In sr.textfields
                Set elText = stxt.createMSText(msapp)
                msapp.ActiveModelReference.AddElement elText
'                tec1.AppendCopyOfElement elText
'                elCell.AppendToCellOfCurrentElement elLine
            Next
        
        Next
        
    '    ActiveModelReference.AddElement elCell
    
    ElseIf Message.InputType = msdCadInputTypeReset Then
        msapp.CadInputQueue.SendReset
    End If
    
    
'    CadInputQueue.SendCommand "mdl keyin simdgc drawtable"
    

    



alles:

    If Not msapp Is Nothing Then msapp.CommandState.StartDefaultCommand
    
   
    Set msapp = Nothing
    
    Exit Sub
err:
    
    MsgBox "Проблема при отрисовке. Перезапуск Offtake может решить проблему"
    Set msapp = Nothing

End Sub

