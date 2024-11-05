VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsStd"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public OK As Boolean

Public stdID As Long

Public stdTypeID As Long
Public stdTypeName As String
Public stdTypeDev As String
Public stdNumber As String
Public stdNumberAlt As String
'Public stdFullNumber As String
Public stdName As String

Private flds() As Variant
Private vls() As Variant

Public bChanged As Boolean

'Public Property Let u(ByVal v As Double)
'End Property
'/******************************************************************************

Public Property Get FULLNUMBER() As String
'/******************************************************************************

    If bUseStdNumberAlt And Len(Trim(stdNumberAlt)) > 0 Then
        FULLNUMBER = Trim(stdTypeName & Replace(stdTypeDev, "_", " ") & stdNumberAlt)
    Else
        FULLNUMBER = Trim(stdTypeName & Replace(stdTypeDev, "_", " ") & stdNumber)
    End If


End Property


'/******************************************************************************
Public Property Get FULLNUMBER_TRANSLATED() As String
'/******************************************************************************

    If bUseStdNumberAlt And Len(Trim(stdNumberAlt)) > 0 Then
        FULLNUMBER_TRANSLATED = Trim(getTrans(stdTypeName, "", 2) & Replace(stdTypeDev, "_", " ") & stdNumberAlt)
    Else
        FULLNUMBER_TRANSLATED = Trim(getTrans(stdTypeName, "", 2) & Replace(stdTypeDev, "_", " ") & stdNumber)
    End If


End Property


'/******************************************************************************
Public Function setStdType(ByVal sTypeName As String, Optional bAddIfNotExist As Boolean = False) As Boolean
'/******************************************************************************
    
    On Error GoTo setStdType_ERR
    
    
    setStdType = False
    
    Dim s As String
    s = UCase(sTypeName)
    
    Dim RS As New ADODB.Recordset
    RS.Open "select * from standardtype where stdTypeName = '" & s & "'", cn_srtm, adOpenForwardOnly, adLockOptimistic
    
    If RS.EOF Then
        If bAddIfNotExist Then
            RS.NextRecordset
            RS.Open "select top 1 * from standardtype order by stdTypeID desc"
            RS.AddNew
            RS.fields("stdTypeName").Value = s
            RS.Update
            RS.Requery
        Else
            RS.Close
            Set RS = Nothing
            Exit Function
        End If
    End If
    
    RS.MoveFirst
    stdTypeID = RS.fields("stdTypeID").Value
    stdTypeName = s
'    stdFullNumber = FULLNUMBER
    
    RS.Close
    Set RS = Nothing
    
    
    setStdType = True
    
    Exit Function
    
setStdType_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setStdType - Error"
    
End Function


Public Function setStdTypeID(ID As Long) As Boolean
    
    setStdTypeID = False
    
    If ID = stdTypeID Then
        setStdTypeID = True
        Exit Function
    End If
    
    
    Dim RS As New ADODB.Recordset
    If bUseCursorClient Then RS.CursorLocation = adUseClient
    RS.Open "select * from standardtype where stdTypeID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        RS.MoveFirst
        stdTypeID = ID
        stdTypeName = RS.fields("stdTypeName").Value & ""
        stdTypeDev = RS.fields("stdTypeDevision").Value & ""
        bChanged = True
        setStdTypeID = True
        
'        stdFullNumber = FULLNUMBER
        
    End If
    
    RS.Close
    Set RS = Nothing
    
    
    
    
    
    
    
End Function



'/******************************************************************************
Public Function setStdID(ByVal vID As Long, Optional ByRef RSS As ADODB.Recordset = Nothing) As Boolean
'/******************************************************************************

    On Error GoTo setStdID_ERR
    
    Dim RS As ADODB.Recordset

    If RSS Is Nothing Then
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        RS.Open "select * from view_standard where stdID = " & vID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RS.EOF Then RS.MoveFirst
    Else
        Set RS = RSS
    End If


    If RS.EOF Then
        stdID = 0
        Exit Function
    End If
    
    
    
    stdID = vID
    stdNumber = RS.fields("stdNumber").Value
    stdNumberAlt = getFieldStringValue(RS, "stdNumberAlt", stdNumber)
    stdTypeName = RS.fields("stdTypeName").Value
    stdTypeID = RS.fields("stdTypeID").Value
    stdName = RS.fields("stdName").Value
    stdTypeDev = RS.fields("stdTypeDevision").Value & ""
    
    If Len(Trim(stdNumberAlt)) = 0 Then stdNumberAlt = stdNumber
    
'    stdFullNumber = FULLNUMBER
    
    If RSS Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If
    
    
    setStdID = True


Exit Function

setStdID_ERR:
    If RSS Is Nothing Then Set RS = Nothing

End Function

'/******************************************************************************
Public Function setNumber(sNumber As String) As Boolean
'/******************************************************************************

    On Error GoTo setNumber_ERR
    
    stdNumber = sNumber
    
'    stdFullNumber = FULLNUMBER
    
    bChanged = True
    
    


    setNumber = True
Exit Function

setNumber_ERR:
    setNumber = False

End Function



'/******************************************************************************
Public Function setByNumber(sTypeName As String, sNumber As String) As Boolean
'/******************************************************************************
    
    On Error GoTo setByNumber_ERR
    
    
    
    Dim RS As New ADODB.Recordset
    If bUseCursorClient Then RS.CursorLocation = adUseClient
    RS.Open "select * from view_standard where stdTypeName = '" & sTypeName & "' and stdNumber = '" & sNumber & "'", cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    If RS.EOF Then
        
        If InStr(sNumber, "*") > 0 Then
            sNumber = Replace(sNumber, "*", "")
        Else
            sNumber = sNumber & "*"
        End If
        
        RS.Close
        RS.Open "select * from view_standard where stdTypeName = '" & sTypeName & "' and stdNumber = '" & sNumber & "'", cn_srtm, adOpenForwardOnly, adLockReadOnly
        
        If RS.EOF Then
            stdID = 0
            stdTypeID = 0
            stdNumber = ""
            stdTypeName = ""
'            stdFullNumber = FULLNUMBER
            setByNumber = False
            Exit Function
        End If
    End If
    
    RS.MoveFirst
    
    stdID = RS.fields("stdID").Value
    stdNumber = RS.fields("stdNumber").Value
    stdNumberAlt = getFieldStringValue(RS, "stdNumberAlt", stdNumber)
    stdName = RS.fields("stdName").Value
    stdTypeName = RS.fields("stdTypeName").Value
    stdTypeID = RS.fields("stdTypeID").Value
    stdTypeDev = RS.fields("stdTypeDevision").Value & ""
    
    If Len(Trim(stdNumberAlt)) = 0 Then stdNumberAlt = stdNumber
    
'    stdFullNumber = Trim(RS.Fields("stdFullNumber").Value)
'    stdFullNumber = FULLNUMBER
    
    bChanged = True
    
    setByNumber = True
    
    RS.Close
    Set RS = Nothing
    
    Exit Function
    
setByNumber_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setByNumber - Error"
    
End Function


'/******************************************************************************
Public Function save(ByRef bVarOutStdExist As Boolean) As Boolean
'/******************************************************************************
    
    On Error GoTo save_ERR
    
    save = False
    
    If stdTypeID = 0 Then Exit Function
    If Len(Trim(Me.stdNumber)) = 0 Then Exit Function
    
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from standard where stdID = " & stdID, cn_srtm, adOpenForwardOnly, adLockOptimistic
    
    '    flds(0) = "stdTypeID"
    '    flds(1) = "stdNumber"
    '    flds(2) = "stdName"
    
    vls(0) = stdTypeID
    vls(1) = stdNumber
    vls(2) = stdName
    
    If RS.EOF Then
        bVarOutStdExist = False
        RS.NextRecordset
        RS.Open "select top 1 * from standard order by stdID desc", cn_srtm, adOpenForwardOnly, adLockOptimistic
        RS.AddNew flds, vls
        RS.Update
        RS.Requery
        RS.MoveFirst
        stdID = RS.fields("stdID").Value
        writeOperationS operCreate, "standard", stdID, "создание"
    Else
        bVarOutStdExist = True
        RS.MoveFirst
        RS.Update flds, vls
        writeOperationS operModify, "standard", stdID, "сохранение"
    End If
    
    RS.Close
    Set RS = Nothing
    
    bChanged = False
    save = True
    
    Exit Function
    
save_ERR:
    save = False
    
End Function

Private Sub Class_Initialize()


    ReDim flds(0 To 2)
    ReDim vls(0 To 2)
    
    flds(0) = "stdTypeID"
    flds(1) = "stdNumber"
    flds(2) = "stdName"
    
    bChanged = False

End Sub

Private Sub Class_Terminate()
'

End Sub
