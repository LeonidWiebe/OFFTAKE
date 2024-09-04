VERSION 5.00
Begin VB.Form frmCopy 
   BorderStyle     =   1  'Fixed Single
   Caption         =   " опирование"
   ClientHeight    =   3945
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7335
   Icon            =   "frmCopy.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3945
   ScaleWidth      =   7335
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton btnCancel 
      Caption         =   "ќтмена"
      Height          =   375
      Left            =   120
      TabIndex        =   12
      Top             =   3480
      Width           =   3135
   End
   Begin VB.CommandButton btnOK 
      Caption         =   " опировать"
      Default         =   -1  'True
      Height          =   375
      Left            =   3480
      TabIndex        =   11
      Top             =   3480
      Width           =   3735
   End
   Begin VB.Frame Frame3 
      Caption         =   "также подлежит копированию"
      Height          =   1335
      Left            =   120
      TabIndex        =   6
      Top             =   2040
      Width           =   7095
      Begin VB.CheckBox chkRedirect 
         Caption         =   "перенаправл€ть (рекомендуетс€)"
         Height          =   255
         Left            =   3720
         TabIndex        =   13
         ToolTipText     =   $"frmCopy.frx":000C
         Top             =   840
         Value           =   1  'Checked
         Width           =   2895
      End
      Begin VB.CheckBox chkReinChilds 
         Caption         =   "вложенные каталоги"
         Height          =   255
         Left            =   120
         TabIndex        =   10
         Top             =   960
         Width           =   2775
      End
      Begin VB.CheckBox chkListContent 
         Caption         =   "также содержимое этих списков"
         Height          =   255
         Left            =   3360
         TabIndex        =   9
         Top             =   600
         Width           =   3615
      End
      Begin VB.CheckBox chkLists 
         Caption         =   "списки, принадлежащие каталогу"
         Height          =   255
         Left            =   120
         TabIndex        =   8
         Top             =   600
         Width           =   4575
      End
      Begin VB.CheckBox chkLinks 
         Caption         =   "ссылки на издели€ унифицированного каталога"
         Height          =   255
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   5175
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "куда"
      Height          =   855
      Left            =   120
      TabIndex        =   1
      Top             =   1080
      Width           =   7095
      Begin VB.TextBox txtDstName 
         Height          =   285
         Left            =   120
         TabIndex        =   3
         Top             =   480
         Width           =   6855
      End
      Begin VB.Label lblDst 
         Caption         =   "путь"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   6855
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "откуда"
      Height          =   855
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   7095
      Begin VB.TextBox txtSrcName 
         BackColor       =   &H8000000F&
         Enabled         =   0   'False
         Height          =   285
         Left            =   120
         Locked          =   -1  'True
         TabIndex        =   2
         Top             =   480
         Width           =   6855
      End
      Begin VB.Label lblSrc 
         Caption         =   "путь"
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   240
         Width           =   6855
      End
   End
End
Attribute VB_Name = "frmCopy"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'/******************************************************************************
Private Sub btnCancel_Click()
'/******************************************************************************

    On Error GoTo btnCancel_Click_ERR

    copyInfo.bOk = False
    
    Unload Me
Exit Sub

btnCancel_Click_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "btnCancel_Click - Error"

End Sub

'/******************************************************************************
Private Sub btnOK_Click()
'/******************************************************************************


    On Error GoTo btnOK_Click_ERR
    
    
    If Len(Trim(Me.txtDstName.text)) = 0 Then
        Exit Sub
    End If
    
    
    copyInfo.bSrcDstEqual = CBool(Me.lblSrc.Caption = Me.lblDst.Caption)

    copyInfo.bLinks = CBool(Me.chkLinks.Value)
    copyInfo.bListContent = CBool(Me.chkListContent.Value)
    copyInfo.bLists = CBool(Me.chkLists.Value)
    copyInfo.bReinChilds = CBool(Me.chkReinChilds.Value)
    copyInfo.bListRedirect = CBool(Me.chkRedirect.Value)
    
    If Me.txtDstName.Enabled Then copyInfo.sNewCatName = Trim(Me.txtDstName.text)
    




    copyInfo.bOk = True
    
    Unload Me



Exit Sub

btnOK_Click_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "btnOK_Click - Error"

End Sub

'/******************************************************************************
Private Sub Form_Load()
'/******************************************************************************

    On Error GoTo Form_Load_ERR


    chkLinks.Value = GetSetting("Offtake2", "frmCopy", "chkLinks.Value", False)
    chkLists.Value = GetSetting("Offtake2", "frmCopy", "chkLists.Value", True)
    chkListContent.Value = GetSetting("Offtake2", "frmCopy", "chkListContent.Value", True)
    chkReinChilds.Value = GetSetting("Offtake2", "frmCopy", "chkReinChilds.Value", True)






Exit Sub

Form_Load_ERR:

End Sub

Private Sub Form_Paint()

    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked


End Sub

'/******************************************************************************
Private Sub Form_Unload(Cancel As Integer)
'/******************************************************************************

    On Error GoTo Form_Unload_ERR



    If chkLists.Enabled Then Call SaveSetting("Offtake2", "frmCopy", "chkLists.Value", chkLists.Value)
    If chkListContent.Enabled Then Call SaveSetting("Offtake2", "frmCopy", "chkListContent.Value", chkListContent.Value)
    
    If chkLinks.Enabled Then Call SaveSetting("Offtake2", "frmCopy", "chkLinks.Value", chkLinks.Value)
    If chkReinChilds.Enabled Then Call SaveSetting("Offtake2", "frmCopy", "chkReinChilds.Value", chkReinChilds.Value)


Exit Sub

Form_Unload_ERR:

End Sub
