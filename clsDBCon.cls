VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDBCon"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

   Public text As String
   Public server As String
   Public database As String
   Public login As String
   Public root As Long
   Public connected As Boolean
   Public constring As String
   Public userno As Long
   Public canedit As Boolean
   Public glev As Integer
   Public ispwdb As Boolean
   Public sql_filter As String

   
   Public canedit_grid As Boolean
   Public canedit_tree As Boolean

    Public regexps As New Collection


Private Sub Class_Initialize()
    glev = 3
End Sub
