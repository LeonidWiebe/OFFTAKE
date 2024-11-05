VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "colSrtm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "Top_Level" ,"No"
Attribute VB_Ext_KEY = "Collection" ,"clsSrtm"
Attribute VB_Ext_KEY = "Member0" ,"clsSrtm"
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Option Explicit

'local variable to hold collection
Private mCol As Collection

'/******************************************************************************
Public Function exists(srtmID As Long) As Boolean
'/******************************************************************************

    On Error GoTo existsProperty_ERR


    Dim p As clsSrtm
    
    Set p = mCol(CStr(srtmID))

    exists = True

Exit Function

existsProperty_ERR:

    exists = False

End Function



Public Function AddSimple(sm As clsSrtm, Optional sKey As String = "") As clsSrtm
    
    
    If Len(sKey) = 0 Then
        mCol.Add sm
    Else
        mCol.Add sm, sKey
    End If
    
    
    Set AddSimple = sm


End Function



'/******************************************************************************
Public Property Get Item(IndexKey As Variant) As clsSrtm
Attribute Item.VB_UserMemId = 0
'/******************************************************************************
    
    On Error GoTo Item_ERR
    
    
    Dim s As clsSrtm
    
    If typeName(IndexKey) = "String" Then
        If Not exists(Val(IndexKey)) Then
            Set s = New clsSrtm
            Dim ID As Long
            ID = Val(IndexKey)
            If s.loadSrtm(Nothing, ID) Then
                s.loadSrtmProps
                mCol.Add s, IndexKey
            End If
            Set s = Nothing
        End If
    End If
    
    Set Item = mCol(Trim(IndexKey))
    
    
    
    Exit Property
    
Item_ERR:
    Set Item = New clsSrtm
    
    
    
End Property

'/******************************************************************************
Public Sub Clear()
'/******************************************************************************

    On Error GoTo Clear_ERR
    
    
    Set mCol = New Collection

Exit Sub

Clear_ERR:

End Sub

Public Property Get Count() As Long
    Count = mCol.Count
End Property


'/******************************************************************************
Public Sub Remove(vntIndexKey As Variant)
'/******************************************************************************


    If typeName(vntIndexKey) = "String" Then
        mCol.Remove Trim(vntIndexKey)
    Else
        mCol.Remove vntIndexKey
    End If


End Sub


Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
    'this property allows you to enumerate
    'this collection with the For...Each syntax
    Set NewEnum = mCol.[_NewEnum]
End Property


Private Sub Class_Initialize()
    'creates the collection when this class is created
    Set mCol = New Collection
End Sub


Private Sub Class_Terminate()
    'destroys collection when this class is terminated
    Set mCol = Nothing
End Sub



