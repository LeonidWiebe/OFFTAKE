VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "colProp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "Top_Level" ,"No"
Attribute VB_Ext_KEY = "Collection" ,"clsProp"
Attribute VB_Ext_KEY = "Member0" ,"clsProp"
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Option Explicit

'добавление свойства для posdef в базу
'- имеем posdefID
'- запись в таблицу property - получить propID,propName
'- запись в таблицу r_posdef_property -> posdefID-propID
'- поле в таблицу отношений r_sortament_property -> propName
'- галку в view_r_sortament_property_3 -> propName
'- галку в view_r_part_position -> propName



'local variable to hold collection
Private mCol As Collection

'/******************************************************************************
Public Function existsProperty(strPropName As String) As Boolean
'/******************************************************************************

    On Error GoTo existsProperty_ERR


    Dim p As clsProp
    
    Set p = mCol(strPropName)

    existsProperty = True

Exit Function

existsProperty_ERR:

    existsProperty = False

End Function


'/******************************************************************************
Public Function getPropSiValue(strPropName As String) As Variant
'/******************************************************************************
    
    On Error GoTo getPropvalue_ERR
    
    Dim v As Double
    Dim k As Double
    
    
    If existsProperty(strPropName) Then
        getPropSiValue = Me(strPropName).PVAL_SI
    Else
        k = selectDoubleFromBase(cn_srtm, "view_property", "propK", "propName", strPropName)
        v = selectDoubleFromBase(cn_srtm, "property", "propDefValue", "propName", strPropName)
        getPropSiValue = v * k
    End If
    
    If k = 0# Then k = 1#
    
    
    Exit Function
    
getPropvalue_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getPropvalue - Error"
    
End Function


Public Function AddSimple(p As clsProp, Optional sKey As String = "") As clsProp
    
    
    If Len(sKey) = 0 Then
        mCol.Add p
    Else
        mCol.Add p, sKey
    End If
    
    
    Set AddSimple = p


End Function

'
'Public Function Add(ID As Long, Optional sKey As String, Optional ByRef prnt As clsPos = Nothing, Optional bSrtm As Boolean = False) As clsProp
'    Dim p As clsProp
'    Set p = New clsProp
'
'    If Not prnt Is Nothing Then Set p.parentPos = prnt
'
'
'    p.bEditable = Not bSrtm
'
'
'    If ID = 0 Then
'        p.loadByPropName sKey
'    Else
'        p.loadByPropID ID
'    End If
'
'    If Len(sKey) = 0 Then
'        mCol.Add p
'    Else
'        mCol.Add p, sKey
'    End If
'
'
'
'
'    Set Add = p
'    Set p = Nothing
'
'
'End Function


'/******************************************************************************
Public Function AddByPropName(sKey As String, Optional ByRef prnt As clsPos = Nothing, Optional bSrtm As Boolean = False) As clsProp
'/******************************************************************************

    On Error GoTo AddByPropName_ERR

    Dim p As New clsProp
    
    If Len(sKey) = 0 Then Exit Function
    
    Set p = p.fromExisting(sKey)
    
    
    If Not prnt Is Nothing Then Set p.parentPos = prnt


    p.bEditable = Not bSrtm
    

    mCol.Add p, sKey


    Set AddByPropName = p
    Set p = Nothing


Exit Function

AddByPropName_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "AddByPropName - Error"

End Function

Public Function AddNewProp(ByRef p As clsProp) As clsProp


    If existsProperty(p.propName) Then
        Set AddNewProp = Me(p.propName)
        If p.bMassCalc Then p.bEditable = True
        Exit Function
    End If

    p.bEditable = True
    mCol.Add p, Trim(p.propName)

    'return the object created
    Set AddNewProp = p


End Function


Public Property Get Item(IndexKey As Variant) As clsProp
Attribute Item.VB_UserMemId = 0

    On Error GoTo Item_ERR

  
    If typeName(IndexKey) = "String" Then
        Set Item = mCol(Trim(IndexKey))
    Else
        Set Item = mCol(IndexKey)
    End If
  
  

Exit Property

Item_ERR:
    Set Item = Nothing
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "Item - Error"

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


