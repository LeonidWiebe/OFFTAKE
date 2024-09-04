VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsConfigWordGroupColumn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Column As String 'рег.выраж.
Public TitleRowsCount As Integer
Public TitleText As String
Public GroupExpression As String
Public Hidden As Boolean

'/******************************************************************************
Public Sub Initialize(ByVal Column As String, GroupExpression As String, ByVal TitleRowsCount As Integer, ByVal TitleText As String)
'Public Sub Initialize(ByVal Column As String, GroupExpression As String, ByVal TitleRowsCount As Integer, ByVal TitleText As String, ByVal Hidden As String)
'/******************************************************************************
    On Error GoTo Initialize_ERR
        
    Me.Column = Column
    Me.GroupExpression = GroupExpression
    Me.TitleRowsCount = TitleRowsCount
    Me.TitleText = TitleText
    Me.Hidden = CBool(Hidden)
Exit Sub
Initialize_ERR:
    If bMainFormLoaded Then
    F1.SB.Panels("status").text = "Initialize" & "() - " & err.Description
    End If
End Sub






