VERSION 5.00
Object = "{0E59F1D2-1FBE-11D0-8FF2-00A0D10038BC}#1.0#0"; "msscript.ocx"
Begin VB.Form frmCalc 
   BorderStyle     =   0  'None
   ClientHeight    =   690
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6150
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   690
   ScaleWidth      =   6150
   ShowInTaskbar   =   0   'False
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   4920
      TabIndex        =   2
      Top             =   360
      Width           =   1095
   End
   Begin MSScriptControlCtl.ScriptControl SC 
      Left            =   3240
      Top             =   1920
      _ExtentX        =   1005
      _ExtentY        =   1005
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6135
   End
   Begin VB.Label Label1 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   12
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   360
      Width           =   6015
   End
End
Attribute VB_Name = "frmCalc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public bOk As Boolean

Public FG As VSFlexGrid
Public Row As Long
Public Col As Long

Public nd As Integer

Private Sub Form_Deactivate()
Unload Me
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then bOk = True: Unload Me
If KeyAscii = 27 Then bOk = False:  Unload Me


End Sub

Private Sub Form_Load()

bOk = False
Text1_Change

End Sub

Private Sub Form_LostFocus()

Unload Me
End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked
End Sub

Private Sub Form_Unload(Cancel As Integer)
    
    If bOk Then
        FG.TextMatrix(Row, Col) = Me.Label1.Caption
        'FG.Cell(flexcpFontUnderline, Row, Col) = True
        Call F1.fgCatParts_AfterEdit(Row, Col)
    End If
    
End Sub

'/******************************************************************************
Private Sub Text1_Change()
'/******************************************************************************
    
    On Error GoTo Text1_Change_ERR
    
    Dim ss As Long
    
    ss = Text1.SelStart
    Text1.text = Replace(Text1.text, ",", ".")
    Text1.SelStart = ss
    
    
    Label1.Caption = Round(SC.Eval(Text1.text), nd)
    
    Exit Sub
    
Text1_Change_ERR:
    '    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "Text1_Change - Error"
    
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then bOk = True:   Unload Me
If KeyAscii = 27 Then bOk = False:   Unload Me

End Sub
