VERSION 5.00
Object = "{0AFE7BE0-11B7-4A3E-978D-D4501E9A57FE}#1.0#0"; "C1Sizer.ocx"
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Begin VB.Form frmPosdef 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Определение позиций"
   ClientHeight    =   7005
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9855
   Icon            =   "frmPosdef.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7005
   ScaleWidth      =   9855
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin C1SizerLibCtl.C1Tab C1Tab1 
      Height          =   6735
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   9615
      _cx             =   16960
      _cy             =   11880
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   204
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   -1  'True
      Appearance      =   2
      MousePointer    =   0
      Version         =   801
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      FrontTabColor   =   -2147483633
      BackTabColor    =   -2147483633
      TabOutlineColor =   -2147483632
      FrontTabForeColor=   -2147483630
      Caption         =   "Типы позиций|Свойства позиций|Расчёт массы"
      Align           =   0
      CurrTab         =   0
      FirstTab        =   0
      Style           =   3
      Position        =   0
      AutoSwitch      =   -1  'True
      AutoScroll      =   -1  'True
      TabPreview      =   -1  'True
      ShowFocusRect   =   0   'False
      TabsPerPage     =   0
      BorderWidth     =   0
      BoldCurrent     =   0   'False
      DogEars         =   -1  'True
      MultiRow        =   0   'False
      MultiRowOffset  =   200
      CaptionStyle    =   0
      TabHeight       =   0
      TabCaptionPos   =   4
      TabPicturePos   =   0
      CaptionEmpty    =   ""
      Separators      =   0   'False
      AccessibleName  =   ""
      AccessibleDescription=   ""
      AccessibleValue =   ""
      AccessibleRole  =   37
      Begin C1SizerLibCtl.C1Elastic C1Elastic3 
         Height          =   6360
         Left            =   10560
         TabIndex        =   41
         TabStop         =   0   'False
         Top             =   330
         Width           =   9525
         _cx             =   16801
         _cy             =   11218
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Enabled         =   -1  'True
         Appearance      =   5
         MousePointer    =   0
         Version         =   801
         BackColor       =   -2147483633
         ForeColor       =   -2147483630
         FloodColor      =   6553600
         ForeColorDisabled=   -2147483631
         Caption         =   ""
         Align           =   0
         AutoSizeChildren=   0
         BorderWidth     =   6
         ChildSpacing    =   4
         Splitter        =   0   'False
         FloodDirection  =   0
         FloodPercent    =   0
         CaptionPos      =   1
         WordWrap        =   -1  'True
         MaxChildSize    =   0
         MinChildSize    =   0
         TagWidth        =   0
         TagPosition     =   0
         Style           =   0
         TagSplit        =   2
         PicturePos      =   4
         CaptionStyle    =   0
         ResizeFonts     =   0   'False
         GridRows        =   0
         GridCols        =   0
         Frame           =   3
         FrameStyle      =   0
         FrameWidth      =   1
         FrameColor      =   -2147483628
         FrameShadow     =   -2147483632
         FloodStyle      =   1
         _GridInfo       =   ""
         AccessibleName  =   ""
         AccessibleDescription=   ""
         AccessibleValue =   ""
         AccessibleRole  =   9
         Begin VB.ComboBox cmbMCTable 
            Height          =   315
            ItemData        =   "frmPosdef.frx":000C
            Left            =   3480
            List            =   "frmPosdef.frx":001F
            Style           =   2  'Dropdown List
            TabIndex        =   49
            Top             =   1320
            Width           =   2175
         End
         Begin VB.ComboBox cmbCalc 
            Height          =   315
            Left            =   3480
            Style           =   2  'Dropdown List
            TabIndex        =   47
            Top             =   360
            Width           =   2175
         End
         Begin VSFlex8Ctl.VSFlexGrid fgMassCalc 
            Height          =   6015
            Left            =   120
            TabIndex        =   42
            Top             =   120
            Width           =   2895
            _cx             =   103224306
            _cy             =   103229810
            Appearance      =   2
            BorderStyle     =   1
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
            BackColorBkg    =   -2147483636
            BackColorAlternate=   -2147483643
            GridColor       =   -2147483633
            GridColorFixed  =   -2147483632
            TreeColor       =   -2147483632
            FloodColor      =   192
            SheetBorder     =   -2147483642
            FocusRect       =   0
            HighLight       =   1
            AllowSelection  =   0   'False
            AllowBigSelection=   0   'False
            AllowUserResizing=   0
            SelectionMode   =   1
            GridLines       =   1
            GridLinesFixed  =   2
            GridLineWidth   =   1
            Rows            =   50
            Cols            =   2
            FixedRows       =   0
            FixedCols       =   0
            RowHeightMin    =   0
            RowHeightMax    =   0
            ColWidthMin     =   0
            ColWidthMax     =   0
            ExtendLastCol   =   -1  'True
            FormatString    =   ""
            ScrollTrack     =   -1  'True
            ScrollBars      =   2
            ScrollTips      =   -1  'True
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
            ShowComboButton =   1
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
            AccessibleName  =   ""
            AccessibleDescription=   ""
            AccessibleValue =   ""
            AccessibleRole  =   24
         End
         Begin VSFlex8Ctl.VSFlexGrid fgMcPropEdit 
            Height          =   2175
            Left            =   6720
            TabIndex        =   43
            Top             =   600
            Width           =   2655
            _cx             =   103223883
            _cy             =   103223036
            Appearance      =   2
            BorderStyle     =   1
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
            BackColorBkg    =   -2147483636
            BackColorAlternate=   -2147483643
            GridColor       =   -2147483633
            GridColorFixed  =   -2147483632
            TreeColor       =   -2147483632
            FloodColor      =   192
            SheetBorder     =   -2147483642
            FocusRect       =   0
            HighLight       =   1
            AllowSelection  =   0   'False
            AllowBigSelection=   0   'False
            AllowUserResizing=   0
            SelectionMode   =   1
            GridLines       =   1
            GridLinesFixed  =   2
            GridLineWidth   =   1
            Rows            =   50
            Cols            =   3
            FixedRows       =   0
            FixedCols       =   0
            RowHeightMin    =   0
            RowHeightMax    =   0
            ColWidthMin     =   0
            ColWidthMax     =   0
            ExtendLastCol   =   -1  'True
            FormatString    =   ""
            ScrollTrack     =   -1  'True
            ScrollBars      =   2
            ScrollTips      =   -1  'True
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
            ShowComboButton =   1
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
            AccessibleName  =   ""
            AccessibleDescription=   ""
            AccessibleValue =   ""
            AccessibleRole  =   24
         End
         Begin VB.Label Label17 
            Caption         =   "Масса единицы"
            Height          =   255
            Left            =   3480
            TabIndex        =   50
            Top             =   1080
            Width           =   2175
         End
         Begin VB.Label Label16 
            Caption         =   "Зависимость"
            Height          =   255
            Left            =   3480
            TabIndex        =   48
            Top             =   120
            Width           =   2055
         End
         Begin VB.Label Label14 
            Caption         =   "Свойства для расчета массы"
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
            Left            =   6720
            TabIndex        =   45
            Top             =   120
            Width           =   2655
         End
         Begin VB.Label Label13 
            Caption         =   "(свойства сортамента выделены)"
            Height          =   255
            Left            =   6720
            TabIndex        =   44
            Top             =   360
            Width           =   2655
         End
      End
      Begin C1SizerLibCtl.C1Elastic C1Elastic2 
         Height          =   6360
         Left            =   10260
         TabIndex        =   25
         TabStop         =   0   'False
         Top             =   330
         Width           =   9525
         _cx             =   16801
         _cy             =   11218
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Enabled         =   -1  'True
         Appearance      =   5
         MousePointer    =   0
         Version         =   801
         BackColor       =   -2147483633
         ForeColor       =   -2147483630
         FloodColor      =   6553600
         ForeColorDisabled=   -2147483631
         Caption         =   ""
         Align           =   0
         AutoSizeChildren=   0
         BorderWidth     =   6
         ChildSpacing    =   4
         Splitter        =   0   'False
         FloodDirection  =   0
         FloodPercent    =   0
         CaptionPos      =   1
         WordWrap        =   -1  'True
         MaxChildSize    =   0
         MinChildSize    =   0
         TagWidth        =   0
         TagPosition     =   0
         Style           =   0
         TagSplit        =   2
         PicturePos      =   4
         CaptionStyle    =   0
         ResizeFonts     =   0   'False
         GridRows        =   0
         GridCols        =   0
         Frame           =   3
         FrameStyle      =   0
         FrameWidth      =   1
         FrameColor      =   -2147483628
         FrameShadow     =   -2147483632
         FloodStyle      =   1
         _GridInfo       =   ""
         AccessibleName  =   ""
         AccessibleDescription=   ""
         AccessibleValue =   ""
         AccessibleRole  =   9
         Begin VB.Frame Frame2 
            Caption         =   "Свойство"
            Height          =   3135
            Left            =   4200
            TabIndex        =   27
            Top             =   240
            Width           =   4455
            Begin VB.TextBox txtPropName 
               Height          =   285
               Left            =   240
               TabIndex        =   34
               Top             =   360
               Width           =   3855
            End
            Begin VB.TextBox txtPropDescr 
               Height          =   285
               Left            =   240
               TabIndex        =   33
               Top             =   720
               Width           =   3855
            End
            Begin VB.ComboBox cmbPropValue 
               Height          =   315
               Left            =   240
               Style           =   2  'Dropdown List
               TabIndex        =   32
               Top             =   1200
               Width           =   2175
            End
            Begin VB.ComboBox cmbMUnits 
               Height          =   315
               Left            =   240
               Style           =   2  'Dropdown List
               TabIndex        =   31
               Top             =   1680
               Width           =   2175
            End
            Begin VB.TextBox txtDefValue 
               Height          =   285
               Left            =   2520
               TabIndex        =   30
               Top             =   1680
               Width           =   1575
            End
            Begin VB.ComboBox cmbMUnitsSrtm 
               Height          =   315
               Left            =   1920
               Style           =   2  'Dropdown List
               TabIndex        =   29
               Top             =   2160
               Width           =   2175
            End
            Begin VB.ComboBox cmbTable 
               Height          =   315
               ItemData        =   "frmPosdef.frx":0045
               Left            =   240
               List            =   "frmPosdef.frx":0052
               Style           =   2  'Dropdown List
               TabIndex        =   28
               Top             =   2640
               Width           =   2655
            End
            Begin VB.Label Label10 
               Caption         =   "по умолчанию"
               Height          =   255
               Left            =   2520
               TabIndex        =   36
               Top             =   1440
               Width           =   1335
            End
            Begin VB.Label Label11 
               Alignment       =   1  'Right Justify
               Caption         =   "в сортаменте"
               Height          =   255
               Left            =   360
               TabIndex        =   35
               Top             =   2160
               Width           =   1455
            End
         End
         Begin VSFlex8Ctl.VSFlexGrid fgSrtmProps 
            Height          =   6015
            Left            =   120
            TabIndex        =   26
            Top             =   120
            Width           =   3855
            _cx             =   103226000
            _cy             =   103229810
            Appearance      =   2
            BorderStyle     =   1
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
            BackColorBkg    =   -2147483636
            BackColorAlternate=   -2147483643
            GridColor       =   -2147483633
            GridColorFixed  =   -2147483632
            TreeColor       =   -2147483632
            FloodColor      =   192
            SheetBorder     =   -2147483642
            FocusRect       =   0
            HighLight       =   1
            AllowSelection  =   0   'False
            AllowBigSelection=   0   'False
            AllowUserResizing=   0
            SelectionMode   =   1
            GridLines       =   1
            GridLinesFixed  =   2
            GridLineWidth   =   1
            Rows            =   50
            Cols            =   5
            FixedRows       =   1
            FixedCols       =   0
            RowHeightMin    =   0
            RowHeightMax    =   0
            ColWidthMin     =   0
            ColWidthMax     =   0
            ExtendLastCol   =   -1  'True
            FormatString    =   ""
            ScrollTrack     =   -1  'True
            ScrollBars      =   2
            ScrollTips      =   -1  'True
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
            Editable        =   0
            ShowComboButton =   1
            WordWrap        =   0   'False
            TextStyle       =   0
            TextStyleFixed  =   0
            OleDragMode     =   0
            OleDropMode     =   0
            DataMode        =   0
            VirtualData     =   -1  'True
            DataMember      =   ""
            ComboSearch     =   3
            AutoSizeMouse   =   0   'False
            FrozenRows      =   0
            FrozenCols      =   0
            AllowUserFreezing=   0
            BackColorFrozen =   0
            ForeColorFrozen =   0
            WallPaperAlignment=   9
            AccessibleName  =   ""
            AccessibleDescription=   ""
            AccessibleValue =   ""
            AccessibleRole  =   24
         End
      End
      Begin C1SizerLibCtl.C1Elastic C1Elastic1 
         Height          =   6360
         Left            =   45
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   330
         Width           =   9525
         _cx             =   16801
         _cy             =   11218
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   204
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Enabled         =   -1  'True
         Appearance      =   5
         MousePointer    =   0
         Version         =   801
         BackColor       =   -2147483633
         ForeColor       =   -2147483630
         FloodColor      =   6553600
         ForeColorDisabled=   -2147483631
         Caption         =   ""
         Align           =   0
         AutoSizeChildren=   0
         BorderWidth     =   6
         ChildSpacing    =   4
         Splitter        =   0   'False
         FloodDirection  =   0
         FloodPercent    =   0
         CaptionPos      =   1
         WordWrap        =   -1  'True
         MaxChildSize    =   0
         MinChildSize    =   0
         TagWidth        =   0
         TagPosition     =   0
         Style           =   0
         TagSplit        =   2
         PicturePos      =   4
         CaptionStyle    =   0
         ResizeFonts     =   0   'False
         GridRows        =   0
         GridCols        =   0
         Frame           =   3
         FrameStyle      =   0
         FrameWidth      =   1
         FrameColor      =   -2147483628
         FrameShadow     =   -2147483632
         FloodStyle      =   1
         _GridInfo       =   ""
         AccessibleName  =   ""
         AccessibleDescription=   ""
         AccessibleValue =   ""
         AccessibleRole  =   9
         Begin VB.CheckBox chkSort 
            Caption         =   "сортировка"
            Height          =   255
            Left            =   6600
            TabIndex        =   52
            Top             =   6000
            Width           =   1335
         End
         Begin VB.CheckBox chkPosNum 
            Caption         =   "нумеровать позиции изделия"
            Height          =   255
            Left            =   3240
            TabIndex        =   51
            Top             =   6000
            Width           =   4215
         End
         Begin VB.TextBox txtName 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   204
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   390
            Left            =   3240
            TabIndex        =   16
            Top             =   375
            Width           =   3255
         End
         Begin VB.TextBox txtNames 
            Height          =   285
            Left            =   3240
            TabIndex        =   15
            Top             =   1080
            Width           =   3255
         End
         Begin VB.CheckBox chkMassCommon 
            Caption         =   "в выборке считать массу отдельно"
            Height          =   255
            Left            =   3240
            TabIndex        =   14
            Top             =   5760
            Width           =   4095
         End
         Begin VB.TextBox txtOfftSymb 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   9.75
               Charset         =   204
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   5520
            TabIndex        =   13
            Top             =   3120
            Width           =   615
         End
         Begin VB.CheckBox chkDrawName 
            Caption         =   "перед наименованием добавлять тип позиции"
            Height          =   255
            Left            =   3240
            TabIndex        =   12
            Top             =   5520
            Width           =   4455
         End
         Begin VB.TextBox txtDrawSymbol 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   9.75
               Charset         =   204
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   5520
            TabIndex        =   11
            Top             =   3480
            Width           =   615
         End
         Begin VB.TextBox txtDrawSrtmPrefix 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   9.75
               Charset         =   204
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   5520
            TabIndex        =   10
            Top             =   3840
            Width           =   615
         End
         Begin VB.ComboBox cmbMassCalc 
            Height          =   315
            Left            =   3240
            Style           =   2  'Dropdown List
            TabIndex        =   9
            Top             =   2520
            Width           =   2895
         End
         Begin VB.TextBox txtDefaultQty 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   9.75
               Charset         =   204
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   5520
            TabIndex        =   8
            Top             =   4200
            Width           =   615
         End
         Begin VB.ComboBox cmbPosDefGlobal 
            Height          =   315
            Left            =   3240
            Style           =   2  'Dropdown List
            TabIndex        =   7
            Top             =   1800
            Width           =   2895
         End
         Begin VB.CommandButton btnSave 
            Enabled         =   0   'False
            Height          =   735
            Left            =   8520
            Picture         =   "frmPosdef.frx":0095
            Style           =   1  'Graphical
            TabIndex        =   6
            Top             =   5400
            Width           =   855
         End
         Begin VB.Frame Frame1 
            Caption         =   "Использование массы"
            Height          =   855
            Left            =   3240
            TabIndex        =   3
            Top             =   4560
            Width           =   2895
            Begin VB.OptionButton optMassLevel 
               Caption         =   "первостепенное"
               Height          =   255
               Index           =   0
               Left            =   120
               TabIndex        =   5
               Top             =   240
               Value           =   -1  'True
               Width           =   1935
            End
            Begin VB.OptionButton optMassLevel 
               Caption         =   "второстепенное"
               Height          =   255
               Index           =   1
               Left            =   120
               TabIndex        =   4
               Top             =   480
               Width           =   1815
            End
         End
         Begin VSFlex8Ctl.VSFlexGrid FG 
            Height          =   6015
            Left            =   120
            TabIndex        =   2
            Top             =   120
            Width           =   2895
            _cx             =   103224306
            _cy             =   103229810
            Appearance      =   2
            BorderStyle     =   1
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
            BackColorBkg    =   -2147483636
            BackColorAlternate=   -2147483643
            GridColor       =   -2147483633
            GridColorFixed  =   -2147483632
            TreeColor       =   -2147483632
            FloodColor      =   192
            SheetBorder     =   -2147483642
            FocusRect       =   0
            HighLight       =   1
            AllowSelection  =   0   'False
            AllowBigSelection=   0   'False
            AllowUserResizing=   1
            SelectionMode   =   1
            GridLines       =   1
            GridLinesFixed  =   2
            GridLineWidth   =   1
            Rows            =   50
            Cols            =   10
            FixedRows       =   1
            FixedCols       =   0
            RowHeightMin    =   0
            RowHeightMax    =   0
            ColWidthMin     =   0
            ColWidthMax     =   0
            ExtendLastCol   =   -1  'True
            FormatString    =   ""
            ScrollTrack     =   -1  'True
            ScrollBars      =   2
            ScrollTips      =   -1  'True
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
            ShowComboButton =   1
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
            AccessibleName  =   ""
            AccessibleDescription=   ""
            AccessibleValue =   ""
            AccessibleRole  =   24
         End
         Begin VSFlex8Ctl.VSFlexGrid fgPosProp 
            Height          =   2175
            Left            =   6720
            TabIndex        =   37
            Top             =   600
            Width           =   2655
            _cx             =   106435147
            _cy             =   106434300
            Appearance      =   2
            BorderStyle     =   1
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
            BackColorBkg    =   -2147483636
            BackColorAlternate=   -2147483643
            GridColor       =   -2147483633
            GridColorFixed  =   -2147483632
            TreeColor       =   -2147483632
            FloodColor      =   192
            SheetBorder     =   -2147483642
            FocusRect       =   0
            HighLight       =   1
            AllowSelection  =   0   'False
            AllowBigSelection=   0   'False
            AllowUserResizing=   0
            SelectionMode   =   1
            GridLines       =   1
            GridLinesFixed  =   2
            GridLineWidth   =   1
            Rows            =   50
            Cols            =   4
            FixedRows       =   0
            FixedCols       =   0
            RowHeightMin    =   0
            RowHeightMax    =   0
            ColWidthMin     =   0
            ColWidthMax     =   0
            ExtendLastCol   =   -1  'True
            FormatString    =   ""
            ScrollTrack     =   -1  'True
            ScrollBars      =   2
            ScrollTips      =   -1  'True
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
            ShowComboButton =   1
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
            AccessibleName  =   ""
            AccessibleDescription=   ""
            AccessibleValue =   ""
            AccessibleRole  =   24
         End
         Begin VSFlex8Ctl.VSFlexGrid fgMcProp 
            Height          =   2175
            Left            =   6720
            TabIndex        =   38
            Top             =   3120
            Width           =   2655
            _cx             =   103223883
            _cy             =   103223036
            Appearance      =   2
            BorderStyle     =   1
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
            BackColorBkg    =   -2147483636
            BackColorAlternate=   -2147483643
            GridColor       =   -2147483633
            GridColorFixed  =   -2147483632
            TreeColor       =   -2147483632
            FloodColor      =   192
            SheetBorder     =   -2147483642
            FocusRect       =   0
            HighLight       =   1
            AllowSelection  =   0   'False
            AllowBigSelection=   0   'False
            AllowUserResizing=   0
            SelectionMode   =   1
            GridLines       =   1
            GridLinesFixed  =   2
            GridLineWidth   =   1
            Rows            =   50
            Cols            =   3
            FixedRows       =   0
            FixedCols       =   0
            RowHeightMin    =   0
            RowHeightMax    =   0
            ColWidthMin     =   0
            ColWidthMax     =   0
            ExtendLastCol   =   -1  'True
            FormatString    =   ""
            ScrollTrack     =   -1  'True
            ScrollBars      =   2
            ScrollTips      =   -1  'True
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
            ShowComboButton =   1
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
            AccessibleName  =   ""
            AccessibleDescription=   ""
            AccessibleValue =   ""
            AccessibleRole  =   24
         End
         Begin VB.Label Label15 
            Caption         =   "(галка - сортировка при выборе)"
            Height          =   255
            Left            =   6720
            TabIndex        =   46
            Top             =   360
            Width           =   2655
         End
         Begin VB.Label Label12 
            Caption         =   "Свойства позиции"
            Height          =   255
            Left            =   6720
            TabIndex        =   40
            Top             =   120
            Width           =   2655
         End
         Begin VB.Label Label9 
            Caption         =   "Свойства для расчета массы"
            Height          =   255
            Left            =   6720
            TabIndex        =   39
            Top             =   2880
            Width           =   2295
         End
         Begin VB.Label Label1 
            Caption         =   "Символ позиции в выборке"
            Height          =   255
            Left            =   3240
            TabIndex        =   24
            Top             =   3120
            Width           =   2175
         End
         Begin VB.Label Label2 
            Caption         =   "Фрагмент библиотеки"
            Height          =   255
            Left            =   3240
            TabIndex        =   23
            Top             =   3480
            Width           =   2175
         End
         Begin VB.Label Label3 
            Caption         =   "Префикс наименования"
            Height          =   255
            Left            =   3240
            TabIndex        =   22
            Top             =   3840
            Width           =   2175
         End
         Begin VB.Label Label4 
            Caption         =   "Количество по умолчанию"
            Height          =   255
            Left            =   3240
            TabIndex        =   21
            Top             =   4200
            Width           =   2175
         End
         Begin VB.Label Label5 
            Caption         =   "Наименование"
            Height          =   255
            Left            =   3240
            TabIndex        =   20
            Top             =   120
            Width           =   2655
         End
         Begin VB.Label Label6 
            Caption         =   "Наименование во множ. числе"
            Height          =   255
            Left            =   3240
            TabIndex        =   19
            Top             =   840
            Width           =   2655
         End
         Begin VB.Label Label7 
            Caption         =   "Принадлежность в выборке"
            Height          =   255
            Left            =   3240
            TabIndex        =   18
            Top             =   1560
            Width           =   2655
         End
         Begin VB.Label Label8 
            Caption         =   "Расчет массы"
            Height          =   255
            Left            =   3240
            TabIndex        =   17
            Top             =   2280
            Width           =   2655
         End
      End
   End
End
Attribute VB_Name = "frmPosdef"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Dim pd As clsPD
Dim pdg As clsPD
Dim calc As clsMC

Public sCurSort As String

Dim bBrys As Boolean

Sub loadGrids()

    bBrys = True

    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select posdefID, posdefUsing as [u], sortNumber as [sn], posdefName from posdef order by " & sCurSort, cn_srtm, adOpenStatic, adLockReadOnly
    Set FG.DataSource = RS
    FG.ColHidden(0) = True ' pdID
'    FG.ColHidden(2) = True ' sortNumber
    
    
    RS.Close
    Set RS = Nothing
    
    FG.AddItem 0 & vbTab & 0 & vbTab & ""
    
    
    fgSrtmProps.Rows = 1
    fgSrtmProps.TextMatrix(0, 0) = "id"
    fgSrtmProps.TextMatrix(0, 1) = "Срт"
    fgSrtmProps.TextMatrix(0, 2) = "Мас"
    fgSrtmProps.TextMatrix(0, 3) = "Свойство"
    fgSrtmProps.TextMatrix(0, 4) = "name"
    fgSrtmProps.ColHidden(0) = True
    fgSrtmProps.ColHidden(1) = True
    fgSrtmProps.ColHidden(2) = True
    fgSrtmProps.ColHidden(4) = True
    fgSrtmProps.ColDataType(1) = flexDTBoolean
    fgSrtmProps.ColDataType(2) = flexDTBoolean
    
    fgPosProp.ColHidden(0) = True
    fgPosProp.ColHidden(1) = True
    fgPosProp.ColDataType(2) = flexDTBoolean
    If fgPosProp.Rows = 0 Then fgPosProp.AddItem 0
    fgPosProp.ColWidth(2) = 300
    
    fgMcProp.ColHidden(0) = True
    fgMcProp.ColHidden(1) = True
    
    fgMcPropEdit.ColHidden(0) = True
    fgMcPropEdit.ColHidden(1) = True
    
    fgMassCalc.ColHidden(0) = True
    
    Dim pr As clsProp
    
    For Each pr In globProps
    
        fgSrtmProps.AddItem pr.propID & vbTab & vbTab & vbTab & pr.propDescr & vbTab & pr.propName
    
    Next pr
    
    fgSrtmProps.AutoSize 1, 2
    
    
    Dim mc As clsMC
    
    fgMassCalc.Rows = 0
    For Each mc In globMassCalcs
    
        fgMassCalc.AddItem mc.mcID & vbTab & mc.mcName
    
    Next mc
    
    fgSrtmProps.AutoSize 1, 2
    
    
    Set RS = New ADODB.Recordset
    RS.Open "select * from property where [using] = 1", cn_srtm, adOpenStatic, adLockReadOnly
    
    
    Dim s As String
    
    s = fgPosProp.BuildComboList(RS, "propDescr", "propID")
    
    fgPosProp.ColComboList(3) = s
    
    RS.Close
    Set RS = Nothing
    
    
    
    
    bBrys = False

End Sub


Private Sub btnSave_Click()

    Dim bNew As Boolean
    
    If pd.pdID = 0 Then
        If MsgBox("Создаем новый тип позиции '" & pd.PD_NAME & "'. Всё правильно?", vbYesNo, "Новый тип позиции") = vbNo Then Exit Sub
        bNew = True
    End If
    
    If pd.savePosDef(CBool(Me.chkSort.Value)) Then
        If bNew Then
            loadGrids
            globPosdefs.AddPosdef pd, CStr(pd.pdID)
        End If
        btnSave.Enabled = False
        F1.loadSrtmTree
    End If
    
End Sub

Private Sub chkDrawName_Click()

    If bBrys Then Exit Sub

    pd.bDrawName = CBool(chkDrawName.Value)

    letEnabled

End Sub

'/******************************************************************************
Private Sub chkMassCommon_Click()
'/******************************************************************************

    If bBrys Then Exit Sub

    pd.bMassCommon = CBool(chkMassCommon.Value)

    letEnabled


End Sub

Private Sub chkPosNum_Click()

    If bBrys Then Exit Sub

    pd.bPosNum = CBool(chkPosNum.Value)


End Sub

'/******************************************************************************
Private Sub cmbMassCalc_Click()
'/******************************************************************************

    On Error GoTo cmbMassCalc_Click_ERR


    If bBrys Then Exit Sub
    

    If cmbMassCalc.ListIndex >= 0 Then

        If cmbMassCalc.ItemData(cmbMassCalc.ListIndex) = 0 Then
            pd.mcID = 0
        Else
            pd.mcID = CLng(cmbMassCalc.ItemData(cmbMassCalc.ListIndex))
        End If

    End If
    
    letEnabled

Exit Sub

cmbMassCalc_Click_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "cmbMassCalc_Click - Error"

End Sub



'/******************************************************************************
Private Sub cmbPosDefGlobal_Click()
'/******************************************************************************

    On Error GoTo cmbPosDefGlobal_Click_ERR


    If bBrys Then Exit Sub

    If cmbPosDefGlobal.ListIndex >= 0 Then
        
        pd.pdIDGlobal = cmbPosDefGlobal.ItemData(cmbPosDefGlobal.ListIndex)
        
    End If
    
    letEnabled

Exit Sub

cmbPosDefGlobal_Click_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "cmbPosDefGlobal_Click - Error"

End Sub





Private Sub FG_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    
    
    If Col = 1 Then
        
        Dim RS As New ADODB.Recordset
        
        RS.Open "select posdefUsing from posdef where posdefID = " & Val(FG.TextMatrix(Row, 0)), cn_srtm, adOpenForwardOnly, adLockOptimistic
        
        If Not RS.EOF Then
            RS.MoveFirst
            RS.Fields("posdefUsing").Value = CBool(FG.TextMatrix(Row, 1))
            RS.Update
            
            pd.bUsing = CBool(FG.TextMatrix(Row, 1))
            
            F1.loadSrtmTree
        End If
        
        RS.Close
        Set RS = Nothing
        
    End If
    
End Sub

Private Sub FG_AfterMoveRow(ByVal Row As Long, Position As Long)

    Dim I As Integer
    Dim sn0 As Long
    Dim sn As Long
    Dim pdID As Long
    
    
    For I = 1 To FG.Rows - 2
    
        pdID = Val(FG.TextMatrix(I, 0))
        sn0 = Val(FG.TextMatrix(I, 2))
        
        If sn0 > 0 Then
        
            sn = sn + 10
            
            If updateTableInBase(cn_srtm, "posdef", "sortNumber", sn, "posdefID", pdID) Then
                FG.TextMatrix(I, 2) = sn
                globPosdefs(CStr(pdID)).sortNumber = sn
            End If
        
        End If
        
        
        
        
    
    Next I


End Sub

Private Sub FG_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)

    If Col <> 1 Then Cancel = True: Exit Sub
    If Row = 0 Then Cancel = True: Exit Sub
    If Row = FG.Rows - 1 Then Cancel = True: Exit Sub
    
    


End Sub

Private Sub fg_BeforeMouseDown(ByVal Button As Integer, ByVal Shift As Integer, ByVal X As Single, ByVal Y As Single, Cancel As Boolean)


    If sCurSort = "sortNumber" Then

    If FG.MouseCol = 3 And FG.MouseRow > 0 And FG.MouseRow < FG.Rows - 1 Then
        Cancel = True
        FG.Select FG.MouseRow, FG.MouseCol
        FG.DragRow FG.MouseRow
    End If

    End If
End Sub


Private Sub FG_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    
    
    If FG.MouseRow = 0 Then
        
        If sCurSort = "sortNumber" Then
            sCurSort = "posdefName"
        Else
            sCurSort = "sortNumber"
        End If
        
        
        loadGrids
        
    End If
    
    
End Sub

'/******************************************************************************
Private Sub FG_RowColChange()
'/******************************************************************************
    
    Dim I As Integer
    Dim j As Integer
    Dim ID As Long
    
    On Error GoTo FG_RowColChange_ERR
    
    
    If FG.Row <= 0 Then Exit Sub
    
    
    
    
    ID = Val(FG.TextMatrix(FG.Row, 0))
    
    If Not pd Is Nothing Then Set pd = Nothing
    
    If ID = 0 Then
        Set pd = New clsPD
    Else
        Set pd = globPosdefs(CStr(ID))
    End If
    
    
    bBrys = True
    
    Me.txtName.text = pd.PD_NAME
    Me.txtNames.text = pd.pdNameMulti
    
    Me.txtDefaultQty = Format(pd.pdDefQty, "0.0")
    Me.txtDrawSrtmPrefix = pd.pdDrawSrtmPrefix
    Me.txtDrawSymbol = pd.pdDrawSymbol
    Me.txtOfftSymb = pd.pdDrawSign
    
    If pd.mcID = 0 Then
        Me.cmbMassCalc.ListIndex = 0
    Else
        For I = 0 To cmbMassCalc.ListCount - 1
            If cmbMassCalc.ItemData(I) = pd.mcID Then Me.cmbMassCalc.ListIndex = I
        Next I
    End If
    
    For I = 0 To cmbPosDefGlobal.ListCount - 1
        If cmbPosDefGlobal.ItemData(I) = pd.pdIDGlobal Then
            If cmbPosDefGlobal.ItemData(I) = pd.pdID Then
                Me.cmbPosDefGlobal.ListIndex = 0
            Else
                Me.cmbPosDefGlobal.ListIndex = I
            End If
        End If
    Next I
    
    
    optMassLevel(pd.iMassLevel).Value = True
    
    
    If pd.bDrawName Then chkDrawName.Value = 1 Else chkDrawName.Value = 0
    If pd.bMassCommon Then chkMassCommon.Value = 1 Else chkMassCommon.Value = 0
    If pd.bPosNum Then chkPosNum.Value = 1 Else chkPosNum.Value = 0
    
    Dim prop As clsProp
    
    fgPosProp.Rows = 0
    fgMcProp.Rows = 0
        
    If ID > 0 Then
        For Each prop In pd.pd_props
            fgPosProp.AddItem prop.propID & vbTab & prop.propName & vbTab & CBool(prop.iSortOrder) & vbTab & prop.propDescr
            If Len(prop.sTableName) > 0 Then fgPosProp.Cell(flexcpFontBold, fgPosProp.Rows - 1, 3) = True
        Next prop
        fgPosProp.AddItem 0
        fgPosProp.ColWidth(2) = 300
        
        For Each prop In pd.PD_MCALC.mc_props
            fgMcProp.AddItem prop.propID & vbTab & prop.propName & vbTab & prop.propDescr
            If Len(prop.sTableName) > 0 Then fgMcProp.Cell(flexcpFontBold, fgMcProp.Rows - 1, 2) = True
        Next prop
        
    End If
        

    
    
    btnSave.Enabled = False
    
    bBrys = False
    
    Exit Sub
    
FG_RowColChange_ERR:
    bBrys = False
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "FG_RowColChange - Error"
    
End Sub

Private Sub fgMassCalc_RowColChange()
    
    Dim mc As clsMC
    Dim ID As Long
    Dim prop As clsProp
    Dim I As Integer
    
    If fgMassCalc.Row < 0 Then Exit Sub
    
    ID = Val(fgMassCalc.TextMatrix(fgMassCalc.Row, 0))
    
    Set mc = globMassCalcs(CStr(ID))
    
    fgMcPropEdit.Rows = 0
    For Each prop In mc.mc_props
        fgMcPropEdit.AddItem prop.propID & vbTab & prop.propName & vbTab & prop.propDescr
        If Len(prop.sTableName) > 0 Then fgMcPropEdit.Cell(flexcpFontBold, fgMcPropEdit.Rows - 1, 2) = True
    Next prop
    fgMcPropEdit.AddItem 0
    
    
    
    For I = 0 To cmbCalc.ListCount - 1
        If cmbCalc.ItemData(I) = mc.calcID Then
            Me.cmbCalc.ListIndex = I
        End If
    Next I
    
    If mc.mcTable = "massunit" Then
        cmbMCTable.ListIndex = 1
    ElseIf mc.mcTable = "masslength" Then
        cmbMCTable.ListIndex = 2
    ElseIf mc.mcTable = "massarea" Then
        cmbMCTable.ListIndex = 3
    ElseIf mc.mcTable = "massvolume" Then
        cmbMCTable.ListIndex = 4
    Else
        cmbMCTable.ListIndex = 0
    End If
    
    
    
End Sub

Private Sub fgPosProp_AfterEdit(ByVal Row As Long, ByVal Col As Long)

    Dim propID As Long
    Dim prop As clsProp

    
    
    If Col = 2 Then
        saveSortOrder
    ElseIf Col = 3 Then
    
        propID = Val(fgPosProp.ComboData(fgPosProp.ComboIndex))
        If propID = 0 Then Exit Sub
    
        If fgPosProp.TextMatrix(Row, 3) = "" Then Exit Sub
        
        If selectLongFromBase(cn_srtm, "r_posdef_property", "relID", "propID", propID, "posdefID", pd.pdID) > 0 Then
            fgPosProp.TextMatrix(Row, 0) = 0
            fgPosProp.TextMatrix(Row, 1) = ""
            fgPosProp.TextMatrix(Row, 2) = False
            fgPosProp.TextMatrix(Row, 3) = ""
            Exit Sub
        End If
    
        If selectLongFromBase(cn_srtm, "r_masscalc_property", "relID", "propID", propID, "mcID", pd.mcID) > 0 Then
            fgPosProp.TextMatrix(Row, 0) = 0
            fgPosProp.TextMatrix(Row, 1) = ""
            fgPosProp.TextMatrix(Row, 2) = False
            fgPosProp.TextMatrix(Row, 3) = ""
            Exit Sub
        End If
    
    
    
        If insertDataInBase(cn_srtm, "r_posdef_property", "propID", propID, "posdefID", pd.pdID) > 0 Then
            fgPosProp.TextMatrix(Row, 0) = propID
            fgPosProp.TextMatrix(Row, 1) = selectStringFromBase(cn_srtm, "property", "propName", "propID", propID)
            fgPosProp.TextMatrix(Row, 2) = False
            fgPosProp.AddItem 0
            
        Else
        End If
    End If
    
    pd.loadPosdefProps
    



End Sub

Private Sub fgPosProp_AfterMoveRow(ByVal Row As Long, Position As Long)

    saveSortOrder
    
    pd.loadPosdefProps


End Sub

Private Sub fgPosProp_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)

    If Col = 2 Then
        If Val(fgPosProp.TextMatrix(Row, 0)) = 0 Then Cancel = True
        '...
    Else
        If Val(fgPosProp.TextMatrix(Row, 0)) > 0 Then Cancel = True ' редактируем только нижнюю строку
    End If




End Sub

Private Sub fgPosProp_BeforeMouseDown(ByVal Button As Integer, ByVal Shift As Integer, ByVal X As Single, ByVal Y As Single, Cancel As Boolean)
    
    
    If fgPosProp.MouseCol = 3 And fgPosProp.MouseRow >= 0 And fgPosProp.MouseRow < fgPosProp.Rows - 1 Then
        Cancel = True
        fgPosProp.Select fgPosProp.MouseRow, fgPosProp.MouseCol
        fgPosProp.DragRow fgPosProp.MouseRow
    End If
    
    
    
End Sub

Private Sub fgPosProp_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode = 46 Then
    
        Dim ID As Long
        ID = fgPosProp.TextMatrix(fgPosProp.Row, 0)
        
        If ID = 0 Then Exit Sub
        
        Dim iRecordsAffected As Integer
        
        Dim cmd As New ADODB.Command
        cmd.ActiveConnection = cn_srtm
        cmd.CommandText = "delete from [r_posdef_property] where propID = " & ID & " and posdefID = " & pd.pdID
        cmd.Execute iRecordsAffected
        
        If iRecordsAffected = 1 Then
            fgPosProp.RemoveItem fgPosProp.Row
            pd.loadPosdefProps
        End If
        
        Set cmd = Nothing
    
    End If



End Sub



'/******************************************************************************
' не используется
Private Sub fgSrtmProps_AfterEdit(ByVal Row As Long, ByVal Col As Long)
'/******************************************************************************
    
    On Error GoTo fgSrtmProps_AfterEdit_ERR
    
    Dim bVal As Boolean
    Dim propID As Long
    Dim relID As Long
    
    bVal = CBool(fgSrtmProps.TextMatrix(Row, Col))
    propID = fgSrtmProps.TextMatrix(Row, 0)
    
    If Col = 2 Then ' r_masscalc_property
        
        If bVal Then
            Dim RS As New ADODB.Recordset
            RS.Open "select * from r_masscalc_property where mcID = " & pd.mcID & " and propID = " & propID, cn_srtm, adOpenForwardOnly, adLockOptimistic
            If RS.EOF Then
                RS.AddNew
                RS.Fields("mcID").Value = pd.mcID
                RS.Fields("propID").Value = propID
                RS.Update
                RS.Close
                Set RS = Nothing
                
            End If
            
            fgSrtmProps.TextMatrix(Row, 1) = True
            
        Else
            Dim iRecordsAffected As Integer
            
            Dim cmd As New ADODB.Command
            cmd.ActiveConnection = cn_srtm
            
            cmd.CommandText = "delete from [r_masscalc_property] where mcID = " & pd.mcID & " and propID = " & propID
            
            cmd.Execute iRecordsAffected
            
            Set cmd = Nothing
            
            fgSrtmProps.TextMatrix(Row, 1) = selectFromBase(cn_srtm, relID, "r_posdef_property", "relID", "posdefID", pd.pdID, "propID", propID)
            
            
        End If
        
        
        ' перегружаем masscalc
        Dim mc As clsMC
        Set mc = globMassCalcs(CStr(pd.mcID))
        If mc.loadMassCalc(Nothing, mc.mcID) Then
            mc.loadMassCalcProps
        End If
        
        
    ElseIf Col = 1 Then ' r_posdef_property
    Else
    End If
    
    Exit Sub
    
fgSrtmProps_AfterEdit_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "fgSrtmProps_AfterEdit - Error"
    
End Sub

Private Sub fgSrtmProps_AfterRowColChange(ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long)
    
    Dim prop As clsProp
    
    Dim I As Integer
    
    If NewRow <= 0 Then Exit Sub
    
    
    Set prop = globProps(fgSrtmProps.TextMatrix(NewRow, 4))
    
    txtPropName.text = prop.propName
    txtPropDescr.text = prop.propDescr
    
    
    For I = 0 To cmbPropValue.ListCount - 1
        If cmbPropValue.List(I) = prop.propvalName Then cmbPropValue.ListIndex = I
    Next I
    
    For I = 0 To cmbMUnits.ListCount - 1
        If cmbMUnits.ItemData(I) = prop.PROP_MU.muID Then cmbMUnits.ListIndex = I
    Next I
    
    If prop.PROP_MU_SRTM.muID = 0 Then
        cmbMUnitsSrtm.ListIndex = 0
    ElseIf prop.PROP_MU_SRTM.muID = prop.PROP_MU.muID Then
        cmbMUnitsSrtm.ListIndex = 0
    Else
        For I = 0 To cmbMUnitsSrtm.ListCount - 1
            If cmbMUnitsSrtm.ItemData(I) = prop.PROP_MU_SRTM.muID Then cmbMUnitsSrtm.ListIndex = I
        Next I
    End If
    
    
    txtDefValue.text = prop.propDefValue
    
    
    
    
    If prop.sTableName = "r_sortament_property" Then
        cmbTable.ListIndex = 1
    ElseIf prop.sTableName = "r_rein_property" Then
        cmbTable.ListIndex = 2
    Else
        cmbTable.ListIndex = 0
    End If
    
    
End Sub

'/******************************************************************************
Private Sub fgSrtmProps_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
'/******************************************************************************

    On Error GoTo fgSrtmProps_BeforeEdit_ERR
    

    If Col = 3 Then Cancel = True: Exit Sub
    If Col = 2 Then Cancel = True: Exit Sub ' для masscalc нужно сделать отдельно, например чтобы настраивать "толщина на радиус" и добавлять новые masscalc
    
    If Col = 1 And CBool(fgSrtmProps.TextMatrix(Row, 2)) Then Cancel = True: Exit Sub
    
    

Exit Sub

fgSrtmProps_BeforeEdit_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "fgSrtmProps_BeforeEdit - Error"

End Sub

Private Sub Form_Load()
    
    
    '    Dim RS As New ADODB.Recordset
    Dim mc As clsMC
    Dim mu As clsMU
    
    sCurSort = "sortNumber"
    
    loadGrids
    
    
    bBrys = True
    
    cmbPosDefGlobal.AddItem "То же"
    cmbPosDefGlobal.ItemData(cmbPosDefGlobal.NewIndex) = 0
    
    For Each pdg In globPosdefs
        
        cmbPosDefGlobal.AddItem pdg.PD_NAME
        cmbPosDefGlobal.ItemData(cmbPosDefGlobal.NewIndex) = pdg.pdID
        
    Next pdg
    
    
    '    cmbMassCalc.AddItem ""
    '    cmbMassCalc.ItemData(cmbMassCalc.NewIndex) = -1
    
    For Each mc In globMassCalcs
        
        cmbMassCalc.AddItem mc.mcName
        cmbMassCalc.ItemData(cmbMassCalc.NewIndex) = mc.mcID
        
    Next mc
    
    
    cmbMUnits.AddItem "нет"
    cmbMUnits.ItemData(cmbMUnits.NewIndex) = 0
    
    cmbMUnitsSrtm.AddItem "то же"
    cmbMUnitsSrtm.ItemData(cmbMUnits.NewIndex) = 0
    
    For Each mu In globMUnits
        
        cmbMUnits.AddItem mu.muShortName
        cmbMUnits.ItemData(cmbMUnits.NewIndex) = mu.muID
        
        cmbMUnitsSrtm.AddItem mu.muShortName
        cmbMUnitsSrtm.ItemData(cmbMUnitsSrtm.NewIndex) = mu.muID
        
    Next mu
    
    
    
    
    cmbPropValue.AddItem "double"
    cmbPropValue.ItemData(cmbPropValue.NewIndex) = 1
    
    cmbPropValue.AddItem "long"
    cmbPropValue.ItemData(cmbPropValue.NewIndex) = 2
    
    cmbPropValue.AddItem "string"
    cmbPropValue.ItemData(cmbPropValue.NewIndex) = 3
    
    
    
    
    
    
    cmbCalc.AddItem "нет"
    cmbCalc.ItemData(cmbCalc.NewIndex) = 0
    
    For Each mc In globMassCalcs
        
        If mc.mcID > 0 Then
            
            cmbCalc.AddItem mc.mcName
            cmbCalc.ItemData(cmbCalc.NewIndex) = mc.mcID
            
        End If
        
    Next mc
    
    
    
    
    
    
    bBrys = False
    
    
    FG.Row = 1
    FG_RowColChange
    
    fgMassCalc.Row = 0
    fgMassCalc_RowColChange
    
    
    C1Tab1.CurrTab = 0
    
    
    
End Sub


Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked
End Sub

Private Sub optMassLevel_Click(Index As Integer)

    If bBrys Then Exit Sub
    
    If optMassLevel(Index).Value Then pd.iMassLevel = Index


End Sub

Private Sub txtDefaultQty_LostFocus()

    If bBrys Then Exit Sub

    If pd.pdDefQty = getDbl(txtDefaultQty.text) Then Exit Sub

    pd.pdDefQty = getDbl(txtDefaultQty.text)

    txtDefaultQty.text = Format((pd.pdDefQty), "0.0###")
    
    letEnabled

End Sub



Private Sub txtDrawSrtmPrefix_LostFocus()


    If bBrys Then Exit Sub

    If pd.pdDrawSrtmPrefix = Trim(txtDrawSrtmPrefix.text) Then Exit Sub

    pd.pdDrawSrtmPrefix = Trim(txtDrawSrtmPrefix.text)
    
    txtDrawSrtmPrefix.text = pd.pdDrawSrtmPrefix

    letEnabled

End Sub

Private Sub txtDrawSymbol_LostFocus()

    If bBrys Then Exit Sub
    
    If pd.pdDrawSymbol = Trim(txtDrawSymbol.text) Then Exit Sub
    
    pd.pdDrawSymbol = Trim(txtDrawSymbol.text)
    
    txtDrawSymbol.text = pd.pdDrawSymbol

    letEnabled


End Sub

Private Sub txtName_LostFocus()
    
    Dim s1 As String
    Dim s2 As String
    
    If bBrys Then Exit Sub
    
    If pd.pdName = Trim(txtName.text) Then Exit Sub
    
    If Len(Trim(txtName.text)) = 0 Then
        
        btnSave.Enabled = False
        Exit Sub
        
    End If
    
    
    s1 = UCase(Trim(txtName.text))
    s2 = LCase(Trim(txtName.text))
    
    pd.pdName = left(s1, 1)
    
    If Len(Trim(txtName.text)) > 1 Then
        
        pd.pdName = pd.pdName & right(s2, Len(s2) - 1)
        
    End If
    
    txtName.text = pd.pdName
    letEnabled
    
    
    
End Sub


Private Sub txtNames_LostFocus()

    Dim s1 As String
    Dim s2 As String
    
    If bBrys Then Exit Sub
    
    If pd.pdNameMulti = Trim(txtNames.text) Then Exit Sub
    
    If Len(Trim(txtNames.text)) = 0 Then
        
        btnSave.Enabled = False
        Exit Sub
        
    End If
    
    
    s1 = UCase(Trim(txtNames.text))
    s2 = LCase(Trim(txtNames.text))
    
    pd.pdNameMulti = left(s1, 1)
    
    If Len(Trim(txtNames.text)) > 1 Then
        
        pd.pdNameMulti = pd.pdNameMulti & right(s2, Len(s2) - 1)
        
    End If
    
    txtNames.text = pd.pdNameMulti
    letEnabled


End Sub

'/******************************************************************************
Private Sub txtOfftSymb_LostFocus()
'/******************************************************************************



    If bBrys Then Exit Sub

    If pd.pdDrawSign = Trim(txtOfftSymb.text) Then Exit Sub

    pd.pdDrawSign = Trim(txtOfftSymb.text)

    txtOfftSymb.text = pd.pdDrawSign
    
    letEnabled



End Sub



'/******************************************************************************
Private Sub letEnabled()
'/******************************************************************************

    btnSave.Enabled = False

    If Len(Trim(pd.pdName)) = 0 Then Exit Sub
    
    
    If pd.mcID = 0 Then Exit Sub
    
'    If pd.pdDefQty = 0# Then Exit Sub
    
    btnSave.Enabled = True
    
    
    
    


End Sub


'/******************************************************************************
Private Sub saveSortOrder()
'/******************************************************************************

    On Error GoTo saveSortOrder_ERR

    Dim propID As Long
    Dim relID As Long
    Dim pdID As Long
    Dim prop As clsProp
    Dim iSO As Integer
    Dim iSOtoSave As Integer
    
    pdID = pd.pdID


    Dim I As Integer

    iSO = 0

    For I = 0 To fgPosProp.Rows - 2
    
        propID = Val(fgPosProp.TextMatrix(I, 0))
        
        If CBool(fgPosProp.TextMatrix(I, 2)) Then
            iSO = iSO + 1
            iSOtoSave = iSO
        Else
            iSOtoSave = 0
        End If
        
        relID = selectLongFromBase(cn_srtm, "r_posdef_property", "relID", "posdefID", pdID, "propID", propID)
        
        If Not updateTableInBase(cn_srtm, "r_posdef_property", "sortOrder", iSOtoSave, "relID", relID) Then
            MsgBox "Error"
        End If
    
    
    Next I



Exit Sub

saveSortOrder_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "saveSortOrder - Error"

End Sub
