VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form frmCatName 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Создание каталога"
   ClientHeight    =   2445
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4965
   Icon            =   "frmCatName.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2445
   ScaleWidth      =   4965
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.OptionButton optCat 
      Caption         =   "Арматура"
      Height          =   255
      Index           =   1
      Left            =   240
      TabIndex        =   21
      Top             =   840
      Width           =   2775
   End
   Begin VB.OptionButton optCat 
      Caption         =   "Изделия"
      Height          =   255
      Index           =   0
      Left            =   240
      TabIndex        =   20
      Top             =   580
      Value           =   -1  'True
      Width           =   2775
   End
   Begin VB.TextBox txtDSLev 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   960
      MaxLength       =   2
      TabIndex        =   17
      Text            =   "00"
      Top             =   120
      Width           =   495
   End
   Begin VB.CheckBox chkLev 
      Height          =   375
      Index           =   3
      Left            =   4680
      TabIndex        =   16
      Top             =   1200
      Width           =   255
   End
   Begin VB.CheckBox chkLev 
      Height          =   375
      Index           =   2
      Left            =   4680
      TabIndex        =   15
      Top             =   840
      Width           =   255
   End
   Begin VB.CheckBox chkLev 
      Height          =   375
      Index           =   1
      Left            =   4680
      TabIndex        =   14
      Top             =   480
      Width           =   255
   End
   Begin VB.CheckBox chkLev 
      Height          =   375
      Index           =   0
      Left            =   4680
      TabIndex        =   13
      Top             =   120
      Width           =   255
   End
   Begin VB.TextBox txtLev 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   3
      Left            =   3600
      TabIndex        =   12
      Text            =   "0"
      Top             =   1200
      Width           =   735
   End
   Begin VB.TextBox txtLev 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   2
      Left            =   3600
      TabIndex        =   10
      Text            =   "0"
      Top             =   840
      Width           =   735
   End
   Begin VB.TextBox txtLev 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   1
      Left            =   3600
      TabIndex        =   8
      Text            =   "0"
      Top             =   480
      Width           =   735
   End
   Begin MSComCtl2.UpDown UpDown1 
      Height          =   285
      Index           =   0
      Left            =   4336
      TabIndex        =   6
      Top             =   120
      Width           =   240
      _ExtentX        =   423
      _ExtentY        =   503
      _Version        =   393216
      BuddyControl    =   "txtLev(0)"
      BuddyDispid     =   196612
      BuddyIndex      =   0
      OrigLeft        =   5520
      OrigTop         =   120
      OrigRight       =   5760
      OrigBottom      =   495
      Increment       =   100
      Max             =   99000
      Min             =   -99000
      SyncBuddy       =   -1  'True
      BuddyProperty   =   0
      Enabled         =   -1  'True
   End
   Begin VB.TextBox txtLev 
      Alignment       =   1  'Right Justify
      Height          =   285
      Index           =   0
      Left            =   3600
      TabIndex        =   5
      Text            =   "0"
      Top             =   120
      Width           =   735
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Отмена"
      Height          =   495
      Left            =   120
      TabIndex        =   4
      Top             =   1800
      Width           =   1935
   End
   Begin VB.CommandButton Command1 
      Caption         =   "ОК"
      Height          =   495
      Left            =   2400
      TabIndex        =   3
      Top             =   1800
      Width           =   2415
   End
   Begin VB.TextBox txtNum 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   2400
      MaxLength       =   4
      TabIndex        =   2
      Text            =   "0000"
      Top             =   120
      Width           =   855
   End
   Begin VB.ComboBox cmbCatDef 
      Height          =   315
      Left            =   240
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   1200
      Width           =   3015
   End
   Begin VB.ComboBox cmbCatType 
      Height          =   315
      ItemData        =   "frmCatName.frx":000C
      Left            =   2280
      List            =   "frmCatName.frx":0016
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   3480
      Width           =   3015
   End
   Begin MSComCtl2.UpDown UpDown1 
      Height          =   285
      Index           =   1
      Left            =   4335
      TabIndex        =   7
      Top             =   480
      Width           =   240
      _ExtentX        =   423
      _ExtentY        =   503
      _Version        =   393216
      BuddyControl    =   "txtLev(0)"
      BuddyDispid     =   196612
      BuddyIndex      =   0
      OrigLeft        =   5520
      OrigTop         =   120
      OrigRight       =   5760
      OrigBottom      =   495
      Increment       =   100
      Max             =   99000
      Min             =   -99000
      SyncBuddy       =   -1  'True
      BuddyProperty   =   0
      Enabled         =   -1  'True
   End
   Begin MSComCtl2.UpDown UpDown1 
      Height          =   285
      Index           =   2
      Left            =   4335
      TabIndex        =   9
      Top             =   840
      Width           =   240
      _ExtentX        =   423
      _ExtentY        =   503
      _Version        =   393216
      BuddyControl    =   "txtLev(0)"
      BuddyDispid     =   196612
      BuddyIndex      =   0
      OrigLeft        =   5520
      OrigTop         =   120
      OrigRight       =   5760
      OrigBottom      =   495
      Increment       =   100
      Max             =   99000
      Min             =   -99000
      SyncBuddy       =   -1  'True
      BuddyProperty   =   0
      Enabled         =   -1  'True
   End
   Begin MSComCtl2.UpDown UpDown1 
      Height          =   285
      Index           =   3
      Left            =   4335
      TabIndex        =   11
      Top             =   1200
      Width           =   240
      _ExtentX        =   423
      _ExtentY        =   503
      _Version        =   393216
      BuddyControl    =   "txtLev(0)"
      BuddyDispid     =   196612
      BuddyIndex      =   0
      OrigLeft        =   5520
      OrigTop         =   120
      OrigRight       =   5760
      OrigBottom      =   495
      Increment       =   100
      Max             =   99000
      Min             =   -99000
      SyncBuddy       =   -1  'True
      BuddyProperty   =   0
      Enabled         =   -1  'True
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      Caption         =   "Номер"
      Height          =   255
      Left            =   1560
      TabIndex        =   19
      Top             =   120
      Width           =   735
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      Caption         =   "Уровень"
      Height          =   255
      Left            =   120
      TabIndex        =   18
      Top             =   120
      Width           =   735
   End
End
Attribute VB_Name = "frmCatName"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Command1_Click()
    Unload Me
End Sub

Private Sub Command2_Click()
    Unload Me
End Sub

'/******************************************************************************
Private Sub Form_Load()
'/******************************************************************************

    On Error GoTo Form_Load_ERR

    txtLev_LostFocus 0
    txtLev_LostFocus 1
    txtLev_LostFocus 2
    txtLev_LostFocus 3



Exit Sub

Form_Load_ERR:
    If bMainFormLoaded Then F1.SB.Panels("status").text = "Form_Load" & "() - " & err.Description

End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked
End Sub

Private Sub txtDSLev_KeyPress(KeyAscii As Integer)

    Select Case KeyAscii
        Case 48 To 57
        Case Else
        KeyAscii = 0
    End Select

End Sub

Private Sub txtDSLev_LostFocus()

    txtDSLev.text = Format(CLng(getDbl(txtDSLev.text)), "00")


End Sub

Private Sub txtLev_LostFocus(Index As Integer)

    Dim dval As Double
    
    dval = getDbl(txtLev(Index).text)
    
    If Abs(dval - CLng(dval)) > 0# Then
        dval = dval * 1000
    Else
    End If
    

    txtLev(Index).text = Format(dval, "00,000")


End Sub

Private Sub txtNum_KeyPress(KeyAscii As Integer)

    Select Case KeyAscii
        Case 48 To 57
        Case Else
        KeyAscii = 0
    End Select


End Sub

Private Sub txtNum_LostFocus()

    txtNum.text = Format(CLng(getDbl(txtNum.text)), "0000")


End Sub

Private Sub UpDown1_Change(Index As Integer)
    txtLev_LostFocus Index

End Sub
