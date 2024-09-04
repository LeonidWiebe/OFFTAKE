VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "colPartType"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Collection" ,"clsPartType"
Attribute VB_Ext_KEY = "Member0" ,"clsPartType"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'local variable to hold collection
Private mCol As Collection

Public Function AddPartType(pd As clsPartType, Optional sKey As String = "", Optional bNothing As Boolean = True) As Boolean
    
    If Not pd Is Nothing Then
    
        If Len(sKey) = 0 Then
            mCol.Add pd
        Else
            mCol.Add pd, sKey
        End If
        
        If bNothing Then Set pd = Nothing
    
    End If
    
    AddPartType = True

End Function


Public Property Get Item(IndexKey As Variant) As clsPartType
Attribute Item.VB_UserMemId = 0
  
  
    On Error GoTo Item_ERR
    
    
    Dim pd As clsPartType
    
    If typeName(IndexKey) = "String" Then
        If Not exists(Val(IndexKey)) Then
            Set pd = New clsPartType
            pd.loadPartType Val(IndexKey)
            mCol.Add pd, IndexKey
            Set pd = Nothing
        End If
    End If
    
    Set Item = mCol(Trim(IndexKey))
    
    
    Exit Property
    
Item_ERR:
    Set Item = New clsPartType
  
  
  
  
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


Public Function exists(pdID As Long) As Boolean

    On Error GoTo existsProperty_ERR


    Dim p As clsPartType
    
    Set p = mCol(CStr(pdID))

    exists = True

Exit Function

existsProperty_ERR:

    exists = False

End Function
