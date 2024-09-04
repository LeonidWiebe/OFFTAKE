VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCatDef"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public cdID As Long
Public cdName As String
Public bIsDocSet As Boolean
Public iUpLevel As Integer

Public partdefID As Long

Public speedKey As String
Public simKey As String

'/******************************************************************************
Public Property Get CD_NAME() As String
'/******************************************************************************

    On Error GoTo CD_NAME_ERR
    
    If bIsDocSet Then CD_NAME = cdName & " (комплект)" Else CD_NAME = cdName

Exit Property

CD_NAME_ERR:
    CD_NAME = cdName

End Property
