VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsMU"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public children As Collection

Public muID As Long
Public muName As String
Public muShortName As String
Public muSiK As Double
Public parentID As Long
Public muSpecName As String

'/******************************************************************************
Public Property Get MU_PRNT() As clsMU
'/******************************************************************************

    On Error GoTo MU_PRNT_ERR

    If parentID > 0 Then
        Set MU_PRNT = Nothing
    Else
        Set MU_PRNT = globMUnits(CStr(parentID))
    End If
    
Exit Property

MU_PRNT_ERR:
    Set MU_PRNT = Nothing

End Property


'/******************************************************************************
Public Function loadMUnits(RSfrom As ADODB.Recordset, ID As Long) As Boolean
'/******************************************************************************

    On Error GoTo loadMUnits_ERR

    Dim RS As ADODB.Recordset

    If RSfrom Is Nothing Then
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        RS.Open "select * from measureunit where muID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RS.EOF Then RS.MoveFirst
    Else
        Set RS = RSfrom
    End If
    
    If Not RS.EOF Then
        
        muID = ID
        muName = RS.Fields("muName").Value & ""
        muShortName = RS.Fields("muShortName").Value & ""
        muSiK = RS.Fields("muSiK").Value
        parentID = Val(RS.Fields("muParentID").Value & "")
        muSpecName = RS.Fields("muSpecName").Value & ""
        
        If Len(muSpecName) = 0 Then muSpecName = muShortName

    End If
    
    
    If RSfrom Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If
    
    loadMUnits = True


Exit Function

loadMUnits_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, " - Error"

End Function



Public Function loadChildren() As Boolean
    
    Dim mu As clsMU
    
    Dim I As Integer
    
    For I = 1 To globMUnits.Count
        
        Set mu = globMUnits(I)
        
        If mu.parentID = muID Then
        
            If children Is Nothing Then Set children = New Collection
            
            children.Add mu, CStr(mu.muID)
            
        End If
        
        
    Next I
    
    loadChildren = True
    
    
End Function



