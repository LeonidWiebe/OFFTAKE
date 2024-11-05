VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsPartType"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit


   Public ptID As Long
   Public ptName As String
'   Public specID As Long
   Public sortKey As String
   Public ptpdsID As Long
   Public ptsketch As String

Public ptsets As Collection



'/******************************************************************************
Public Function loadPartType(ID As Long, Optional RSout As ADODB.Recordset = Nothing) As Boolean
'/******************************************************************************
    
    On Error GoTo loadPartDef_ERR
    
    Dim RS As ADODB.Recordset
    
    If Not RSout Is Nothing Then
        Set RS = RSout
    Else
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        RS.Open "select * from parttype where typeID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RS.EOF Then RS.MoveFirst
    End If
    
    
    
    
    If Not RS.EOF Then
        
        ptID = RS.fields("typeID").Value
        ptName = RS.fields("typeName").Value & ""
'        specID = RS.Fields("specID").Value
        sortKey = Format(RS.fields("sortID").Value, "00000") & Format(RS.fields("typeID").Value, "00000")
        ptpdsID = getFieldLongValue(RS, "pdsID", 0)
        ptsketch = getFieldStringValue(RS, "partsketch", "")
        
    End If
    
    
    If RSout Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If
    
    
    Me.loadPtDSets
    
    loadPartType = True
    
    
    Exit Function
    
loadPartDef_ERR:
    Set frmSps = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadPartType - Error"
    '    Resume Next
    
End Function







Private Sub Class_Initialize()

    
    Set ptsets = New Collection
    

End Sub

Private Sub Class_Terminate()
    
    Set ptsets = Nothing

End Sub

'/******************************************************************************
Public Sub loadPtDSets()
'/******************************************************************************

    On Error GoTo loadPDSets_ERR

    Set ptsets = New Collection
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from r_pdset_parttype where ptID = " & Me.ptID, cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            Dim pds As New clsPDSet
            pds.relID = RS.fields("relID").Value
            pds.pdsID = RS.fields("pdsID").Value
            pds.pdID = RS.fields("ptID").Value
            pds.pdsNameAlt = RS.fields("relNameAlt").Value & ""
            
            ptsets.Add pds, CStr(pds.relID)
            
            Set pds = Nothing
            
            RS.MoveNext
        Loop Until RS.EOF
    
    
    End If
    
    
    RS.Close
    Set RS = Nothing


Exit Sub

loadPDSets_ERR:
    Set RS = Nothing
    Set ptsets = New Collection
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadPDSets - Error"

End Sub

'/******************************************************************************
Public Property Get PartType_NAME() As String
'/******************************************************************************

    On Error GoTo PD_NAME_ERR
    
    Dim pds As clsPDSet
    Dim strPdsName As String
    
    strPdsName = ptName
    
    For Each pds In ptsets
        If usrCurrent.pdsID = pds.pdsID And Len(pds.pdsNameAlt) > 0 Then
            strPdsName = pds.pdsNameAlt
        End If
    Next pds
    
    PartType_NAME = strPdsName

Exit Property

PD_NAME_ERR:
PartType_NAME = ptName

End Property

