VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsConfigViewErr"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Column As String 'рег.выраж.
Public ErrorExpression As String
Public Trigger As Boolean
Public Message As String

'/******************************************************************************
Public Sub Initialize(ByVal Column As String, ByVal ErrorExpression As String, ByVal Trigger As String, Message As String)
'/******************************************************************************
    On Error GoTo Initialize_ERR
        
    Me.Column = Column
    Me.ErrorExpression = ErrorExpression
    Me.Trigger = CBool(Trigger)
    Me.Message = Message

Exit Sub
Initialize_ERR:
    If bMainFormLoaded Then
    F1.SB.Panels("status").text = "Initialize" & "() - " & err.Description
    End If
End Sub





