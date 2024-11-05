VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsStdPd"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public stdpdID As Long
'Public std As clsStd
'Public pd As clsPD
Public stdID As Long
Public pdID As Long

Public bUseDrawSgn As Boolean

Public mcID As Long

Public bUsing As Boolean

Public pdNameAlt As String

Public iStdPdMassLevel As Integer

Public spdsets As Collection


'/******************************************************************************
Public Sub loadStdPdSets()
'/******************************************************************************

    On Error GoTo loadStdPdSets_ERR

    Set spdsets = New Collection
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from r_stdpd_pdset where stdpdID = " & Me.stdpdID, cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            Dim pds As New clsPDSet
            pds.relID = RS.Fields("relID").Value
            pds.pdsID = RS.Fields("pdsID").Value
            pds.pdID = RS.Fields("stdpdID").Value
'            pds.pdsNameAlt = RS.Fields("relNameAlt").Value & ""
            
            spdsets.Add pds, CStr(pds.relID)
            
            Set pds = Nothing
            
            RS.MoveNext
        Loop Until RS.EOF
    
    
    End If
    
    
    RS.Close
    Set RS = Nothing


Exit Sub

loadStdPdSets_ERR:
    Set spdsets = New Collection

End Sub


'/******************************************************************************
Public Function loadByID(ID As Long, Optional RSin As ADODB.Recordset = Nothing) As Boolean
'/******************************************************************************

    On Error GoTo loadByID_ERR

    


    Dim RS As ADODB.Recordset
    
    
    If RSin Is Nothing Then
        Set RS = New ADODB.Recordset
        RS.Open "select * from r_standard_posdef where relID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RS.EOF Then RS.MoveFirst
    Else
        Set RS = RSin
    End If
    
    
    
    If Not RS.EOF Then
        
        stdID = RS.Fields("stdID").Value
        pdID = RS.Fields("posdefID").Value
        stdpdID = RS.Fields("relID").Value
        bUsing = RS.Fields("using").Value
        pdNameAlt = RS.Fields("pdNameAlt").Value & ""
        If Not IsNull(RS.Fields("massLevel").Value) Then iStdPdMassLevel = RS.Fields("massLevel").Value
        
        If IsNull(RS.Fields("mcID").Value) Then
            Me.mcID = 0
        Else
            Me.mcID = RS.Fields("mcID").Value
        End If
        
        bUseDrawSgn = RS.Fields("useDrawSign").Value
    
    End If
    
    If RSin Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If


    Me.loadStdPdSets


    loadByID = True

Exit Function


loadByID_ERR:

End Function



'/******************************************************************************
Public Function loadByIDs(stdID As Long, pdID As Long) As Boolean
'/******************************************************************************

    On Error GoTo loadByIDs_ERR


    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from r_standard_posdef where stdID = " & stdID & " and posdefID = " & pdID, cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    If RS.EOF Then Exit Function
    
    RS.MoveFirst
        
    stdID = RS.Fields("stdID").Value
    pdID = RS.Fields("posdefID").Value
    stdpdID = RS.Fields("relID").Value
    bUsing = RS.Fields("using").Value
    pdNameAlt = RS.Fields("pdNameAlt").Value & ""
    If Not IsNull(RS.Fields("massLevel").Value) Then iStdPdMassLevel = RS.Fields("massLevel").Value
    
    If IsNull(RS.Fields("mcID").Value) Then
        Me.mcID = 0
    Else
        Me.mcID = RS.Fields("mcID").Value
    End If
    
    bUseDrawSgn = RS.Fields("useDrawSign").Value
    
    RS.Close
    Set RS = Nothing


    loadByIDs = True



Exit Function

loadByIDs_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadByIDs - Error"

End Function


'/******************************************************************************
Public Property Get SP_STD() As clsStd
'/******************************************************************************

    On Error GoTo SP_STD_ERR
    
    If stdID = 0 Then
        Set SP_STD = New clsStd
    Else
        Set SP_STD = globStds(CStr(stdID))
    End If

Exit Property

SP_STD_ERR:
    Set SP_STD = New clsStd

End Property

'/******************************************************************************
Public Property Get SP_PD() As clsPD
'/******************************************************************************

    On Error GoTo SP_STD_ERR
    
    If pdID = 0 Then
        Set SP_PD = New clsPD
    Else
        Set SP_PD = globPosdefs(CStr(pdID))
    End If

Exit Property

SP_STD_ERR:
    Set SP_PD = New clsPD

End Property

'/******************************************************************************
Private Sub Class_Initialize()
'/******************************************************************************

    Set spdsets = New Collection
    iStdPdMassLevel = -1

End Sub

Private Sub Class_Terminate()

    Set spdsets = Nothing

End Sub
