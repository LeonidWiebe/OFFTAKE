VERSION 5.00
Begin VB.Form frmSketch 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Эскиз в MicroStation"
   ClientHeight    =   2955
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4905
   Icon            =   "frmSketch.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2955
   ScaleWidth      =   4905
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.Frame Frame4 
      Caption         =   "Размеры"
      Height          =   1455
      Left            =   1800
      TabIndex        =   15
      Top             =   4320
      Width           =   4695
      Begin VB.TextBox txtCellWidth 
         Height          =   285
         Left            =   3480
         TabIndex        =   19
         Text            =   "8000"
         Top             =   240
         Width           =   975
      End
      Begin VB.TextBox txtCellHeight 
         Height          =   285
         Left            =   3480
         TabIndex        =   18
         Text            =   "4000"
         Top             =   600
         Width           =   975
      End
      Begin VB.TextBox txtMaxHeight 
         Height          =   285
         Left            =   3480
         TabIndex        =   16
         Text            =   "54000"
         Top             =   960
         Width           =   975
      End
      Begin VB.Label Label2 
         Alignment       =   1  'Right Justify
         Caption         =   "высота ячейки"
         Height          =   255
         Left            =   360
         TabIndex        =   21
         Top             =   600
         Width           =   3015
      End
      Begin VB.Label Label1 
         Alignment       =   1  'Right Justify
         Caption         =   "ширина таблицы"
         Height          =   255
         Left            =   360
         TabIndex        =   20
         Top             =   240
         Width           =   3015
      End
      Begin VB.Label lblMaxHeight 
         Alignment       =   1  'Right Justify
         Caption         =   "максимальная высота таблицы"
         Height          =   255
         Left            =   360
         TabIndex        =   17
         Top             =   960
         Width           =   3015
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Автомасштаб"
      Height          =   1095
      Left            =   3240
      TabIndex        =   10
      Top             =   3120
      Width           =   4695
      Begin VB.TextBox txtScaleVer 
         Height          =   285
         Left            =   3240
         TabIndex        =   14
         Text            =   "2000"
         Top             =   640
         Width           =   975
      End
      Begin VB.TextBox txtScaleHor 
         Height          =   285
         Left            =   3240
         TabIndex        =   13
         Text            =   "4000"
         Top             =   300
         Width           =   975
      End
      Begin VB.CheckBox chkScaleVer 
         Caption         =   "по вертикали не более"
         Height          =   255
         Left            =   960
         TabIndex        =   12
         Top             =   640
         Width           =   3135
      End
      Begin VB.CheckBox chkScaleHor 
         Caption         =   "по горизонтали не более"
         Height          =   255
         Left            =   960
         TabIndex        =   11
         Top             =   300
         Width           =   3135
      End
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Отмена"
      Height          =   250
      Left            =   1440
      TabIndex        =   9
      Top             =   2640
      Width           =   1215
   End
   Begin VB.CheckBox chkShow 
      Caption         =   "Показывать каждый раз при вставке"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   2280
      Width           =   3255
   End
   Begin VB.CommandButton btnOk 
      Caption         =   "OK"
      Height          =   255
      Left            =   2880
      TabIndex        =   7
      Top             =   2640
      Width           =   1935
   End
   Begin VB.Frame Frame2 
      Caption         =   "Радиус скругления"
      Height          =   855
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   2775
      Begin VB.TextBox txtRad 
         Height          =   285
         Left            =   1920
         TabIndex        =   6
         Text            =   "200"
         Top             =   480
         Width           =   615
      End
      Begin VB.OptionButton optRad 
         Caption         =   "фиксированный ="
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   5
         Top             =   480
         Width           =   2535
      End
      Begin VB.OptionButton optRad 
         Caption         =   "как в позиции"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   4
         Top             =   240
         Value           =   -1  'True
         Width           =   2535
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Масштаб"
      Height          =   855
      Left            =   3000
      TabIndex        =   0
      Top             =   120
      Width           =   1815
      Begin VB.TextBox txtScale 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Index           =   1
         Left            =   960
         TabIndex        =   2
         Text            =   "1"
         Top             =   360
         Width           =   735
      End
      Begin VB.TextBox txtScale 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Index           =   0
         Left            =   120
         TabIndex        =   1
         Text            =   "1"
         Top             =   360
         Width           =   735
      End
   End
End
Attribute VB_Name = "frmSketch"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public bSaveSketchSettings As Boolean


Private Sub btnOk_Click()
    
    bFormOk = True
    
    If optRad(0).Value Then
        iSketchRadiusOpt = 0
    Else
        iSketchRadiusOpt = 1
    End If
    
    
    
    iSketchRadiusVal = getDbl(txtRad.text)
    iSketchScaleLft = getDbl(txtScale(0).text)
    iSketchScaleRgt = getDbl(txtScale(1).text)
    iSketchShowDialog = chkShow.Value
    
    If chkScaleHor.Value Then iSketchScaleHor = Val(txtScaleHor.text) Else iSketchScaleHor = 0
    If chkScaleVer.Value Then iSketchScaleVer = Val(txtScaleVer.text) Else iSketchScaleVer = 0
    
    iSketchCellHeight = Val(txtCellHeight.text)
    iSketchCellWidth = Val(txtCellWidth.text)
    iSketchMaxHeight = Val(txtMaxHeight.text)
    
    If bSaveSketchSettings Then
        SaveSetting "Offtake2", "Size", "iSketchRadiusOpt", iSketchRadiusOpt
        SaveSetting "Offtake2", "Size", "iSketchRadiusVal", iSketchRadiusVal
        SaveSetting "Offtake2", "Size", "iSketchScaleLft", iSketchScaleLft
        SaveSetting "Offtake2", "Size", "iSketchScaleRgt", iSketchScaleRgt
        
        SaveSetting "Offtake2", "Size", "iSketchShowDialog", iSketchShowDialog
        
        SaveSetting "Offtake2", "Size", "chkScaleHor.Value", chkScaleHor.Value
        SaveSetting "Offtake2", "Size", "chkScaleVer.Value", chkScaleVer.Value
        SaveSetting "Offtake2", "Size", "txtScaleHor.Value", txtScaleHor.text
        SaveSetting "Offtake2", "Size", "txtScaleVer.Value", txtScaleVer.text
        SaveSetting "Offtake2", "Size", "iSketchScaleHor", iSketchScaleHor
        SaveSetting "Offtake2", "Size", "iSketchScaleVer", iSketchScaleVer
        
        SaveSetting "Offtake2", "Size", "iSketchCellHeight", iSketchCellHeight
        SaveSetting "Offtake2", "Size", "iSketchCellWidth", iSketchCellWidth
        SaveSetting "Offtake2", "Size", "iSketchMaxHeight", iSketchMaxHeight
    End If

    Unload Me
    
    
    
End Sub


Private Sub Command1_Click()

    bFormOk = False
    
    Unload Me

End Sub

'/******************************************************************************
Private Sub Form_Load()
'/******************************************************************************

    bFormOk = False


    optRad(iSketchRadiusOpt).Value = True
    txtRad.text = iSketchRadiusVal
    txtScale(0).text = iSketchScaleLft
    txtScale(1).text = iSketchScaleRgt
    chkShow.Value = iSketchShowDialog
    
    chkScaleHor.Value = GetSetting("Offtake2", "Size", "chkScaleHor.Value", 0)
    chkScaleVer.Value = GetSetting("Offtake2", "Size", "chkScaleVer.Value", 0)
    txtScaleHor.text = GetSetting("Offtake2", "Size", "txtScaleHor.Value", txtScaleHor.text)
    txtScaleVer.text = GetSetting("Offtake2", "Size", "txtScaleVer.Value", txtScaleVer.text)
    
    txtCellHeight.text = iSketchCellHeight
    txtCellWidth.text = iSketchCellWidth
    txtMaxHeight.text = iSketchMaxHeight
    
    Me.Frame3.height = 1095

End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked

End Sub

