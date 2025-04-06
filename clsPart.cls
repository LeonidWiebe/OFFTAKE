VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsPart"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Member0" ,"colPos"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit


Public catID As Long
Public catName As String

'Public cat As clsCat

Public catIDold As Long

Public partID As Long
Public partIDold As Long
'Public parentID As Long
Public part_prntID As Long

Public bPartDscrUpdate As Boolean
Public bDsNum As Boolean
Private sDescr As String


Public partName As String
Public partNameLink As String
Public partNameOld As String
Public prms As New Collection ' of long

Public partDescr As String
Public partVers As String
Public partSheet As String
Public partSortNumber As String

Public partStatusID As Long

Public ps As colPos

Public partDocSetPartListID As Long
Public partDocSetDrawingsID As Long

Public partdefID As Long
Private partdefName_over As String

Public iSpecNumber As Integer

Public typeID As Long
Public parttypeID As Long ' parttypeID, typeID исп. для типа объекта - part, catalog, ...
Private typeName_over As String

Public partOK As Boolean

Public FG As VSFlexGrid
Public fgp As VSFlexGrid


Public bIsCat As Boolean
Public bIsLink As Boolean
Public bIsByPrm As Boolean

'Public bLoadedFromBase As Boolean
Public bRoundDefined As Boolean
Public iRoundLocalShift As Integer

Public iMaxPosNumber As Long ' только для импорта арматуры
Public partQty As Double ' для загрузки изделий из модели, спецификации
Public partRunMetQty As Double ' только для загрузки изделий из модели
Public bRunMet As Boolean ' только для расчета спецификации
Public massCommon As Double ' только для расчета спецификации

Public bBlockUpdate As Boolean ' block update from rein model

Private flds() As Variant
Private vls() As Variant

Public ts_elID As Long
Public ts_mrPtr As Long
Public s_elID As String

Public specPrefix As String

' для использования в модели
Private m_rng As Offtmisc.OfftIntRange3D

Public colTagSetNames As Collection
 
 
Public koefs As New Collection
 
Public Property Get rng() As OfftIntRange3D
    rng = m_rng
End Property

'/******************************************************************************
Public Property Get PART_CAT() As clsCat
'/******************************************************************************

    On Error GoTo PART_CAT_ERR
    
    If Me.catID = 0 Then GoTo PART_CAT_ERR
    
    Set PART_CAT = cCats(CStr(Me.catID))

Exit Property

PART_CAT_ERR:
    Set PART_CAT = New clsCat

End Property






'/******************************************************************************
Public Sub setRange(rLowX As Double, rLowY As Double, rLowZ As Double, rHighX As Double, rHighY As Double, rHighZ As Double)
'/******************************************************************************

    On Error GoTo setRange_ERR

    m_rng.high.X = CLng(rHighX)
    m_rng.high.Y = CLng(rHighY)
    m_rng.high.z = CLng(rHighZ)
    
    m_rng.low.X = CLng(rLowX)
    m_rng.low.Y = CLng(rLowY)
    m_rng.low.z = CLng(rLowZ)


Exit Sub

setRange_ERR:

    m_rng.high.X = 0
    m_rng.high.Y = 0
    m_rng.high.z = 0
    
    m_rng.low.X = 0
    m_rng.low.Y = 0
    m_rng.low.z = 0

'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "setRange - Error"

End Sub


'/******************************************************************************
Public Function getPartStatusName() As String
'/******************************************************************************

    On Error GoTo getPartStatusName_ERR

    getPartStatusName = stts(partStatusID)


Exit Function

getPartStatusName_ERR:
    getPartStatusName = "Unknown"
'    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getPartStatusName - Error"

End Function

'Public Property Let u(ByVal v As Double)
'End Property

'Public Property Get u(ByVal v As Double)
'End Property


'/******************************************************************************
Public Function setCat(ID As Long) As Boolean
'/******************************************************************************
    
    On Error GoTo setCat_ERR
    
    catID = ID
    catName = PART_CAT.catName
    
    setCat = True
    
    Exit Function
    
setCat_ERR:
    
End Function

'/******************************************************************************
Public Function getCommonMassString(strSep As String) As String
'/******************************************************************************

    On Error GoTo getCommonMassString_ERR

    Dim p As clsPos
    Dim iLev As Integer
    
    For Each p In ps.pm
        If p.getMassLevel > 0 And (p.POS_MCALC.mcID = 10) Then ' 10 - ввод массы вручную (напр. набивка)
            If iLev < p.getMassLevel Then iLev = p.getMassLevel
        End If
    Next p

    Dim bNoSepCommon As Boolean
    bNoSepCommon = False
    If Not curSpecCfg Is Nothing Then
        bNoSepCommon = curSpecCfg.bPosdefIsText
    End If


    If iLev > 0 And bNoSepCommon = False Then
        getCommonMassString = getPartMassForSpec(0) & strSep & getPartMassForSpec(iLev)
    Else
        getCommonMassString = getPartMassForSpec(0)
    End If


Exit Function

getCommonMassString_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "getCommonMassString - Error"

End Function



'/******************************************************************************
' ТОЛЬКО ДЛЯ РАСЧЕТА МАССЫ В СПЕЦИФИКАЦИИ
Public Function getPartMassForSpec(iLevel As Integer, Optional bReal As Boolean = False) As String
'/******************************************************************************

    On Error GoTo getCommonMassString_ERR

    Dim m As Double
    Dim bLev As Boolean
    Dim numdig As Integer

    Dim p As clsPos
    
    m = 0#
    
    For Each p In ps.pm
'        If p.getMassLevel <= iLevel Then
        If ((iLevel = 0 And Not (p.POS_MCALC.mcID = 10)) Or iLevel > 0) And p.POS_PD.bInclCmnMass Then
        
            If bReal Then
                'p.bUMCalc = False
                'm = m + getDbl(p.POS_UMASS_REAL) * p.posQty * p.posMassKoef
                m = m + p.posCMass * p.posMassKoef
            Else
                m = m + getDbl(p.POS_CMASS) * p.posMassKoef
            End If
            
            If numdig < p.numDigits Then numdig = p.numDigits
            
        End If
    Next p
    
    For Each p In ps.pe
'        If p.getMassLevel <= iLevel Then
        If ((iLevel = 0 And Not (p.POS_MCALC.mcID = 10)) Or iLevel > 0) And p.POS_PD.bInclCmnMass Then
        
            If bReal Then
                'p.bUMCalc = False
                'm = m + getDbl(p.POS_UMASS_REAL) * p.posQty * p.posMassKoef
                m = m + p.posCMass * p.posMassKoef
            Else
                m = m + getDbl(p.POS_CMASS) * p.posMassKoef
            End If
            
            If numdig < p.numDigits Then numdig = p.numDigits
            
        End If
    Next p
    
    
    If bReal Then
        getPartMassForSpec = Format(m, "0.000000000")
    Else
        getPartMassForSpec = Format(roundShaman(m, numdig), "0.0")
    End If



Exit Function

getCommonMassString_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "getCommonMassString - Error"

End Function


'/******************************************************************************
Public Property Get PART_CMASS() As Double
'/******************************************************************************

    On Error GoTo PART_CMASS_ERR

    Dim m As Double

    Dim p As clsPos
    
    For Each p In ps.pm
        If p.POS_PD.bInclCmnMass Then m = m + getDbl(p.POS_CMASS)
    Next p
    
    For Each p In ps.pe
        If p.POS_PD.bInclCmnMass Then m = m + getDbl(p.POS_CMASS)
    Next p
    
    PART_CMASS = m

Exit Property

PART_CMASS_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "PART_CMASS - Error"

End Property

Public Function getPartMassPM(iLev As Integer) As Double

    Dim m As Double

    Dim p As clsPos
    
    For Each p In ps.pm
        If p.getMassLevel <= iLev And p.POS_PD.bInclCmnMass Then m = m + getDbl(p.POS_CMASS)
    Next p
    
    getPartMassPM = m


End Function


'/******************************************************************************
Public Sub updateMasses(Optional bRecalcPositions As Boolean = True, Optional bAll As Boolean = False)
'/******************************************************************************
    
    On Error GoTo updateMasses_ERR
    
    If fgp.Rows < 3 Then Exit Sub ' если нет позиций
    
    Dim i As Long
    Dim p As clsPos
    Dim bUpd As Boolean
    
    If bRecalcPositions Then
        For i = 1 To fgp.Rows - 1
            
            If fgp.RowHeight(i) = 480 Then
                
                Dim ID As Long
                ID = Val(fgp.TextMatrix(i, 4))
                If ID > 0 Then
                    Set p = ps(CStr(ID))
                    If bAll Or p.POS_MCALC.mcID = 5 Then p.updatePosRow i, bUpd, False, False, False, True
                End If
                
                
            Else
            End If
            
        Next i
    End If
    
    fgp.TextMatrix(fgp.Rows - 1, 3) = Me.getCommonMassString(" / ") ' PART_CMASS
    fgp.Cell(flexcpAlignment, fgp.Rows - 1, 3) = flexAlignRightCenter
    

    
    
    
    Exit Sub
    
updateMasses_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "updateMasses - Error"
    
End Sub

'/******************************************************************************
Public Function updateMassesInBase(Optional bForceIgnoreStatus As Boolean = False) As Boolean
'/******************************************************************************

    On Error GoTo updateMassesInBase_ERR

    Dim p As clsPos
    Dim bOk As Boolean
    
    If Me.partStatusID = pst.pstRazrabotka Or bForceIgnoreStatus Then

        For Each p In ps.pm
            bOk = updateTableInBase(cn_data, p.POS_SRC_TABLE, "posUnitMass", getDbl(p.POS_UMASS), "posID", p.posID)
            bOk = updateTableInBase(cn_data, p.POS_SRC_TABLE, "posCommonMass", getDbl(p.POS_CMASS), "posID", p.posID)
        Next p
        
        For Each p In ps.pe
            bOk = updateTableInBase(cn_data, p.POS_SRC_TABLE, "posUnitMass", getDbl(p.POS_UMASS), "posID", p.posID)
            bOk = updateTableInBase(cn_data, p.POS_SRC_TABLE, "posCommonMass", getDbl(p.POS_CMASS), "posID", p.posID)
        Next p
        
        updateMassesInBase = True
    
    End If
    
    


Exit Function

updateMassesInBase_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "updateMassesInBase - Error"

End Function


Private Sub Class_Initialize()

    Set FG = F1.fgPart
    Set fgp = F1.fgPositions
    Set ps = New colPos
    
    ReDim flds(0 To 14)
    ReDim vls(0 To 14)
    
    flds(0) = "catID"
    flds(1) = "partdefID"
    flds(2) = "typeID"
    flds(3) = "partName"
    flds(4) = "partDescr"
    flds(5) = "partVersion"
    flds(6) = "partIDold"
    flds(7) = "catIDold"
    flds(8) = "partSheet"
    flds(9) = "partSortNumber"
    flds(10) = "partMainPosEP" ' используется теперь для хранения флага блокирования обновления из модели для арматуры (mnuReinGridBlock)
    flds(11) = "parentID"
    flds(12) = "partStatusID"
    flds(13) = "partRoundShift"
    flds(14) = "partRoundSaved"
    
    Set colTagSetNames = New Collection
    
    bPartDscrUpdate = True
    


End Sub

'/******************************************************************************
Private Sub Class_Terminate()
'/******************************************************************************

    On Error GoTo Class_Terminate_ERR

    Set ps = Nothing
    
Exit Sub

Class_Terminate_ERR:

End Sub


'/******************************************************************************
Public Function saveName(n As String) As Boolean
'/******************************************************************************

    On Error GoTo NAME_ERR

    saveName = False
    
    Dim partNewName As String
    Dim partBaseName As String
    Dim bLog As Boolean
    
    
    partBaseName = selectStringFromBase(cn_data, "part", "partName", "partID", partID)
    
    
    If Len(Trim(n)) > 0 Then
    
        partNewName = correctPartName(n)
        
        If partNewName = strNewPartName Then bLog = False Else bLog = True
    
        If partBaseName = partNewName And bIsLink Then ' reset
        
            partNewName = ""
            partName = partBaseName
            
        ElseIf partBaseName = partNewName Then ' то же имя
        
            Exit Function
            
        Else
        
            If checkExistInCatalog(partNewName, partVers) > 0 Then
                If Len(partVers) > 0 Then
                    MsgBox n & " (версия " & partVers & ") уже есть в каталоге", vbCritical, ""
                Else
                    MsgBox n & " уже есть в каталоге", vbCritical, ""
                End If
                Exit Function
            End If
            
            partName = partNewName
            
        End If
    
        
    ElseIf Me.bIsLink Then
    
        partNewName = ""
        partName = partBaseName
        
    Else
        Exit Function
    End If
    
    
    'correctName
    

    Dim RS As New ADODB.Recordset
    
    If Me.bIsLink Then
    
        'Dim part_catID As Long
        'part_catID = selectLongFromBase(cn_data, "part", "catID", "partID", partID)
    
        RS.Open "select * from r_catalog_part where partID = " & partID & " and catID = " & lngCurCatID, cn_data, adOpenForwardOnly, adLockOptimistic
    
        If Not RS.EOF Then
        
            RS.MoveFirst
            If Len(partNewName) = 0 Then
                RS.fields("partLinkName").Value = Null
            Else
                RS.fields("partLinkName").Value = partName
            End If
            RS.Update
            
            'If bLog Then Call writeOperationS(operModify, "part", partID, "наименование " & n)
            
        End If
    
    Else
    
        RS.Open "select partName, partSortNumber from part where partID = " & partID, cn_data, adOpenForwardOnly, adLockOptimistic
        
        If Not RS.EOF Then
            
            RS.MoveFirst
            RS.fields("partName").Value = partName
            RS.fields("partSortNumber").Value = genSortNumber(partName)
            RS.Update
            
            If bLog Then Call writeOperationS(operModify, "part", partID, "наименование " & partName)
            
        End If
        
        RS.Close
        
    End If
    
    Set RS = Nothing
    
    If F1.fgPart.Rows > 0 Then F1.fgPart.TextMatrix(0, 1) = partName
    

    saveName = True


Exit Function

NAME_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "part.saveName - Error"

End Function

'/******************************************************************************
Public Property Let DESCR(ByVal n As String)
'/******************************************************************************

    On Error GoTo DESCR_ERR



    Dim RS As New ADODB.Recordset
    
    RS.Open "select partDescr from part where partID = " & partID, cn_data, adOpenForwardOnly, adLockOptimistic
    
    If RS.EOF Then Exit Property
    
    RS.MoveFirst
    RS.fields("partDescr").Value = Trim(n)
    RS.Update
    
    partDescr = Trim(n)
    If F1.fgPart.Rows > 3 Then F1.fgPart.TextMatrix(3, 1) = Me.PART_DESCR
    If Me.bDsNum Then
        If bFormGridsIcons Then F1.fgPart.Cell(flexcpPicture, 3, 1) = F1.ImageList2.ListImages("catalog").ExtractIcon
        F1.fgPart.Cell(flexcpPictureAlignment, 3, 1) = flexPicAlignRightCenter
    End If
    
    If Len(Trim(n)) = 0 Then
        Call writeOperationS(operModify, "part", partID, "обнуление обозначения")
    Else
        Call writeOperationS(operModify, "part", partID, "обозначение " & n)
    End If



Exit Property

DESCR_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "DESCR - Error"

End Property

'/******************************************************************************
Public Property Let SHEET(ByVal n As String)
'/******************************************************************************

    On Error GoTo DESCR_ERR

    Dim s As String
    s = partSheet

    Dim v As Long
    Dim vtosave As String
    
    v = Val(Trim(n))
    
    If v <= 0 Then
        'F1.fgPart.TextMatrix(4, 1) = s
        'Exit Property
        vtosave = ""
    
    Else
        vtosave = CStr(v)
    End If
    

    Dim RS As New ADODB.Recordset
    
    RS.Open "select partSheet from part where partID = " & partID, cn_data, adOpenForwardOnly, adLockOptimistic
    
    If RS.EOF Then Exit Property
    
    If v > 0 And lngCurSpecID > 0 Then
        Dim SC As clsSCfg
        Set SC = getColItem(colSpecTextOver, CStr(lngCurSpecID))
        If Not SC Is Nothing Then
            If Len(SC.spec_sheet_num_fmt) > 0 Then
                vtosave = Format(v, SC.spec_sheet_num_fmt)
            End If
            If Len(SC.spec_sheet_num_pfx) > 0 Then
                vtosave = SC.spec_sheet_num_pfx & vtosave
            End If
            
        End If
    End If
    
    RS.MoveFirst
    RS.fields("partSheet").Value = vtosave
    RS.Update
    
    partSheet = vtosave
    If F1.fgPart.Rows > 4 Then F1.fgPart.TextMatrix(4, 1) = partSheet
    
    Call writeOperationS(operModify, "part", partID, "лист " & n)



Exit Property

DESCR_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "SHEET - Error"

End Property


'/******************************************************************************
Public Function saveVERS(ByVal vers As String)
'/******************************************************************************

    On Error GoTo DESCR_ERR
    
    Dim sVers As String
    
    sVers = UCase(Trim(vers))

    If checkExistInCatalog(partName, sVers) > 0 Then
        If Len(sVers) > 0 Then
            MsgBox partName & " (версия " & sVers & ") уже есть в каталоге", vbCritical, ""
        Else
            MsgBox partName & " уже есть в каталоге", vbCritical, ""
        End If
        Exit Function
    End If


    Dim RS As New ADODB.Recordset
    
    RS.Open "select partVersion from part where partID = " & partID, cn_data, adOpenForwardOnly, adLockOptimistic
    
    If RS.EOF Then Exit Function
    
    RS.MoveFirst
    RS.fields("partVersion").Value = sVers
    RS.Update
    
    partVers = sVers
    If F1.fgPart.Rows > 5 Then F1.fgPart.TextMatrix(5, 1) = partVers
    
    Call writeOperationS(operModify, "part", partID, "версия " & sVers)



Exit Function

DESCR_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "saveVERS - Error"

End Function



'/******************************************************************************
Public Sub savePartDef(pdID As Long)
'/******************************************************************************

    On Error GoTo PARTDEF_ERR


    If pdID <= 0 Then Exit Sub

    Dim RS As New ADODB.Recordset
    
    RS.Open "select partdefID from part where partID = " & partID, cn_data, adOpenForwardOnly, adLockOptimistic
    
    If RS.EOF Then Exit Sub
    
    RS.MoveFirst
    RS.fields("partdefID").Value = pdID
    RS.Update
    
    partdefID = pdID
'    partdefName = partdefs(pdID).partdefName
    
    
    F1.fgPart.TextMatrix(1, 1) = Me.partdefName
    F1.fgPart.TextMatrix(1, 2) = partdefID
    
    Call writeOperationS(operModify, "part", partID, "тип " & partdefName)


Exit Sub

PARTDEF_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "savePartDef - Error"

End Sub

Public Sub savePartType(ptID As Long)


    If ptID <= 0 Then Exit Sub

    Dim RS As New ADODB.Recordset
    
    RS.Open "select typeID from part where partID = " & partID, cn_data, adOpenForwardOnly, adLockOptimistic
    
    If RS.EOF Then Exit Sub
    
    RS.MoveFirst
    RS.fields("typeID").Value = ptID
    RS.Update
    
    typeID = ptID
    parttypeID = ptID
'    typeName = parttypes(ptID).ptName
    
    
    F1.fgPart.TextMatrix(2, 1) = typeName
    F1.fgPart.TextMatrix(2, 2) = typeID
    
    Call writeOperationS(operModify, "part", partID, "тип " & typeName)



End Sub

'/******************************************************************************
Public Function setIDv2(ID As Long, bLoadPositions As Boolean, bLoadProperties As Boolean, bLoadPoints As Boolean, Optional RSfrom As ADODB.Recordset = Nothing) As Boolean
'/******************************************************************************
    
    On Error GoTo setIDv2_ERR
    
    
    Dim RS As ADODB.Recordset
    
    
    If RSfrom Is Nothing Then
    
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        
        
        Dim strSQL As String
        
        ' VIEW_R_PART_POSITION - предст. служащее исключительно для быстрого отображения содержимого изделия,
        ' по сути является дублированием VIEW_POSITION, но с некторыми отличиями
        
        strSQL = "SELECT "
        
        strSQL = strSQL & conn.strBaseName & ".dbo.view_r_part_position.* "
        strSQL = strSQL & "," & conn.strSrtmName & ".dbo.view_r_sortament_property_3.* "
        strSQL = strSQL & "," & conn.strBaseName & ".dbo.part.partName as prtnm "
        strSQL = strSQL & "," & conn.strBaseName & ".dbo.part.catID as prtCatID "
        
        strSQL = strSQL & "FROM "
        strSQL = strSQL & conn.strBaseName & ".dbo.view_r_part_position "
        
        strSQL = strSQL & "LEFT OUTER JOIN "
        strSQL = strSQL & conn.strSrtmName & ".dbo.view_r_sortament_property_3 "
        strSQL = strSQL & "ON "
        strSQL = strSQL & conn.strBaseName & ".dbo.view_r_part_position.pos_srtmID "
        strSQL = strSQL & "= "
        strSQL = strSQL & conn.strSrtmName & ".dbo.view_r_sortament_property_3.srtmID "
        
        strSQL = strSQL & "LEFT OUTER JOIN "
        strSQL = strSQL & conn.strBaseName & ".dbo.part "
        strSQL = strSQL & "ON "
        strSQL = strSQL & conn.strBaseName & ".dbo.view_r_part_position.pos_srtmID "
        strSQL = strSQL & "= "
        strSQL = strSQL & "-" & conn.strBaseName & ".dbo.part.partID "
        
        strSQL = strSQL & "WHERE "
        strSQL = strSQL & conn.strBaseName & ".dbo.view_r_part_position.partID = " & ID & " "
        
        strSQL = strSQL & "ORDER BY [posNumber]"
        
        
        RS.Open strSQL, cn_data, adOpenForwardOnly, adLockReadOnly
        
    Else
    
        Set RS = RSfrom
        
    End If
    
    
    If RS.EOF Then
        partID = 0
        partOK = False
        Exit Function
    End If
    
    
    If RSfrom Is Nothing Then RS.MoveFirst
    
    
    
    
    
    '|||||||||||||||||||||||||||||| Д Е Т А Л Ь |||||||||||||||||||||||||||||||||||||||||||||||||||
    
    partID = RS.fields("partID").Value
    
    setCat RS.fields("catID").Value
    
    catIDold = RS.fields("catIDold").Value & ""
    partIDold = RS.fields("partIDold").Value & ""
    partNameOld = RS.fields("partNameOld").Value & ""
    
    partName = RS.fields("partName").Value & ""
    part_prntID = RS.fields("parentID").Value
    partStatusID = RS.fields("partStatusID").Value
    
    ' round settings -------
    bRoundDefined = CBool(RS.fields("partRoundSaved").Value)
    If bRoundDefined Then
        iRoundLocalShift = RS.fields("partRoundShift").Value
    Else
        iRoundLocalShift = rndGlobal.iPosMass
    End If
    ' ----------------------
    
    If IsNull(RS.fields("partdefID").Value) Then
        partdefID = 0
    Else
        partdefID = RS.fields("partdefID").Value
    End If
    
'    partdefName = partdefs(partdefID).partdefName
    
    If IsNull(RS.fields("typeID").Value) Then
        typeID = 0
        parttypeID = 0
    Else
        typeID = RS.fields("typeID").Value
        parttypeID = typeID
    End If
    
'    typeName = parttypes(typeID).ptName
    
    'Dim ct As clsCat
    'Set ct = cCats(CStr(catID))
    If cCats(CStr(catID)).dsDrawID = 0 Then partDescr = RS.fields("partDescr").Value & ""
    
    partVers = RS.fields("partVersion").Value & ""
    partSheet = RS.fields("partSheet").Value & ""
    partSortNumber = RS.fields("partSortNumber").Value & ""
    
    partDocSetPartListID = RS.fields("dsPartListID").Value
    partDocSetDrawingsID = RS.fields("dsDrawingsID").Value
    
    bBlockUpdate = CBool(RS.fields("partMainPosEP").Value)
    
    '||||||||||||||||||||||||||| П О З И Ц И И ||||||||||||||||||||||||||||||||||||||||
    If bLoadPositions Then
        
        
        Dim p As clsPos
        Set ps = New colPos
        
        
        Do
            
            Set p = New clsPos
            
            Set p.parentPart = Me
            
            p.posPrtName = RS.fields("prtnm").Value & ""
            p.posPrtCatID = Val(RS.fields("prtCatID").Value & "")
'            p.posPrtCatPath = RS.Fields("prtCatPath").Value & ""
            p.posPrtMass = RS.fields("partMass").Value
            
            If p.loadDataFromRSrecord(RS, "pos_") And bLoadProperties Then
            
'                p.getSrtmProps
                p.reloadSrtmPropsFromRS RS
                p.reloadPosPropsFromRS RS, "pos_"
                
                If bLoadPoints And ps.Count = 0 Then Rein.armLoadSketch p
                
                Set p = ps.AddPos(p, CStr(p.posID))
            
            End If
            
            
            Set p = Nothing
            
            RS.MoveNext
        Loop Until RS.EOF
        
    End If
    
    If RSfrom Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If
    
    setIDv2 = True
    
    Exit Function
    
setIDv2_ERR:
    If RSfrom Is Nothing Then Set RS = Nothing
    
    '    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "setIDv2 - Error"
    
End Function


'/******************************************************************************
Public Function getPartNameForSpec(ByRef spcfg As clsSCfg) As String
'/******************************************************************************

    On Error GoTo getPartNameForSpec_ERR
    
    getPartNameForSpec = Me.partName
    
    If spcfg Is Nothing Then Exit Function
    
    If spcfg.o_spec_text_name.Count = 0 Then Exit Function
    
    Dim sPartNameCand As String
    Dim sReplaceFrom As String
    Dim sReplaceTo As String
    Dim obj As colAts
    
    
    Set obj = spcfg.o_spec_text_name("parttype" & Me.parttypeID)
    
    sPartNameCand = obj.attval("value")
    
    
    If Len(sPartNameCand) = 0 Then
    
        Set obj = spcfg.o_spec_text_name
    
        sPartNameCand = obj.attval("value")
        
    End If
    
    
    
    If Len(sPartNameCand) = 0 Then Exit Function
    
    sPartNameCand = Replace(sPartNameCand, "[partname]", partName)
    sPartNameCand = Replace(sPartNameCand, "[typename]", Me.PARTTYPE.ptName)
    
    
    ' === replace ===
    Dim orpl As colAts
    
    For Each orpl In obj
        If left(orpl.atname, 7) = "replace" Then
            sReplaceFrom = orpl.attval("from")
            sReplaceTo = orpl.attval("to")
            If Len(sReplaceFrom) > 0 Then
                sPartNameCand = Replace(sPartNameCand, sReplaceFrom, sReplaceTo)
            End If
        End If
    Next
    
    
    Set obj = spcfg.o_spec_text_name
    
    For Each orpl In obj
        If left(orpl.atname, 7) = "replace" Then
            sReplaceFrom = orpl.attval("from")
            sReplaceTo = orpl.attval("to")
            If Len(sReplaceFrom) > 0 Then
                sPartNameCand = Replace(sPartNameCand, sReplaceFrom, sReplaceTo)
            End If
        End If
    Next
    
    ' ===============
    
    If Len(sPartNameCand) = 0 Then Exit Function
    
    getPartNameForSpec = sPartNameCand


    
Exit Function

getPartNameForSpec_ERR:
    getPartNameForSpec = Me.partName
    'MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getPartNameForSpec - Error"

End Function




'/******************************************************************************
Public Property Let ID(ByVal vID As Long)
'/******************************************************************************
    
    On Error GoTo ID_ERR
    
    'gotick True
    
    setIDv2 vID, True, True, False
    
    'gotick False, "after setIDv2"
    
    updatePartGrids False
    
    'gotick False, "after updatePartGrids"
    
    Exit Property
    
ID_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "ID - Error"
    
End Property


'/******************************************************************************
Public Sub updatePartGrids(bReloadsProps As Boolean)
'/******************************************************************************
    
    On Error GoTo updatePartGrids_ERR
    
    Dim ds As clsDocSet
    
    FG.Rows = 0
    FG.ColHidden(2) = True
    FG.ColHidden(3) = True
    FG.ColHidden(4) = True
    FG.ColHidden(5) = True
    FG.ColHidden(6) = True
    
    
    If partID = 0 Then Exit Sub
    
    Dim ct As clsCat
    Set ct = cCats(catID)
    
    
    ' изделие
    '-------------------------------------------------------------------
    If Not bFormGridsRedraw Then FG.redraw = flexRDNone
    
    FG.Rows = 0
    
    FG.EditMask = ""
    
    
    If bIsCat Then
        F1.fgCatsAddCatalog FG, Me.partID
        FG.Tag = objs("catalog")
    Else
    
        If Me.bIsLink And Len(Me.partNameLink) > 0 Then
            FG.AddItem "Наименование" & vbTab & partNameLink
        Else
            FG.AddItem "Наименование" & vbTab & partName
        End If
        FG.Cell(flexcpFontBold, FG.Rows - 1, 0) = True
        
        FG.AddItem "Характеристика" & vbTab & Me.partdefName & vbTab & partdefID
        FG.Cell(flexcpFontBold, FG.Rows - 1, 0) = True
        
        If Me.partdefID = 4 Then
            FG.AddItem "KKS" & vbTab & (-Me.partDocSetDrawingsID * (-Me.partDocSetPartListID + 1)) & vbTab & 0
        Else
            FG.AddItem "Тип" & vbTab & typeName & vbTab & typeID
        End If
        FG.Cell(flexcpFontBold, FG.Rows - 1, 0) = True
        
        FG.AddItem "Обозначение" & vbTab & Me.PART_DESCR & vbTab & 0
        FG.Cell(flexcpFontBold, FG.Rows - 1, 0) = True
        If Me.bDsNum Then
            'If bFormGridsIcons Then
                FG.Cell(flexcpPicture, FG.Rows - 1, 1) = F1.ImageList2.ListImages("catalog").ExtractIcon
            'End If
            FG.Cell(flexcpPictureAlignment, FG.Rows - 1, 1) = flexPicAlignRightCenter
        End If
        
'        If partDocSetPartListID > 0 Then
'            Set ds = globDocSets(CStr(partDocSetPartListID))
'            ds.setPartID partID
'            FG.AddItem "Ведомость" & vbTab & ds.docsetNumber & vbTab & 0
'            FG.Cell(flexcpFontBold, FG.Rows - 1, 0) = True
'        End If
        
'        If partDocSetDrawingsID > 0 Then
'            Set ds = globDocSets(CStr(partDocSetDrawingsID))
'            ds.setPartID partID
'            FG.AddItem "Комплект" & vbTab & ds.docsetNumber & vbTab & 0
'            FG.Cell(flexcpFontBold, FG.Rows - 1, 0) = True
'        End If
        
        FG.AddItem "Лист" & vbTab & partSheet & vbTab & 0
        FG.Cell(flexcpFontBold, FG.Rows - 1, 0) = True
        
        FG.AddItem "Версия" & vbTab & partVers & vbTab & 0
        FG.Cell(flexcpFontBold, FG.Rows - 1, 0) = True
        
        
        If bIsLink Then
        
    '    Dim nd As Node
    '    Set nd = F1.tvGetTreeNode(F1.tvCats, "catalog" & catID)
    '    If nd Is Nothing Then
    '        FG.AddItem "Каталог" & vbTab & catName & vbTab & 0
    '    Else
    '        FG.AddItem "Каталог" & vbTab & nd.FullPath & vbTab & 0
    '    End If
        
            FG.AddItem "Каталог" & vbTab & cCats(CStr(catID)).getCatPath & vbTab & 0
        
        Else
            FG.AddItem "Статус" & vbTab & getPartStatusName & vbTab & partStatusID
        End If
        FG.Cell(flexcpFontBold, FG.Rows - 1, 0) = True
        
        FG.Tag = objs("part")
    End If
    
    
    
    FG.AddItem ""
    
    FG.AutoSize 0
    
    'gotick False, "after AutoSize"

    Dim bRoundChanged As Boolean
    bRoundChanged = False
    
    ' определяем сдвиг для тех изделий, в которых он не определен --------------
    If Not Me.bRoundDefined And Not bIsCat Then
    
        If updateTableInBase(cn_data, "part", "partRoundShift", rndGlobal.iPosMass, "partID", Me.partID) Then
            updateTableInBase cn_data, "part", "partRoundSaved", CInt(1), "partID", Me.partID
            iRoundLocalShift = rndGlobal.iPosMass
            bRoundDefined = True
            bRoundChanged = True
        End If
    
    End If
    '--------------------------------------------------------------------------
    
    'gotick False, "after updateTableInBase"
    
    BRYS = True
    F1.sldRound.Value = Me.iRoundLocalShift
    BRYS = False
    
    'gotick False, "after F1.sldRound.Value = Me.iRoundLocalShift"
    
    F1.sldRound.top = FG.RowHeight(0) * (FG.Rows - 1)
    F1.elFgPartGrid.Move F1.elFgPartGrid.left, F1.elFgPartGrid.top, F1.elFgPartGrid.width, FG.RowHeight(0) * (FG.Rows + 1) - 150
    
    F1.elFgPart.ChildSpacing = F1.elFgPart.ChildSpacing - 1
    F1.elFgPart.ChildSpacing = F1.elFgPart.ChildSpacing + 1
    
    F1.elFgPosGrid_ResizeChildren
    
    If Not bFormGridsRedraw Then FG.redraw = flexRDDirect
    
    'gotick False, "after FG.redraw"
    
    
    ' позиции
    '-------------------------------------------------------------------
    If Not bFormGridsRedraw Then fgp.redraw = flexRDNone
    fgp.FormatString = "Позиция" & vbTab & "Кол-во" & vbTab & "Масса" & vbTab & "Общ. масса"
    fgp.Rows = 1
    
    fgp.ColAlignment(2) = flexAlignRightCenter
    fgp.ColAlignment(3) = flexAlignRightCenter
    
    Dim p As clsPos
    Dim r As Long
    Dim bUpdateUM As Boolean
    Dim bUpdateCM As Boolean
    
    Dim bUpd As Boolean
    
    'gotick True
    
    For Each p In ps.pm
        
        p.fgAddEmptyRow , False
        r = fgp.Rows - 1
        
        'gotick False, "after fgAddEmptyRow " & CStr(p.posNumber)
        
        bUpdateUM = bRoundChanged
        bUpdateCM = bRoundChanged
        
        'If p.posUMass = 0 Then bUpdateUM = True
        'If p.posCMass = 0 Then bUpdateCM = True
        
        If p.POS_SRTM.srtmID > 0 And p.posUMass > 0 And p.bUMCalc Then
            If Abs((p.POS_UMASS_REAL - p.posUMass) / p.posUMass) > 0.01 Then
                bUpdateUM = True
            End If
        ElseIf p.POS_SRTM.srtmID < 0 And p.posUMass > 0 And p.bUMCalc Then
            If Abs((p.posPrtMass - p.posUMass) / p.posUMass) > 0.01 Then
                bUpdateUM = True
            End If
        End If
        
'        If p.POS_SRTM.srtmID > 0 And p.POS_UMASS_REAL > 0 And p.posCMass > 0 And p.bCMCalc Then
        If p.POS_SRTM.srtmID > 0 And p.posCMass > 0 And p.bCMCalc Then
            If Abs((getDbl(p.POS_CMASS) - p.posCMass) / p.posCMass) > 0.01 Then
                bUpdateCM = True
            End If
'        ElseIf p.POS_SRTM.srtmID < 0 And p.POS_UMASS_REAL > 0 And p.posCMass > 0 And p.bCMCalc Then
        ElseIf p.POS_SRTM.srtmID < 0 And p.posCMass > 0 And p.bCMCalc Then
'            If Abs((p.POS_UMASS_REAL * p.getPosQty - p.posCMass) / p.posCMass) > 0.01 Then
            If Abs((p.POS_UMASS_REAL * p.posQty - p.posCMass) / p.posCMass) > 0.01 Then
                bUpdateCM = True
            End If
        End If
        
        
        p.updatePosRow r, bUpd, True, False, bReloadsProps, bUpdateUM Or bUpdateCM
        p.fgRowToEdit = r
        
        If bUpd Then ' было обновлено - ставим галки
            If bFormGridsIcons Then
            If bUpdateUM Then p.fgp.Cell(flexcpPicture, r, 2) = F1.ImageList2.ListImages("gal1").ExtractIcon
            If bUpdateCM Then p.fgp.Cell(flexcpPicture, r, 3) = F1.ImageList2.ListImages("gal1").ExtractIcon
            End If
        Else
            If bUpdateUM Then p.fgp.Cell(flexcpBackColor, r, 2) = lngLightRed
            If bUpdateCM Then p.fgp.Cell(flexcpBackColor, r, 3) = lngLightRed
        End If
        
        'gotick False, "after updatePosRow"
        
        If F1.tbPart.Buttons("Collapsed").Value = tbrUnpressed Then
            fgp.IsCollapsed(r) = flexOutlineCollapsed
        End If
        
        'gotick False, "after flexOutlineCollapsed"
        
    Next p
    
    'gotick False, "after ps.pm"
    
    For Each p In ps.pe
        
        p.fgAddEmptyRow , False
        p.updatePosRow fgp.Rows - 1, bUpd, True, False, bReloadsProps, True
        p.fgRowToEdit = fgp.Rows - 1
        
    Next p
    
    'gotick False, "after ps.pe"
    
    ' add last empty row
    Dim np As New clsPos
    np.fgAddEmptyRow
    
    
    
    If Not bFormGridsRedraw Then fgp.redraw = flexRDDirect
    
    'gotick False, "after fgp.redraw"
    
    
'    If Me.isInRunningMeters Then
'        FG.TextMatrix(FG.Rows - 1, 0) = "погонные метры"
'    End If
    
    If bIsCat Then
    
        If Not checkCatPerm(partID) Then
            FG.TextMatrix(FG.Rows - 1, 1) = "блокировано"
        End If
    
    Else
    
        If Not checkPartPerm(partID, operModify) Then
            FG.TextMatrix(FG.Rows - 1, 1) = "блокировано (статус)"
        ElseIf bIsLink Then
            FG.TextMatrix(FG.Rows - 1, 1) = "блокировано частично (ссылка на " & partName & ")"
    '    ElseIf F1.tbPart.Buttons("EditPart").Value = tbrUnpressed Then
    '        FG.TextMatrix(FG.Rows - 1, 1) = "блокировано (кнопка 'Правка')"
        ElseIf bCatIsBlocked Then
            FG.TextMatrix(FG.Rows - 1, 1) = "блокировано (ограничен доступ в каталог)"
        Else
            FG.TextMatrix(FG.Rows - 1, 1) = "редактирование доступно"
        End If
        
        If partIDold > 0 And catIDold > 0 And Not bIsLink Then
            FG.TextMatrix(FG.Rows - 1, 0) = "импортировано"
        ElseIf partIDold > 0 And Len(partNameOld) > 0 And Not bIsLink Then
            FG.TextMatrix(FG.Rows - 1, 0) = " >>> " & partNameOld
        ElseIf bIsLink Then
            FG.TextMatrix(FG.Rows - 1, 0) = "ссылка"
        Else
        End If
        
        
    End If
    
    
    
    
    
    FG.Cell(flexcpBackColor, FG.Rows - 1, 0, FG.Rows - 1, FG.cols - 1) = vbButtonFace
    
    
    F1.elFgPosGrid_ResizeChildren
    
    'gotick False, "after elFgPosGrid_ResizeChildren"
    
    Exit Sub
    
updatePartGrids_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "updatePartGrids - Error"
    
End Sub


'/******************************************************************************
Public Sub updatePosNumbersInBase(bOrder As Boolean)
'/******************************************************************************
    
    On Error GoTo updatePositionsInBase_ERR
    
    Dim pos As clsPos
    Dim pn As Double
    Dim pnOld As Double
    pn = 0#
    
    For Each pos In Me.ps.pm
    
        If bOrder Then
            pn = pn + 1
            pnOld = pos.posNumber
            pos.posNumber = pn
            If pn <> pnOld Then
                If updateTableInBase(cn_data, pos.POS_SRC_TABLE, "posNumber", pn, "posID", pos.posID) Then
                End If
            End If
        Else
            If updateTableInBase(cn_data, pos.POS_SRC_TABLE, "posNumber", pos.posNumber, "posID", pos.posID) Then
            End If
        End If
        
    Next pos
    
    
    
    
    
    
    Exit Sub
    
updatePositionsInBase_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "updatePositionsInBase - Error"
    
End Sub


'/******************************************************************************
Public Sub correctName()
'/******************************************************************************

    On Error GoTo correctName_ERR

    
    partName = correctPartName(partName)



Exit Sub

correctName_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "correctName - Error"

End Sub


'/******************************************************************************
Public Function genSortNumber(pn As String, Optional prjID As Long = 0) As String
'/******************************************************************************
    
    On Error GoTo setSortNumber_ERR
    
    
    If pn = strNewPartName Then
        genSortNumber = "ZZZZZZ-ZZZZZ-ZZZZZ"
        Exit Function
    End If
    
    Dim ar() As String
    
    Dim alpE As String
    Dim alpR As String
    Dim alpD As String
    
    alpE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    alpR = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯ"
    alpD = "0123456789"
    
    
    Dim splitter As String
    splitter = "-"
    
    Dim sReplFrom As String
    Dim sReplTo As String
    Dim bReplace As Boolean
    
    bReplace = False
    
    If prjID > 0 Then
        Dim o As colAts
        For Each o In listcfg
            If o.atname = "Sort" Then
                If Val(o.attval("projectID")) = prjID Then
                    
                    If Len(o.attval("splitter")) > 0 Then
                        splitter = o.attval("splitter")
                    End If
                    
                    sReplFrom = o("replace").attval("from")
                    sReplTo = o("replace").attval("to")
                    
                    If Len(sReplFrom) > 0 Then bReplace = True
                
                End If
            End If
        Next
    End If
    
    
    Dim str As String ' вырезка строки с одними цифрами
    Dim strD As String ' вырезка строки без цифр
    
    Dim i As Integer
    
    str = pn
    strD = pn
    
    str = Replace(str, " ", splitter, , , vbTextCompare)
    str = Replace(str, ".", splitter, , , vbTextCompare)
    str = Replace(str, ",", splitter, , , vbTextCompare)
    str = Replace(str, ";", splitter, , , vbTextCompare)
    str = Replace(str, ":", splitter, , , vbTextCompare)
    '....
    
    strD = Replace(strD, " ", "", , , vbTextCompare)
    strD = Replace(strD, splitter, "", , , vbTextCompare)
    
    
    For i = 1 To Len(alpE)
        str = Replace(str, Mid(alpE, i, 1), "", , , vbTextCompare)
    Next i
    
    For i = 1 To Len(alpR)
        str = Replace(str, Mid(alpR, i, 1), "", , , vbTextCompare)
    Next i
    
    For i = 1 To Len(alpD)
        strD = Replace(strD, Mid(alpD, i, 1), "", , , vbTextCompare)
    Next i
    
    
    If bReplace Then
        strD = Replace(strD, sReplFrom, sReplTo, , , vbTextCompare)
    End If
    
    
    If Len(str) > 0 Then
        ar = Split(str, splitter)
        partSortNumber = strD & Format(Val(ar(0)), "00000")
        If UBound(ar) > 0 Then partSortNumber = partSortNumber & splitter & Format(Val(ar(1)), "00000")
        If UBound(ar) > 1 Then partSortNumber = partSortNumber & splitter & Format(Val(ar(2)), "00000")
        If UBound(ar) > 2 Then partSortNumber = partSortNumber & splitter & Format(Val(ar(3)), "00000")
        If UBound(ar) > 3 Then partSortNumber = partSortNumber & splitter & Format(Val(ar(4)), "00000")
        If UBound(ar) > 4 Then partSortNumber = partSortNumber & splitter & Format(Val(ar(5)), "00000")
        If UBound(ar) > 5 Then partSortNumber = partSortNumber & splitter & Format(Val(ar(6)), "00000")
        If UBound(ar) > 6 Then partSortNumber = partSortNumber & splitter & Format(Val(ar(7)), "00000")
        If UBound(ar) > 7 Then partSortNumber = partSortNumber & splitter & Format(Val(ar(8)), "00000")
        If UBound(ar) > 8 Then partSortNumber = partSortNumber & splitter & Format(Val(ar(9)), "00000")
    Else
        partSortNumber = strD
    End If
    
    genSortNumber = partSortNumber
    
    
    Exit Function
    
setSortNumber_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setSortNumber - Error"
    
End Function


'/******************************************************************************
Public Function import(catIDfrom As Long, pname As String, Optional bSkipIfFailed As Boolean = True) As Boolean
'/******************************************************************************
    
        On Error GoTo import_ERR
    
    
    
    Dim RS As New ADODB.Recordset
    Dim RSP As New ADODB.Recordset
    Dim ar() As String
    Dim sPartCorrectName As String
    
    If cn_mdb Is Nothing Then Exit Function
    
    If cn_mdb.State = 0 Then Exit Function
    
    '    partIDfrom -> pname
    
    
    sPartCorrectName = correctPartName(pname)
    
    RSP.Open "select * from [C" & catIDfrom & "] where [Наименование изделия] = '" & pname & "' and [Удалено] = 0", cn_mdb, adOpenForwardOnly, adLockReadOnly
    
    
    If RSP.EOF Then
        partIDold = 0
        import = False
        FLog.addLog "part", pname, "не найдено в таблице", True, True
        GoTo ext2
    End If
    
    catIDold = catIDfrom
    
    partIDold = selectLongFromBase(cn_mdb, "parts", "mslink", "Наименование", pname)
    
    RSP.MoveFirst
    
    
    '|||||||||||||||||||||||||||||| Д Е Т А Л Ь |||||||||||||||||||||||||||||||||||||||||||||||||||
    '=============
    partName = sPartCorrectName
    
    genSortNumber partName
    
    
    
    '=============
    partDescr = RSP.fields("Обозначение изделия").Value & ""
    ar = Split(partDescr, ", лист ")
    If UBound(ar) = 1 Then
        partDescr = Trim(ar(0))
        partSheet = Trim(ar(1))
    Else
        ar = Split(partDescr, " лист ")
        If UBound(ar) = 1 Then
            partDescr = Trim(ar(0))
            partSheet = Trim(ar(1))
        Else
            partSheet = ""
        End If
    End If
    '=============
    If IsNull(RSP.fields("Характеристика изделия").Value) Then
        partdefID = 2
'        partdefName = ""
    Else
'        partdefName = RSP.Fields("Характеристика изделия").Value
        partdefID = selectLongFromBase(cn_mdb, "PartChar", "PartCharID", "PartCharName", partdefName)
        If partdefID = 0 Then
            FLog.addLog "part", partName, "Не найдена хар-ка " & partdefName, True, True
            GoTo ext2
        End If
    End If
    '=============
    If IsNull(RSP.fields("Область данных").Value) Then
        typeID = 1
        typeName = ""
    Else
        typeName = RSP.fields("Область данных").Value
        typeID = selectLongFromBase(cn_mdb, "PartType", "PartTypeID", "PartTypeName", typeName)
        If typeID = 0 Then
            FLog.addLog "part", partName, "Не найден тип " & typeName, True, True
            GoTo ext2
        End If
    End If
    '=============
    
    
    import = True
    
    RS.Open "select * from [C" & catIDold & "] where [Наименование изделия] = '" & pname & "' and [Удалено] = 0 order by [Счетчик]", cn_mdb, adOpenForwardOnly, adLockReadOnly
    
    '||||||||||||||||||||||||||| П О З И Ц И И ||||||||||||||||||||||||||||||||||||||||
    
    Dim p As clsPos
    Dim pn As Double
    
    If Not RS.EOF Then
        
        FLog.addLog "part", partName, "обработка позиций в таблице C" & catIDold, False
        
        
        RS.MoveFirst
        
        partVers = RS.fields("Версия изделия").Value & ""
        
        Do
            
            Set p = New clsPos
            
            Set p.parentPart = Me
            
            FLog.C1Elastic1.BackColor = &H80000009
            FLog.Refresh
            
            '=====================================
            ' ждем секунду чтобы не было перегрузки сервера
            Sleep 500
            '=====================================
            
            FLog.C1Elastic1.BackColor = &H8000000F
            FLog.Refresh
            
            If p.import(RS) Or Not bSkipIfFailed Then
                
                If Val(p.posNumber) > iMaxPosNumber Then iMaxPosNumber = Val(p.posNumber)
                
                If p.posNumber > 0 Then
                    Set p = ps.AddPos(p, CStr(p.posNumber))
                Else
                    Set p = ps.AddPos(p)
                End If
                
                Set p = Nothing
                
            Else
                
                import = False
                FLog.addLog "part", partName, "неудачный импорт позиции", True
                
            End If
            
            
            RS.MoveNext
        Loop Until RS.EOF
        
        
        
    Else
        FLog.addLog "part", partName, "Позиций не найдено в таблице C" & catIDold, True, True
        import = False
        
    End If
    
    
    
    
    
    
ext:
    
    
    RS.Close
    Set RS = Nothing
ext2:
    
    RSP.Close
    Set RSP = Nothing
    
    Exit Function
    
import_ERR:
    FLog.addLog "part", "error", "[" & err.Number & "] " & err.Description, True
    
End Function

'/******************************************************************************
Public Function updatePartFields() As Boolean
'/******************************************************************************

    On Error GoTo updatePartFields_ERR

    updatePartFields = False

    Dim RS As New ADODB.Recordset
    
    RS.Open "select top 1 * from part where partID = " & partID & " order by partID desc", cn_data, adOpenForwardOnly, adLockOptimistic
    

    
    If RS.EOF Then
        
        RS.NextRecordset
        RS.Open "select top 1 * from part order by partID desc", cn_data, adOpenForwardOnly, adLockOptimistic
        RS.AddNew flds, vls
        RS.Update
        RS.Requery
        RS.MoveFirst
        partID = RS.fields("partID").Value
        writeOperationS operCreate, "part", partID, "создание " & partName
    Else
        RS.MoveFirst
        RS.Update flds, vls
        writeOperationS operModify, "part", partID, "сохранение " & partName
    End If
    
    RS.Close
    
    Set RS = Nothing
    
    updatePartFields = True

Exit Function

updatePartFields_ERR:
    Set RS = Nothing
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "updatePartFields - Error"

End Function

Public Function checkExistInCatalog(n As String, v As String) As Long



    Dim lngExistPartID As Long
    ' table name changed from part to view_part2 - для переименования ссылок 24/10/2023
    lngExistPartID = selectLongFromBase(cn_data, "view_part2", "partID", "partName", n, "catID", catID, "deleted", 0, "partVersion", v)
    
    ' чтобы не проверяла саму себя
    If lngExistPartID > 0 And lngExistPartID = partID Then lngExistPartID = 0
    
    checkExistInCatalog = lngExistPartID


End Function




'/******************************************************************************
Public Sub savePart(Optional bSavePositions As Boolean = True, Optional bCopy As Boolean = False)
'/******************************************************************************
    
    On Error GoTo save_ERR
    
    Dim RS As New ADODB.Recordset
    Dim i As Integer
    Dim pos As clsPos
    
    
    If Len(Trim(partName)) = 0 Then
        Exit Sub
    Else
        partSortNumber = genSortNumber(partName)
    End If
    
    
    partName = correctPartName(partName)
    
'    checkExistInCatalog partName, partVers
    
    
    RS.Open "select top 1 * from part where partID = " & partID & " order by partID desc", cn_data, adOpenForwardOnly, adLockOptimistic
    
    If bSavePositions Then
        For i = 1 To ps.pm.Count
            Set pos = ps.pm(i)
            pos.partID = partID
            If pos.partID = 0 Then pos.posID = 0
        Next i
        
        For i = 1 To ps.pe.Count
            Set pos = ps.pe(i)
            pos.partID = partID
            If pos.partID = 0 Then pos.posID = 0
        Next i
    End If
    
    '=================
    vls(0) = catID
    vls(1) = partdefID
    vls(2) = typeID
    vls(3) = partName
    vls(4) = partDescr
    vls(5) = partVers
    vls(6) = partIDold
    vls(7) = catIDold
    vls(8) = partSheet
    vls(9) = partSortNumber
    vls(10) = 0
    vls(11) = part_prntID
    vls(12) = partStatusID
    
    ' iRoundLocalShift
    If bRoundDefined Then
        vls(13) = iRoundLocalShift
    Else
        If bCopy Then vls(13) = 0 Else vls(13) = rndGlobal.iPosMass
    End If
    
    ' iRoundLocalSaved
    If bCopy Then
        vls(14) = bRoundDefined
    Else
        vls(14) = True
    End If
    '=================
    
    
    If RS.EOF Then
        
        RS.NextRecordset
        RS.Open "select top 1 * from part order by partID desc", cn_data, adOpenForwardOnly, adLockOptimistic
        RS.AddNew flds, vls
        RS.Update
        RS.Requery
        RS.MoveFirst
        partID = RS.fields("partID").Value
        writeOperationS operCreate, "part", partID, "создание " & partName
    Else
        RS.MoveFirst
        RS.Update flds, vls
        writeOperationS operModify, "part", partID, "сохранение " & partName
    End If
    
    RS.Close
    
    Set RS = Nothing
    

    If bSavePositions Then
        For i = 1 To ps.pm.Count
            Set pos = ps.pm(i)
            pos.partID = partID
            pos.savePos bCopy
            If i = 1 Then
                pos.saveArmPoints False
'                updateTableInBase cn_data, "part", "partMainPosEP", pos.isInRunMet, "partID", partID
            End If
        Next i
        
        For i = 1 To ps.pe.Count
            Set pos = ps.pe(i)
            pos.partID = partID
            pos.savePos bCopy
        Next i
    End If

    
    
    
    
    
    
    Exit Sub
    
save_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "save - Error"
    
End Sub


'/******************************************************************************
Public Function getNodeName()
'/******************************************************************************
    
    On Error GoTo getNodeName_ERR
    
    Dim str As String
    
    str = partName
    
    If Len(Trim(partVers)) > 0 Then
        str = str & " rev." & Trim(partVers)
    End If
    
    getNodeName = str
    
    Exit Function
    
getNodeName_ERR:
    getNodeName = partName
    
End Function


Public Function isInRunningMeters() As Integer
    
    Dim pos As clsPos
    Dim prop As clsProp
    
    isInRunningMeters = 0
    
    If Me.ps Is Nothing Then Exit Function
    If Me.ps.pm Is Nothing Then Exit Function
    
    If Me.ps.pm.Count > 0 Then
        Set pos = Me.ps.pm(1)
        isInRunningMeters = pos.isInRunMet
    End If
    
    
End Function


'/******************************************************************************
Public Function setPartFromCat(ctptID As Long, bLoadAllPositions As Boolean, bLoadProperties As Boolean, bLoadPoints As Boolean, Optional RSfrom As ADODB.Recordset = Nothing) As Boolean
'/******************************************************************************

    On Error GoTo setPartFromCat_ERR

    Dim RS As ADODB.Recordset
    
    bIsCat = True
    
    
    If RSfrom Is Nothing Then
    
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        
        
        Dim strSQL As String
        
        
        strSQL = "SELECT "
        
        strSQL = strSQL & conn.strBaseName & ".dbo.view_r_cat_position.* "
        strSQL = strSQL & "," & conn.strSrtmName & ".dbo.view_r_sortament_property_3.* "
'        strSQL = strSQL & "," & conn.strBaseName & ".dbo.part.partName as prtnm "
'        strSQL = strSQL & "," & conn.strBaseName & ".dbo.part.catID as prtCatID "
        
        strSQL = strSQL & "FROM "
        strSQL = strSQL & conn.strBaseName & ".dbo.view_r_cat_position "
        
        strSQL = strSQL & "LEFT OUTER JOIN "
        strSQL = strSQL & conn.strSrtmName & ".dbo.view_r_sortament_property_3 "
        strSQL = strSQL & "ON "
        strSQL = strSQL & conn.strBaseName & ".dbo.view_r_cat_position.pos_srtmID "
        strSQL = strSQL & "= "
        strSQL = strSQL & conn.strSrtmName & ".dbo.view_r_sortament_property_3.srtmID "
        
'        strSQL = strSQL & "LEFT OUTER JOIN "
'        strSQL = strSQL & conn.strBaseName & ".dbo.part "
'        strSQL = strSQL & "ON "
'        strSQL = strSQL & conn.strBaseName & ".dbo.view_r_part_position.pos_srtmID "
'        strSQL = strSQL & "= "
'        strSQL = strSQL & "-" & conn.strBaseName & ".dbo.part.partID "
        
        strSQL = strSQL & "WHERE "
        strSQL = strSQL & conn.strBaseName & ".dbo.view_r_cat_position.catID = " & ctptID & " "
        
        strSQL = strSQL & "ORDER BY [posNumber]"
        
        
        RS.Open strSQL, cn_data, adOpenForwardOnly, adLockReadOnly
        
    Else
    
        Set RS = RSfrom
        
    End If
    
    
    If RS.EOF Then
        partID = 0
        partOK = False
        Exit Function
    End If

    If RSfrom Is Nothing Then RS.MoveFirst



    '|||||||||||||||||||||||||||||| Д Е Т А Л Ь |||||||||||||||||||||||||||||||||||||||||||||||||||

    partID = RS.fields("catID").Value
    
    partName = RS.fields("catName").Value & ""
    
    partStatusID = RS.fields("catStatus").Value
    
    If IsNull(RS.fields("catTypeID").Value) Then
        typeID = 0
    Else
        typeID = RS.fields("catTypeID").Value
    End If
    
    typeName = cattypes(typeID).ctName
    
'    partVers = RS.Fields("partVersion").Value & ""
    
    partDocSetPartListID = RS.fields("dsPartListID").Value
    partDocSetDrawingsID = RS.fields("dsDrawingsID").Value

    '||||||||||||||||||||||||||| П О З И Ц И И ||||||||||||||||||||||||||||||||||||||||

'    If bLoadPositions Then
        
        Dim p As clsPos
        Set ps = New colPos
        
        Do
            
            Set p = New clsPos
            
            Set p.parentPart = Me
            
'            p.posPrtName = RS.Fields("prtnm").Value & ""
'            p.posPrtCatID = Val(RS.Fields("prtCatID").Value & "")

'            p.posPrtMass = RS.Fields("partMass").Value
            
            If p.loadDataFromRSrecord(RS, "pos_") And bLoadProperties Then
            
                p.reloadSrtmPropsFromRS RS
                p.reloadPosPropsFromRS RS, "pos_"
                
'                If bLoadPoints And ps.Count = 0 Then Rein.armLoadSketch p
                
                Set p = ps.AddPos(p, CStr(p.posID))
            
            End If
            
            
            Set p = Nothing
            
            If Not bLoadAllPositions Then Exit Do
            
            RS.MoveNext
        Loop Until RS.EOF
        
'    End If
    
    If RSfrom Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If
    
    setPartFromCat = True




Exit Function

setPartFromCat_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "setPartFromCat - Error"

End Function


'/******************************************************************************
Public Property Get PART_DESCR() As String
'/******************************************************************************

    On Error GoTo PART_DESCR_ERR
    
    Dim ct As clsCat
    Set ct = cCats(catID)
    
    'if ct.dsDrawID
    
    If (Len(partDescr) > 0 Or PART_CAT.bUnif) And ct.dsDrawID = 0 Then
        PART_DESCR = partDescr
        bDsNum = False
    Else
        If Len(sDescr) = 0 And bPartDscrUpdate Then sDescr = PART_CAT.CAT_DS_NUM
        'bPartDscrUpdate = False
        PART_DESCR = sDescr
        bDsNum = (Len(sDescr) > 0)
    End If
    
    

Exit Property

PART_DESCR_ERR:
PART_DESCR = "PART_DESCR Error"

End Property

'/******************************************************************************
Public Property Get PARTTYPE() As clsPartType

    On Error GoTo PARTTYPE_ERR

    If Me.parttypeID > 0 Then
        Set PARTTYPE = globPartTypes(CStr(Me.parttypeID))
    Else
        Set PARTTYPE = globPartTypes(CStr(Me.typeID))
    End If


Exit Property

PARTTYPE_ERR:
    Set PARTTYPE = New clsPartType

End Property

Public Property Get typeName() As String

    On Error GoTo typeName_ERR

    If Len(typeName_over) > 0 Then
        typeName = typeName_over
    Else
        typeName = Me.PARTTYPE.PartType_NAME
    End If

Exit Property

typeName_ERR:
    typeName = ""

End Property

Public Property Let typeName(ByVal n As String)

    On Error GoTo typeName_ERR

    typeName_over = n

Exit Property

typeName_ERR:
    typeName_over = ""

End Property



'/******************************************************************************
Public Property Get PARTDEF() As clsPartDef

    On Error GoTo PART_DEFNAME_ERR

    Set PARTDEF = globPartDefs(CStr(Me.partdefID))


Exit Property

PART_DEFNAME_ERR:
    Set PARTDEF = New clsPartDef

End Property

Public Property Get partdefName() As String

    On Error GoTo partdefName_ERR
    If Len(partdefName_over) > 0 Then
        partdefName = partdefName_over
    Else
        partdefName = Me.PARTDEF.PartDef_NAME
    End If

Exit Property

partdefName_ERR:
    partdefName = ""

End Property


Public Property Let partdefName(ByVal n As String)

    On Error GoTo partdefName_ERR

    partdefName_over = n

Exit Property

partdefName_ERR:
    partdefName_over = ""

End Property

