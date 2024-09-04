VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsMC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public calcs As Collection

Public mcID As Long
Public mcName As String
Public mcTable As String
Public mcDescr As String
Public mcSign As String
Public calcID As Long

Public mc_props As colProp

Public bSpecQty As Boolean
Public bSpecUMass As Boolean
Public bSpecCMass As Boolean


Public Function loadChildren() As Boolean
    
    Dim mc As clsMC
    
    
    Dim I As Integer
    
    
    For I = 1 To globMassCalcs.Count
        
        Set mc = globMassCalcs(I)
        
        If mc.calcID = mcID And mcID > 0 Then
        
            If calcs Is Nothing Then Set calcs = New Collection
            
            calcs.Add mc, CStr(mc.mcID)
            
        End If
        
        
    Next I
    
    
End Function


'/******************************************************************************
Public Function copy(ByRef mc As clsMC) As Boolean
'/******************************************************************************
    
    On Error GoTo copy_ERR
    
    mcID = mc.mcID
    mcName = mc.mcName
    mcTable = mc.mcTable
    mcDescr = mc.mcDescr
    mcSign = mc.mcSign
    calcID = mc.calcID
    
    bSpecQty = mc.bSpecQty
    bSpecUMass = mc.bSpecUMass
    bSpecCMass = mc.bSpecCMass
    
    
    
    Exit Function
    
copy_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, " - Error"
    
End Function


'/******************************************************************************
Public Property Get MC_PRNT() As clsMC
'/******************************************************************************

    On Error GoTo MC_PRNT_ERR
    
    If calcID = 0 Then
        Set MC_PRNT = Nothing
    Else
        Set MC_PRNT = globMassCalcs(CStr(calcID))
    End If


Exit Property

MC_PRNT_ERR:

    Set MC_PRNT = Nothing

End Property

'/******************************************************************************
Public Function loadMassCalcProps() As Boolean
'/******************************************************************************

    On Error GoTo loadMassCalcProps_ERR


    Dim RS As New ADODB.Recordset
    Dim s As String
    
    Set mc_props = New colProp

    If bUseCursorClient Then RS.CursorLocation = adUseClient
    RS.Open "select * from r_masscalc_property where mcID = " & mcID, cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            Dim prop As New clsProp
            prop.loadByPropID RS.Fields("propID").Value
            prop.bMassCalc = True
            
            mc_props.AddNewProp prop
            
            Set prop = Nothing
            
            RS.MoveNext
        Loop Until RS.EOF
        
    End If
    
    
    RS.Close
    Set RS = Nothing
    
    loadMassCalcProps = True


Exit Function

loadMassCalcProps_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadMassCalcProps - Error"

End Function



'/******************************************************************************
Public Function loadMassCalc(RSfrom As ADODB.Recordset, ID As Long) As Boolean
'/******************************************************************************

    On Error GoTo loadMassCalcs_ERR

    Dim RS As ADODB.Recordset

    If RSfrom Is Nothing Then
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        RS.Open "select * from masscalc where mcID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RS.EOF Then RS.MoveFirst
    Else
        Set RS = RSfrom
    End If
    
    If Not RS.EOF Then
        
        mcID = ID
        mcName = RS.Fields("mcName").Value & ""
        mcTable = RS.Fields("mcTable").Value & ""
        mcDescr = RS.Fields("mcDescription").Value & ""
        mcSign = RS.Fields("mcSign").Value & ""
        calcID = RS.Fields("calcID").Value
        
        bSpecQty = RS.Fields("specQty").Value
        bSpecUMass = RS.Fields("specUMass").Value
        bSpecCMass = RS.Fields("specCMass").Value

    End If
    
    
    If RSfrom Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If


    loadMassCalc = True

Exit Function

loadMassCalcs_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadMassCalcs - Error"

End Function



Private Sub Class_Initialize()

Set mc_props = New colProp

End Sub

Private Sub Class_Terminate()
Set mc_props = Nothing

End Sub


'/******************************************************************************
Public Function existChildMC(mcIDver As Long) As Boolean
'/******************************************************************************

    On Error GoTo existChildMC_ERR
    
    Dim mcc As clsMC
    
    Set mcc = globMassCalcs(CStr(mcIDver))
    
    If mcc.calcID = 0 Then
        If mcc.mcID = mcIDver Then existChildMC = True
        Exit Function
    End If
    
    Set mcc = mcc.MC_PRNT.calcs(CStr(mcIDver))
    
    existChildMC = True

Exit Function

existChildMC_ERR:

End Function
