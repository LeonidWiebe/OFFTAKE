VERSION 5.00
Begin VB.Form frmSplash 
   BorderStyle     =   0  'None
   ClientHeight    =   6810
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   13635
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6810
   ScaleWidth      =   13635
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox Picture1 
      AutoSize        =   -1  'True
      BorderStyle     =   0  'None
      Height          =   2235
      Left            =   0
      Picture         =   "frmSplash.frx":0000
      ScaleHeight     =   2235
      ScaleWidth      =   6705
      TabIndex        =   0
      Top             =   0
      Width           =   6705
      Begin VB.Label lblStatus 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "..."
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808080&
         Height          =   375
         Left            =   120
         TabIndex        =   2
         Top             =   1800
         Width           =   6255
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "..."
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808080&
         Height          =   255
         Left            =   360
         TabIndex        =   1
         Top             =   1440
         Width           =   5775
      End
   End
End
Attribute VB_Name = "frmSplash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim bShown As Boolean

'/******************************************************************************
Public Sub setStatus(str As String)
'/******************************************************************************

    On Error GoTo setStatus_ERR
    
    
    If Not bShown Then Exit Sub
    
    If bDontUseSplash = 1 Or bAdminMode Then
        Me.Move 0, 0
    End If
    
    
    Me.lblStatus.Caption = str
    Me.lblStatus.Refresh

Exit Sub

setStatus_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setStatus - Error"

End Sub

Private Sub Form_Activate()

bShown = True

End Sub

Private Sub Form_Click()
Unload Me
End Sub

Private Sub Form_Deactivate()
Unload Me
End Sub

Private Sub Form_Load()

    Me.width = Picture1.width
    Me.height = Picture1.height

    Me.Label1.Caption = "v " & App.Major & "." & App.Minor & "." & App.Revision


End Sub

Private Sub Form_LostFocus()
Unload Me
End Sub


Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, True
    bShown = True
End Sub

Private Sub Picture1_Click()
Unload Me

End Sub
