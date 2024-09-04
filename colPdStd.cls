VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "colStdPd"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Collection" ,"clsStdPd"
Attribute VB_Ext_KEY = "Member0" ,"clsStdPd"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'local variable to hold collection
Private mCol As Collection


'Public sp_srtm As colSrtm ' не исп., создать для исп. в F2 (сортамент - в память)


Public Property Get Item(IndexKey As Variant) As clsStdPd
Attribute Item.VB_UserMemId = 0
  
  
    On Error GoTo Item_ERR
    
    
    Dim s As clsStdPd
    
    If typeName(IndexKey) = "String" Then
        If Not exists(Val(IndexKey)) Then
            Set s = New clsStdPd
            If s.loadByID(Val(IndexKey)) Then mCol.Add s, IndexKey
            Set s = Nothing
        End If
    End If
    
    Set Item = mCol(Trim(IndexKey))
            
            
    Exit Property
    
Item_ERR:

    Set Item = New clsStdPd
  
  
  
End Property



Public Property Get Count() As Long
    Count = mCol.Count
End Property


Public Sub Remove(vntIndexKey As Variant)
    mCol.Remove vntIndexKey
End Sub


Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
    Set NewEnum = mCol.[_NewEnum]
End Property


Private Sub Class_Initialize()
    Set mCol = New Collection
End Sub


Private Sub Class_Terminate()
    Set mCol = Nothing
End Sub

Public Function exists(ID As Long) As Boolean

    On Error GoTo existsProperty_ERR


    Dim p As clsStdPd
    
    Set p = mCol(CStr(ID))

    exists = True

Exit Function

existsProperty_ERR:

    exists = False

End Function




Public Function AddStdPd(st As clsStdPd, Optional sKey As String = "") As Boolean
    
    If Not st Is Nothing Then
    
        If Len(sKey) = 0 Then
            mCol.Add st
        Else
            mCol.Add st, sKey
        End If
    
    End If
    
    AddStdPd = True

End Function

'/******************************************************************************
Public Function fromIDs(stdID As Long, pdID As Long) As clsStdPd
'/******************************************************************************

    On Error GoTo fromIDs_ERR

    If stdID = 0 Or pdID = 0 Then
        fromIDs = Nothing
        Exit Function
    End If

    Dim std As clsStd
    Dim pd As clsPD
    
    Set std = globStds(CStr(stdID))
    Set pd = globPosdefs(CStr(pdID))
    
    Set fromIDs = fromStdAndPD(std, pd)
    

Exit Function

fromIDs_ERR:
    Set fromIDs = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "fromIDs - Error"

End Function




'/******************************************************************************
Public Function fromStdAndPD(s As clsStd, p As clsPD) As clsStdPd
'/******************************************************************************
    
    On Error GoTo fromStdAndPD_ERR
    
    
    If s Is Nothing Or p Is Nothing Then
        fromStdAndPD = Nothing
        Exit Function
    End If
    
    
    Dim stdpd As clsStdPd
    
    For Each stdpd In Me
        
        If s.stdID = stdpd.SP_STD.stdID And p.pdID = stdpd.SP_PD.pdID Then
            
            Set fromStdAndPD = stdpd
            Exit Function
            
        End If
        
    Next stdpd
    
    
    
    ' не найден, пробуем загрузить
    
    
    Set stdpd = New clsStdPd
    
    If stdpd.loadByIDs(s.stdID, p.pdID) Then
        Me.AddStdPd stdpd, CStr(stdpd.stdpdID)
        Set fromStdAndPD = Me(CStr(stdpd.stdpdID))
    Else
        Set fromStdAndPD = Nothing
    End If
    
    Set stdpd = Nothing
    
    
    
    
    Exit Function
    
fromStdAndPD_ERR:
    Set fromStdAndPD = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "fromStdAndPD - Error"
    
End Function
