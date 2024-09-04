VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCat"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public catID As Long
Public catName As String

Public catTypeID As Long
Public catTypeName As String

Public catdefID As Long

Public objID As Long
Public objectID As Long

Public bDeleted As Boolean
Public bForTesting As Boolean
Public bUnif As Boolean

Public bOpen As Boolean
Public iStatus As pst

Private sTreeNodeImage As String

Public catListID As Long

Public catDocSetPartListID As Long
Public catDocSetDrawingsID As Long

Private catPath As String
Private projectID As Long
Private blockID As Long
Private bldingID As Long

Public catDocSetLev As Integer
Public catDocSetNum As Integer

Public dsDrawID As Long
Private dsNumber As String
Private dsVers As String

Public pw_ds_fld_ID As Long


Public userspecID As Long

'/******************************************************************************
Private Function getVersFromName(sCatName As String) As String
'/******************************************************************************

    On Error GoTo getVersFromName_ERR

    Dim iVers As Integer
    Dim sVers As String
    
    iVers = 0
    sVers = ""

    getVersFromName = ""

    Dim ar() As String
    
    ar = Split(sCatName, "_")

    If UBound(ar) = 1 Then
        sVers = UCase(ar(1))
    
    Else
        ar = Split(sCatName, "=")
    
        If UBound(ar) = 1 Then
            sVers = UCase(ar(1))
        End If
    
    End If
    
    
    
    If Len(Trim(sVers)) = 0 Then Exit Function
    
    iVers = Val(sVers)
    
    Do While iVers = 0
        sVers = right(sVers, Len(sVers) - 1)
        If Len(Trim(sVers)) = 0 Then Exit Do
        iVers = Val(sVers)
    Loop
    
    If iVers = 0 Then Exit Function
    
    getVersFromName = "C" & Format(iVers, "00")

Exit Function

getVersFromName_ERR:
getVersFromName = ""

End Function


'/******************************************************************************
Public Function loadCatByID(RS As ADODB.Recordset, ID As Long, Optional bPW As Boolean = False) As Boolean
'/******************************************************************************

    On Error GoTo loadCatByID_ERR


    Dim RSS As ADODB.Recordset
    
    If RS Is Nothing Then
        Set RSS = New ADODB.Recordset
        If bUseCursorClient Then RSS.CursorLocation = adUseClient
        If bPW Then
            RSS.Open "select * from view_object_catalog_pw where catID = " & ID, cn_data, adOpenForwardOnly, adLockReadOnly
        Else
            RSS.Open "select * from view_object_catalog where catID = " & ID, cn_data, adOpenForwardOnly, adLockReadOnly
        End If
        If Not RSS.EOF Then RSS.MoveFirst
    Else
        Set RSS = RS
    End If
    
    
    If Not RSS.EOF Then
    
        objID = RSS.fields("objID").Value
        objectID = RSS.fields("objectID").Value
    
        If bPW Then
        
            Dim prjID As Long
            Dim sCodeName1 As String
            Dim sCodeName2 As String
            Dim sCodeField As String
            prjID = getFieldLongValue(RSS, "prjID", 0)
            
            If prjID > 0 Then
                Dim r As New RegExp
                Dim dsn As clsDocSetNum
                
                For Each dsn In globDSNum
                    If dsn.dsnprjID = prjID And dsn.dsndtID = 2 Then
                        r.Pattern = dsn.dsnRegex
                        sCodeField = dsn.dsnFieldName
                        Exit For
                    End If
                Next
                
                If r.Pattern = "" Then Set RSS = Nothing
                
                dsDrawID = getFieldLongValue(RSS, "dsID", 0)
                sCodeName1 = getFieldStringValue(RSS, "o_projectname", "")
                sCodeName2 = getFieldStringValue(RSS, sCodeField, "")
                
                catName = sCodeName1
               
                dsVers = getVersFromName(sCodeName1)
                
                If r.Test(sCodeName2) Then ' номер из карточки приоритетнее
                    dsNumber = sCodeName2
                Else
                    If r.Test(sCodeName1) Then
                        dsNumber = sCodeName1
                    End If
                End If
                 
                If Len(dsNumber) = 0 Then
                    dsDrawID = 0
                    Set RSS = Nothing
                End If
            Else
                Set RSS = Nothing
            End If
            
            If IsNull(RSS.fields("catID").Value) Then Set RSS = Nothing
       
            If RSS Is Nothing Then Exit Function
        End If
    
        catID = RSS.fields("catID").Value
        catName = RSS.fields("catName").Value
    
        catTypeID = RSS.fields("catTypeID").Value
        
        If Not bPW Then catdefID = RSS.fields("catdefID").Value
        
       
        catListID = RSS.fields("catlistID").Value
        
        bDeleted = RSS.fields("deleted").Value
        bForTesting = RSS.fields("forTesting").Value
        bUnif = RSS.fields("catUnif").Value
        bOpen = RSS.fields("catOpen").Value
        iStatus = RSS.fields("catStatus").Value
        
        catTypeName = cattypes(catTypeID).ctName
        
        sTreeNodeImage = cattypes(catTypeID).tnNum
        
        If bPW Then
        
            pw_ds_fld_ID = RSS.fields("dsID").Value
        
            'sTreeNodeImage = RSS.fields("image").Value
        Else
            
            
            catDocSetDrawingsID = RSS.fields("dsDrawingsID").Value
            catDocSetPartListID = RSS.fields("dsPartListID").Value
            userspecID = RSS.fields("specID").Value
            
            catDocSetLev = 0
            catDocSetNum = 0
            If Not IsNull(RSS.fields("dsLev").Value) Then catDocSetLev = RSS.fields("dsLev").Value
            If Not IsNull(RSS.fields("dsNum").Value) Then catDocSetNum = RSS.fields("dsNum").Value
            
            dsDrawID = RSS.fields("dsDrawingsID").Value
            dsNumber = RSS.fields("dsNumber").Value & ""
            
        End If
        
        loadCatByID = True
    
    End If
    
    If RS Is Nothing Then RSS.Close
    Set RSS = Nothing




Exit Function

loadCatByID_ERR:
    Set RSS = Nothing
    loadCatByID = False
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadByID - Error"

End Function


'/******************************************************************************
Public Function getCatPath(Optional bUseCache As Boolean = False) As String
'/******************************************************************************

    On Error GoTo getCtaPath_ERR
    
    If bUseCache And Len(catPath) > 0 Then
        getCatPath = catPath
        Exit Function
    End If
    
    
    Dim cmd As New ADODB.Command
    cmd.ActiveConnection = cn_data
    cmd.CommandType = adCmdStoredProc
    cmd.CommandText = "getPath2"
    cmd.Parameters.Append cmd.CreateParameter("ret", adBSTR, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("objID", adBigInt, adParamInput, , objs("catalog"))
    cmd.Parameters.Append cmd.CreateParameter("objectID", adBigInt, adParamInput, , Me.catID)
    cmd.Parameters.Append cmd.CreateParameter("nameshort", adInteger, adParamInput, , 30)
    cmd.Execute
    
    catPath = cmd.Parameters("ret") & ""
    
    getCatPath = catPath
    

Exit Function

getCtaPath_ERR:
    getCatPath = ""

End Function



Public Function getTreeNodeImage() As String

    If bOpen Then
        getTreeNodeImage = sTreeNodeImage & "_open_st" & iStatus
    Else
        getTreeNodeImage = sTreeNodeImage & "_closed_st" & iStatus
    End If
    
    


End Function


'/******************************************************************************
Public Function getProjectIDfromDB(Optional bUseCache As Boolean = False) As Long
'/******************************************************************************

    On Error GoTo getProjectIDfromDB_ERR

    If bUseCache And projectID > 0 Then
        getProjectIDfromDB = projectID
        Exit Function
    End If
    


    Dim cmd As New ADODB.Command
    cmd.ActiveConnection = cn_data
    cmd.CommandType = adCmdStoredProc
    cmd.CommandText = "getProjID"
    cmd.Parameters.Append cmd.CreateParameter("ret", adBigInt, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("objID", adBigInt, adParamInput, , objs("catalog"))
    cmd.Parameters.Append cmd.CreateParameter("objectID", adBigInt, adParamInput, , Me.catID)
    cmd.Execute
    
    projectID = cmd.Parameters("ret") & ""
    
    getProjectIDfromDB = projectID



Exit Function

getProjectIDfromDB_ERR:
    getProjectIDfromDB = 0
    If bMainFormLoaded Then F1.SB.Panels("status").text = "getProjectIDfromDB" & "() - " & err.Description

End Function

'/******************************************************************************
Public Function getBuildingID(Optional bUseCache As Boolean = False) As Long
'/******************************************************************************

    On Error GoTo get_ERR

    If bUseCache And bldingID > 0 Then
        getBuildingID = bldingID
        Exit Function
    End If
    


    Dim cmd As New ADODB.Command
    cmd.ActiveConnection = cn_data
    cmd.CommandType = adCmdStoredProc
    cmd.CommandText = "getBuildingID"
    cmd.Parameters.Append cmd.CreateParameter("ret", adBigInt, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("objID", adBigInt, adParamInput, , objs("catalog"))
    cmd.Parameters.Append cmd.CreateParameter("objectID", adBigInt, adParamInput, , Me.catID)
    cmd.Execute
    
    bldingID = cmd.Parameters("ret") & ""
    
    getBuildingID = bldingID



Exit Function

get_ERR:
    getBuildingID = 0
    If bMainFormLoaded Then F1.SB.Panels("status").text = "getBuildingID" & "() - " & err.Description

End Function



'/******************************************************************************
Public Function getBlockIDfromDB(Optional bUseCache As Boolean = False) As Long
'/******************************************************************************

    On Error GoTo getBlockIDfromDB_ERR

    If bUseCache And blockID > 0 Then
        getBlockIDfromDB = blockID
        Exit Function
    End If
    


    Dim cmd As New ADODB.Command
    cmd.ActiveConnection = cn_data
    cmd.CommandType = adCmdStoredProc
    cmd.CommandText = "getBlockID"
    cmd.Parameters.Append cmd.CreateParameter("ret", adBigInt, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("objID", adBigInt, adParamInput, , objs("catalog"))
    cmd.Parameters.Append cmd.CreateParameter("objectID", adBigInt, adParamInput, , Me.catID)
    cmd.Execute
    
    blockID = cmd.Parameters("ret") & ""
    
    getBlockIDfromDB = blockID



Exit Function

getBlockIDfromDB_ERR:
    If bMainFormLoaded Then F1.SB.Panels("status").text = "getBlockIDfromDB" & "() - " & err.Description

End Function



Public Function getDocSetNumber(Optional bGetFromBase As Boolean = True, Optional prjID As Long = 0, Optional prjDesc As String = "", Optional iWdt As Integer = 30) As String

    If dsDrawID = 0 Then Exit Function

    If Len(dsNumber) > 0 Then
    
        If bGetFromBase And Me.pw_ds_fld_ID > 0 Then
        
            getDocSetNumber = dsNumber
        
        ElseIf prjID > 0 Then
        
            Dim dsn As clsDocSetNum
            For Each dsn In globDSNum
                If dsn.dsnprjID = prjID And dsn.dsndtID = 2 Then
                    Exit For
                End If
            Next
            
            Dim str As String
            
            If Not dsn Is Nothing Then
                str = Mid(dsNumber, dsn.dsnLevStart, dsn.dsnLevLen) & "-" & Mid(dsNumber, dsn.dsnDigStart, dsn.dsnDigLen)
                
                If Len(dsVers) = 3 Then str = str & "=" & dsVers
                
                If Len(Trim(prjDesc & "")) > 0 Then
                    If Len(prjDesc) > iWdt Then
                        str = str & " - " & left(prjDesc, iWdt) & "..."
                    Else
                        str = str & " - " & prjDesc
                    End If
                
                Else
                End If
                
                getDocSetNumber = str
                
            Else
                getDocSetNumber = dsNumber
            End If
        
        
        Else
            getDocSetNumber = dsNumber
        End If
    
    
        Exit Function
    End If
    
    If bGetFromBase Then
        dsNumber = selectStringFromBase(cn_data, "docset", "dsNumber", "dsID", dsDrawID)
    End If
    
    getDocSetNumber = dsNumber



End Function


'/******************************************************************************
Public Property Get CAT_DS_NUM() As String
'/******************************************************************************

    On Error GoTo CAT_DS_NUM_ERR
    
    
'    Dim cmd As New ADODB.Command
'    cmd.ActiveConnection = cn_data
'    cmd.CommandType = adCmdStoredProc
'    cmd.CommandText = "getCatNum"
'    cmd.Parameters.Append cmd.CreateParameter("ret", adBSTR, adParamReturnValue)
'    cmd.Parameters.Append cmd.CreateParameter("objID", adBigInt, adParamInput, , objs("catalog"))
'    cmd.Parameters.Append cmd.CreateParameter("objectID", adBigInt, adParamInput, , Me.catID)
'    cmd.Parameters.Append cmd.CreateParameter("dsTypeID", adBigInt, adParamInput, , dstype.dsDrawings)
'    cmd.Parameters.Append cmd.CreateParameter("specID", adBigInt, adParamInput, , 1)
'    cmd.Execute
'    CAT_DS_NUM = cmd.Parameters("ret") & ""

    CAT_DS_NUM = getDocSetNumber(False)


Exit Property

CAT_DS_NUM_ERR:
    CAT_DS_NUM = "CAT_DS_NUM - Error"

End Property


'/******************************************************************************
Public Property Get CAT_DS_NUM_Lite() As String
'/******************************************************************************

    On Error GoTo CAT_DS_NUM_Lite_ERR
    
    Dim sLev As String
    Dim sNum As String
    
    If Me.catDocSetLev < 0 Then sLev = "&&" Else sLev = Format(Me.catDocSetLev, "00")
    If Me.catDocSetNum < 0 Then sNum = "&&&&" Else sNum = Format(Me.catDocSetNum, "0000")
    
    
    CAT_DS_NUM_Lite = sLev & "-" & sNum
    
    

Exit Property

CAT_DS_NUM_Lite_ERR:
    CAT_DS_NUM_Lite = "CAT_DS_NUM_Lite - Error"

End Property


'/******************************************************************************
Public Property Get CAT_CATDEF() As clsCatDef
'/******************************************************************************

    On Error GoTo CAT_CATDEF_ERR
    
    Set CAT_CATDEF = globCatDefs(CStr(Me.catdefID))
 
Exit Property

CAT_CATDEF_ERR:

    Set CAT_CATDEF = globCatDefs("0")

End Property


