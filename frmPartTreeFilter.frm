VERSION 5.00
Begin VB.Form frmPartTreeFilter 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Опции загрузки"
   ClientHeight    =   2625
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3795
   ControlBox      =   0   'False
   Icon            =   "frmPartTreeFilter.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2625
   ScaleWidth      =   3795
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.CheckBox Check2 
      Caption         =   "возможны символы справа"
      Height          =   255
      Left            =   360
      TabIndex        =   5
      Top             =   1320
      Width           =   3135
   End
   Begin VB.CheckBox Check1 
      Caption         =   "возможны символы слева"
      Height          =   255
      Left            =   360
      TabIndex        =   4
      Top             =   960
      Width           =   3135
   End
   Begin VB.CommandButton Command2 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   495
      Left            =   360
      TabIndex        =   2
      Top             =   2040
      Width           =   1455
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   495
      Left            =   1920
      TabIndex        =   1
      Top             =   2040
      Width           =   1575
   End
   Begin VB.TextBox txtFilter 
      Height          =   285
      Left            =   360
      TabIndex        =   0
      Top             =   480
      Width           =   3135
   End
   Begin VB.Label Label1 
      Caption         =   "Фильтр по наименованию изделия"
      Height          =   255
      Left            =   360
      TabIndex        =   3
      Top             =   240
      Width           =   3255
   End
End
Attribute VB_Name = "frmPartTreeFilter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public bOk As Boolean

'/******************************************************************************
Private Sub Command1_Click()
'/******************************************************************************
    
    On Error GoTo Command1_Click_ERR
    
    
    sFilterPartName = Trim(txtFilter.text)
    
    If Check1.Value = 1 Then sFilterPartName = "%" & sFilterPartName
    If Check2.Value = 1 Then sFilterPartName = sFilterPartName & "%"
    
    updateTableInBase cn_srtm, "usr", "usrPartFilter", sFilterPartName, "usrID", usrCurrent.usrID
    
    bOk = True
    
    Unload Me
    
    Exit Sub
    
Command1_Click_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "Command1_Click - Error"
    
End Sub

'/******************************************************************************
Private Sub Command2_Click()
'/******************************************************************************
    
    
    On Error GoTo Command2_Click_ERR
    
    bOk = False
    
    Unload Me
    
    Exit Sub
    
Command2_Click_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "Command2_Click - Error"
    
End Sub

'/******************************************************************************
Private Sub Form_Load()
'/******************************************************************************


    On Error GoTo Form_Load_ERR
    
    bOk = False

    If left(sFilterPartName, 1) = "%" Then Check1.Value = 1
    If right(sFilterPartName, 1) = "%" Then Check2.Value = 1

    
    txtFilter.text = Replace(sFilterPartName, "%", "")
    
Exit Sub

Form_Load_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "Form_Load - Error"

End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked
End Sub

