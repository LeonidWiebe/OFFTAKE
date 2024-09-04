VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDocSetSign"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public dssID As Long
Public dssSymbol As String
Public dssDataType As datatype
Public dssNumChars As Integer
Public dssTable As String
Public dssField As String

Public cCol As Collection


'/******************************************************************************
Public Function loadDSS(RSfrom As ADODB.Recordset, ID As Long) As Boolean
'/******************************************************************************

    On Error GoTo loadMat_ERR

    Dim RS As ADODB.Recordset

    If RSfrom Is Nothing Then
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        RS.Open "select * from docsetsign where dssID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RS.EOF Then RS.MoveFirst
    Else
        Set RS = RSfrom
    End If
    
    If Not RS.EOF Then
        
        dssID = RS.Fields("dssID").Value
        dssSymbol = RS.Fields("dssSymbol").Value
        dssDataType = RS.Fields("dssDataType").Value
        dssNumChars = RS.Fields("dssChars").Value
        dssTable = RS.Fields("dssTable").Value & ""
        dssField = RS.Fields("dssField").Value & ""
        
    End If
    
    
    If RSfrom Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If

    loadDSS = True


Exit Function

loadMat_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadDSS - Error"

End Function

Private Sub Class_Initialize()
    Set cCol = New Collection
End Sub

Private Sub Class_Terminate()
    Set cCol = Nothing
End Sub
