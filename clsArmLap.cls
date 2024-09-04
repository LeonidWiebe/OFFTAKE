VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsArmLap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Member0" ,"colArmLap"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public lapID As Long
Public projectID As Long
Public betonID As Long
Public classID As Long
Public diameter As Integer
Public maxlen As Double

Public lapValue As Integer

'/******************************************************************************
Public Property Get KEY() As String
'/******************************************************************************

    On Error GoTo KEY_ERR
    
    Dim strRet As String

    strRet = Format(projectID, "000")
    
    strRet = strRet & "." & Format(betonID, "000")
    
    strRet = strRet & "." & Format(classID, "000")

    strRet = strRet & "." & Format(diameter, "000")

    
    KEY = strRet


Exit Property

KEY_ERR:
    KEY = "000-000-000-000"

End Property



'/******************************************************************************
Public Function loadLap(RSfrom As ADODB.Recordset, Optional ID As Long = 0) As Boolean
'/******************************************************************************

    On Error GoTo loadLap_ERR


    Dim RS As ADODB.Recordset

    If RSfrom Is Nothing Then
        Set RS = New ADODB.Recordset
        RS.CursorLocation = adUseClient
        RS.Open "select * from rein_laps where lapID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RS.EOF Then RS.MoveFirst
    Else
        Set RS = RSfrom
    End If
    
    If Not RS.EOF Then
        
        lapID = RS.Fields("lapID").Value
        projectID = RS.Fields("projectID").Value
        betonID = RS.Fields("betonID").Value
        classID = RS.Fields("armclassID").Value
        diameter = RS.Fields("diameter").Value
        lapValue = RS.Fields("lapValue").Value
        maxlen = RS.Fields("maxlen").Value
        

    End If
    
    If maxlen = 0# Then maxlen = cstMaxBarLength
    
    If RSfrom Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If


    loadLap = True


Exit Function

loadLap_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, " - Error"

End Function




