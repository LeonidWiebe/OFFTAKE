VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "colPos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"No"
Attribute VB_Ext_KEY = "Collection" ,"clsPos"
Attribute VB_Ext_KEY = "Member0" ,"clsPos"
Option Explicit

'local variable to hold collection
Public pm As Collection
Public pe As Collection




Public Function AddPos(p As clsPos, Optional sKey As String = "", Optional after As Long = 0, Optional before As Long = 0) As clsPos
    
    'set the properties passed into the method
    
    
    If Len(Trim(sKey)) = 0 Then
        If Not p.POS_PD.bPosNum Then
            pe.Add p
        Else
            If after > 0 Then
                pm.Add p, , , after
            ElseIf before > 0 Then
                pm.Add p, , before
            Else
                pm.Add p
            End If
        End If
    Else
        If Not p.POS_PD.bPosNum Then
            pe.Add p, sKey
        Else
            If after > 0 Then
                pm.Add p, sKey, , after
            ElseIf before > 0 Then
                pm.Add p, sKey, before
            Else
                pm.Add p, sKey
            End If
        End If
    End If
    
    
    
    'return the object created
    Set AddPos = p
    
    
End Function


'/******************************************************************************
Public Sub Clear()
'/******************************************************************************

    On Error GoTo Clear_ERR
    
    
    Set pm = New Collection
    Set pe = New Collection

Exit Sub

Clear_ERR:

End Sub

'/******************************************************************************
Public Function getItem(IndexKey As Variant) As clsPos
'/******************************************************************************

    On Error GoTo getItemByPosNumber_ERR

    If pm.Count > 0 Then
        Set getItem = pm(IndexKey)
    ElseIf pe.Count > 0 Then
        Set getItem = pe(IndexKey)
    Else
        Set getItem = New clsPos
    End If


Exit Function

getItemByPosNumber_ERR:
    Set getItem = New clsPos
'    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getItemByPosNumber - Error"

End Function


'/******************************************************************************
Public Property Get Item(IndexKey As String) As clsPos
Attribute Item.VB_UserMemId = 0
'/******************************************************************************

    On Error GoTo Item_ERR


    Set Item = pm(Trim(IndexKey))
    
Exit Property

Item_ERR:
    Set Item = pe(Trim(IndexKey))

End Property




Public Property Get Count() As Long
    Count = pm.Count + pe.Count
End Property


'/******************************************************************************
Public Sub Remove(IndexKey As String)
'/******************************************************************************

    On Error GoTo Remove_ERR

    
    pm.Remove (Trim(IndexKey))
    
Exit Sub

Remove_ERR:
    pe.Remove (Trim(IndexKey))

End Sub


''/******************************************************************************
'Public Property Get NewEnum() As IUnknown
''/******************************************************************************
'
'
'
'    Set NewEnum = pm.[_NewEnum]
'
'
'
'End Property


Private Sub Class_Initialize()
    'creates the collection when this class is created
    Set pm = New Collection
    Set pe = New Collection
End Sub


Private Sub Class_Terminate()
    'destroys collection when this class is terminated
    Set pm = Nothing
    Set pe = Nothing
End Sub

