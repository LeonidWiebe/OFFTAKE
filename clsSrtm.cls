VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSrtm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'Public stdpd As clsStdPd

Public stdpdID As Long

Public srtmName As String
Public srtmID As Long
Public bUsing As Boolean

Public srtm_props As colProp

Public bNew As Boolean



Private Sub Class_Initialize()

    Set srtm_props = New colProp

End Sub

Private Sub Class_Terminate()

    Set srtm_props = Nothing
End Sub



'/******************************************************************************
Public Function saveSrtm(Optional strOper As String = "") As Boolean
'/******************************************************************************
    
    On Error GoTo save_ERR
    
    If stdpdID = 0 Then Exit Function
    
    If Len(Trim(srtmName)) = 0 Then Exit Function
    
    bNew = False
    
    If Len(strOper) = 0 Then strOper = "сохранение"
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from sortament where srtmID = " & srtmID, cn_srtm, adOpenStatic, adLockOptimistic
    
    If RS.EOF Then
        RS.NextRecordset
        RS.Open "select top 1 * from sortament order by srtmID desc", cn_srtm, adOpenStatic, adLockOptimistic
        RS.AddNew
        RS.Fields("srtmName").Value = srtmName
        RS.Fields("stdposdefID").Value = stdpdID
        RS.Fields("srtmUsing").Value = bUsing
        RS.Update
        RS.Requery
        RS.MoveFirst
        srtmID = RS.Fields("srtmID").Value
        bNew = True
        Call writeOperationS(operCreate, "srtm", srtmID)
    Else
        RS.MoveFirst
        RS.Fields("srtmName").Value = srtmName
        RS.Fields("stdposdefID").Value = stdpdID
        RS.Fields("srtmUsing").Value = bUsing
        RS.Update
        Call writeOperationS(operModify, "srtm", srtmID, strOper)
    End If
    
    globSrtm(CStr(srtmID)).bUsing = bUsing
    globSrtm(CStr(srtmID)).srtmID = srtmID
    globSrtm(CStr(srtmID)).srtmName = srtmName
    globSrtm(CStr(srtmID)).stdpdID = stdpdID
    
    
    saveSrtm = True
    
    Exit Function
    
save_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "saveSrtm - Error"
    
End Function



'/******************************************************************************
Public Function loadSrtm(RSfrom As ADODB.Recordset, ID As Long) As Boolean
'/******************************************************************************

    On Error GoTo loadSrtmByIDv2_ERR

    Dim RS As ADODB.Recordset

    If RSfrom Is Nothing Then
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        RS.Open "select * from sortament where srtmID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RS.EOF Then RS.MoveFirst
    Else
        Set RS = RSfrom
    End If
    
    If Not RS.EOF Then
        
        stdpdID = RS.Fields("stdposdefID").Value
        srtmID = RS.Fields("srtmID").Value
        srtmName = RS.Fields("srtmName").Value
        bUsing = CBool(RS.Fields("srtmUsing").Value)

    End If
    
    
    If RSfrom Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If
    
    loadSrtm = True
    

Exit Function

loadSrtmByIDv2_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadSrtm - Error"

End Function



'/******************************************************************************
Public Function loadSrtmProps(Optional RSfrom As ADODB.Recordset = Nothing) As Boolean
'/******************************************************************************

    On Error GoTo loadSrtmProps_ERR

    Set srtm_props = New colProp
    
    Dim I As Integer
    
    Dim RS As ADODB.Recordset
    Dim s As String

    If RSfrom Is Nothing Then
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        RS.Open "select * from r_sortament_property where srtmID = " & srtmID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RS.EOF Then RS.MoveFirst
    Else
        Set RS = RSfrom
    End If
    
    
    If Not RS.EOF Then
        
        For I = 0 To RS.Fields.Count - 1
            s = RS.Fields(I).NAME & ""
            If Not (LCase(left(s, 4)) = "srtm" Or LCase(right(s, 2)) = "id") Then ' пропускаем все ID и свойства "srtmName" и т.п.
                If Not IsNull(RS.Fields(I).Value) Then
                    Dim prop As clsProp
                    Set prop = srtm_props.AddByPropName(s, Nothing, True)
                    prop.setValue RS.Fields(I).Value
                    Set prop = Nothing
                End If
            End If
        Next I


    End If
    
    
    If RSfrom Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If
    
    loadSrtmProps = True



Exit Function

loadSrtmProps_ERR:
    Set frmSps = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadSrtmProps - Error"

End Function


'/******************************************************************************
Public Property Get SRTM_STDPD() As clsStdPd
'/******************************************************************************

    On Error GoTo SRTM_STDPD_ERR
    
    If stdpdID = 0 Then
        Set SRTM_STDPD = New clsStdPd
    Else
        Set SRTM_STDPD = globStdPosdefs(CStr(stdpdID))
    End If
    

Exit Property

SRTM_STDPD_ERR:
Set SRTM_STDPD = New clsStdPd

End Property
