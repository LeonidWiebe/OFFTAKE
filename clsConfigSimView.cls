VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsConfigSimView"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Name As String
Public Title As String
Public Keys As String
Public SqlQuery As String

Public Proj As String

Public HiddenColumns As String
Public MergeColumns As String
Public SubTotalColumns As String

Public MergeRef As String
Public LevelFilterColumn As String
Public AutoIndexColumn As String


Public Errors As New Collection
Public cEditFields As New Collection


'Настройки Excel
Public Excel_TemplatePath As String
Public Excel_StartRow As Integer
Public Excel_StrartColumn As Integer
Public Excel_EndPageRow As Integer
Public Excel_Jump As Integer
Public Excel_SavePath As String
Public Excel_GroupBy As String

'Настройки Word
Public Word_TemplatePath As String
Public Word_TableIndex As Integer
Public Word_GroupColumnsColl As New Collection
Public Word_NewRowKey As String
Public Word_TableStartRow As Integer

Public Word_GroupColumn  As Integer
Public Word_TitleRowsCount  As Integer

'Настройки MicroStation
Public MS_TemplatePath As String
Public MS_SpecConfig As clsSCfg
'/******************************************************************************
Public Sub Initialize(ByVal Name As String, ByVal Title As String, ByVal Keys As String, SqlQuery As String)
'/******************************************************************************
    On Error GoTo Initialize_ERR
    
    Me.Name = Name
    Me.Title = Title
    Me.Keys = Keys
    Me.SqlQuery = SqlQuery
    Me.Word_TableStartRow = 1
    

Exit Sub
Initialize_ERR:
    If bMainFormLoaded Then
    F1.SB.Panels("status").text = "Initialize" & "() - " & err.Description
    End If
End Sub
