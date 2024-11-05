VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "colDocSets"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Collection" ,"clsDocSet"
Attribute VB_Ext_KEY = "Member0" ,"clsDocSet"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'local variable to hold collection
Private mCol As Collection

Public Sub Add(ds As clsDocSet, Optional sKey As String)
    
    If Len(sKey) = 0 Then
        mCol.Add ds
    Else
        mCol.Add ds, sKey
    End If



End Sub

'/******************************************************************************
Public Property Get Item(vntIndexKey As Variant) As clsDocSet
Attribute Item.VB_UserMemId = 0
'/******************************************************************************

    On Error GoTo Item_ERR

  Set Item = mCol(vntIndexKey)
Exit Property

Item_ERR:
    Dim ds As New clsDocSet
    If ds.loadDocSet(Nothing, Val(vntIndexKey)) Then
        globDocSets.Add ds, CStr(ds.docsetID)
        Set ds = Nothing
        Set Item = mCol(vntIndexKey)
    Else
        Set Item = ds
    End If

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

