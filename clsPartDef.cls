VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsPartDef"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

   Public partdefID As Long
   Public partdefName As String
   Public partdefNameMulti As String
   Public bUsePositions As Boolean
   Public parentID As Long
   Public partdefSort As Integer
   Public partdefKksDiv As String
   Public pdpdsID As Long


Public prdsets As Collection



'/******************************************************************************
Public Function loadPartDef(ID As Long, Optional RSout As ADODB.Recordset = Nothing) As Boolean
'/******************************************************************************

    On Error GoTo loadPartDef_ERR

    Dim RS As ADODB.Recordset

    If Not RSout Is Nothing Then
        Set RS = RSout
    Else
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        RS.Open "select * from partdef where partdefID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RS.EOF Then RS.MoveFirst
    End If


    
    
    If Not RS.EOF Then
        
        partdefID = RS.Fields("partdefID").Value
        partdefName = RS.Fields("partdefName").Value & ""
        partdefNameMulti = RS.Fields("partdefNameMulti").Value & ""
        bUsePositions = RS.Fields("partdefUsePositions").Value
        parentID = RS.Fields("parentID").Value
        partdefSort = RS.Fields("partdefSort").Value
        partdefKksDiv = getFieldStringValue(RS, "kksDiv", "")
        pdpdsID = getFieldLongValue(RS, "pdsID", 0)
        
    End If
    
    
    If RSout Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If
    
    
    Me.loadPrDSets
    
    loadPartDef = True


Exit Function

loadPartDef_ERR:
    Set frmSps = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadPartDef - Error"
'    Resume Next

End Function







Private Sub Class_Initialize()

    
    Set prdsets = New Collection
    

End Sub

Private Sub Class_Terminate()
    
    Set prdsets = Nothing

End Sub

'/******************************************************************************
Public Sub loadPrDSets()
'/******************************************************************************

    On Error GoTo loadPDSets_ERR

    Set prdsets = New Collection
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from r_pdset_partdef where partdefID = " & Me.partdefID, cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            Dim pds As New clsPDSet
            pds.relID = RS.Fields("relID").Value
            pds.pdsID = RS.Fields("pdsID").Value
            pds.pdID = RS.Fields("partdefID").Value
            pds.pdsNameAlt = RS.Fields("relNameAlt").Value & ""
            
            prdsets.Add pds, CStr(pds.relID)
            
            Set pds = Nothing
            
            RS.MoveNext
        Loop Until RS.EOF
    
    
    End If
    
    
    RS.Close
    Set RS = Nothing


Exit Sub

loadPDSets_ERR:
    Set RS = Nothing
    Set prdsets = New Collection
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadPDSets - Error"

End Sub

'/******************************************************************************
Public Property Get PartDef_NAME() As String
'/******************************************************************************

    On Error GoTo PD_NAME_ERR
    
    Dim pds As clsPDSet
    Dim strPdsName As String
    
    strPdsName = partdefName
    
    For Each pds In prdsets
        If usrCurrent.pdsID = pds.pdsID And Len(pds.pdsNameAlt) > 0 Then
            strPdsName = pds.pdsNameAlt
        End If
    Next pds
    
    PartDef_NAME = strPdsName

Exit Property

PD_NAME_ERR:
PartDef_NAME = partdefName

End Property

