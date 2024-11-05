VERSION 5.00
Begin VB.Form frmDBsel 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   1770
   ClientLeft      =   45
   ClientTop       =   45
   ClientWidth     =   4680
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1770
   ScaleWidth      =   4680
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox chkRemDB 
      Caption         =   "больше не спрашивать"
      Height          =   255
      Left            =   600
      TabIndex        =   4
      Top             =   800
      Width           =   3495
   End
   Begin VB.CommandButton btnCancel 
      Cancel          =   -1  'True
      Caption         =   "Отмена"
      Height          =   495
      Left            =   480
      TabIndex        =   2
      Top             =   1200
      Width           =   1575
   End
   Begin VB.CommandButton btnOK 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   495
      Left            =   2400
      TabIndex        =   1
      Top             =   1200
      Width           =   1695
   End
   Begin VB.ComboBox cmbBase 
      Height          =   315
      Left            =   480
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   360
      Width           =   3615
   End
   Begin VB.Label Label1 
      Caption         =   "База данных"
      Height          =   255
      Left            =   480
      TabIndex        =   3
      Top             =   120
      Width           =   3495
   End
End
Attribute VB_Name = "frmDBsel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub btnCancel_Click()
BRYS = True
Unload Me

End Sub

'/******************************************************************************
Private Sub btnOK_Click()
'/******************************************************************************


    On Error Resume Next

    BRYS = False
    strCurDataBase = Me.cmbBase.text
    
    If Me.chkRemDB.Value = 1 Then
        Call SaveSetting("Offtake2", "Source", "DB_rem", strCurDataBase)
    Else
        Call DeleteSetting("Offtake2", "Source", "DB_rem")
    End If
    
    
    Unload Me


End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, True

End Sub
