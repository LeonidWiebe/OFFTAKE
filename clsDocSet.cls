VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDocSet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public docsetID As Long
Public dsetType As dstype
Public docsetNumber As String
Public objID As Long
Public objectID As Long

Public docsetLevel As Integer ' -1, 0, 1 - подземная, не опр., надземная

'Public docsetNum As Integer

'/******************************************************************************
Public Sub setCatID(ID As Long)
'/******************************************************************************

    On Error GoTo setCatID_ERR
    
    objectID = ID
    objID = objs("catalog")

Exit Sub

setCatID_ERR:

End Sub


'/******************************************************************************
Public Sub setPartID(ID As Long)
'/******************************************************************************

    On Error GoTo setCatID_ERR
    
    objectID = ID
    objID = objs("part")

Exit Sub

setCatID_ERR:

End Sub


'/******************************************************************************
Public Function loadDocSet(RSfrom As ADODB.Recordset, ID As Long) As Boolean
'/******************************************************************************

    On Error GoTo loadMat_ERR

    Dim RS As ADODB.Recordset

    If RSfrom Is Nothing Then
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        RS.Open "select * from docset where dsID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RS.EOF Then RS.MoveFirst
    Else
        Set RS = RSfrom
    End If
    
    If Not RS.EOF Then
        
        docsetID = RS.fields("dsID").Value
        dsetType = RS.fields("dsTypeID").Value
        docsetNumber = RS.fields("dsNumber").Value
        If IsNull(RS.fields("dsLevel").Value) Then
            docsetLevel = 0
        Else
            docsetLevel = RS.fields("dsLevel").Value
        End If
        
'        docsetNum = RS.Fields("dsNum").Value
        
        loadDocSet = True
        
    End If
    
    
    If RSfrom Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If

    


Exit Function

loadMat_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadDocSet - Error"

End Function




