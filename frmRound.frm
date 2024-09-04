VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Begin VB.Form frmRound 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Настройки округления"
   ClientHeight    =   4920
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4725
   Icon            =   "frmRound.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4920
   ScaleWidth      =   4725
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.Frame Frame2 
      Caption         =   "Пример расчета"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1455
      Left            =   120
      TabIndex        =   0
      Top             =   3360
      Width           =   4455
      Begin VB.TextBox txtVal 
         Height          =   285
         Left            =   240
         TabIndex        =   1
         Text            =   "444.445"
         Top             =   360
         Width           =   1575
      End
      Begin MSComctlLib.Slider sldND 
         Height          =   255
         Left            =   2520
         TabIndex        =   2
         Top             =   720
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   450
         _Version        =   393216
         LargeChange     =   1
         Min             =   -4
         Max             =   4
      End
      Begin MSComctlLib.Slider sldShift 
         Height          =   255
         Left            =   2520
         TabIndex        =   3
         Top             =   1080
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   450
         _Version        =   393216
         LargeChange     =   1
         Min             =   -4
         Max             =   4
      End
      Begin VB.Label lblShift 
         AutoSize        =   -1  'True
         Caption         =   "5"
         Height          =   195
         Left            =   4200
         TabIndex        =   18
         Top             =   1080
         Width           =   90
      End
      Begin VB.Label Label7 
         Caption         =   "="
         Height          =   255
         Left            =   2040
         TabIndex        =   7
         Top             =   420
         Width           =   255
      End
      Begin VB.Label lblResVal 
         Caption         =   "445"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2280
         TabIndex        =   6
         Top             =   420
         Width           =   1455
      End
      Begin VB.Label Label5 
         Caption         =   "Смещение меньше/больше"
         Height          =   255
         Left            =   240
         TabIndex        =   5
         Top             =   1080
         Width           =   2295
      End
      Begin VB.Label Label4 
         Caption         =   "Знаков после запятой"
         Height          =   255
         Left            =   240
         TabIndex        =   4
         Top             =   720
         Width           =   1935
      End
      Begin VB.Label lblND 
         AutoSize        =   -1  'True
         Caption         =   "0"
         Height          =   195
         Left            =   4200
         TabIndex        =   17
         Top             =   720
         Width           =   90
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Параметры смещения (меньше/больше)"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2415
      Left            =   120
      TabIndex        =   8
      Top             =   120
      Width           =   4455
      Begin VB.CommandButton Command1 
         Caption         =   "Сохранить параметры"
         Height          =   375
         Left            =   240
         TabIndex        =   16
         Top             =   1920
         Width           =   3975
      End
      Begin VB.Frame Frame1 
         Caption         =   "Эскизы арматурных стержней"
         Height          =   1095
         Left            =   240
         TabIndex        =   9
         Top             =   720
         Width           =   3975
         Begin MSComctlLib.Slider sldArmSegmLen 
            Height          =   255
            Left            =   1800
            TabIndex        =   10
            Top             =   360
            Width           =   2055
            _ExtentX        =   3625
            _ExtentY        =   450
            _Version        =   393216
            Enabled         =   0   'False
            LargeChange     =   1
            Min             =   -4
            Max             =   4
         End
         Begin MSComctlLib.Slider sldArmArcLen 
            Height          =   255
            Left            =   1800
            TabIndex        =   11
            Top             =   720
            Width           =   2055
            _ExtentX        =   3625
            _ExtentY        =   450
            _Version        =   393216
            Enabled         =   0   'False
            LargeChange     =   1
            Min             =   -4
            Max             =   4
            SelStart        =   -3
            Value           =   -3
         End
         Begin VB.Label Label2 
            Caption         =   "Длина сегмента"
            Height          =   255
            Left            =   120
            TabIndex        =   13
            Top             =   360
            Width           =   1455
         End
         Begin VB.Label Label3 
            Caption         =   "Длина закругления"
            Height          =   255
            Left            =   120
            TabIndex        =   12
            Top             =   720
            Width           =   1695
         End
      End
      Begin MSComctlLib.Slider sldPosMass 
         Height          =   255
         Left            =   1800
         TabIndex        =   14
         Top             =   360
         Width           =   2415
         _ExtentX        =   4260
         _ExtentY        =   450
         _Version        =   393216
         LargeChange     =   1
         Min             =   -4
         Max             =   4
         SelStart        =   -2
         Value           =   -2
      End
      Begin VB.Label Label1 
         Caption         =   "Масса позиций"
         Height          =   255
         Left            =   240
         TabIndex        =   15
         Top             =   360
         Width           =   1695
      End
   End
   Begin VB.Label Label6 
      Caption         =   "Внимание! Менять эти настройки рекомендуется только если Вы чётко представляете - что такое смещение границы округления!"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   735
      Left            =   120
      TabIndex        =   19
      Top             =   2640
      Width           =   4455
   End
End
Attribute VB_Name = "frmRound"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit




Private Sub Command1_Click()

    
    rndGlobal.iPosMass = sldPosMass.Value
'    rndGlobal.iArmSegm = sldArmSegmLen.Value
'    rndGlobal.iArmArc = sldArmArcLen.Value

    Call SaveSetting("Offtake2", "RndShift", "iPosMass", rndGlobal.iPosMass)
'    Call SaveSetting("Offtake2", "RndShift", "iArmSegm", rndGlobal.iArmSegm)
'    Call SaveSetting("Offtake2", "RndShift", "iArmArc", rndGlobal.iArmArc)





End Sub


Private Sub Form_Load()
    
    sldPosMass.Value = rndGlobal.iPosMass
    sldArmSegmLen.Value = rndGlobal.iArmSegm
    sldArmArcLen.Value = rndGlobal.iArmArc


End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked
End Sub

Private Sub sldND_Change()

    lblResVal.Caption = roundShaman(getDbl(Me.txtVal.text), sldND.Value, , sldShift.Value)
    lblND.Caption = sldND.Value
    
End Sub

Private Sub sldND_Click()
    lblResVal.Caption = roundShaman(getDbl(Me.txtVal.text), sldND.Value, , sldShift.Value)
    lblND.Caption = sldND.Value

End Sub

Private Sub sldShift_Change()
    lblResVal.Caption = roundShaman(getDbl(Me.txtVal.text), sldND.Value, , sldShift.Value)
    lblShift.Caption = sldShift.Value + 5

End Sub

Private Sub sldShift_Click()
    lblResVal.Caption = roundShaman(getDbl(Me.txtVal.text), sldND.Value, , sldShift.Value)
    lblShift.Caption = sldShift.Value + 5

End Sub

Private Sub txtVal_Change()
    lblResVal.Caption = roundShaman(getDbl(Me.txtVal.text), sldND.Value, , sldShift.Value)

End Sub

Private Sub txtVal_Click()
    lblResVal.Caption = roundShaman(getDbl(Me.txtVal.text), sldND.Value, , sldShift.Value)

End Sub
