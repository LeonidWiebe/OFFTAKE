VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsPD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public pdID As Long
Public pdIDGlobal As Long
Public pdName As String
Public pdNameMulti As String
Public pdDefQty As Double
Public strSort As String
Public pdDrawSign As String
Public pdDrawSymbol As String
Public pdDrawSrtmPrefix As String
Public bDrawName As Boolean
Public bMassCommon As Boolean
Public sortNumber As Long
Public bUsing As Boolean
Public iMassLevel As Integer
Public bPosNum As Boolean
Public pdIDtoCalc As Long ' если pdIDtoCalc > 0 и mcID = 5 то считается сумма массы только для pdID = pdIDtoCalc
Public bSpecSign As Boolean ' если в спецификации bPosSignStd = true и bSpecSign = true - srtmName печатается как исполнение рядом со стандартом
Public bUsedByCatPos As Boolean
Public bInclCmnMass As Boolean

'Private mc As clsMC
Public mcID As Long

Public syms As Collection
Public pdsets As Collection

Public pd_props As colProp

Public pd_stds As colStdPd ' не исп., сделать для F2, чтобы исп. colSrtm при выборе (сортамент - в память)


'/******************************************************************************
Public Function loadPosdef(ID As Long, Optional bLoadProps As Boolean = True) As Boolean
'/******************************************************************************

    On Error GoTo loadPosdef_ERR

    Dim RS As ADODB.Recordset

    Set RS = New ADODB.Recordset
    If bUseCursorClient Then RS.CursorLocation = adUseClient
    RS.Open "select * from posdef where posdefID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
    If Not RS.EOF Then RS.MoveFirst
    
    
    If Not RS.EOF Then
        
        loadPosdefFromRS RS

    End If
    
    
    If bLoadProps Then Me.loadPosdefProps
    
    Me.loadPDSets
    
    loadPosdef = True


Exit Function

loadPosdef_ERR:
    Set frmSps = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadPosdef - Error"
'    Resume Next

End Function


'/******************************************************************************
Public Function loadPosdefProps() As Boolean
'/******************************************************************************

    On Error GoTo loadPosdefProps_ERR
    
    Dim RS As New ADODB.Recordset

    RS.Open "select * from view_r_posdef_property where posdefID = " & pdID & " order by sortOrder", cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    strSort = ""
    
    Set pd_props = New colProp
    
    If Not RS.EOF Then
        
        RS.MoveFirst
        Do
            loadPosdefPropsFromRS RS
            
            RS.MoveNext
            
        Loop Until RS.EOF
        
    End If
    
    RS.Close
    Set RS = Nothing
    
    
    If Len(strSort) = 0 Then strSort = "srtmName"
    

    loadPosdefProps = True


Exit Function

loadPosdefProps_ERR:
    Set RS = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadPosdefProps - Error"

End Function



'/******************************************************************************
Private Sub setValues(RS As ADODB.Recordset)
'/******************************************************************************


        RS.fields("posdefName").Value = Me.pdName
        If Len(Me.pdNameMulti) = 0 Then
            RS.fields("posdefNameMulti").Value = Me.pdName
        Else
            RS.fields("posdefNameMulti").Value = Me.pdNameMulti
        End If
        RS.fields("massCommon").Value = Me.bMassCommon
        RS.fields("posdefDrawName").Value = Me.bDrawName
        RS.fields("sortNumber").Value = Me.sortNumber
        If Len(Me.pdDrawSign) > 0 Then RS.fields("posdefDrawSign").Value = Me.pdDrawSign
        If Len(Me.pdDrawSymbol) > 0 Then RS.fields("posdefDrawSymbol").Value = Me.pdDrawSymbol
        If Len(Me.pdDrawSrtmPrefix) > 0 Then RS.fields("posdefDrawSrtmPrefix").Value = Me.pdDrawSrtmPrefix
        RS.fields("masscalcID").Value = Me.mcID
        RS.fields("massLevel").Value = Me.iMassLevel
        RS.fields("posdefUsing").Value = bUsing
        RS.fields("posNum").Value = bPosNum
        RS.fields("posdefDefaultQty").Value = Me.pdDefQty
'        If Not Me.PD_MCALC.MC_PRNT Is Nothing Then RS.Fields("calcID").Value = Me.PD_MCALC.calcID 'not using field
        If Me.pdIDGlobal = 0 Then RS.fields("posdefIDGlobal").Value = Me.pdID Else RS.fields("posdefIDGlobal").Value = Me.pdIDGlobal
        RS.fields("pdIDtoCalc").Value = Me.pdIDtoCalc


End Sub

'/******************************************************************************
Public Function savePosDef(bSort As Boolean) As Boolean
'/******************************************************************************

    On Error GoTo save_ERR
    
    Dim iMSN As Long

    Dim RS As New ADODB.Recordset
    
    If bSort Then
        RS.Open "select max(sortNumber) as [msn] from posdef", cn_srtm, adOpenForwardOnly, adLockOptimistic
        RS.MoveFirst
        iMSN = RS.fields("msn").Value + 10
        RS.NextRecordset
    End If
    
    RS.Open "select * from posdef where posdefID = " & pdID, cn_srtm, adOpenForwardOnly, adLockOptimistic
    
    If RS.EOF Then
    
        Me.sortNumber = iMSN
        bUsing = False
        
        RS.NextRecordset
        RS.Open "select top 1 * from posdef order by posdefID desc", cn_srtm, adOpenStatic, adLockOptimistic
        
    
        RS.AddNew
        setValues RS
        RS.Update
        RS.Requery
        RS.MoveFirst
        Me.pdID = RS.fields("posdefID").Value
    
    Else
        RS.MoveFirst
        setValues RS
        RS.Update
    
    End If
    
    RS.Close
    
    Set RS = Nothing
    
    
    If Me.pdIDGlobal = 0 Then
        updateTableInBase cn_srtm, "posdef", "posdefIDGlobal", Me.pdID, "posdefID", Me.pdID
        Me.pdIDGlobal = Me.pdID
    End If



    savePosDef = True



Exit Function

save_ERR:
    savePosDef = False
'    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, " - Error"

End Function


'/******************************************************************************
Public Sub loadSynonyms()
'/******************************************************************************

    On Error GoTo loadSynonyms_ERR
    Set syms = New Collection
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from view_posdef_synonims where posdefID = " & Me.pdID, cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            syms.Add RS.fields("posdefSyn").Value & ""
            RS.MoveNext
        Loop Until RS.EOF
    
    
    End If
    
    
    RS.Close
    Set RS = Nothing

Exit Sub

loadSynonyms_ERR:
    Set RS = Nothing
    Set syms = New Collection

End Sub

Private Sub Class_Initialize()

    Set pd_props = New colProp
    
    Set pdsets = New Collection
    
    Me.bPosNum = True
    
    bInclCmnMass = True

End Sub

Private Sub Class_Terminate()
    Set pd_props = Nothing
    Set pdsets = Nothing

End Sub

'/******************************************************************************
Public Sub loadPDSets()
'/******************************************************************************

    On Error GoTo loadPDSets_ERR

    Set pdsets = New Collection
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from r_pdset_posdef where posdefID = " & Me.pdID, cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            Dim pds As New clsPDSet
            pds.relID = RS.fields("relID").Value
            pds.pdsID = RS.fields("pdsID").Value
            pds.pdID = RS.fields("posdefID").Value
            pds.pdsNameAlt = RS.fields("relNameAlt").Value & ""
            pds.bDrawSrtmName = getFieldBoolValue(RS, "relDrawName", True)
            
            pdsets.Add pds, CStr(pds.relID)
            
            Set pds = Nothing
            
            RS.MoveNext
        Loop Until RS.EOF
    
    
    End If
    
    
    RS.Close
    Set RS = Nothing


Exit Sub

loadPDSets_ERR:
    Set RS = Nothing
    Set pdsets = New Collection
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadPDSets - Error"

End Sub

Public Function mustDrawSrtmName() As Boolean
    On Error GoTo err

    Dim pds As clsPDSet

    For Each pds In pdsets
        If usrCurrent.pdsID = pds.pdsID Then
            mustDrawSrtmName = pds.bDrawSrtmName
            Exit Function
        End If
    Next pds

    mustDrawSrtmName = True

Exit Function
err:
    mustDrawSrtmName = True
End Function

'/******************************************************************************
Public Property Get PD_NAME() As String
'/******************************************************************************

    On Error GoTo PD_NAME_ERR
    
    Dim pds As clsPDSet
    Dim strPdsName As String
    
    strPdsName = pdName
    
    For Each pds In pdsets
        If usrCurrent.pdsID = pds.pdsID And Len(pds.pdsNameAlt) > 0 Then
            strPdsName = pds.pdsNameAlt
        End If
    Next pds
    
    PD_NAME = strPdsName

Exit Property

PD_NAME_ERR:
PD_NAME = pdName

End Property


'/******************************************************************************
Public Property Get PD_MCALC() As clsMC
'/******************************************************************************

    On Error GoTo PD_MCALC_ERR
    
    If mcID = 0 Then GoTo PD_MCALC_ERR
    
    Set PD_MCALC = globMassCalcs(CStr(mcID))

Exit Property

PD_MCALC_ERR:
    Set PD_MCALC = New clsMC

End Property


'/******************************************************************************
Public Function loadPosdefFromRS(RS As ADODB.Recordset)
'/******************************************************************************

    On Error GoTo loadPosdefByRS_ERR


        pdID = RS.fields("posdefID").Value
        pdIDGlobal = RS.fields("posdefIDGlobal").Value & ""
        pdName = RS.fields("posdefName").Value & ""
        pdDefQty = RS.fields("posdefDefaultQty").Value
        pdDrawSign = RS.fields("posdefDrawSign").Value & ""
        pdDrawSymbol = RS.fields("posdefDrawSymbol").Value & ""
        pdDrawSrtmPrefix = RS.fields("posdefDrawSrtmPrefix").Value & ""
        bDrawName = CBool(RS.fields("posdefDrawName").Value)
        bMassCommon = CBool(RS.fields("massCommon").Value)
        pdNameMulti = RS.fields("posdefNameMulti").Value & ""
        sortNumber = RS.fields("sortNumber").Value & ""
        bUsing = RS.fields("posdefUsing").Value
        bPosNum = RS.fields("posNum").Value
        pdIDtoCalc = RS.fields("pdIDtoCalc").Value
        bSpecSign = CBool(RS.fields("specSign").Value)
        bUsedByCatPos = CBool(RS.fields("usedByCatPos").Value)
        bInclCmnMass = getFieldBoolValue(RS, "inclCmnMass", True)
        
        If pdDrawSign = "¶" Then
            pdDrawSign = scfgCmn.spec_text_diam
        End If
        
        iMassLevel = RS.fields("massLevel").Value
        
'        If usrCurrent.depID = 1 Then ' XXXXXXXXXXXXXXXXXXX temp
'            If pdID = 13 Then iMassLevel = 1 ' муфта
'            If pdID = 16 Then iMassLevel = 1 ' гайка
'            If pdID = 19 Then iMassLevel = 1 ' болт
'            If pdID = 26 Then iMassLevel = 1 ' стоп гайка
'            If pdID = 27 Then iMassLevel = 1 ' шпилька
'            If pdID = 28 Then iMassLevel = 1 ' фланец
'            If pdID = 30 Then iMassLevel = 1 ' прокладка
'            If pdID = 31 Then iMassLevel = 1 ' шайба
'            If pdID = 32 Then iMassLevel = 1 ' заглушка
'        End If
        
        
        If Len(pdNameMulti) = 0 Then pdNameMulti = pdName
        
        mcID = RS.fields("masscalcID").Value



Exit Function

loadPosdefByRS_ERR:
    If bMainFormLoaded Then F1.SB.Panels("status").text = "loadPosdefByRS" & "() - " & err.Description

End Function


Public Function loadPosdefPropsFromRS(RS As ADODB.Recordset) As Boolean

    If IsNull(RS.fields("propID").Value) Then Exit Function


    Dim prop As New clsProp
    prop.loadByPropID RS.fields("propID").Value, RS
    prop.iSortOrder = RS.fields("sortOrder").Value
    
    pd_props.AddNewProp prop
    
    If prop.iSortOrder > 0 Then
        If Len(strSort) > 0 Then strSort = strSort & ","
        strSort = strSort & "[" & prop.propName & "]"
    End If
    
    Set prop = Nothing


End Function
