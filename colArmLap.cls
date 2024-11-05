VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "colArmLap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"No"
Attribute VB_Ext_KEY = "Collection" ,"clsArmLap"
Attribute VB_Ext_KEY = "Member0" ,"clsArmLap"
Option Explicit

Private mCol As Collection

'/******************************************************************************
Public Function exists(IndexKey As Variant) As Boolean
'/******************************************************************************

    On Error GoTo existsProperty_ERR


    Dim p As clsArmLap
    
    Set p = mCol(IndexKey)

    exists = True

Exit Function

existsProperty_ERR:

    exists = False

End Function

'/******************************************************************************
Public Function addLap(lap As clsArmLap) As Boolean
'/******************************************************************************

    On Error GoTo addLap_ERR

    If Not Me.exists(lap.KEY) Then
        mCol.Add lap, lap.KEY
    End If

Exit Function

addLap_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "addLap - Error"

End Function




'/******************************************************************************
Public Property Get Item(IndexKey As Variant) As clsArmLap
Attribute Item.VB_UserMemId = 0
'/******************************************************************************



    On Error GoTo Item_ERR
    
    If typeName(IndexKey) = "String" Then
        If Me.exists(IndexKey) Then
            Set Item = mCol(IndexKey)
            Exit Property
        Else
            Dim ar() As String
            ar = Split(IndexKey, ".")
            If UBound(ar) = 3 Then
                ar(0) = "000"
                IndexKey = Join(ar, ".")
                If Me.exists(IndexKey) Then
                    Set Item = mCol(IndexKey)
                    Exit Property
                Else
                    err.Raise 1
                End If
            Else
                err.Raise 1
            End If
        End If
    Else
        Set Item = mCol(IndexKey)
    End If


  
Exit Property

Item_ERR:
    Set Item = New clsArmLap

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

