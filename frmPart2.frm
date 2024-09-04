VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{D76D7128-4A96-11D3-BD95-D296DC2DD072}#1.0#0"; "Vsflex7.ocx"
Begin VB.Form FPart 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   3705
   ClientLeft      =   255
   ClientTop       =   255
   ClientWidth     =   4830
   ControlBox      =   0   'False
   LinkTopic       =   "FP"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3705
   ScaleWidth      =   4830
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Slider sldTs 
      Height          =   195
      Left            =   2880
      TabIndex        =   32
      ToolTipText     =   "Изменение количества цифр после запятой для массы"
      Top             =   3480
      Width           =   705
      _ExtentX        =   1244
      _ExtentY        =   344
      _Version        =   393216
      LargeChange     =   0
      Max             =   4
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Пересчитать массу"
      Height          =   285
      Left            =   2880
      TabIndex        =   1
      ToolTipText     =   "Пересчитать массу позиции"
      Top             =   2520
      Width           =   1850
   End
   Begin VB.Frame FrameSchet 
      Caption         =   "%"
      Height          =   585
      Left            =   2880
      TabIndex        =   30
      Top             =   2880
      Width           =   1515
      Begin MSComCtl2.UpDown updPr 
         Height          =   285
         Left            =   1080
         TabIndex        =   38
         Top             =   195
         Width           =   240
         _ExtentX        =   423
         _ExtentY        =   503
         _Version        =   393216
         Enabled         =   -1  'True
      End
      Begin VB.TextBox Procent 
         Alignment       =   2  'Center
         Height          =   285
         Left            =   120
         TabIndex        =   31
         ToolTipText     =   "процентное содержание от общей массы изделия"
         Top             =   200
         Width           =   915
      End
   End
   Begin VB.Frame FrameChoise 
      Height          =   2500
      Left            =   2880
      TabIndex        =   20
      Top             =   0
      Width           =   1850
      Begin VB.OptionButton optMass 
         Caption         =   "процентно"
         Height          =   195
         Index           =   3
         Left            =   70
         TabIndex        =   28
         ToolTipText     =   "общая масса позиций умножается на проценты, которые указываются справа"
         Top             =   1960
         Width           =   1400
      End
      Begin VB.OptionButton optMass 
         Caption         =   "погонные метры"
         Height          =   195
         Index           =   0
         Left            =   70
         TabIndex        =   27
         ToolTipText     =   "исходная масса умножается на длину"
         Top             =   700
         Width           =   1700
      End
      Begin VB.OptionButton optMass 
         Caption         =   "по трем сторонам"
         Height          =   195
         Index           =   1
         Left            =   70
         TabIndex        =   26
         ToolTipText     =   "исходная масса умножается на длину, толщину и ширину"
         Top             =   950
         Width           =   1700
      End
      Begin VB.OptionButton optMass 
         Caption         =   "кольцо"
         Height          =   195
         Index           =   2
         Left            =   70
         TabIndex        =   25
         ToolTipText     =   "исходная масса умножается на площадь, рассчитанную по формуле кольца (для фланцев)"
         Top             =   1710
         Width           =   1400
      End
      Begin VB.TextBox InputMass 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   105
         TabIndex        =   24
         ToolTipText     =   "Исходная величина для расчета массы позиции, берется из сортамента"
         Top             =   350
         Width           =   1620
      End
      Begin VB.OptionButton optMass 
         Caption         =   "не считать"
         Height          =   195
         Index           =   4
         Left            =   70
         TabIndex        =   23
         ToolTipText     =   "масса позиции равна исходной массе"
         Top             =   2210
         Width           =   1400
      End
      Begin VB.OptionButton optMass 
         Caption         =   "площадь на толщ."
         Height          =   195
         Index           =   5
         Left            =   70
         TabIndex        =   22
         ToolTipText     =   "исходная масса умножается на площадь и толщину"
         Top             =   1200
         Width           =   1700
      End
      Begin VB.OptionButton optMass 
         Caption         =   "объем"
         Height          =   195
         Index           =   6
         Left            =   70
         TabIndex        =   21
         ToolTipText     =   "исходная масса умножается на объем"
         Top             =   1450
         Width           =   1400
      End
      Begin VB.Label Label12 
         AutoSize        =   -1  'True
         Caption         =   "исходная масса"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   204
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Left            =   195
         TabIndex        =   29
         Top             =   150
         Width           =   1455
      End
   End
   Begin VB.Frame Frame1 
      Height          =   750
      Left            =   120
      TabIndex        =   6
      Top             =   2880
      Width           =   2600
      Begin MSComCtl2.UpDown updC 
         Height          =   300
         Index           =   7
         Left            =   2230
         TabIndex        =   7
         ToolTipText     =   "Изменение на 1"
         Top             =   200
         Width           =   240
         _ExtentX        =   423
         _ExtentY        =   529
         _Version        =   393216
         OrigLeft        =   1995
         OrigTop         =   2835
         OrigRight       =   2265
         OrigBottom      =   3060
         Increment       =   1000
         Max             =   10000
         Enabled         =   -1  'True
      End
      Begin MSComCtl2.UpDown updC 
         Height          =   300
         Index           =   6
         Left            =   1980
         TabIndex        =   8
         ToolTipText     =   "Изменение на 5"
         Top             =   200
         Width           =   240
         _ExtentX        =   423
         _ExtentY        =   529
         _Version        =   393216
         OrigLeft        =   2520
         OrigTop         =   2835
         OrigRight       =   2790
         OrigBottom      =   3060
         Increment       =   100
         Max             =   10000
         Enabled         =   -1  'True
      End
      Begin MSComCtl2.UpDown updC 
         Height          =   300
         Index           =   5
         Left            =   1610
         TabIndex        =   9
         ToolTipText     =   "Изменение на 10"
         Top             =   200
         Width           =   240
         _ExtentX        =   423
         _ExtentY        =   529
         _Version        =   393216
         OrigLeft        =   2940
         OrigTop         =   2835
         OrigRight       =   3210
         OrigBottom      =   3060
         Increment       =   10
         Max             =   10000
         Enabled         =   -1  'True
      End
      Begin MSComCtl2.UpDown updC 
         Height          =   300
         Index           =   4
         Left            =   1360
         TabIndex        =   10
         ToolTipText     =   "Изменение на 50"
         Top             =   200
         Width           =   240
         _ExtentX        =   423
         _ExtentY        =   529
         _Version        =   393216
         OrigLeft        =   4410
         OrigTop         =   2625
         OrigRight       =   4680
         OrigBottom      =   2850
         Increment       =   1000
         Max             =   10000
         Enabled         =   -1  'True
      End
      Begin MSComCtl2.UpDown updC 
         Height          =   300
         Index           =   3
         Left            =   990
         TabIndex        =   11
         ToolTipText     =   "Изменение на 100"
         Top             =   200
         Width           =   240
         _ExtentX        =   423
         _ExtentY        =   529
         _Version        =   393216
         OrigLeft        =   3675
         OrigTop         =   2730
         OrigRight       =   3945
         OrigBottom      =   2955
         Increment       =   100
         Max             =   10000
         Enabled         =   -1  'True
      End
      Begin MSComCtl2.UpDown updC 
         Height          =   300
         Index           =   2
         Left            =   740
         TabIndex        =   12
         ToolTipText     =   "Изменение на 500"
         Top             =   200
         Width           =   240
         _ExtentX        =   423
         _ExtentY        =   529
         _Version        =   393216
         OrigLeft        =   3570
         OrigTop         =   2625
         OrigRight       =   3840
         OrigBottom      =   2850
         Increment       =   10
         Max             =   10000
         Enabled         =   -1  'True
      End
      Begin MSComCtl2.UpDown updC 
         Height          =   300
         Index           =   1
         Left            =   370
         TabIndex        =   13
         ToolTipText     =   "Изменение на 1000"
         Top             =   200
         Width           =   240
         _ExtentX        =   423
         _ExtentY        =   529
         _Version        =   393216
         OrigLeft        =   3465
         OrigTop         =   2625
         OrigRight       =   3735
         OrigBottom      =   2850
         Increment       =   5
         Max             =   10000
         Enabled         =   -1  'True
      End
      Begin MSComCtl2.UpDown updC 
         Height          =   300
         Index           =   0
         Left            =   120
         TabIndex        =   14
         ToolTipText     =   "Изменение на 5000"
         Top             =   195
         Width           =   240
         _ExtentX        =   423
         _ExtentY        =   529
         _Version        =   393216
         OrigLeft        =   4410
         OrigTop         =   2835
         OrigRight       =   4680
         OrigBottom      =   3165
         Max             =   10000
         Enabled         =   -1  'True
      End
      Begin VB.Label Label15 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "5:1000"
         Height          =   195
         Left            =   105
         TabIndex        =   18
         Top             =   495
         Width           =   525
      End
      Begin VB.Label Label14 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "5:100"
         Height          =   195
         Left            =   765
         TabIndex        =   17
         Top             =   495
         Width           =   435
      End
      Begin VB.Label Label13 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "5:10"
         Height          =   195
         Left            =   1440
         TabIndex        =   16
         Top             =   495
         Width           =   345
      End
      Begin VB.Label Label11 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "5:1"
         Height          =   195
         Left            =   2100
         TabIndex        =   15
         Top             =   495
         Width           =   255
      End
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   200
      Left            =   16080
      Top             =   7080
   End
   Begin VB.ComboBox Item 
      BackColor       =   &H00E0E0E0&
      Height          =   315
      Left            =   13440
      TabIndex        =   4
      ToolTipText     =   "Область данных"
      Top             =   7000
      Visible         =   0   'False
      Width           =   3000
   End
   Begin VB.CommandButton Command5 
      Caption         =   "None"
      Height          =   330
      Left            =   15120
      TabIndex        =   3
      ToolTipText     =   "Снять выделение"
      Top             =   6960
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.CommandButton Command4 
      Caption         =   "All"
      Height          =   330
      Left            =   15120
      TabIndex        =   2
      ToolTipText     =   "Выделить все"
      Top             =   7320
      Visible         =   0   'False
      Width           =   645
   End
   Begin VB.ListBox lstPart 
      BackColor       =   &H8000000F&
      Height          =   5685
      Left            =   14040
      Style           =   1  'Checkbox
      TabIndex        =   0
      ToolTipText     =   "Колонки таблицы позиций изделия"
      Top             =   7000
      Visible         =   0   'False
      Width           =   2010
   End
   Begin VSFlex7Ctl.VSFlexGrid FGParam 
      Height          =   2655
      Index           =   0
      Left            =   120
      TabIndex        =   5
      Top             =   120
      Width           =   2655
      _cx             =   4683
      _cy             =   4683
      _ConvInfo       =   1
      Appearance      =   0
      BorderStyle     =   0
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   204
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MousePointer    =   0
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      BackColorFixed  =   -2147483633
      ForeColorFixed  =   -2147483630
      BackColorSel    =   -2147483635
      ForeColorSel    =   -2147483634
      BackColorBkg    =   -2147483633
      BackColorAlternate=   -2147483643
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483632
      TreeColor       =   -2147483632
      FloodColor      =   192
      SheetBorder     =   -2147483633
      FocusRect       =   0
      HighLight       =   0
      AllowSelection  =   0   'False
      AllowBigSelection=   0   'False
      AllowUserResizing=   0
      SelectionMode   =   1
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   0
      Cols            =   3
      FixedRows       =   0
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   200
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   ""
      ScrollTrack     =   0   'False
      ScrollBars      =   3
      ScrollTips      =   0   'False
      MergeCells      =   0
      MergeCompare    =   0
      AutoResize      =   -1  'True
      AutoSizeMode    =   0
      AutoSearch      =   0
      AutoSearchDelay =   2
      MultiTotals     =   -1  'True
      SubtotalPosition=   1
      OutlineBar      =   0
      OutlineCol      =   0
      Ellipsis        =   0
      ExplorerBar     =   0
      PicturesOver    =   0   'False
      FillStyle       =   0
      RightToLeft     =   0   'False
      PictureType     =   0
      TabBehavior     =   0
      OwnerDraw       =   0
      Editable        =   2
      ShowComboButton =   -1  'True
      WordWrap        =   0   'False
      TextStyle       =   0
      TextStyleFixed  =   0
      OleDragMode     =   0
      OleDropMode     =   0
      DataMode        =   0
      VirtualData     =   -1  'True
      DataMember      =   ""
      ComboSearch     =   3
      AutoSizeMouse   =   -1  'True
      FrozenRows      =   0
      FrozenCols      =   0
      AllowUserFreezing=   0
      BackColorFrozen =   0
      ForeColorFrozen =   0
      WallPaperAlignment=   9
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   12480
      Top             =   9120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPart2.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPart2.frx":005E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VSFlex7Ctl.VSFlexGrid FGParam 
      Height          =   1935
      Index           =   1
      Left            =   11880
      TabIndex        =   19
      Top             =   4080
      Width           =   3015
      _cx             =   5318
      _cy             =   3413
      _ConvInfo       =   1
      Appearance      =   0
      BorderStyle     =   0
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   204
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MousePointer    =   0
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      BackColorFixed  =   -2147483633
      ForeColorFixed  =   -2147483630
      BackColorSel    =   -2147483635
      ForeColorSel    =   -2147483634
      BackColorBkg    =   -2147483633
      BackColorAlternate=   -2147483643
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483632
      TreeColor       =   -2147483632
      FloodColor      =   192
      SheetBorder     =   -2147483633
      FocusRect       =   0
      HighLight       =   0
      AllowSelection  =   0   'False
      AllowBigSelection=   0   'False
      AllowUserResizing=   0
      SelectionMode   =   1
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   0
      Cols            =   3
      FixedRows       =   0
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   200
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   ""
      ScrollTrack     =   0   'False
      ScrollBars      =   3
      ScrollTips      =   0   'False
      MergeCells      =   0
      MergeCompare    =   0
      AutoResize      =   -1  'True
      AutoSizeMode    =   0
      AutoSearch      =   0
      AutoSearchDelay =   2
      MultiTotals     =   -1  'True
      SubtotalPosition=   1
      OutlineBar      =   0
      OutlineCol      =   0
      Ellipsis        =   0
      ExplorerBar     =   0
      PicturesOver    =   0   'False
      FillStyle       =   0
      RightToLeft     =   0   'False
      PictureType     =   0
      TabBehavior     =   0
      OwnerDraw       =   0
      Editable        =   2
      ShowComboButton =   -1  'True
      WordWrap        =   0   'False
      TextStyle       =   0
      TextStyleFixed  =   0
      OleDragMode     =   0
      OleDropMode     =   0
      DataMode        =   0
      VirtualData     =   -1  'True
      DataMember      =   ""
      ComboSearch     =   3
      AutoSizeMouse   =   -1  'True
      FrozenRows      =   0
      FrozenCols      =   0
      AllowUserFreezing=   0
      BackColorFrozen =   0
      ForeColorFrozen =   0
      WallPaperAlignment=   9
   End
   Begin VB.Label lblTs 
      AutoSize        =   -1  'True
      Caption         =   "0"
      Height          =   195
      Left            =   3600
      TabIndex        =   33
      Top             =   3480
      Width           =   90
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H00E0E0E0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Наименование"
      Height          =   285
      Left            =   12000
      TabIndex        =   37
      ToolTipText     =   "Светлые параметры необходимы при расчете выборки"
      Top             =   1860
      Width           =   1350
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00E0E0E0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Характеристика"
      Height          =   285
      Left            =   12000
      TabIndex        =   36
      ToolTipText     =   "Светлые параметры необходимы при расчете выборки"
      Top             =   1530
      Width           =   1350
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H00E0E0E0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Стандарт"
      Height          =   285
      Left            =   12000
      TabIndex        =   35
      ToolTipText     =   "Светлые параметры необходимы при расчете выборки"
      Top             =   2520
      Width           =   1350
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H00E0E0E0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Материал"
      Height          =   285
      Left            =   12000
      TabIndex        =   34
      ToolTipText     =   "Светлые параметры необходимы при расчете выборки"
      Top             =   2190
      Width           =   1350
   End
   Begin VB.Menu mnu_f1 
      Caption         =   "типа полундра"
      Visible         =   0   'False
      Begin VB.Menu mnu_edittable 
         Caption         =   "Выбрать из сортамента ..."
      End
   End
End
Attribute VB_Name = "FPart"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private intTekParamIndex As Integer
Private intTekParameter As Integer



Private picArrow As New StdPicture
Private picArrowR As New StdPicture










Private Sub FGParam_AfterRowColChange(Index As Integer, ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long)


Me.FGParam(Index).Cell(flexcpPicture, OldRow, 0) = Nothing
Me.FGParam(Index).Cell(flexcpPicture, NewRow, 0) = picArrow
Me.FGParam(Index).Cell(flexcpPicture, OldRow, 2) = Nothing
Me.FGParam(Index).Cell(flexcpPicture, NewRow, 2) = picArrowR
intTekParameter = NewRow
Me.FGParam(Index).AutoSize 0
If NewCol < 2 Then Me.FGParam(Index).Col = 2


End Sub

Private Sub FGParam_BeforeEdit(Index As Integer, ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)

If Col < 2 Then Cancel = True



End Sub

Private Sub FGParam_GotFocus(Index As Integer)
       
       
       Me.FGParam(intTekParamIndex).Cell(flexcpPicture, 0, 0, FGParam(intTekParamIndex).Rows - 1, 0) = Nothing
       Me.FGParam(intTekParamIndex).Cell(flexcpPicture, 0, 2, FGParam(intTekParamIndex).Rows - 1, 2) = Nothing
       
       
       
       intTekParamIndex = Index
       intTekParameter = Me.FGParam(Index).Row
       Me.FGParam(Index).Cell(flexcpPicture, Me.FGParam(Index).Row, 0) = picArrow
       Me.FGParam(Index).Cell(flexcpPicture, Me.FGParam(Index).Row, 2) = picArrowR
       
End Sub

Private Sub FGParam_LostFocus(Index As Integer)


Me.FGParam(Index).Cell(flexcpPicture, Me.FGParam(Index).Row, 2) = Nothing




End Sub



Private Sub Form_Deactivate()

Unload Me

End Sub

Private Sub Form_Load()
       
       
       Dim I As Integer
       Dim RSD As New ADODB.Recordset
       Dim SQLD As String
       
       
       
       Set picArrow = Me.ImageList1.ListImages(1).Picture
       Set picArrowR = Me.ImageList1.ListImages(2).Picture
       
       
       
       With Me.FGParam(0)
              .AddItem "   " & vbTab & "Количество"
              .AddItem "   " & vbTab & "Длина"
              .AddItem "   " & vbTab & "Толщина"
              .AddItem "   " & vbTab & "Ширина"
              .AddItem "   " & vbTab & "Высота"
              .AddItem "   " & vbTab & "Диаметр"
              .AddItem "   " & vbTab & "Радиус"
              .AddItem "   " & vbTab & "Внешн.рад."
              .AddItem "   " & vbTab & "Внутр.рад."
              .AddItem "   " & vbTab & "Сегмент"
              .Cell(flexcpBackColor, 0, 0, .Rows - 1, 1) = &H8000000F
              .Cell(flexcpBackColor, 0, 2, 0, 2) = &HC0FFFF
              .AutoSize 0, 2
              .Cell(flexcpAlignment, 0, 2, .Rows - 1) = 1
       End With
       
       With Me.FGParam(1)
              .AddItem "   " & vbTab & "Объем"
              .AddItem "   " & vbTab & "Площадь"
              .AddItem "   " & vbTab & "Масса"
              .Cell(flexcpBackColor, 2, 2, 2, 2) = &HC0FFC0
              .AddItem "   " & vbTab & "Масса р."
              .Cell(flexcpBackColor, 3, 2, 3, 2) = &HFFFFC0
              .AddItem "   " & vbTab & "Общая м."
              .Cell(flexcpBackColor, 4, 2, 4, 2) = &HC0FFC0
              .AddItem "   " & vbTab & "Общая м. р."
              .Cell(flexcpBackColor, 5, 2, 5, 2) = &HFFFFC0
              .Cell(flexcpBackColor, 0, 0, .Rows - 1, 1) = &H8000000F
              .AutoSize 0, 2
              .Cell(flexcpAlignment, 0, 2, .Rows - 1) = 1
       End With
       
       
       Me.FGParam(0).Cell(flexcpPictureAlignment, 0, 0, Me.FGParam(0).Rows - 1) = flexPicAlignLeftCenter
       Me.FGParam(1).Cell(flexcpPictureAlignment, 0, 0, Me.FGParam(1).Rows - 1) = flexPicAlignLeftCenter
       Me.FGParam(0).Cell(flexcpPictureAlignment, 0, 2, Me.FGParam(0).Rows - 1) = flexPicAlignRightCenter
       Me.FGParam(1).Cell(flexcpPictureAlignment, 0, 2, Me.FGParam(1).Rows - 1) = flexPicAlignRightCenter
       
       Me.FGParam(0).Height = 240 * Me.FGParam(0).Rows + 60
       Me.FGParam(1).Height = 240 * Me.FGParam(1).Rows + 60
'       FGParam_GotFocus 0
'       FGParam_LostFocus 0
       
       
       

End Sub



