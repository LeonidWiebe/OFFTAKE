VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDocSetNum"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public dsnID As Long
Public dsnprjID As Long
Public dsndtID As dstype
Public dsnMask As String
Public dsnRegex As String
Public dsnFieldName As String

Public dsnCmnLen As Integer
Public dsnLevStart As Integer
Public dsnLevLen As Integer
Public dsnDigStart As Integer
Public dsnDigLen As Integer


'/******************************************************************************
Public Function loadDSNum(RSfrom As ADODB.Recordset, ID As Long) As Boolean
'/******************************************************************************

    On Error GoTo loadMat_ERR

    Dim RS As ADODB.Recordset

    If RSfrom Is Nothing Then
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        RS.Open "select * from docsetnumber where nmbID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RS.EOF Then RS.MoveFirst
    Else
        Set RS = RSfrom
    End If
    
    If Not RS.EOF Then
        
        dsnID = RS.fields("nmbID").Value
        dsnprjID = RS.fields("projectID").Value
        dsndtID = RS.fields("dstID").Value ' docset number type, see table docsettype
        dsnMask = RS.fields("nmbMask").Value
        dsnRegex = RS.fields("nmbRegex").Value & ""
        dsnFieldName = RS.fields("nmbFieldName").Value & "" ' field in view where docset number exist, alternative to dms_doc.[o_projectname]
        
        If Not IsNull(RS.fields("nmbCmnLen").Value) Then dsnCmnLen = RS.fields("nmbCmnLen").Value Else dsnCmnLen = 0
        If Not IsNull(RS.fields("nmbLevStart").Value) Then dsnLevStart = RS.fields("nmbLevStart").Value Else dsnLevStart = 0
        If Not IsNull(RS.fields("nmbLevLen").Value) Then dsnLevLen = RS.fields("nmbLevLen").Value Else dsnLevLen = 0
        If Not IsNull(RS.fields("nmbDigStart").Value) Then dsnDigStart = RS.fields("nmbDigStart").Value Else dsnDigStart = 0
        If Not IsNull(RS.fields("nmbDigLen").Value) Then dsnDigLen = RS.fields("nmbDigLen").Value Else dsnDigLen = 0
        
    End If
    
    
    If RSfrom Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If

    loadDSNum = True


Exit Function

loadMat_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadDSNum - Error"

End Function

