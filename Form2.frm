VERSION 5.00
Object = "{0AFE7BE0-11B7-4A3E-978D-D4501E9A57FE}#1.0#0"; "c1sizer.ocx"
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Begin VB.Form F2 
   ClientHeight    =   4965
   ClientLeft      =   60
   ClientTop       =   60
   ClientWidth     =   7740
   ControlBox      =   0   'False
   Icon            =   "Form2.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4965
   ScaleWidth      =   7740
   ShowInTaskbar   =   0   'False
   Begin C1SizerLibCtl.C1Elastic C1Elastic1 
      Height          =   4965
      Left            =   0
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   0
      Width           =   7740
      _cx             =   13653
      _cy             =   8758
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
      Appearance      =   3
      MousePointer    =   0
      Version         =   801
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      FloodColor      =   6553600
      ForeColorDisabled=   -2147483631
      Caption         =   ""
      Align           =   5
      AutoSizeChildren=   2
      BorderWidth     =   2
      ChildSpacing    =   5
      Splitter        =   -1  'True
      FloodDirection  =   0
      FloodPercent    =   0
      CaptionPos      =   1
      WordWrap        =   -1  'True
      MaxChildSize    =   0
      MinChildSize    =   2000
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
      Begin C1SizerLibCtl.C1Elastic C1Elastic3 
         Height          =   4905
         Left            =   2250
         TabIndex        =   2
         TabStop         =   0   'False
         Top             =   30
         Width           =   5460
         _cx             =   9631
         _cy             =   8652
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
         Appearance      =   4
         MousePointer    =   0
         Version         =   801
         BackColor       =   -2147483633
         ForeColor       =   -2147483630
         FloodColor      =   6553600
         ForeColorDisabled=   -2147483631
         Caption         =   ""
         Align           =   0
         AutoSizeChildren=   4
         BorderWidth     =   6
         ChildSpacing    =   4
         Splitter        =   -1  'True
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
         Begin C1SizerLibCtl.C1Elastic C1Elastic5 
            Height          =   1920
            Left            =   90
            TabIndex        =   5
            TabStop         =   0   'False
            Top             =   90
            Width           =   5280
            _cx             =   9313
            _cy             =   3387
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
            Appearance      =   4
            MousePointer    =   0
            Version         =   801
            BackColor       =   -2147483633
            ForeColor       =   -2147483630
            FloodColor      =   6553600
            ForeColorDisabled=   -2147483631
            Caption         =   ""
            Align           =   0
            AutoSizeChildren=   3
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
            Begin VSFlex8Ctl.VSFlexGrid fgPosStd 
               Height          =   1740
               Left            =   90
               TabIndex        =   6
               Top             =   90
               Width           =   5100
               _cx             =   87630628
               _cy             =   87624701
               Appearance      =   1
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
               HighLight       =   1
               AllowSelection  =   0   'False
               AllowBigSelection=   0   'False
               AllowUserResizing=   0
               SelectionMode   =   0
               GridLines       =   1
               GridLinesFixed  =   2
               GridLineWidth   =   1
               Rows            =   0
               Cols            =   1
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
         End
         Begin C1SizerLibCtl.C1Elastic C1Elastic4 
            Height          =   2745
            Left            =   90
            TabIndex        =   4
            TabStop         =   0   'False
            Top             =   2070
            Width           =   5280
            _cx             =   9313
            _cy             =   4842
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
            Appearance      =   4
            MousePointer    =   0
            Version         =   801
            BackColor       =   -2147483633
            ForeColor       =   -2147483630
            FloodColor      =   6553600
            ForeColorDisabled=   -2147483631
            Caption         =   ""
            Align           =   0
            AutoSizeChildren=   2
            BorderWidth     =   6
            ChildSpacing    =   4
            Splitter        =   -1  'True
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
            Begin C1SizerLibCtl.C1Elastic C1Elastic7 
               Height          =   2565
               Left            =   2640
               TabIndex        =   8
               TabStop         =   0   'False
               Top             =   90
               Width           =   2550
               _cx             =   4498
               _cy             =   4524
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
               Appearance      =   4
               MousePointer    =   0
               Version         =   801
               BackColor       =   -2147483633
               ForeColor       =   -2147483630
               FloodColor      =   6553600
               ForeColorDisabled=   -2147483631
               Caption         =   ""
               Align           =   0
               AutoSizeChildren=   1
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
               Begin VSFlex8Ctl.VSFlexGrid fgPosMat 
                  Height          =   2385
                  Left            =   90
                  TabIndex        =   10
                  Top             =   90
                  Width           =   2370
                  _cx             =   87625812
                  _cy             =   87625839
                  Appearance      =   1
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
                  HighLight       =   1
                  AllowSelection  =   0   'False
                  AllowBigSelection=   0   'False
                  AllowUserResizing=   0
                  SelectionMode   =   0
                  GridLines       =   1
                  GridLinesFixed  =   2
                  GridLineWidth   =   1
                  Rows            =   0
                  Cols            =   1
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
            End
            Begin C1SizerLibCtl.C1Elastic C1Elastic6 
               Height          =   2565
               Left            =   90
               TabIndex        =   7
               TabStop         =   0   'False
               Top             =   90
               Width           =   2490
               _cx             =   4392
               _cy             =   4524
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
               Appearance      =   4
               MousePointer    =   0
               Version         =   801
               BackColor       =   -2147483633
               ForeColor       =   -2147483630
               FloodColor      =   6553600
               ForeColorDisabled=   -2147483631
               Caption         =   ""
               Align           =   0
               AutoSizeChildren=   1
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
               Begin VSFlex8Ctl.VSFlexGrid fgPosName 
                  Height          =   2385
                  Left            =   90
                  TabIndex        =   9
                  Top             =   90
                  Width           =   2310
                  _cx             =   87625707
                  _cy             =   87625839
                  Appearance      =   1
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
                  HighLight       =   1
                  AllowSelection  =   0   'False
                  AllowBigSelection=   0   'False
                  AllowUserResizing=   0
                  SelectionMode   =   0
                  GridLines       =   1
                  GridLinesFixed  =   2
                  GridLineWidth   =   1
                  Rows            =   0
                  Cols            =   1
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
            End
         End
      End
      Begin C1SizerLibCtl.C1Elastic C1Elastic2 
         Height          =   4905
         Left            =   30
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   30
         Width           =   2145
         _cx             =   3784
         _cy             =   8652
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
         Appearance      =   4
         MousePointer    =   0
         Version         =   801
         BackColor       =   -2147483633
         ForeColor       =   -2147483630
         FloodColor      =   6553600
         ForeColorDisabled=   -2147483631
         Caption         =   ""
         Align           =   0
         AutoSizeChildren=   1
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
         Begin VSFlex8Ctl.VSFlexGrid fgPosDef 
            Height          =   4725
            Left            =   90
            TabIndex        =   3
            Top             =   90
            Width           =   1965
            _cx             =   87625098
            _cy             =   87629966
            Appearance      =   1
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
            HighLight       =   1
            AllowSelection  =   0   'False
            AllowBigSelection=   0   'False
            AllowUserResizing=   0
            SelectionMode   =   0
            GridLines       =   1
            GridLinesFixed  =   2
            GridLineWidth   =   1
            Rows            =   0
            Cols            =   1
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
      End
   End
End
Attribute VB_Name = "F2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public bLoaded As Boolean

Public curPosIndex As Long

Public curPos As clsPos

Public bStdChangedEvent As Boolean

Public bCatPos As Boolean

'/******************************************************************************
Public Sub loadGrids()
'/******************************************************************************
    
    On Error GoTo setPos_ERR
    
    bLoaded = False
    
    posDefLoad
    posStdLoad
    posMatLoad
    posNameLoad
    
'    If curPos.getPosdefID > 0 Then posStdLoad
'    If curPos.getStandardID > 0 Then posNameLoad
'    If curPos.getPosdefID > 0 Then posMatLoad
    
    bLoaded = True
    
    Exit Sub
    
setPos_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setPos - Error"
    
End Sub


Private Sub fgPosDef_AfterRowColChange(ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long)
    
    If NewRow = -1 Then Exit Sub
    If Not bLoaded Then Exit Sub
    
    Dim pdID As Long
    pdID = Val(fgPosDef.TextMatrix(NewRow, 0))
    
    
    curPos.setPosdefID pdID
    posStdLoad
    posMatLoad True
    posNameLoad
    
    
    
End Sub

Private Sub fgPosDef_BeforeRowColChange(ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long, Cancel As Boolean)


    Dim pdID As Long
    Dim posID As Long
    
    If NewRow < 0 Then Exit Sub
    
    pdID = Val(fgPosDef.TextMatrix(NewRow, 0))
    
    posID = Val(F1.fgPositions.TextMatrix(F1.fgPositions.Row, 4))
    
    If posID = 0 Then Exit Sub
    
    Dim pd As clsPD
    Set pd = globPosdefs(CStr(pdID))
    
'    If (pd.mc.mcID = 5 And curPos.POS_MCALC.mcID = 5) Or (pd.mc.mcID <> 5 And curPos.POS_MCALC.mcID <> 5) Then
    If (pd.bPosNum And curPos.POS_PD.bPosNum) Or (Not pd.bPosNum And Not curPos.POS_PD.bPosNum) Then
    Else
        Cancel = True
    End If



End Sub

Private Sub fgPosMat_AfterRowColChange(ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long)

    If Not bLoaded Then Exit Sub
    
    Dim bUpd As Boolean

    If fgPosMat.Rows = 0 Then
        Exit Sub
    End If

    If NewRow >= 0 Then
        curPos.setMaterial Val(fgPosMat.TextMatrix(NewRow, 0))  ' с сохранением в базе
    End If

    If curPos.POS_SRTM.srtmID > 0 Then
'        F1.fgPositions.TextMatrix(F1.fgPositions.Row, 0) = curPos.getDescr
        
        curPos.updatePosRow curPos.fgRowToEdit, bUpd, True, True, True, True
        
    Else
'        If Not F1.curPos Is Nothing Then F1.fgPositions.TextMatrix(F1.fgPositions.Row, 0) = F1.curPos.getDescr
    End If




End Sub


Private Sub fgPosMat_BeforeSelChange(ByVal OldRowSel As Long, ByVal OldColSel As Long, ByVal NewRowSel As Long, ByVal NewColSel As Long, Cancel As Boolean)
    
    If NewColSel > 1 Then Cancel = True: Exit Sub
    If Me.curPos.POS_SRTM.srtmID = 0 And Not bStdChangedEvent Then Cancel = True
    
End Sub

Private Sub fgPosMat_Click()

'    fgPosMat_AfterRowColChange 0, 0, fgPosMat.Row, fgPosMat.Col


End Sub

Private Sub fgPosName_AfterRowColChange(ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long)
    
    Dim bUpd As Boolean
    
    If fgPosName.Rows = 0 Then Exit Sub
    If Not bLoaded Then Exit Sub
    
    If NewRow >= 0 Then
        curPos.setSrtm Val(fgPosName.TextMatrix(NewRow, 0)), True, True
    End If
    
    If curPos.POS_SRTM.srtmID > 0 Then
        
        If curPos.fgRowToEdit = curPos.fgp.Rows - 1 Then
            
            Dim np As New clsPos
            np.fgAddEmptyRow
            
        End If
        
        ' синхронизация???
'        If Not F1.curPos Is Nothing Then
'            F1.curPos.setSrtm curPos.pos_srtm.srtmID, False, True
'        End If
        
        curPos.updatePosRow curPos.fgRowToEdit, bUpd, True, True, True, True
        
    End If '
    
    
    
End Sub


' дополнение к fgPosName_AfterRowColChange() для случая когда список posName только загружен (при изм. стандарта), и выбирается первая позиция,
' в этом случае fgPosName_AfterRowColChange не срабатывает
Private Sub fgPosName_Click() '

    If curPos.POS_SRTM.srtmID = 0 Then
        fgPosName_AfterRowColChange 0, 0, fgPosName.Row, fgPosName.Col
    End If


End Sub

Private Sub fgPosStd_AfterRowColChange(ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long)
    
    If NewRow = -1 Then Exit Sub
    If Not bLoaded Then Exit Sub
    If Len(fgPosStd.TextMatrix(NewRow, 0)) = 0 Then Exit Sub
    
    
    
    curPos.setStandard Val(fgPosStd.TextMatrix(NewRow, 0))
    
    posMatLoad True ' by std change event
    posNameLoad
    
    
    
    
End Sub

Private Sub fgPosStd_BeforeSelChange(ByVal OldRowSel As Long, ByVal OldColSel As Long, ByVal NewRowSel As Long, ByVal NewColSel As Long, Cancel As Boolean)

    If NewColSel > 1 Then Cancel = True

End Sub

Private Sub Form_Deactivate()

    Unload Me

End Sub

Private Sub Form_Load()


    F2.top = GetSetting("Offtake2", "Size", "F2.top", F2.top)
    F2.left = GetSetting("Offtake2", "Size", "F2.Left", F2.left)
    F2.Height = GetSetting("Offtake2", "Size", "F2.Height", F2.Height)
    F2.width = GetSetting("Offtake2", "Size", "F2.Width", F2.width)

    C1Elastic2.width = GetSetting("Offtake2", "Size", "C1Elastic2.Width", C1Elastic2.width)
    C1Elastic3.width = GetSetting("Offtake2", "Size", "C1Elastic3.Width", C1Elastic3.width)
    C1Elastic4.Height = GetSetting("Offtake2", "Size", "C1Elastic4.Height", C1Elastic4.Height)
    C1Elastic6.width = GetSetting("Offtake2", "Size", "C1Elastic6.Width", C1Elastic6.width)
    
'    posDefLoad

End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked
End Sub

'/******************************************************************************
Private Sub Form_Unload(Cancel As Integer)
'/******************************************************************************

    If curPos.posID > 0 And curPos.POS_SRTM.srtmID = 0 Then ' если выбор позиции не был закончен, но данные сброшены
        curPos.reloadPosData
    End If


    SaveSetting "Offtake2", "Size", "f2.top", F2.top
    SaveSetting "Offtake2", "Size", "f2.Left", F2.left
    SaveSetting "Offtake2", "Size", "f2.Height", F2.Height
    SaveSetting "Offtake2", "Size", "f2.Width", F2.width

    SaveSetting "Offtake2", "Size", "C1Elastic2.Width", C1Elastic2.width
    SaveSetting "Offtake2", "Size", "C1Elastic3.Width", C1Elastic3.width
    SaveSetting "Offtake2", "Size", "C1Elastic4.Height", C1Elastic4.Height
    SaveSetting "Offtake2", "Size", "C1Elastic6.Width", C1Elastic6.width

End Sub

'/******************************************************************************
Private Sub posDefLoad()
'/******************************************************************************

    On Error GoTo posDefLoad_ERR
    
    
    Dim strSQL As String
    
    If usrCurrent.pdsID = 0 Then
        If Me.bCatPos Then
            strSQL = "select posdefID, posdefName from posdef where usedByCatPos = 1 order by sortNumber"
        Else
            strSQL = "select posdefID, posdefName from posdef where posdefUsing = 1 order by sortNumber"
        End If
    Else
        strSQL = "select posdefID, (case when relNameAlt is null then posdefName else relNameAlt end) as posdefName from view_r_pdset_posdef where pdsID = " & usrCurrent.pdsID
        If F1.mnuPrefPdSortByUse.Checked Then
            strSQL = strSQL & " order by sortNumber, cnt desc"
        Else
            strSQL = strSQL & " order by posdefName"
        End If
    End If
    

    Dim RS As New ADODB.Recordset
    
    RS.Open strSQL, cn_srtm, adOpenStatic, adLockReadOnly
    
    Set Me.fgPosDef.DataSource = RS
    
    fgPosDef.ColHidden(0) = True
    
    Me.fgPosDef.Row = -1 ' нет выделенных
    If curPos.getPosdefID = 0 Then Exit Sub
    
    Dim i As Integer
    
    For i = 0 To Me.fgPosDef.Rows - 1
        If Me.fgPosDef.TextMatrix(i, 0) = curPos.getPosdefID Then
        
            fgPosDef.ShowCell i, 1
            Me.fgPosDef.Select i, 1
        
        End If
    
    Next i


Exit Sub

posDefLoad_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "posDefLoad - Error"

End Sub


'/******************************************************************************
Private Sub posStdLoad()
'/******************************************************************************

    On Error GoTo posStdLoad_ERR


    If curPos.getPosdefID = 0 Then Exit Sub
    
    Dim strStdnum As String
    Dim strSQL As String
    
    If bUseStdNumberAlt Then
        strStdnum = "stdFullNumberAlt"
    Else
        strStdnum = "stdFullNumber"
    End If
    
    strSQL = "select stdID, " & strStdnum & ", stdName "
    
    strSQL = strSQL & "from view_r_standard_posdef_srtm_using "
    
    strSQL = strSQL & "where posdefID = " & curPos.getPosdefID & " and stdUsing = 1 "
    
    If usrCurrent.pdsID > 0 Then
        strSQL = strSQL & "and relID not in (select stdpdID from r_stdpd_pdset where pdsID = " & usrCurrent.pdsID & ") "
    End If
    
    strSQL = strSQL & "order by stdFullNumber "

    Dim RS As New ADODB.Recordset
    
    RS.Open strSQL, cn_srtm, adOpenStatic, adLockReadOnly
    
    
    Set Me.fgPosStd.DataSource = RS
    
    Me.fgPosStd.AutoSize 1
    
    fgPosStd.ColHidden(0) = True
    
    Me.fgPosStd.Row = -1 ' нет выделенных
    
    If fgPosStd.Rows = 1 Then
        Me.fgPosStd.Select 0, 1 ' вызывает событие и загрузку fgPosName
    End If
    
    If curPos.getStandardID = 0 Then Exit Sub
    
    
    Dim i As Integer
    
    For i = 0 To Me.fgPosStd.Rows - 1
        If Me.fgPosStd.TextMatrix(i, 0) = curPos.getStandardID Then
        
            fgPosStd.ShowCell i, 1
            Me.fgPosStd.Select i, 1
        
        End If
    
    Next i
    
    
    


Exit Sub

posStdLoad_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "posStdLoad - Error"

End Sub



'/******************************************************************************
Private Sub posMatLoad(Optional bByStdChangeEvent As Boolean = False)
'/******************************************************************************
    
    On Error GoTo posMatLoad_ERR
    
    Dim iRowFound As Long
    Dim i As Long

    Dim strStdnum As String
    If bUseStdNumberAlt Then
        strStdnum = "stdFullNumberAlt"
    Else
        strStdnum = "stdFullNumber"
    End If
    
    
    If curPos.getPosdefID = 0 Then Exit Sub
    
    iRowFound = 0
    
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select matID, matName, " & strStdnum & " from view_r_stdpd_material where stdpdID = " & curPos.POS_STDPD.stdpdID & " order by matSortNumber", cn_srtm, adOpenStatic, adLockReadOnly
    
    If RS.EOF Then
        RS.NextRecordset
        RS.Open "select matID, matName, " & strStdnum & " from view_r_posdef_material where posdefID = " & curPos.getPosdefID & " and matUsing = 1 order by matSortNumber", cn_srtm, adOpenStatic, adLockReadOnly
    End If
    
    
    
    Set Me.fgPosMat.DataSource = RS
    fgPosMat.AddItem 0 & vbTab & "-" & vbTab & "не определён", 0
    fgPosMat.AutoSize 0, fgPosMat.cols - 1
    fgPosMat.ColHidden(0) = True
    
    If curPos.getMatID > 0 Then
        For i = 0 To Me.fgPosMat.Rows - 1
            If Me.fgPosMat.TextMatrix(i, 0) = curPos.getMatID Then iRowFound = i
        Next i
    End If
    
    
    bStdChangedEvent = bByStdChangeEvent
    
    
    
    If iRowFound = 0 Then
        Me.fgPosMat.Row = -1 ' нет выделенных
    Else
'        Me.fgPosMat.Row = iRowFound
        fgPosMat.ShowCell iRowFound, 1
        Me.fgPosMat.Select iRowFound, 1
    End If
    
    
    
    bStdChangedEvent = False
    
    
    Exit Sub
    
posMatLoad_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "posMatLoad - Error"
    
End Sub

'/******************************************************************************
Private Sub posNameLoad()
'/******************************************************************************

    On Error GoTo posNameLoad_ERR
    
    Me.fgPosName.Rows = 0

    If curPos.getPosdefID = 0 Then Exit Sub
    If curPos.getStandardID = 0 Then Exit Sub

    Dim RS As New ADODB.Recordset
    
    Dim strSQL As String
    strSQL = "select srtmID, (case when [number] is null then srtmName else srtmName + ' ' + right('00' + convert(varchar,[number]),2) end) as srtmName from view_r_sortament_property_3 where posdefID = " & curPos.getPosdefID & _
            " and stdID = " & curPos.getStandardID & " and srtmUsing = 1"
    
    
    If Len(curPos.POS_PD.strSort) > 0 Then strSQL = strSQL & " order by " & curPos.POS_PD.strSort
    
    RS.Open strSQL, cn_srtm, adOpenStatic, adLockReadOnly
    
    Set Me.fgPosName.DataSource = RS
    
    fgPosName.ColHidden(0) = True
    
    Me.fgPosName.Row = -1 ' нет выделенных
    If curPos.POS_SRTM.srtmID = 0 Then Exit Sub
    
    Dim i As Integer
    
    For i = 0 To Me.fgPosName.Rows - 1
        If Me.fgPosName.TextMatrix(i, 0) = curPos.POS_SRTM.srtmID Then
        
        Me.fgPosName.Select i, 1
        Me.fgPosName.toprow = i
        
        End If
    
    Next i


Exit Sub

posNameLoad_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "posNameLoad - Error"

End Sub


