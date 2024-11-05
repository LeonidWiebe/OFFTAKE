VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSG"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public spt As spectype ' использовать количество изделий для расчета общей массы

Public dInterval As Double

Public cSpecUnits As Collection

Public cSpParts As Collection

Public bSaveSpec As Boolean

Public bCheckMass As Boolean

Public cSums As Collection

Dim msapp As Object

Public bParams As Boolean

'/******************************************************************************
Public Function getColPart(strKey As String) As clsPart
'/******************************************************************************

    On Error GoTo getColPart_ERR
    
    Set getColPart = cSpParts(strKey)

Exit Function

getColPart_ERR:
    Set getColPart = New clsPart

End Function


Private Sub Class_Initialize()
    
    Set cSpecUnits = New Collection
    Set cSpParts = New Collection
    Set cSums = New Collection
    
    dInterval = 10# * dSpecCmnScale
    
    Set msapp = getMS
    
    bParams = False
    
End Sub

Private Sub Class_Terminate()
    
    Set cSpecUnits = Nothing
    Set cSpParts = Nothing
    Set cSums = Nothing
    
    Set msapp = Nothing
    
End Sub

'/******************************************************************************
Public Function checkLibrary(Optional sLibName As String = "") As Integer
'/******************************************************************************
    
    On Error GoTo checkLibrary_ERR
    
    If sLibName = "" Then sLibName = strDrawingsLibraryFileName
    
    Dim istat As Integer
    
    istat = 0
    
    If msapp Is Nothing Then Exit Function
    
    istat = -1
    
    If msapp.IsCellLibraryAttached Then
        
        istat = 1
        
        If StrComp(msapp.AttachedCellLibrary.FullName, sLibName, vbTextCompare) <> 0 Then
            
            istat = 2
            msapp.DetachCellLibrary
            
            istat = 3
            msapp.AttachCellLibrary sLibName, msdConversionModeNever
            
        End If
        
    Else
    
        istat = 4
        msapp.AttachCellLibrary sLibName, msdConversionModeNever
        
    End If
    
    istat = 5
    
    checkLibrary = istat
    
    Exit Function
    
checkLibrary_ERR:
    checkLibrary = istat
    
End Function


Public Sub drawWiseSpec()

    
    Dim su As colSU
    
    For Each su In cSpecUnits
    
        su.drawSpecUnit
    
    Next su





End Sub



'/******************************************************************************
Public Sub draw_spec()
'/******************************************************************************

    On Error GoTo draw_ERR

'    cap.draw 0#

    Dim st As Integer
    st = checkLibrary ' 5 - success



    If st <> 5 Then
    
        Dim strTempFilename As String
        
        strTempFilename = Environ("TEMP") & "\" & Format(Now, "YYYY-MM-DD-HH-mm-ss") & ".dgn"
    
        If FileExists(strDrawingsLibraryFileName) Then
    
            If copyFile(strDrawingsLibraryFileName, strTempFilename, True) Then
            
                st = 100 + checkLibrary(strTempFilename) ' 105 success
            
            Else
                st = 6 ' cannot copy from net
            End If
        
        Else
            st = 7 ' lib file not exists (net access)
        End If
        
    End If
    



    If Not (st = 5 Or st = 105) Then
    
        Dim res As VbMsgBoxResult
        
        res = MsgBox("   Не удалось подключить библиотеку" & strDrawingsLibraryFileName & " (ошибка " & st & ")" & vbNewLine & _
                    "   Некоторые части спецификации будут отсутствовать   " & vbNewLine & _
                    "   Продолжать выполение?   ", vbYesNo, "Вопрос")
                    
        If res = vbNo Then Exit Sub
    
    End If


    Dim su As colSU
    Dim d As Double
    
    For Each su In cSpecUnits
    
        
        su.offsetX = d
        su.drawSpecUnit
        
        d = d + su.width + dInterval
    
    Next su




Exit Sub

draw_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "draw - Error"

End Sub


'/******************************************************************************
Public Function getHeight(Optional bMax As Boolean = False) As Double
'/******************************************************************************
    
    On Error GoTo getHeight_ERR
    
    Dim h As Double
    Dim su As colSU
    
    
    
    For Each su In cSpecUnits
        
        If bMax Then
            If h < su.getHeight Then h = su.getHeight
        Else
            h = h + su.getHeight
        End If
        
    Next su
    
    
    getHeight = h
    
    Exit Function
    
getHeight_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getHeight - Error"
    
End Function


'/******************************************************************************
Public Function getWidth()
'/******************************************************************************

    On Error GoTo getWidth_ERR


    Dim h As Double
    Dim su As colSU
    
    
    
    For Each su In cSpecUnits
        
        h = h + su.width
        
    Next su
    
    
    getWidth = h + dInterval * (Me.cSpecUnits.Count - 1)


Exit Function

getWidth_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getWidth - Error"

End Function


'/******************************************************************************
Public Sub setEqualHeight(bAddDopRows As Boolean)
'/******************************************************************************
    
    On Error GoTo setEqualHeight_ERR
    
    
    Dim su As colSU
    Dim cnt As Long
    Dim i As Integer
    Dim rdop As clsSR
    Dim h As Double
    Dim r As New clsSR
    Dim iLastRows As Integer
    Dim iLastRowsCmn As Integer ' количество строк до максимального количества из секций
    Dim iLastRowsGlb As Integer ' количество строк до lngSpecDefaultRows
    Dim iSpecLastRows As Integer
    
    If cSpecUnits.Count < 1 Then Exit Sub
    
    For Each su In cSpecUnits
        
        If cnt < su.Count Then cnt = su.Count
        
    Next su
    
    
    If bAddDopRows Then
        iSpecLastRows = lngSpecLastRows
    Else
        iSpecLastRows = 0
    End If
    
    
    Set su = cSpecUnits(cSpecUnits.Count)
    
    h = (su.Count) * r.row_height
    
    iLastRowsCmn = cnt - su.Count
    iLastRowsGlb = lngSpecDefaultRows - su.Count
    
    If cSpecUnits.Count = 1 Then ' если всего одна секция
        iLastRows = iSpecLastRows
    End If
    
    If iLastRowsCmn > iSpecLastRows Then
        iLastRows = iSpecLastRows
    End If
    
    If blnSpecLastRows And cSpecUnits.Count > 1 Then
        iLastRows = iLastRowsCmn
    End If
    
    

    For i = 1 To iLastRows

        Set rdop = New clsSR

        Set rdop.prnt = su

        rdop.setOffset h

        su.AddRow rdop

        h = h + rdop.row_height


    Next i
    
    
    Exit Sub
    
setEqualHeight_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setEqualHeight - Error"
    
End Sub

Public Sub setSpecGridPosRow(FG As VSFlexGrid, pos As clsPos, bMass As Boolean)


With FG

    .TextMatrix(.Rows - 1, .ColIndex("partDescr")) = pos.POS_PD_NAME & " " & pos.POS_SRTM.srtmName
    
    If pos.pos_props.existsProperty("length") Then
        If pos.pos_props("length").hasValue Then
        .TextMatrix(.Rows - 1, .ColIndex("partDescr")) = .TextMatrix(.Rows - 1, .ColIndex("partDescr")) & " L=" & pos.pos_props("length").PVAL
        End If
    End If
    
    If pos.pos_props.existsProperty("width") Then
        If pos.pos_props("width").hasValue Then
        .TextMatrix(.Rows - 1, .ColIndex("partDescr")) = .TextMatrix(.Rows - 1, .ColIndex("partDescr")) & " W=" & pos.pos_props("width").PVAL
        End If
    End If
    
    If pos.pos_props.existsProperty("thickness") Then
        If pos.pos_props("thickness").hasValue Then
        .TextMatrix(.Rows - 1, .ColIndex("partDescr")) = .TextMatrix(.Rows - 1, .ColIndex("partDescr")) & " T=" & pos.pos_props("thickness").PVAL
        End If
    End If
    
    If pos.pos_props.existsProperty("radiusinn") Then
        If pos.pos_props("radiusinn").hasValue Then
        .TextMatrix(.Rows - 1, .ColIndex("partDescr")) = .TextMatrix(.Rows - 1, .ColIndex("partDescr")) & " R=" & pos.pos_props("radiusinn").PVAL
        End If
    End If

    If bMass Then
        .TextMatrix(.Rows - 1, .ColIndex("partQty")) = Round(pos.posQty, 3)
        .TextMatrix(.Rows - 1, .ColIndex("mass")) = pos.posUMass
        .TextMatrix(.Rows - 1, .ColIndex("cmass")) = pos.posCMass
    End If



End With

End Sub




'/******************************************************************************
Public Sub setSpecGrid(FG As VSFlexGrid, ByRef dSumMass As Double, Optional bReal As Boolean = False)
'/******************************************************************************
    
    On Error GoTo setGrid_ERR
    
    dSumMass = 0#
    
    Dim dSumMass2 As Double
    
    With FG
        
        
        .cols = 11
        .Rows = 1
        
        .ColKey(0) = "type"
        .ColKey(1) = "num"
        .ColKey(2) = "partName"
        .ColKey(3) = "partDescr"
        .ColKey(4) = "partSheet"
        .ColKey(5) = "partMainPosEP"
        .ColKey(6) = "partQty"
        .ColKey(7) = "mass"
        .ColKey(8) = "cmass"
        .ColKey(9) = "partdefNameMulti"
        .ColKey(10) = "note"
        
        .ColHidden(0) = True
        
        .TextMatrix(0, .ColIndex("partName")) = "Наименование"
        .TextMatrix(0, .ColIndex("partDescr")) = "Обозначение"
        .TextMatrix(0, .ColIndex("partSheet")) = "Лист"
        .TextMatrix(0, .ColIndex("partMainPosEP")) = "пог.м"
        .TextMatrix(0, .ColIndex("partQty")) = "Кол-во"
        .TextMatrix(0, .ColIndex("mass")) = "Ед.Масса"
        .TextMatrix(0, .ColIndex("cmass")) = "Общ.Масса"
        .TextMatrix(0, .ColIndex("note")) = "Прим."
        
        .ColHidden(.ColIndex("partdefNameMulti")) = True
        
        If bReal Then
            .ColFormat(.ColIndex("mass")) = sFmtFree
            .ColFormat(.ColIndex("cmass")) = sFmtFree
        Else
            .ColFormat(.ColIndex("mass")) = sFmt1
            .ColFormat(.ColIndex("cmass")) = sFmt1
        End If
        
        .ColDataType(.ColIndex("partMainPosEP")) = flexDTBoolean
        
        .ColAlignment(.ColIndex("partName")) = flexAlignLeftCenter
        .ColAlignment(.ColIndex("partDescr")) = flexAlignLeftCenter
        .ColAlignment(.ColIndex("partSheet")) = flexAlignLeftCenter
        .ColAlignment(.ColIndex("note")) = flexAlignLeftCenter
        
        
        Dim prt As clsPart
        Dim pos As clsPos
        Dim i As Long
        Dim dQty As Double
        
        Dim cat As clsCat
        

        
        For Each prt In cSpParts
            
            i = i + 1
            
            Set cat = cCats(CStr(prt.catID))
            
'            If prt.bRunMet Then dQty = Format(prt.partQty, "0.0##") Else dQty = Format(prt.partQty, "0")
            dQty = prt.partQty
            
            If dQty = 0# Then
            
                For Each pos In prt.ps.pm
                
                    .AddItem ""
                    .TextMatrix(.Rows - 1, .ColIndex("partName")) = prt.partName
                    .TextMatrix(.Rows - 1, .ColIndex("num")) = pos.posNumber
                    .TextMatrix(.Rows - 1, .ColIndex("partMainPosEP")) = prt.bRunMet
                    setSpecGridPosRow FG, pos, True
                
                Next pos
                
                For Each pos In prt.ps.pe
                
                    .AddItem ""
                    .TextMatrix(.Rows - 1, .ColIndex("partName")) = prt.partName
                    setSpecGridPosRow FG, pos, True
                    
                Next pos
            
            ElseIf globPartDefs(CStr(prt.partdefID)).bUsePositions And (prt.ps.pm.Count > 0 Or prt.ps.pe.Count > 0) Then
            
                Set pos = prt.ps.getItem(1)
                
                .AddItem ""
                .TextMatrix(.Rows - 1, .ColIndex("partName")) = prt.partName
                
                setSpecGridPosRow FG, pos, False
                
'                .TextMatrix(.Rows - 1, .ColIndex("partSheet")) = pos.POS_SRTM.srtmName
                .TextMatrix(.Rows - 1, .ColIndex("partMainPosEP")) = prt.bRunMet
                
                If cattypes(cat.catTypeID).ctEnum = ctEmb Then
                    .TextMatrix(.Rows - 1, .ColIndex("partQty")) = dQty
                    .TextMatrix(.Rows - 1, .ColIndex("mass")) = pos.posCMass
                    .TextMatrix(.Rows - 1, .ColIndex("cmass")) = pos.posCMass * dQty
                Else
                    .TextMatrix(.Rows - 1, .ColIndex("partQty")) = Round(pos.posQty, 3)
                    .TextMatrix(.Rows - 1, .ColIndex("mass")) = pos.posUMass
                    .TextMatrix(.Rows - 1, .ColIndex("cmass")) = pos.posCMass
                End If
                
                .Cell(flexcpBackColor, .Rows - 1, 1, , .cols - 1) = lngBlue
                
            Else
            
                .AddItem ""
                .TextMatrix(.Rows - 1, .ColIndex("partName")) = prt.partName
                .TextMatrix(.Rows - 1, .ColIndex("partDescr")) = prt.PART_DESCR
                .TextMatrix(.Rows - 1, .ColIndex("partSheet")) = prt.partSheet
                .TextMatrix(.Rows - 1, .ColIndex("partMainPosEP")) = prt.bRunMet
                .TextMatrix(.Rows - 1, .ColIndex("partQty")) = dQty
                .TextMatrix(.Rows - 1, .ColIndex("mass")) = roundShaman(prt.massCommon, 1) ' стандартное округление format и round(13.45,1) дает 13.4 :/
                .TextMatrix(.Rows - 1, .ColIndex("cmass")) = roundShaman(prt.massCommon, 1) * dQty
                
                dSumMass2 = dSumMass2 + prt.massCommon * dQty
                
            End If
            
            If Not prt.partOK Then
                .Cell(flexcpBackColor, .Rows - 1, 1, , .cols - 1) = lngLightRed
            End If
            
            If Not prt.bIsCat And prt.partQty > 0# Then
                .TextMatrix(.Rows - 1, .ColIndex("num")) = i
                dSumMass = dSumMass + getDbl(.TextMatrix(.Rows - 1, .ColIndex("cmass")))
            End If
            
            .TextMatrix(.Rows - 1, .ColIndex("type")) = CInt(prt.bIsCat)
            
        Next prt
        
        .Subtotal flexSTSum, 0, 8, "0.0", lngGrey, , True, "Общая масса", , True
        
        .AutoSize 0, .cols - 1
        
        
    End With
    
    
    
    Exit Sub
    
setGrid_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "setGrid - Error"
    
End Sub


'/******************************************************************************
Public Sub loadParts2(clID As Long, usrID As Long, Optional bClear As Boolean = True, Optional partdefID As Long = 0, Optional bRein As Boolean = False, Optional objID As Long = 0)
'/******************************************************************************

    On Error GoTo loadParts2_ERR


    Dim RS As New ADODB.Recordset
    Dim part As clsPart
    Dim strSQL As String
    
    Dim ds As clsDocSet
    Dim dsID As Long
    Dim catID As Long
    Dim ct As clsCat
    Dim stID As Long
    
    
    
    If clID = 0 Then Exit Sub
    
    If bClear Then Set cSpParts = New Collection

    If bUseCursorClient Then RS.CursorLocation = adUseClient

    If bRein Then
        strSQL = "select * from " & strFuncNameSpecRein & " where catlistID = " & clID ' для каркасов/каталогов (см.ниже part.specPrefix = "Каркас ")
    Else
        
        strSQL = "SELECT * "
        
        strSQL = strSQL & "FROM "
        strSQL = strSQL & conn.strBaseName & ".dbo." & strFuncNameSpec & " "
        
        strSQL = strSQL & "WHERE "
        strSQL = strSQL & conn.strBaseName & ".dbo." & strFuncNameSpec & ".catlistID = " & clID & " "
        
    End If
    
    
    If objID > 0 Then
        strSQL = strSQL & " and objID = " & objID
    End If
    
    If partdefID > 0 Then
        strSQL = strSQL & " and partdefID = " & partdefID
    End If
    
    If partdefID < 0 Then
        strSQL = strSQL & " and partdefID != " & -partdefID
    End If
    
    
    If bRein Then
        strSQL = strSQL & " order by partSortID"
    Else
        strSQL = strSQL & " ORDER BY [partSortID], clposID, [posNumber]"
    End If
    
    
    If bRein Then
        catID = selectLongFromBase(cn_data, "catlist", "catID", "catlistID", clID)
        Set ct = cCats(CStr(catID))
        'If ct.catDocSetDrawingsID > 0 Then Set ds = globDocSets(CStr(ct.catDocSetDrawingsID))
    End If
    
    
    
   
    
    
    
    RS.Open strSQL, cn_data, adOpenStatic, adLockReadOnly
    
    
    
    
    If RS.EOF Then Exit Sub
    
    
    F1.PB.Min = 0
    F1.PB.Max = RS.RecordCount
    
    RS.MoveFirst
    
    Dim res As VbMsgBoxResult
    res = vbIgnore
    
    Do
    
        If bRein And RS.fields("objID").Value = objs("catalog") Then
        
            Set part = New clsPart
        
            Set ct = cCats(CStr(RS.fields("partID").Value))
            
            If ct.catID <> catID Then
            
'                If res = vbIgnore And RS.Fields("partdefID").Value <> 13 Then
'                    res = MsgBox("Некторые позиции спецификации не имеют свойство 'Изделие арматурное'. Продолжать?", vbYesNo, "")
'                    If res = vbNo Then Exit Sub
'                End If
            
                part.partName = ct.catName
                part.partSheet = "0"
                part.partID = RS.fields("partID").Value
                If Not ds Is Nothing Then part.partDescr = ds.docsetNumber
                part.partQty = RS.fields("partQty").Value
                part.partQty = Round(part.partQty, 3) ' part.partQty = round(RS.Fields("partQty").Value не срабатывает...
                part.partQty = Round(part.partQty, 1)
                part.massCommon = RS.fields("mass").Value
                part.iSpecNumber = cSpParts.Count + 1
                part.partdefID = 13 ' изделие арматурное
                part.parttypeID = part.typeID
                part.typeID = objs("catalog")
                part.partdefName = part.PARTDEF.partdefNameMulti
                part.partOK = True
                
                If part.partQty = 0# Then
                    F1.loadSpecRein False, Me, ct.catID
                Else
                    cSpParts.Add part, CStr(part.partID) & "|" & CStr(objs("catalog"))
    '                part.specPrefix = "Каркас "
                    
                    If bSaveSpec Then
                        stID = insertDataInBase(cn_data, "spectable", "catlistID", clID, "objID", objs("catalog"), "objectID", ct.catID, _
                                                "posNumber", part.iSpecNumber, _
                                                "stText", part.specPrefix & part.partName, _
                                                "stQty", part.partQty, _
                                                "stUMass", part.massCommon, _
                                                "stCMass", part.massCommon * part.partQty, _
                                                "stRunMet", 0)
                    End If
                End If

            End If
        
        ElseIf Not bRein And RS.fields("objID").Value = objs("part") Then
        
            Dim bOk As Boolean
            Dim sm As clsSrtm
        
            bOk = True
            If IsNull(RS.fields("pos_srtmID").Value) Then ' отсутствует
                bOk = False
            ElseIf RS.fields("pos_srtmID").Value < 0 Then ' part
                Debug.Print ""
            Else
                Set sm = globSrtm(CStr(RS.fields("pos_srtmID").Value))
                If sm.srtmID = 0 Then ' srtm id does not exists in table 'sortament'
                    bOk = False
                End If
            End If
            
            
            '============================================
            Dim p As New clsPos
            
            If bOk Then
            
                If p.loadDataFromRSrecord(RS, "pos_") Then
                    
                    'p.getSrtmProps
                    p.reloadSrtmPropsFromRS RS
                    p.reloadPosPropsFromRS RS, "pos_"
                    
                    p.posMassKoef = getFieldDoubleValue(RS, "koef", 1#)
                    
                Else
                    Set p = New clsPos
                End If
            
            End If
            '============================================
            
            
            Set part = getColPart(CStr(RS.fields("partID").Value) & "|" & CStr(objs("part")) & "|" & CStr(RS.fields("clposID").Value))
            
            If part.partID = 0 Then
            
                part.setIDv2 RS.fields("partID").Value, False, False, False, RS
                
                part.partQty = RS.fields("partQty").Value
                part.partQty = Round(part.partQty, 3) ' part.partQty = round(RS.Fields("partQty").Value не срабатывает...
                part.partQty = Round(part.partQty, 1)
                part.parttypeID = part.typeID
                part.typeID = objs("part")
                part.iSpecNumber = cSpParts.Count + 1
                part.partdefName = part.PARTDEF.partdefNameMulti
                
                part.bIsByPrm = getFieldBoolValue(RS, "prm", False)
                
                cSpParts.Add part, CStr(part.partID) & "|" & CStr(objs("part") & "|" & CStr(RS.fields("clposID").Value))
                
            End If
            
            Set p.parentPart = part
            part.ps.AddPos p, CStr(p.posID) '& "|" & CStr(RS.fields("clposID").Value)
            
            If part.ps.Count = RS.fields("poscnt").Value Then
            
                If part.bIsByPrm Then
                    Dim bReal As Boolean
                    bReal = False ' настройка?
                    part.massCommon = getDbl(part.getPartMassForSpec(0, bReal))
                    part.partOK = True
                    Me.bParams = True
                ElseIf Me.bCheckMass Then
                    part.massCommon = getDbl(part.PART_CMASS)
                    If Abs(RS.fields("mass").Value - part.massCommon) > Abs(RS.fields("mass").Value * 0.01) Then
                        part.partOK = False
                    Else
                        part.partOK = True
                    End If
                Else
                    part.massCommon = RS.fields("mass").Value
                    part.partOK = True
                End If
            
                
                part.bRunMet = part.isInRunningMeters
                
                If bSaveSpec Then
                    stID = insertDataInBase(cn_data, "spectable", "catlistID", clID, "objID", objs("part"), "objectID", part.partID, _
                                            "posNumber", part.iSpecNumber, _
                                            "stText", part.partName, _
                                            "stQty", part.partQty, _
                                            "stUMass", part.massCommon, _
                                            "stCMass", part.massCommon * part.partQty, _
                                            "stRunMet", Abs(CInt(part.bRunMet)))
                End If
                
            End If
            
            Set p = Nothing
            Set part = Nothing
        
        
        
        

            
            
        
            '---------------------------------------------------------------
'            If part.setIDv2(RS.Fields("partID").Value, True, True, False) Then
'                part.partQty = RS.Fields("partQty").Value
'                part.partQty = Round(part.partQty, 3) ' part.partQty = round(RS.Fields("partQty").Value не срабатывает...
'                part.partQty = Round(part.partQty, 1)
'                part.massCommon = RS.Fields("mass").Value
'
'                ' несовпадение возможно если поменялась масса в сортаменте
'                If bSaveSpec And Round(part.massCommon, 3) <> Round(part.PART_CMASS, 3) Then
'                    If part.updateMassesInBase() Then
'                        part.massCommon = getDbl(part.PART_CMASS)
'                    End If
'                End If
'
'                part.typeID = objs("part")
'
'                part.iSpecNumber = cSpParts.Count + 1
'                part.bRunMet = part.isInRunningMeters
'                part.partdefName = partdefs(part.partdefID).partdefNameMulti
'                cSpParts.Add part, CStr(part.partID) & "|" & CStr(objs("part"))
'
'                If bSaveSpec Then
'                    stID = insertDataInBase(cn_data, "spectable", "catlistID", clID, "objID", objs("part"), "objectID", part.partID, _
'                                            "posNumber", part.iSpecNumber, _
'                                            "stText", part.partName, _
'                                            "stQty", part.partQty, _
'                                            "stUMass", part.massCommon, _
'                                            "stCMass", part.massCommon * part.partQty, _
'                                            "stRunMet", Abs(CInt(part.bRunMet)))
'                End If
'
'
'            End If
            '---------------------------------------------------------------
            
        ElseIf Not bRein And RS.fields("objID").Value = objs("catalog") Then

            Set ct = cCats(CStr(RS.fields("partID").Value))
            
            Set part = getColPart(CStr(RS.fields("partID").Value) & "|" & CStr(objs("catalog")))

            If part.partID = 0 Then
            
                part.partName = ct.catName
                part.partID = RS.fields("partID").Value
                If Not ds Is Nothing Then part.partDescr = ds.docsetNumber
                part.partQty = RS.fields("partQty").Value
                part.partQty = Round(part.partQty, 3) ' part.partQty = round(RS.Fields("partQty").Value не срабатывает...
                part.partQty = Round(part.partQty, 1)
                part.massCommon = getCatMass2(part.partID, 0)
                part.iSpecNumber = cSpParts.Count + 1
                part.partdefID = 11 ' сборочная единица
                part.typeID = objs("catalog")
                part.partdefName = part.PARTDEF.partdefNameMulti
                part.partOK = True
                
                cSpParts.Add part, CStr(part.partID) & "|" & CStr(objs("catalog"))
                
                If bSaveSpec Then
                    stID = insertDataInBase(cn_data, "spectable", "catlistID", clID, "objID", objs("catalog"), "objectID", ct.catID, _
                                            "posNumber", part.iSpecNumber, _
                                            "stText", part.specPrefix & part.partName, _
                                            "stQty", part.partQty, _
                                            "stUMass", part.massCommon, _
                                            "stCMass", part.massCommon * part.partQty, _
                                            "stRunMet", 0)
                End If
                    
            End If

        
        End If
        
        Set part = Nothing
        
        
        F1.PB.Value = RS.AbsolutePosition
        F1.PB.Refresh
        
        
        RS.MoveNext
        
    Loop Until RS.EOF
    
    
    F1.PB.Value = 0
    
    

Exit Sub

loadParts2_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadParts2 - Error"

End Sub

Private Function getColElem(ByRef Col As Collection, KEY As String) As clsProp

On Error GoTo err:

    Set getColElem = Col(KEY)

Exit Function
err:
    Set getColElem = Nothing

End Function




'/******************************************************************************
Public Sub createWiseDrawStruct(sptp As spectype, fgDyn As VSFlexGrid)
'/******************************************************************************

    Dim spunit As colSU
    Dim i As Integer
    Dim a As Integer
    Dim stxt As clsSpecText
    Dim stxtprev As clsSpecText
    Dim srow As clsSpecRow
    Dim dSum As Double
    Dim prpSum As clsProp
    Dim arstr() As String

    Me.spt = sptp

    Set cSpecUnits = New Collection ' если ограничение по строкам то при превышении будет несколько частей
    
    
'    Do

        Set spunit = New colSU

        If Not curSpecCfg.rowTop Is Nothing Then
        
            Set srow = New clsSpecRow
            srow.Init curSpecCfg.rowTop
            
            spunit.AddSpecRow srow
            Set srow = Nothing
            
            Set spunit.toprow = spunit(spunit.Count)
            
        End If

    
        'Dim bShift As Boolean
        'Dim dShiftY As Double
    
    
    
        For i = 1 To fgDyn.Rows - 1
        
            If fgDyn.RowHidden(i) Then GoTo cont
            
            Set srow = New clsSpecRow
            srow.Init curSpecCfg.rowOrd
    
            'bShift = False
            'dShiftY = 0#
            
            For Each stxt In srow.textfields
            
                If Not stxtprev Is Nothing Then
                    If stxtprev.bTextShift And stxtprev.KEY = stxt.KEY Then
                        stxt.txtoriginY = stxt.txtoriginY - srow.dTextShift
                    End If
                End If
            
'                If srow.bTextShift And right(stxt.sValueType, 5) = "shift" Then
'                    stxt.txtoriginY = stxt.txtoriginY - srow.dTextShift
'                End If
            
                If stxt.sValueType = "" Then
                    stxt.sText = stxt.KEY
                ElseIf left(stxt.sValueType, 6) = "direct" Then
    
                    If fgDyn.ColIndex(stxt.sValueSource) >= 0 Then
                    
                        Call rebuildString(fgDyn.TextMatrix(i, fgDyn.ColIndex(stxt.sValueSource)), arstr, stxt.iMaxTextLength)
                        
                        If UBound(arstr) > 0 Then
                            stxt.sText = arstr(0)
                            dSum = getDbl(stxt.sText)
                            For a = 1 To UBound(arstr)
                                stxt.dTextShift = srow.dTextShift + stxt.dTextHeight * dSpecNextRowParam ' curSpecCfg.rowOrd.dRowHeight
                                stxt.colDopText.Add arstr(a)
                                srow.dRowHeight = srow.dRowHeight + stxt.dTextHeight * dSpecNextRowParam
                                'bShift = True
                                stxt.bTextShift = True
                                srow.bTextShift = True
                            Next a
                            
                            If stxt.dTextShift > srow.dTextShift Then srow.dTextShift = stxt.dTextShift
                            
                        Else
                            stxt.sText = fgDyn.TextMatrix(i, fgDyn.ColIndex(stxt.sValueSource))
                            dSum = getDbl(stxt.sText)
                        End If
                    

                    End If
    
                Else
                End If
                
                If stxt.bIsNumber And curSpecCfg.spcfgUseDots Then
                    stxt.sText = Replace(stxt.sText, ",", ".")
                End If
                
                ' --- sums ---
                Set prpSum = getColElem(cSums, stxt.sValueSource)
                If Not prpSum Is Nothing Then
                    prpSum.propK = prpSum.propK + dSum
                End If
                ' ------------
                
                Set stxtprev = stxt
    
            Next stxt
            
            
            If srow.bTextShift Then
                Dim sln As clsSpecLine
                
'                For Each stxt In srow.textfields
'                    If srow.bTextShift And right(stxt.sValueType, 5) = "shift" Then
'                        stxt.txtoriginY = stxt.txtoriginY - srow.dTextShift
'                    End If
'                Next
                
                If srow.hlines.Count >= 2 Then
                    Set sln = srow.hlines(2)
                    sln.lin_startY = sln.lin_startY - srow.dTextShift
                    sln.lin_endY = sln.lin_endY - srow.dTextShift
                End If

                For Each sln In srow.vlines
                    sln.lin_startY = sln.lin_startY - srow.dTextShift
                Next sln
            End If
            
            
            
            spunit.AddSpecRow srow
            Set srow = Nothing
            
cont:
    
        Next i
        
        
        If cSums.Count > 0 Then
        Set prpSum = cSums(1)
        End If
    

        If Not curSpecCfg.rowBot Is Nothing Then
        
            Set srow = New clsSpecRow
            srow.Init curSpecCfg.rowBot
            
            For Each stxt In srow.textfields
            
                If stxt.sValueType = "sum" Then
                    If Not prpSum Is Nothing Then
                        stxt.sText = prpSum.propK
                    End If
                End If
    
                If stxt.bIsNumber And curSpecCfg.spcfgUseDots Then
                    stxt.sText = Replace(stxt.sText, ",", ".")
                End If
    
            Next stxt
            
            spunit.AddSpecRow srow
            Set srow = Nothing
            
            Set spunit.botrow = spunit(spunit.Count)
        
        End If



'    Dim sp As clsSpecLine
'    Set srow = spunit(5)
'    Set sp = srow.SPECROW_POINT_UNIT



        cSpecUnits.Add spunit
        Set spunit = Nothing
    
'    Loop
    
    
    '====================================
    
    
    
    
    Set spunit = cSpecUnits(1)
    
    spunit.createMSElements








'
'
'
'
'    Dim u As clsSRU
'    Dim rt As clsSRUT
'
'
'
'            Set r = New clsSR
'            Set r.prnt = Me
'
'
'                    Set rt = New clsSRUT
'                    rt.sText = ""
'                    Set u = r.cells(3)
'                    u.rtc.Add rt



End Sub



'/******************************************************************************
Public Sub createCmnSpecDrawStruct(sptp As spectype, Optional sCommonMass As String = "")
'/******************************************************************************

    On Error GoTo createStruct_ERR
    
    
    Dim spunit As colSU
    Dim sprow As clsSR
    Dim qty As Integer
    Dim prt As clsPart
    Dim pos As clsPos
    
    Dim h As Double
    
    Dim i As Integer
    Dim a As Integer
    Dim pnum As Integer
    
     
    
    writeToLogFile "start createCmnSpecDrawStruct(), cSpParts.Count = " & cSpParts.Count, True
    
    a = 1
    
    Me.spt = sptp
    
    Set cSpecUnits = New Collection
    
    Do
        writeToLogFile "do iter begin"
        
        Set spunit = New colSU
        
        If blnDrawSpecCap Then spunit.createHead ' кстати можно добавлять разные шапки
        
        spunit.maxRows = lngSpecDefaultRows
        spunit.originY = spunit.dHeadHeight
        
        If a = 1 Then
        
            For i = 1 To lngSpecFirstRows

                Set sprow = New clsSR
                Set sprow.prnt = spunit
                If spunit.AddRow(sprow) = False Then Exit For

            Next i
        
        
        End If
        
        
        
        For i = a To cSpParts.Count
        
            Set prt = cSpParts(i)
            
'            If prt.bIsCat Then
'            Debug.Print ""
'            End If
            
            If spt = stPart Then
                
                pnum = 0
                For Each pos In prt.ps.pm
                    pnum = pnum + 1
                    pos.posNumber = pnum
                    If pos.POS_SRTM.srtmID < 0 Then
                        Dim pospart As New clsPart
                        If pospart.setIDv2(-pos.POS_SRTM.srtmID, False, False, False) Then
                            pospart.partQty = pos.posQty
                            pospart.massCommon = pos.posUMass
                            qty = spunit.addCmnSpecPartRows(pospart)
                        End If
                        Set pospart = Nothing
                    Else
                        qty = spunit.addCmnSpecPosRows(pos, spt)
                    End If
                Next pos
                
                For Each pos In prt.ps.pe
                    qty = spunit.addCmnSpecPosRows(pos, spt)
                Next pos
                
                ' prt is not nothing
'                If blnSpecCmnMass Then qty = spunit.addCommonMass(prt, sCommonMass)
            
            
            Else
            
                If prt.partQty = 0# And sptp = stList Then
                
                    pnum = 0
                    For Each pos In prt.ps.pm
                        pnum = pnum + 1
                        pos.posNumber = pnum
                        qty = spunit.addCmnSpecPosRows(pos, stPart)
                    Next pos
                    
                    For Each pos In prt.ps.pe
                        qty = spunit.addCmnSpecPosRows(pos, stPart)
                    Next pos
                
                ElseIf (globPartDefs(CStr(prt.partdefID)).bUsePositions Or prt.PART_CAT.catTypeID = ctRein) And (prt.ps.pm.Count > 0 Or prt.ps.pe.Count > 0) Then
                
                    Dim doppos As clsPos
                
                    If prt.ps.pm.Count > 0 Then
                        Set pos = prt.ps.pm(1)
                        If prt.ps.pm.Count > 1 Then
                            Set doppos = prt.ps.pm(2)
                        End If
                    ElseIf prt.ps.pe.Count > 0 Then
                        Set pos = prt.ps.pe(1)
                    End If
                
                    qty = spunit.addCmnSpecPosRows(pos, spt, doppos)
                    
                    Set doppos = Nothing
                Else
                    qty = spunit.addCmnSpecPartRows(prt)
                End If
                
                Set prt = Nothing ' prt is nothing
                
            End If
            
            
            
            If qty <= 0 Then
                a = i + 1 + qty
                Exit For
            End If
            
        Next i
        
        
        
        
        If qty > 0 Then ' чтобы пустые строки печатались только в последней секции
        
            If blnSpecCmnMass Then
                Call spunit.addCommonMass(prt, sCommonMass, Not curSpecCfg.bNewRowMatStd)
            End If
            
            For i = 1 To lngSpecLastRows
                
                Set sprow = New clsSR
                Set sprow.prnt = spunit
                If spunit.AddRow(sprow) = False Then Exit For

            Next i
        End If
        
        
        
        h = 0#
        For Each sprow In spunit
            h = sprow.setOffsetY(h)
        Next sprow
        
        writeToLogFile "cSpecUnits.Add spunit"
        cSpecUnits.Add spunit
        Set spunit = Nothing
    
    
        writeToLogFile "do iter end, qty = " & qty
    
    Loop Until a > cSpParts.Count Or qty > 0
    
    
    
    
    If blnSpecLastRows Then
        writeToLogFile "Me.setEqualHeight(False)..."
        Me.setEqualHeight False
        writeToLogFile "ok"
    End If
    

Exit Sub

createStruct_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "createStruct - Error"
    'Resume Next

End Sub


Public Sub loadCatPos(catID As Long, Optional partdefID As Long = 0)
    
    Dim RS As New ADODB.Recordset
    
    Dim strSQL As String
    
    strSQL = "SELECT "
    
    strSQL = strSQL & conn.strBaseName & ".dbo.view_r_cat_position.* "
    strSQL = strSQL & "," & conn.strSrtmName & ".dbo.view_r_sortament_property_3.* "
    
    strSQL = strSQL & "FROM "
    strSQL = strSQL & conn.strBaseName & ".dbo.view_r_cat_position "
    
    strSQL = strSQL & "LEFT OUTER JOIN "
    strSQL = strSQL & conn.strSrtmName & ".dbo.view_r_sortament_property_3 "
    strSQL = strSQL & "ON "
    strSQL = strSQL & conn.strBaseName & ".dbo.view_r_cat_position.pos_srtmID "
    strSQL = strSQL & "= "
    strSQL = strSQL & conn.strSrtmName & ".dbo.view_r_sortament_property_3.srtmID "
    
    strSQL = strSQL & "WHERE "
    strSQL = strSQL & conn.strBaseName & ".dbo.view_r_cat_position.catID = " & catID & " "
    
    strSQL = strSQL & "ORDER BY [posNumber]"
    
    
    
    
    RS.Open strSQL, cn_data, adOpenForwardOnly, adLockReadOnly
    
'    RS.Open "select * from view_r_cat_position where catID = " & catID, cn_data, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        
        RS.MoveFirst
        Do
        
            If Not IsNull(RS.fields("pos_srtmID").Value) Then
            
            Dim part As New clsPart
                
            If part.setPartFromCat(RS.fields("catID").Value, False, True, False, RS) Then
            
                part.partName = ""
            
                part.partdefID = partdefID
                
                part.parttypeID = part.typeID
                part.typeID = objs("part")
                
                part.partIDold = RS.fields("posID").Value
                
                part.partQty = Round(RS.fields("posQuantity").Value, 3)
                
                part.iSpecNumber = cSpParts.Count + 1
                
                part.partdefName = part.PARTDEF.partdefNameMulti
                
                part.partOK = True
                
                cSpParts.Add part, CStr(part.partIDold) & "|" & CStr(objs("position"))
                
                
'                If bSaveSpec Then ... нэнадо
'                End If
                
                Set part = Nothing
                
                
            End If
                
                
            End If
            
        
            RS.MoveNext
        Loop Until RS.EOF
        
    End If
    
    
End Sub

