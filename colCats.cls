VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "colCats"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Collection" ,"clsCat"
Attribute VB_Ext_KEY = "Member0" ,"clsCat"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'local variable to hold collection
Private mCol As Collection

Public Function AddCatSimple(ct As clsCat, Optional sKey As String = "") As Boolean

On Error GoTo m1
    
    If Not ct Is Nothing Then
    
        If Len(sKey) = 0 Then
            mCol.Add ct
        Else
            mCol.Add ct, sKey
        End If
    
    End If
    
    AddCatSimple = True
    
    Exit Function
    
m1:
    

End Function


Public Function Add(catID As Long, catName As String, catTypeID As Long, catTypeName As String, Optional sKey As String) As clsCat
    'create a new object
    Dim objNewMember As clsCat
    Set objNewMember = New clsCat


    'set the properties passed into the method
    objNewMember.catTypeName = catTypeName
    objNewMember.catTypeID = catTypeID
    objNewMember.catName = catName
    objNewMember.catID = catID
    If Len(sKey) = 0 Then
        mCol.Add objNewMember
    Else
        mCol.Add objNewMember, sKey
    End If


    'return the object created
    Set Add = objNewMember
    Set objNewMember = Nothing


End Function

Public Property Get Item(IndexKey As Variant) As clsCat
Attribute Item.VB_UserMemId = 0
  
    On Error GoTo Item_ERR
    
    
    Dim s As clsCat
    
    If typeName(IndexKey) = "String" Then
        If Not exists(Val(IndexKey)) Then
            Set s = New clsCat
            If s.loadCatByID(Nothing, Val(IndexKey)) Then
                mCol.Add s, IndexKey
            End If
            Set s = Nothing
        End If
    End If
    
    Set Item = mCol(Trim(IndexKey))
    
    
    
    Exit Property
    
Item_ERR:
    Set Item = New clsCat
  
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

'/******************************************************************************
' функция для работы дерева каталогов с новым типом KEY, не используется
Public Function getByTreeKey(sKey As String) As clsCat
'/******************************************************************************

    On Error GoTo getByTreeKey_ERR
    
    Dim ct As clsCat
    
    Dim ar() As String
    ar = Split(sKey, "|")
    
    If UBound(ar) <> 2 Then Exit Function ' nothing
    
    Dim ID As Long
    
    ID = Val(ar(1))
    
    If ID > 0 Then
        Set getByTreeKey = mCol(CStr(ID))
    Else ' catalog/docset
        
        
        For Each ct In mCol
        
            If ct.getDocSetNumber(False) = ar(2) Then
            
                Set getByTreeKey = ct
                Exit For
            
            End If
        
        Next ct
        
        
    End If
    

Exit Function

getByTreeKey_ERR:
    Set getByTreeKey = Nothing

End Function


'/******************************************************************************
Public Function exists(catID As Long) As Boolean

    On Error GoTo existsProperty_ERR


    Dim p As clsCat
    
    Set p = mCol(CStr(catID))

    exists = True

Exit Function

existsProperty_ERR:

    exists = False

End Function
