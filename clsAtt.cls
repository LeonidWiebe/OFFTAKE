VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsAtt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public attName As String

Public attValue As Variant
'Public propDefValue As Variant

'Public colValues As Collection

Public prnt As colAts

Public OK As Boolean


'/*****************************************************
Public Function makeClone() As clsAtt
'/*****************************************************

    On Error GoTo fromExisting_ERR

    Dim pNew As New clsAtt

    Set pNew.prnt = Me.prnt

    pNew.OK = Me.OK
    'pNew.propDefValue = Me.propDefValue

    'pNew.propID = Me.propID

    pNew.attName = Me.attName

    pNew.attValue = Me.attValue

    Set makeClone = pNew

    Set pNew = Nothing


Exit Function

fromExisting_ERR:
    'MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "fromExisting - Error"

End Function


'/******************************************************************************
Public Function setValue(v As Variant) As Boolean
'/******************************************************************************
    
    On Error GoTo setValue_ERR

    attValue = v

    setValue = True
    
    Exit Function


setValue_ERR:
    setValue = False

End Function



Public Function hasValue() As Boolean

    hasValue = True
    
    If IsNull(attValue) Then
        hasValue = False
    ElseIf typeName(attValue) = "String" Then
        If Len(attValue) = 0 Then hasValue = False
    Else
        If attValue = 0 Then hasValue = False
    End If



End Function



Private Sub Class_Initialize()

    'Set colValues = New Collection
    
End Sub

Private Sub Class_Terminate()
    'Set colValues = Nothing
End Sub
