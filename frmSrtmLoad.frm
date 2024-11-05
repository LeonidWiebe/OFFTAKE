VERSION 5.00
Object = "{0AFE7BE0-11B7-4A3E-978D-D4501E9A57FE}#1.0#0"; "c1sizer.ocx"
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Begin VB.Form frmSrtmLoad 
   Caption         =   "Загрузка данных из модели MicroStation"
   ClientHeight    =   11475
   ClientLeft      =   165
   ClientTop       =   450
   ClientWidth     =   13830
   Icon            =   "frmSrtmLoad.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   11475
   ScaleWidth      =   13830
   StartUpPosition =   1  'CenterOwner
   Begin MSComctlLib.ProgressBar PB 
      Align           =   1  'Align Top
      Height          =   255
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   13830
      _ExtentX        =   24395
      _ExtentY        =   450
      _Version        =   393216
      Appearance      =   1
      Scrolling       =   1
   End
   Begin C1SizerLibCtl.C1Elastic C1Elastic1 
      Height          =   11220
      Left            =   0
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   255
      Width           =   13830
      _cx             =   24395
      _cy             =   19791
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
      Align           =   5
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
      Begin C1SizerLibCtl.C1Elastic C1Elastic3 
         Height          =   11040
         Left            =   90
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   90
         Width           =   13650
         _cx             =   24077
         _cy             =   19473
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
         Begin C1SizerLibCtl.C1Elastic C1Elastic5 
            Height          =   10860
            Left            =   90
            TabIndex        =   4
            TabStop         =   0   'False
            Top             =   90
            Width           =   9150
            _cx             =   16140
            _cy             =   19156
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
            Begin VSFlex8Ctl.VSFlexGrid FG 
               Height          =   10680
               Left            =   90
               TabIndex        =   5
               Top             =   90
               Width           =   8970
               _cx             =   97009102
               _cy             =   97012118
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
               AllowSelection  =   -1  'True
               AllowBigSelection=   -1  'True
               AllowUserResizing=   0
               SelectionMode   =   0
               GridLines       =   1
               GridLinesFixed  =   2
               GridLineWidth   =   1
               Rows            =   1
               Cols            =   2
               FixedRows       =   1
               FixedCols       =   1
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
         End
         Begin C1SizerLibCtl.C1Elastic C1Elastic4 
            Height          =   10860
            Left            =   9300
            TabIndex        =   3
            TabStop         =   0   'False
            Top             =   90
            Width           =   4260
            _cx             =   7514
            _cy             =   19156
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
            Begin VSFlex8Ctl.VSFlexGrid FG2 
               Height          =   7185
               Left            =   90
               TabIndex        =   6
               Top             =   90
               Width           =   4080
               _cx             =   97000477
               _cy             =   97005954
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
               AllowSelection  =   -1  'True
               AllowBigSelection=   -1  'True
               AllowUserResizing=   1
               SelectionMode   =   0
               GridLines       =   1
               GridLinesFixed  =   2
               GridLineWidth   =   1
               Rows            =   1
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
               SubtotalPosition=   0
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
            Begin VSFlex8Ctl.VSFlexGrid fgZkkz 
               Height          =   3435
               Left            =   90
               TabIndex        =   7
               Top             =   7335
               Width           =   4080
               _cx             =   71900189
               _cy             =   71899051
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
               AllowSelection  =   -1  'True
               AllowBigSelection=   -1  'True
               AllowUserResizing=   1
               SelectionMode   =   0
               GridLines       =   1
               GridLinesFixed  =   2
               GridLineWidth   =   1
               Rows            =   1
               Cols            =   4
               FixedRows       =   0
               FixedCols       =   0
               RowHeightMin    =   0
               RowHeightMax    =   0
               ColWidthMin     =   800
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
               SubtotalPosition=   0
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
   Begin VB.Menu mnuGetFromModel 
      Caption         =   "Получить из модели"
      Begin VB.Menu mnuGetFromModel1 
         Caption         =   "Без референсов"
      End
      Begin VB.Menu mnuGetFromModel2 
         Caption         =   "С учетом референсов"
      End
      Begin VB.Menu mnuGetFromModelByParam 
         Caption         =   "С разбивкой по параметрам"
         Index           =   0
      End
      Begin VB.Menu mnuGetFromModelByParam 
         Caption         =   ""
         Index           =   1
         Visible         =   0   'False
      End
      Begin VB.Menu mnuGetFromModelByParam 
         Caption         =   ""
         Index           =   2
         Visible         =   0   'False
      End
      Begin VB.Menu mnuGetFromModelByParam 
         Caption         =   ""
         Index           =   3
         Visible         =   0   'False
      End
   End
   Begin VB.Menu mnuLoad 
      Caption         =   "Загрузить"
   End
   Begin VB.Menu mnuSave 
      Caption         =   "Сохранить ссылки в каталог"
   End
   Begin VB.Menu mnuShowView 
      Caption         =   "Показать на виде"
      Enabled         =   0   'False
      Begin VB.Menu mnuShow 
         Caption         =   "Вид 1"
         Index           =   1
      End
      Begin VB.Menu mnuShow 
         Caption         =   "Вид 2"
         Index           =   2
      End
      Begin VB.Menu mnuShow 
         Caption         =   "Вид 3"
         Index           =   3
      End
      Begin VB.Menu mnuShow 
         Caption         =   "Вид 4"
         Index           =   4
      End
      Begin VB.Menu mnuShow 
         Caption         =   "Вид 5"
         Index           =   5
      End
      Begin VB.Menu mnuShow 
         Caption         =   "Вид 6"
         Index           =   6
      End
      Begin VB.Menu mnuShow 
         Caption         =   "Вид 7"
         Index           =   7
      End
      Begin VB.Menu mnuShow 
         Caption         =   "Вид 8"
         Index           =   8
      End
      Begin VB.Menu mnuShowFileSave 
         Caption         =   "Сохранить в файл"
      End
   End
   Begin VB.Menu mnuZkkz 
      Caption         =   "ЗККЗ"
      Begin VB.Menu mnuZkkzCalc 
         Caption         =   "Считать"
      End
   End
End
Attribute VB_Name = "frmSrtmLoad"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public strFileName As String

Dim iSrtmNameCol As Long

Dim iStdTypeNameCol As Long
Dim iStdNumberCol As Long
Dim iStdNameCol As Long

Dim iMatNameCol As Long
Dim iPosDefCol As Long

Dim iFirstPropCol As Long


Const iHeaderRow As Long = 1
Const iFirstRow As Long = 2
Const iFirstCol As Long = 1

Dim Col As Long
Dim Row As Long


Public bLoadRein As Boolean
Public bList As Boolean


Public parts As Collection
Public partsOKnosort As Collection
Public partsOK As Collection
Public partsNF As Collection

Public colTS As Collection

Private arCatIDs() As Long
Private iCatIDsCount As Integer

Private curFrml As clsObj

Public bRowAdded As Boolean





'/******************************************************************************
Public Sub savePartsOkInList()
'/******************************************************************************
    
    On Error GoTo savePartsOkInList_ERR
    
    Dim o As clsObj
    
    Dim iRecordsAffected As Integer
    
    If bCatListIsBlocked Then Exit Sub
    
    If lngCurCatListID = 0 Then Exit Sub
    
    Dim cmd As New ADODB.Command
    cmd.ActiveConnection = cn_data
    
    ' сообщение: перезаписать список такой-то? (путь)
    
    cmd.CommandText = "delete from [r_catlist_part] where catlistID = " & lngCurCatListID
    
    cmd.Execute iRecordsAffected
    
    Set cmd = Nothing
    
    
    
    
    
    
    Dim i As Long
    Dim prt As clsPart
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from r_catlist_part where catlistID = " & lngCurCatListID & " order by relID desc", cn_data, adOpenForwardOnly, adLockOptimistic
    
'    Dim s As String
    Load frmCalc
'    s = frmCalc.SC.Eval("[1]*(1e-3)*((50e-3)+2*[3]*(1e-3))")
'    'frmCalc.SC.ExecuteStatement(
    
    Dim expr As String
    Dim strSpecFormulaLoc As String
    
    For Each prt In partsOK
        
        RS.AddNew
        
        RS.fields("catlistID").Value = lngCurCatListID
        RS.fields("partID").Value = prt.partID
        
        If Not curFrml Is Nothing And prt.partName <> prt.partNameOld Then
        
            RS.fields("partNameOver").Value = prt.partName
            
            Dim dKoef As Double
            'Dim dKoef2 As Double
            
            
            'dKoef = 1#
            
            'strSpecFormulaLoc = curFrml.props.getPropSiValue("strSpecFormula")
            
            
            For Each o In prt.koefs
            
                'o.props("posNumber").propValue
                
                expr = "1"
                
                If o.props.existsProperty("expr") Then
                    expr = o.props("expr").propValue
                End If
                    
            
                If left(expr, Len("native.")) = "native." Then
                
                    expr = Replace(expr, "native.", "")

                    If left(expr, Len("getAncKoefByLen")) = "getAncKoefByLen" Then

                        expr = Replace(expr, "getAncKoefByLen", "")
                        expr = Replace(expr, "(", "")
                        expr = Replace(expr, ")", "")
                        
                        ' получаем аргументы
                        Dim ararg() As String
                        ararg = Split(expr, ",")

                        If UBound(ararg) = 2 Then ' only (0,1,2), see getAncKoefByLen

                            Dim arg(2) As Long
                            
                            'eval every ararg
                            For i = 0 To 2
                            
                                strSpecFormulaLoc = ararg(i)
                            
                                If prt.prms.Count > 0 Then strSpecFormulaLoc = Replace(strSpecFormulaLoc, "[1]", CStr(prt.prms(1)))
                                If prt.prms.Count > 1 Then strSpecFormulaLoc = Replace(strSpecFormulaLoc, "[2]", CStr(prt.prms(2)))
                                If prt.prms.Count > 2 Then strSpecFormulaLoc = Replace(strSpecFormulaLoc, "[3]", CStr(prt.prms(3)))
                                If prt.prms.Count > 3 Then strSpecFormulaLoc = Replace(strSpecFormulaLoc, "[4]", CStr(prt.prms(4)))
                                If prt.prms.Count > 4 Then strSpecFormulaLoc = Replace(strSpecFormulaLoc, "[5]", CStr(prt.prms(5)))
                                
                                strSpecFormulaLoc = frmCalc.SC.Eval(strSpecFormulaLoc)
                                
                                arg(i) = Val(strSpecFormulaLoc)
                            
                            
                            Next i

                            dKoef = getAncKoefByLen(arg(0), arg(1), arg(2))
                            
                            o.props.AddProp "koef", dKoef

                        End If
                        
                    Else ' any other function names???
                        '...
                    End If
                    
                Else
                    ' simply eval
                    
                    strSpecFormulaLoc = expr
                
                    If prt.prms.Count > 0 Then strSpecFormulaLoc = Replace(strSpecFormulaLoc, "[1]", CStr(prt.prms(1)))
                    If prt.prms.Count > 1 Then strSpecFormulaLoc = Replace(strSpecFormulaLoc, "[2]", CStr(prt.prms(2)))
                    If prt.prms.Count > 2 Then strSpecFormulaLoc = Replace(strSpecFormulaLoc, "[3]", CStr(prt.prms(3)))
                    If prt.prms.Count > 3 Then strSpecFormulaLoc = Replace(strSpecFormulaLoc, "[4]", CStr(prt.prms(4)))
                    If prt.prms.Count > 4 Then strSpecFormulaLoc = Replace(strSpecFormulaLoc, "[5]", CStr(prt.prms(5)))
                    
                    strSpecFormulaLoc = frmCalc.SC.Eval(strSpecFormulaLoc)
                    
                    dKoef = getDbl(strSpecFormulaLoc)
                    
                    o.props.AddProp "koef", dKoef
                    
                End If
                
                ' коэффициент в любом случае должен быть
                If Not o.props.existsProperty("koef") Then o.props.AddProp "koef", 1#

            Next o
            
        End If
        
        
        
        If prt.bRunMet Then
            RS.fields("partQty").Value = getDbl(Format(prt.partRunMetQty, "0.0"))
        Else
            RS.fields("partQty").Value = prt.partQty
        End If
        
        RS.Update
        
        RS.Requery
        RS.MoveFirst
        
        Dim recID As Long
        recID = RS.fields("relID").Value
        
        
        ' ============================
        ' create records for positions
        
        If prt.koefs.Count > 0 Then
        
            Dim RSS As New ADODB.Recordset
                    
            RSS.Open "select * from r_catlist_position where catlistID = " & lngCurCatListID & " order by relID desc", cn_data, adOpenForwardOnly, adLockOptimistic
            
            For Each o In prt.koefs
                If o.props.existsProperty("koef") Then
                
                    RSS.AddNew
                
                    RSS.fields("clpID").Value = recID
                    RSS.fields("catlistID").Value = lngCurCatListID
                    RSS.fields("partID").Value = prt.partID
                    RSS.fields("posNumber").Value = o.props("posNumber").propValue
                    RSS.fields("posQty").Value = 1# ' рассчитанное количество?
                    RSS.fields("objID").Value = objs("position")
                    RSS.fields("koef").Value = o.props("koef").propValue
                    
                    RSS.Update
                
                
                End If
            Next
            
            RSS.Close
            Set RSS = Nothing
            
        
        End If
        
        ' ============================
        
        
        
    Next prt
    
    RS.Close
    Set RS = Nothing
    
    Unload frmCalc
    
    
    F1.loadListGrid lngCurCatListID
    
    Call writeOperationS(operModify, "catlist", lngCurCatListID, "добавление изделий")
    
    
    
    Exit Sub
    
savePartsOkInList_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "savePartsOkInList - Error"
    
End Sub



'/******************************************************************************
Private Sub FG_AfterEdit(ByVal Row As Long, ByVal Col As Long)
'/******************************************************************************

    On Error GoTo FG_AfterEdit_ERR


    If Col = 1 Then
    
        Dim t As clsTS
        
        Set t = colTS(FG.TextMatrix(Row, 2))
        
        t.bProcess = CBool(FG.TextMatrix(Row, 1))

        Call SaveSetting("Offtake2", "TagSets", t.ts.Name, t.bProcess)
    
    End If

Exit Sub

FG_AfterEdit_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "FG_AfterEdit - Error"

End Sub

Private Sub FG_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)

    If Col = 2 Then Cancel = True

    If Val(FG.TextMatrix(Row, 0)) >= 0 Then Cancel = True


End Sub

'/******************************************************************************
Private Sub FG_DblClick()
'/******************************************************************************


    On Error GoTo FG_DblClick_ERR
    
    Dim ID As Long
    Dim el As Element
    Dim mr As ModelReference
    Dim mrp As Long
    
    ID = Val(FG.TextMatrix(FG.Row, 0))
    mrp = Val(FG.TextMatrix(FG.Row, 3))
    
    
    Dim msapp As Object
    Set msapp = getMS
    If msapp Is Nothing Then MsgBox sCommonMessage
    
    
    If mrp > 0 Then
        Set mr = msapp.MdlGetModelReferenceFromModelRefP(mrp)
    Else
        Set mr = msapp.ActiveModelReference
    End If
    
    
    If ID > 0 And Not msapp Is Nothing Then
    
        Set el = mr.GetElementByID(DLongFromLong(ID))
        
        If Not el Is Nothing Then
        
            el.redraw msdDrawingModeHilite
        
        End If
    
    End If
    
    Set msapp = Nothing


Exit Sub

FG_DblClick_ERR:
    Set msapp = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "FG_DblClick - Error"

End Sub

Private Sub FG_GotFocus()

    Me.mnuShowView.Enabled = True

End Sub


Private Sub FG_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)

    If Button = 2 Then
    
        PopupMenu Me.mnuShowView
    
    End If
    

End Sub

Private Sub FG2_DblClick()

    Dim sFileName As String

    Dim OFN As OPENFILENAME
    OFN.lStructSize = Len(OFN)
    OFN.hWndOwner = Me.hwnd
    OFN.hInstance = App.hInstance
    OFN.lpstrFilter = "Excel Files (*.xls)" + Chr$(0) + "*.xls" + Chr$(0) + "All Files (*.*)" + Chr$(0) + "*.*" + Chr$(0)
    OFN.lpstrFile = Space$(254)
    OFN.nMaxFile = 255
    OFN.lpstrFileTitle = Space$(254)
    OFN.nMaxFileTitle = 255
    OFN.lpstrInitialDir = CurDir
    OFN.lpstrTitle = "Сохранить таблицу в файл"
    OFN.flags = 0
    Dim a
    a = GetSaveFileName(OFN)
    If (a) Then
        sFileName = LCase(Trim$(OFN.lpstrFile))
    Else
        Exit Sub
    End If

    If Asc(right(sFileName, 1)) = 0 Then sFileName = left(sFileName, Len(sFileName) - 1)
    
    If Not right(sFileName, 4) = ".xls" Then
        sFileName = sFileName & ".xls"
    End If
    
    FG2.SaveGrid sFileName, flexFileExcel
    


End Sub

Private Sub FG2_GotFocus()

    Me.mnuShowView.Enabled = False


End Sub

Private Sub fgLog_GotFocus()

    Me.mnuShowView.Enabled = False


End Sub

'/******************************************************************************
Private Sub fgZkkz_DblClick()
'/******************************************************************************

    On Error GoTo fgZkkz_DblClick_ERR


    Dim sFileName As String

    Dim OFN As OPENFILENAME
    OFN.lStructSize = Len(OFN)
    OFN.hWndOwner = Me.hwnd
    OFN.hInstance = App.hInstance
    OFN.lpstrFilter = "Excel Files (*.xls)" + Chr$(0) + "*.xls" + Chr$(0) + "All Files (*.*)" + Chr$(0) + "*.*" + Chr$(0)
    OFN.lpstrFile = Space$(254)
    OFN.nMaxFile = 255
    OFN.lpstrFileTitle = Space$(254)
    OFN.nMaxFileTitle = 255
    OFN.lpstrInitialDir = CurDir
    OFN.lpstrTitle = "Сохранить таблицу в файл"
    OFN.flags = 0
    Dim a
    a = GetSaveFileName(OFN)
    If (a) Then
        sFileName = LCase(Trim$(OFN.lpstrFile))
    Else
        Exit Sub
    End If

    If Asc(right(sFileName, 1)) = 0 Then sFileName = left(sFileName, Len(sFileName) - 1)
    
    If Not right(sFileName, 4) = ".xls" Then
        sFileName = sFileName & ".xls"
    End If
    
    fgZkkz.SaveGrid sFileName, flexFileExcel


Exit Sub

fgZkkz_DblClick_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "fgZkkz_DblClick - Error"

End Sub



'/******************************************************************************
Private Sub loadCatsForEmb()
'/******************************************************************************
    
    On Error GoTo loadCats_ERR
    
    
    Dim i As Integer
    Dim bExists As Boolean
    
    
    Dim RS As New ADODB.Recordset
    
    
    iCatIDsCount = 0
    
    
    ReDim Preserve arCatIDs(iCatIDsCount)
    arCatIDs(iCatIDsCount) = lngCurCatID
    iCatIDsCount = iCatIDsCount + 1
    
    
    
    
    
    If lngCurProjectID > 0 Then
        
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        
        RS.Open "select * from view_object_catalog where objID = " & objs("project") & " and objectID = " & lngCurProjectID & _
                                        " and forTesting = 0" & _
                                        " and deleted = 0" & _
                                        " and catUnif = 1", cn_data, adOpenForwardOnly, adLockReadOnly
        
        If Not RS.EOF Then
            RS.MoveFirst
            Do
                bExists = False
                For i = 0 To iCatIDsCount - 1
                    If arCatIDs(i) = RS.fields("catID").Value Then bExists = True
                Next i
                
                If Not bExists Then
                    ReDim Preserve arCatIDs(iCatIDsCount)
                    arCatIDs(iCatIDsCount) = RS.fields("catID").Value
                    iCatIDsCount = iCatIDsCount + 1
                End If
                
                RS.MoveNext
            Loop Until RS.EOF
            
        End If
        
        RS.Close
        
    End If
    
    
    If lngCurBlockID > 0 Then
    
        
        RS.Open "select * from view_object_catalog where objID = " & objs("block") & " and objectID = " & lngCurBlockID & _
                                        " and forTesting = 0" & _
                                        " and deleted = 0" & _
                                        " and catUnif = 1", cn_data, adOpenForwardOnly, adLockReadOnly
        
        If Not RS.EOF Then
            RS.MoveFirst
            Do
                bExists = False
                For i = 0 To iCatIDsCount - 1
                    If arCatIDs(i) = RS.fields("catID").Value Then bExists = True
                Next i
                
                If Not bExists Then
                    ReDim Preserve arCatIDs(iCatIDsCount)
                    arCatIDs(iCatIDsCount) = RS.fields("catID").Value
                    iCatIDsCount = iCatIDsCount + 1
                End If
                
                RS.MoveNext
            Loop Until RS.EOF
            
        End If
        
        
        RS.Close
        
        
    End If
    
    
    Set RS = Nothing
    
    Exit Sub
    
loadCats_ERR:
    Set RS = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadCatsForEmb - Error"
    
End Sub

Private Function getIfcPartName(ByRef sName As String) As Boolean

    
    On Error GoTo err
    
    CadInputQueue.SendCommand "mdl load simvw"
    
    Sleep 1000
    
    getIfcPartName = False
    
    sName = GetCExpressionValue("partname", "simvw")

    getIfcPartName = True
    
err:
    

End Function


'/******************************************************************************
Public Sub InitTagProcess(msapp As Object)
'/******************************************************************************
    
    On Error GoTo InitTagProcess_ERR
    
    If msapp Is Nothing Then Exit Sub
    
    Dim bOk(2) As Boolean
    
    Set parts = New Collection
    Set partsOK = New Collection
    Set partsOKnosort = New Collection
    Set partsNF = New Collection
    
    FG.Rows = 1
    
    AddRow lngBlue, True, , "Файл модели: " & msapp.ActiveDesignFile.FullName
    
    
    Dim ts As TagSet
    Dim at As Attachment
    Dim td As TagDefinition
    
    Set colTS = New Collection
    
    
    ' active file
    For Each ts In msapp.ActiveDesignFile.TagSets
        
        Set td = getTagDef(ts, "name")
        bOk(0) = Not CBool(td Is Nothing)
        
'        Set td = getTagDef(ts, "l")
'        bOk(1) = Not CBool(td Is Nothing)
'
        If bOk(0) Then
            
            bOk(0) = GetSetting("Offtake2", "TagSets", ts.Name, True)
            
            addToColTS ts, bOk(0), False
            
        End If
        
    Next ts
    
    For Each at In msapp.ActiveModelReference.Attachments
        
        If at.ElementsVisible And Not (at.IsMissingFile Or at.IsMissingModel) Then
        
        For Each ts In at.DesignFile.TagSets
            
            Set td = getTagDef(ts, "name")
            bOk(0) = Not CBool(td Is Nothing)
            
'            Set td = getTagDef(ts, "l")
'            bOk(1) = Not CBool(td Is Nothing)
            
            If bOk(0) Then
                
                bOk(0) = GetSetting("Offtake2", "TagSets", ts.Name, True)
                
                addToColTS ts, bOk(0), True
                
            End If
            
        Next ts
        
        End If
        
    Next at
    
    
    
    Dim t As clsTS
    bOk(0) = False
    
    If colTS.Count > 0 Then
        AddRow lngBlue, True, , "Отметьте наборы тегов, которые следует обработать:"
        For Each t In colTS
            AddRow , , t.bProcess, t.ts.Name, "-1"
        Next t
        bOk(0) = True
    ElseIf right(msapp.ActiveDesignFile.FullName, 4) = ".ifc" Then
        Dim sPartName As String
        If getIfcPartName(sPartName) Then
            AddRow lngBlue, True, , "Сбор данных из IFC файла"
            bOk(0) = True
        Else
            AddRow lngLightRed, True, , "Сбой системы, сбор данных из IFC файла невозможен"
        End If
    Else
        AddRow lngBlue, True, , "Не найдено ни одного набора тегов"
    End If
    
    
    
    
    Me.FG2.TextMatrix(0, 0) = "Наименование"
    Me.FG2.TextMatrix(0, 1) = "Штук"
    Me.FG2.TextMatrix(0, 2) = "пог.м"
    Me.FG2.TextMatrix(0, 3) = "Совпадений"
    
    Me.FG2.ColFormat(2) = "0.0"
    
    Me.FG2.ColAlignment(0) = flexAlignLeftCenter
    Me.FG2.ColAlignment(1) = flexAlignCenterCenter
    Me.FG2.ColAlignment(2) = flexAlignCenterCenter
    Me.FG2.ColAlignment(3) = flexAlignRightCenter
    
    
    Me.FG2.AutoSize 0, 3
    
    Me.FG2.ColHidden(4) = True
    
    Me.FG2.flags = flexCFAutoClipboard
    Me.fgZkkz.flags = flexCFAutoClipboard
    
    mnuSave.Visible = False
    
    zkkzLoad
    
    loadCatsForEmb
    
    Dim nd As Node
    
    Dim i As Integer
    For i = 0 To iCatIDsCount - 1
        Set nd = tvGetTreeNode(F1.tvCats, "catalog" & arCatIDs(i))
        If nd Is Nothing Then
            AddRow lngLightRed, , , "ОШИБКА"
        Else
            AddRow lngBlue, True, , "Каталог: " & nd.FullPath
        End If
    Next i
    
    

    If msapp.ActiveModelReference.MasterUnit.Label <> "mm" Then
        AddRow lngLightRed, True, , "Проверьте рабочие единицы (Settings - Design file - Working units)"
        AddRow lngLightRed, True, , "Если они не миллиметры, то возможен неверный расчет наложения"
    End If
    
    
    If bOk(0) Then AddRow lngGrey, True, , "Для начала получения данных из модели MicroStation используйте команду меню"
    
    Me.FG.FrozenRows = Me.FG.Rows - 2
    
    
    
    
    
    
    
    Exit Sub
    
InitTagProcess_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "InitTagProcess - Error"
    
End Sub



Private Sub Form_Load()

    mnuZkkzCalc.Checked = GetSetting("Offtake2", "Size", "mnuZkkzCalc.Checked", False)

    Dim o As clsObj
    Dim i As Integer
    For i = 1 To colFrml.Count
        Set o = colFrml(i)
        Me.mnuGetFromModelByParam(i - 1).Visible = True
        Me.mnuGetFromModelByParam(i - 1).Caption = o.objname
        Me.mnuGetFromModelByParam(i - 1).Tag = o.KEY
    Next i




End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked
End Sub

Private Sub Form_Unload(Cancel As Integer)

    Call SaveSetting("Offtake2", "Size", "mnuZkkzCalc.Checked", mnuZkkzCalc.Checked)


End Sub

Public Function addToColTS(ts As TagSet, bProc As Boolean, fromRef As Boolean) As Boolean

    On Error GoTo m1
    
    Dim t As New clsTS
    
    Set t.ts = ts
    t.bProcess = bProc
    t.bFromRef = fromRef

    colTS.Add t, t.ts.Name
    
    addToColTS = True

    Exit Function
    
m1:

End Function



'/******************************************************************************
Public Sub AddRow(Optional clr As Long = -1, Optional bBold As Boolean = False, Optional bSelect As Boolean = False, Optional strMes As String = "", Optional strKey As String = "", Optional strFile As String = "0")
'/******************************************************************************

    On Error GoTo addRow_ERR

    FG.AddItem ""
    
    FG.TextMatrix(FG.Rows - 1, 0) = strKey
    FG.TextMatrix(FG.Rows - 1, 1) = bSelect
    FG.TextMatrix(FG.Rows - 1, 2) = strMes
    FG.TextMatrix(FG.Rows - 1, 3) = strFile
    
    If Val(strKey) < 0 Then Me.FG.Cell(flexcpForeColor, FG.Rows - 1, 2) = lngDarkGrey
    
    If clr >= 0 Then FG.Cell(flexcpBackColor, FG.Rows - 1, 1, , 2) = clr
    
    
    
    FG.Cell(flexcpFontBold, FG.Rows - 1, 2) = bBold

    bRowAdded = True

Exit Sub

addRow_ERR:


End Sub

'/******************************************************************************
Private Sub fillProcessGrid()
'/******************************************************************************

    On Error GoTo fillProcessGrid_ERR

    Dim prt As clsPart
    Dim str As Variant
    Dim strTagSets As String
    Dim strName As String
    
    
    
    
    For Each prt In parts
    
        strTagSets = ""
    
        For Each str In prt.colTagSetNames
            If Len(strTagSets) > 0 Then
                strTagSets = strTagSets & ", "
            End If
            
            strTagSets = strTagSets & str
            
        Next str
        
        strName = prt.catName & " \ " & prt.partName
        
        If prt.colTagSetNames.Count > 1 Then
            AddRow lngLightRed, , , strName & " - дублирование тегов на элементе, наборы " & strTagSets, prt.s_elID, prt.ts_mrPtr
        End If
    
        
        
        If prt.partID = 0 Then
            prt.partOK = False
        End If
        
        
        If prt.iMaxPosNumber > 1 Then
'            prt.OK = False
            AddRow lngLightRed, , , strName & " - дублирование в каталогах", prt.s_elID, prt.ts_mrPtr
        ElseIf prt.iMaxPosNumber = 0 Then
            prt.partOK = False
            AddRow lngLightRed, , , strName & " - не найдена в каталогах базы", prt.s_elID, prt.ts_mrPtr
        End If
        
        
        If prt.bRunMet And prt.partRunMetQty = 0 Then
            prt.partOK = False
            AddRow lngLightRed, , , strName & " - в базе как погонные метры, но длина в теге не определена", prt.s_elID, prt.ts_mrPtr
        End If
        
        
        If prt.bIsLink Then
            AddRow lngLightRed, , , strName & " - детали наложены друг на друга", prt.s_elID, prt.ts_mrPtr
        End If

    
        FG.ShowCell FG.Rows - 1, 1
        If bRowAdded Then FG.Refresh
    
    Next





Exit Sub

fillProcessGrid_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "fillProcessGrid - Error"

End Sub




'/******************************************************************************
Private Sub fillPartsOK()
'/******************************************************************************

    On Error GoTo fillPartsOK_ERR
    
    Dim prt As clsPart
    Dim p As clsPart
    
    Dim strSortNum As String
    
    For Each prt In parts
    
        If prt.partOK Then
        
            strSortNum = prt.genSortNumber(prt.partName, lngCurCatListProjID)
        
            Set p = getPartByName(partsOKnosort, strSortNum)
            If p Is Nothing Then
                partsOKnosort.Add prt, strSortNum
            Else
                p.partQty = p.partQty + 1
                p.partRunMetQty = p.partRunMetQty + prt.partRunMetQty
            End If
            Set p = Nothing
        
        
        
        Else

            Set p = getPartByName(partsNF, prt.partName)
            If p Is Nothing Then
                If Not prt Is Nothing Then
                    prt.partQty = 1
                    partsNF.Add prt, prt.partName
                End If
            Else
                p.partQty = p.partQty + 1
            End If
            Set p = Nothing

        End If
    
    Next


    'Set partsOK = sortCollection(partsOKnosort)


Exit Sub

fillPartsOK_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "fillPartsOK - Error"

End Sub


'/******************************************************************************
Private Sub getFromModel(bUseRefs As Boolean, Optional sPrm As String = "")
'/******************************************************************************
    
    On Error GoTo getFromModel_ERR
    
    Dim i As Integer
    
    Dim bPrm As Boolean
    
    Set curFrml = Nothing
    
    If Len(sPrm) > 0 Then
        Set curFrml = getColItem(colFrml, sPrm)
        If Not curFrml Is Nothing Then bPrm = True
    End If
    
    
    Dim msapp As Object
    Set msapp = getMS
    If msapp Is Nothing Then MsgBox sCommonMessage: Exit Sub
    
    
    Dim sCatIds As String
    Dim RS As New ADODB.Recordset
    
    Dim strTSName As String
    Dim iTSCount As Integer
    Dim arTS() As String
    
    bRowAdded = False
    
    
    '    Me.FG.Rows = 1
    Me.FG2.Rows = 1
    Me.zkkzLoad
    
    
    '    strTSName = InputBox("Введите наборы тегов через запятую", "", GetSetting("Offtake2", "ms", "tagsets", "embb,embb1"))
    '    If Len(Trim(strTSName)) = 0 Then Exit Sub
    '    strTSName = LCase(strTSName)
    '    Call SaveSetting("Offtake2", "ms", "tagsets", Trim(strTSName))
    '    arTS = Split(strTSName, ",")
    
    If iCatIDsCount = 1 Then
        sCatIds = "catID = " & arCatIDs(0)
    Else
        sCatIds = "catID in ("
        
        For i = 0 To iCatIDsCount - 1
            
            If right(sCatIds, 1) <> "(" Then sCatIds = sCatIds & ","
            sCatIds = sCatIds & arCatIDs(i)
            
        Next i
        
        sCatIds = sCatIds & ")"
    End If
    
    
    
    
    
    Set parts = New Collection
    Set partsOK = New Collection
    Set partsOKnosort = New Collection
    Set partsNF = New Collection
    
    AddRow , , , "Компресс..."
    FG.Refresh
    Me.Refresh
    
    msapp.CadInputQueue.SendCommand "compress options on all"
    msapp.CadInputQueue.SendCommand "compress design"
    
    FG.Refresh
    Me.Refresh
    
    
    Dim ts As TagSet
    Dim ee As ElementEnumerator
    Dim at As Attachment
'    Dim esc As ElementScanCriteria
'    Set esc = New ElementScanCriteria
'    esc.ExcludeNonGraphical
    
    
    Dim t As clsTS
    
    If right(ActiveModelReference.DesignFile.FullName, 4) = ".ifc" Then
        Set t = New clsTS
        t.bIFC = True
        colTS.Add t
        bUseRefs = False
    End If
    
    
    ' PROCESS
    '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ' active file
    For Each t In colTS
        
        If Not t.bFromRef Then
            If t.bProcess Then
                AddRow lngBlue, True, , "Обработка набора " & t.ts.Name & " в " & ActiveDesignFile.FullName & "..."
                processTagSet ActiveModelReference, t.ts.Name, sCatIds, bPrm, False
            ElseIf t.bIFC Then
                msapp.CadInputQueue.SendCommand "mdl load simvw"
                AddRow lngBlue, True, , "Обработка " & ActiveDesignFile.FullName & "..."
                processTagSet ActiveModelReference, "", sCatIds, bPrm, True
            Else
                AddRow lngBlue, True, , "Набор тегов пропущен - " & t.ts.Name & " в " & ActiveDesignFile.FullName
            End If
        End If
        
        
    Next t
    
    AddRow lngBlue, True, , "Обработка файла закончена"

    
    ' references
    If bUseRefs Then
        For Each at In ActiveModelReference.Attachments
        
            If at.ElementsVisible And Not (at.IsMissingFile Or at.IsMissingModel) Then
            
            For Each t In colTS
                If t.bProcess Then
                    AddRow lngBlue, True, , "Обработка набора " & t.ts.Name & " в " & at.DesignFile.FullName & "..."
                    processTagSet at, t.ts.Name, sCatIds, bPrm, False
                Else
                    AddRow lngBlue, True, , "Набор тегов пропущен - " & t.ts.Name & " в " & at.DesignFile.FullName & "..."
                End If
            Next t
            
            End If
            
        Next at
        
        
        AddRow lngBlue, True, , "Обработка референсов закончена"
        
    End If
    '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    AddRow lngBlue, True, , "Найденные ошибки:"
    fillProcessGrid
    
    
    'fill partsOKnosort
    '=========================================
     fillPartsOK
    '=========================================
        
    
   
    
    Dim prt As clsPart
    
    For Each prt In partsOKnosort
        
        FG2.AddItem prt.partName & vbTab & prt.partQty & vbTab & prt.partRunMetQty & vbTab & prt.iMaxPosNumber & vbTab & prt.partSortNumber ' prt.genSortNumber(prt.partName)
        
        If prt.bRunMet Then
            FG2.Cell(flexcpFontBold, FG2.Rows - 1, 2) = True
        Else
            FG2.Cell(flexcpFontBold, FG2.Rows - 1, 1) = True
        End If
        
        If prt.iMaxPosNumber > 1 Then
            FG2.Cell(flexcpBackColor, FG2.Rows - 1, 0, , 3) = lngLightRed
        End If
        
    Next prt
    
    
    '... sort partsOK
    
    
    If partsOKnosort.Count > 0 Then
        FG2.Select 1, 4
        FG2.sort = flexSortStringAscending
        FG2.Subtotal flexSTSum, -1, 1, "0", lngGrey, , True, "Всего"
        FG2.Subtotal flexSTSum, -1, 2, "0.0", lngGrey, , True, "Всего"
    End If
    
    Set partsOK = New Collection
    
    For i = 1 To FG2.Rows - 2 ' subtotal
        partsOK.Add partsOKnosort(FG2.TextMatrix(i, 4))
    Next i
    

    '=========================================
    'If mnuZkkzCalc.Checked Then
    '    processZKKZ
    '    fgZkkz.Subtotal flexSTSum, -1, 3, "0", lngGrey, , True, "Всего"
    'End If
    '=========================================
    
    AddRow lngBlue, True, , "Результат:"
    
    For Each prt In partsNF
        AddRow lngLightRed, , , "Изделие '" & prt.partName & "' пропущено " & prt.partQty & " раз"
    Next prt
    AddRow lngRowWinColor, , , "Всего изделий в список - " & partsOK.Count
    
    
    
    AddRow lngBlue, True, , "Подсказка:"
    
    AddRow lngGrey, , , "Для выделения изделия в модели нужно два раза щелкнуть по строчке в этой таблице"
    AddRow lngGrey, , , "Для того чтобы найти изделие в модели, используйте команду меню"
    '    FG.Refresh
    
    
    
    bList = True
    
    If (FG2.Rows > 1) Then
        mnuLoad.Caption = "Сохранить в список"
        
        AddRow lngGrey, , , "Данные списка представлены справа вверху, для сохранения нажмите 'Сохранить в список'"
        AddRow lngGrey, , , "Данные для расчета ЗККЗ представлены справа внизу"
        AddRow lngGrey, , , "Двойной щелчок по таблицам справа позволяет сохранить их в файл Excel"
        AddRow lngGrey, , , "Возможно также использовать клавиши буфера обмена (Ctrl-C, Ctrl-V и т.д.)"
        
        '        FG.Refresh
        
        
        
        If lngCurCatListID > 0 Then
            Dim ctID As Long
            ctID = selectLongFromBase(cn_data, "catlist", "catID", "catlistID", lngCurCatListID)
            mnuLoad.Visible = checkCatPerm(ctID)
        Else
            mnuLoad.Visible = False
        End If
        
        
        mnuSave.Visible = checkCatPerm(lngCurCatID)
        
        
    Else
        
        AddRow lngRowWinColor, , , "Нет изделий для загрузки в список..."
        '        FG.Refresh
        
    End If
    
    
    
    FG.ShowCell FG.Rows - 1, 1
    If bRowAdded Then FG.Refresh
    
    Set msapp = Nothing
    
    Exit Sub
    
getFromModel_ERR:
    Set RS = Nothing
    Set msapp = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "getFromModel - Error"
    
End Sub

Private Sub mnuGetFromModel1_Click()

    getFromModel False


End Sub

Private Sub mnuGetFromModel2_Click()


    getFromModel True

End Sub

Public Sub reinLoadDep2()




End Sub

'/******************************************************************************
Private Sub mnuGetFromModelByParam_Click(Index As Integer)
'/******************************************************************************

    'On Error GoTo mnuGetFromModelByParam_Click_ERR

    getFromModel False, mnuGetFromModelByParam(Index).Tag

Exit Sub

mnuGetFromModelByParam_Click_ERR:
    'MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "mnuGetFromModelByParam_Click - Error"

End Sub


Private Sub mnuLoad_Click()
    
    
    iSrtmNameCol = 0
    iStdTypeNameCol = 0
    iStdNumberCol = 0
    iStdNameCol = 0
    iMatNameCol = 0
    iPosDefCol = 0
    iFirstPropCol = 0
    
    If bLoadRein Then
        reinLoadDep2
        Exit Sub
'    ElseIf bLoadRein And usrCurrent.depID = 3 Then
''        reinLoadDep3
'        Exit Sub
    End If
    
    If bList Then
        savePartsOkInList
        Exit Sub
    End If
    
    
    For Col = 1 To FG.cols - 1
        
        If LCase(Trim(FG.TextMatrix(1, Col))) = "srtmname" Then
            iSrtmNameCol = Col
        ElseIf LCase(Trim(FG.TextMatrix(1, Col))) = "stdtypename" Then
            iStdTypeNameCol = Col
        ElseIf LCase(Trim(FG.TextMatrix(1, Col))) = "stdnumber" Then
            iStdNumberCol = Col
        ElseIf LCase(Trim(FG.TextMatrix(1, Col))) = "stdname" Then
            iStdNameCol = Col
        ElseIf LCase(Trim(FG.TextMatrix(1, Col))) = "posdefname" Then
            iPosDefCol = Col
        ElseIf LCase(Trim(FG.TextMatrix(1, Col))) = "matname" Then
            iMatNameCol = Col
        Else
            iFirstPropCol = Col
            Exit For
        End If
        
    Next Col
    
    
'    If iSrtmNameCol > 0 And iStdTypeNameCol > 0 And iStdNumberCol > 0 And iFirstPropCol > 0 Then
'
'        fgLog.AddItem "Загрузка позиций сортамента..."
'        fgLog.Refresh
'        srtmLoad
'        fgLog.AddItem "Завершено"
'
'    ElseIf iStdTypeNameCol > 0 And iStdNumberCol > 0 And iStdNameCol > 0 Then
'        fgLog.AddItem "Загрузка стандартов..."
'        fgLog.Refresh
'        stdLoad
'        fgLog.AddItem "Завершено"
'
'    ElseIf iPosDefCol > 0 And iMatNameCol > 0 And iStdTypeNameCol > 0 And iStdNumberCol > 0 Then
'        fgLog.AddItem "Загрузка материалов..."
'        fgLog.Refresh
'        matLoad
'        fgLog.AddItem "Завершено"
'
'    ElseIf iSrtmNameCol > 0 And iStdTypeNameCol > 0 And iStdNumberCol > 0 Then
'        fgLog.AddItem "Загрузка электродов..."
'        fgLog.Refresh
'        srtmLoad
'        fgLog.AddItem "Завершено"
'
'    Else
'
'        fgLog.AddItem "Неправильная структура файла для загрузки"
'        Exit Sub
'
'    End If
    
    
    
End Sub

'/******************************************************************************
Public Sub zkkzLoad()
'/******************************************************************************

    On Error GoTo zkkzLoad_ERR

    Dim RS As New ADODB.Recordset
    
    RS.Open "select zzName, zzDiamMin, zzDiamMax, NULL, NULL from r_usr_parts_zkkz", cn_srtm, adOpenStatic, adLockReadOnly

    Set Me.fgZkkz.DataSource = RS






Exit Sub

zkkzLoad_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "zkkzLoad - Error"

End Sub




Public Function getDbl(str As String) As Double

On Error GoTo getDbl_err

    Dim dblv As Double
    
    dblv = str
    getDbl = dblv
    
    Exit Function
    
getDbl_err:

    dblv = Val(str)
    getDbl = dblv

End Function

'/******************************************************************************
Private Sub mnuSave_Click()
'/******************************************************************************
    
    On Error GoTo mnuSave_Click_ERR
    
    Dim RS As New ADODB.Recordset
    Dim prt As clsPart
    Dim prtCurID As Long
    
    
    If bCatIsBlocked Or checkGroupPerm(usrCurrent.groupID, "part", operModify) = False Then
        MsgBox "Каталог используется только для чтения", vbCritical, ""
        Exit Sub
    End If
    
    
    Dim cat As clsCat
    Set cat = cCats(CStr(lngCurCatID))
    
    
    If cat.bUnif Then
        MsgBox "В унифицированный каталог ссылки добавлять нельзя", vbCritical, ""
        Exit Sub
    End If
    
    
    For Each prt In partsOK
        
        RS.Open "select * from r_catalog_part where catID = " & lngCurCatID & " and partID = " & prt.partID, cn_data, adOpenForwardOnly, adLockOptimistic
        
        If RS.EOF Then
            
            If prt.catID <> lngCurCatID Then
                RS.AddNew
                RS.fields("catID").Value = lngCurCatID
                RS.fields("partID").Value = prt.partID
                
                'If prt.partName <> prt.partNameOld Then
                '    RS.fields("partLinkName").Value = prt.partName
                'End If
                
                
                RS.Update
            End If
            
        Else
        End If
        
        RS.NextRecordset
        
        
    Next prt
    
    
    Set RS = Nothing
    
    
    If Not F1.curPart Is Nothing Then
        prtCurID = F1.curPart.partID
    End If
    
    
    F1.loadCatalog lngCurCatID, True, prtCurID, False, False ' каталог перегрузить, изд. выделить, вкладку не активировать, список не перегружать
    
    
    Exit Sub
    
mnuSave_Click_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "mnuSave_Click - Error"
    
End Sub





'/******************************************************************************
Public Function getMSElement(ByRef mr As ModelReference, ByRef el As Element, ID As DLong) As Boolean
'/******************************************************************************

    On Error GoTo getElement_ERR

    Set el = mr.GetElementByID(ID)
    
    getMSElement = True


Exit Function

getElement_ERR:

End Function


'/******************************************************************************
Private Sub mnuShow_Click(Index As Integer)
'/******************************************************************************

    On Error GoTo mnuShow_Click_ERR



    Dim sID As String
    Dim el As Element
'    Dim at As Attachment
    Dim mrp As Long
    Dim mr As ModelReference
    
    mrp = Val(FG.TextMatrix(FG.Row, 3))
    sID = FG.TextMatrix(FG.Row, 0)
    
    
    Dim msapp As Object
    Set msapp = getMS
    If msapp Is Nothing Then MsgBox sCommonMessage: Exit Sub
    
    
    If mrp > 0 Then
        Set mr = msapp.MdlGetModelReferenceFromModelRefP(mrp)
    Else
        Set mr = msapp.ActiveModelReference
    End If
    
    
    If Len(sID) > 0 And Not msapp Is Nothing Then
    
        If Not getMSElement(mr, el, DLongFromString(sID)) Then
        
            MsgBox "Элемент не найден"
            Exit Sub
        
'            For Each at In mr.Attachments
'                If getMSElement(at, el, DLongFromLong(ID)) Then
'                    Exit For
'                End If
'            Next at
        
        End If
        
        Dim v As View
        
        Set v = msapp.ActiveDesignFile.Views(Index)
        
        
        
        
        
        If Not el Is Nothing Then
        
            Dim pOrigin As Point3d
            Dim pExtents As Point3d
            Dim pScale As Point3d
            Dim dZF As Double
            
            pOrigin.x = (el.Range.low.x + el.Range.high.x) / 2
            pOrigin.Y = (el.Range.low.Y + el.Range.high.Y) / 2
            pOrigin.z = (el.Range.low.z + el.Range.high.z) / 2
            
            el.IsLocked = False ' for ifc
            
            Dim tm As Transform3d
            tm = Transform3dIdentity()
            tm.TranslationX = -pOrigin.x
            tm.TranslationY = -pOrigin.Y
            tm.TranslationZ = -pOrigin.z
            el.Transform tm
            tm = Transform3dFromMatrix3d(Matrix3dInverse(v.Rotation))
            tm.TranslationX = 0
            tm.TranslationY = 0
            tm.TranslationZ = 0
            el.Transform tm
            tm = Transform3dIdentity()
            tm.TranslationX = pOrigin.x
            tm.TranslationY = pOrigin.Y
            tm.TranslationZ = pOrigin.z
            el.Transform tm
            
            
            pExtents.x = el.Range.high.x - el.Range.low.x
            pExtents.Y = el.Range.high.Y - el.Range.low.Y
'            pExtents.Z = el.Range.High.Z - el.Range.Low.Z
            
            pScale.x = pExtents.x / v.Extents.x
            pScale.Y = pExtents.Y / v.Extents.Y
'            pScale.Z = pExtents.Z / v.Extents.Z
            
            dZF = pScale.x
            If pScale.Y > dZF Then dZF = pScale.Y
'            If pScale.Z > dZF Then dZF = pScale.Z

            If dZF < 1# Then dZF = 1#
            
            
            v.ZoomAboutPoint pOrigin, dZF * 1.2
            v.redraw
            
            
            If InStr(msapp.Version, "08.11") > 0 Then
                el.IsHighlighted = True
            Else
                el.redraw msdDrawingModeHilite
            End If
            
        End If
    
    End If

    Set msapp = Nothing

Exit Sub

mnuShow_Click_ERR:
    Set msapp = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "mnuShow_Click - Error"

End Sub

'/******************************************************************************
Private Function checkElemIsTube2Flan(el As Element) As Boolean
'/******************************************************************************
    
    On Error GoTo checkElem_ERR
    
    Dim subel As Element
    Dim subelcnt As Integer
    
    If el.IsCellElement Then
        
        Dim cel As CellElement
        Set cel = el.AsCellElement
        
        Dim ee As ElementEnumerator
        Set ee = cel.GetSubElements
        
        
        Do While ee.MoveNext
            Set subel = ee.Current
            
            subelcnt = subelcnt + 1
            
            If Not subel.IsCellElement Then
                checkElemIsTube2Flan = False
                Exit Function
            End If
            
            
        Loop
    Else
        checkElemIsTube2Flan = False
        Exit Function
    End If
    
    
    If subelcnt = 3 Then checkElemIsTube2Flan = True
    
    
    Exit Function
    
checkElem_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "checkElem - Error"
    
End Function

'/******************************************************************************
Public Function checkPartByRange(prt1 As clsPart, prt2 As clsPart) As Boolean
'/******************************************************************************
    
    On Error GoTo checkPartRange_ERR
    
    checkPartByRange = False


    If prt1.s_elID = prt2.s_elID And prt1.ts_mrPtr = prt2.ts_mrPtr Then checkPartByRange = True

    If prt1.rng.high.x = 0 And prt1.rng.high.Y = 0 And prt1.rng.high.z = 0 And prt1.rng.low.x = 0 And prt1.rng.low.Y = 0 And prt1.rng.low.z = 0 Then checkPartByRange = True
    If prt2.rng.high.x = 0 And prt2.rng.high.Y = 0 And prt2.rng.high.z = 0 And prt2.rng.low.x = 0 And prt2.rng.low.Y = 0 And prt2.rng.low.z = 0 Then checkPartByRange = True


    If Abs(prt1.rng.high.x - prt2.rng.high.x) > 10 Then checkPartByRange = True

    If Abs(prt1.rng.high.Y - prt2.rng.high.Y) > 10 Then checkPartByRange = True

    If Abs(prt1.rng.high.z - prt2.rng.high.z) > 10 Then checkPartByRange = True

    If Abs(prt1.rng.low.x - prt2.rng.low.x) > 10 Then checkPartByRange = True

    If Abs(prt1.rng.low.Y - prt2.rng.low.Y) > 10 Then checkPartByRange = True

    If Abs(prt1.rng.low.z - prt2.rng.low.z) > 10 Then checkPartByRange = True


    
    
    Exit Function
    
checkPartRange_ERR:
    checkPartByRange = True
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "checkPartRange - Error"
    
End Function


'/******************************************************************************
Private Sub processZKKZ()
'/******************************************************************************
    
    On Error GoTo processZKKZ_ERR
    
    Dim prt As clsPart
    
    PB.Min = 0
    PB.Max = partsOK.Count
    PB.Value = 0
    
    Dim cnt As Long
    
    For Each prt In partsOK
        
        With fgZkkz
            
            Dim i As Integer
            Dim pos As clsPos
            Dim prop As clsProp
            Dim diam As Double
            Dim cdiam(1 To 2) As Double
            Dim bDiam As Boolean
            
            If prt.partID = 0 Then GoTo cnt
            
            
            prt.setIDv2 prt.partID, True, True, False
            
            
            For i = 1 To prt.ps.pm.Count
                Set pos = prt.ps.pm(i)
                If pos.POS_PD.PD_NAME = "Труба" Then
                    Set prop = pos.pos_props("diameter")
                    If Not prop Is Nothing Then diam = prop.PVAL
                    Exit For
                End If
            Next i
            
            
            For i = 0 To .Rows - 1
                
                cdiam(1) = Val(.TextMatrix(i, 1))
                cdiam(2) = Val(.TextMatrix(i, 2))
                
                bDiam = True
                
                If Not (cdiam(1) = cdiam(2) Or cdiam(2) = 0# Or diam = 0#) Then
                    If Not (cdiam(1) < diam And diam < cdiam(2)) Then
                        bDiam = False
                    End If
                ElseIf cdiam(2) > 0# And diam > 0# Then
                    If Not (diam > cdiam(2)) Then
                        bDiam = False
                    End If
                End If
                
                
                If prt.partName Like .TextMatrix(i, 0) & "*" And bDiam Then
                    If prt.isInRunningMeters Then
                    .TextMatrix(i, 4) = Val(.TextMatrix(i, 4)) + prt.partRunMetQty
                    End If
                    
                    .TextMatrix(i, 3) = Val(.TextMatrix(i, 3)) + prt.partQty
                    '                                If Not telLen Is Nothing Then .TextMatrix(I, 4) = Val(.TextMatrix(I, 4)) + Val(telLen.Value) * 0.001
                    Exit For
                End If
            Next i
        End With
        
cnt:

        cnt = cnt + 1
        
        PB.Value = cnt
        
    Next
    
    PB.Value = 0
    
    Exit Sub
    
processZKKZ_ERR:
    PB.Value = 0
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "processZKKZ - Error"
    
End Sub




'/******************************************************************************
Public Sub processTagSet(mr As ModelReference, tsName As String, sCatIds As String, bPrm As Boolean, bIFC As Boolean)
'/******************************************************************************

    On Error GoTo processTagSet_ERR

    
    
    
    Dim ts As TagSet
    
    If Len(tsName) > 0 Then ' if 0 then IFC
    
        Set ts = getTagSet(mr.DesignFile, tsName)
        
        If ts Is Nothing Then Exit Sub
        
    End If
    
    
    
    '    Dim colFound As New Collection
    '    Dim colNotFound As New Collection
    
    Dim bErr As Boolean
    
    Dim ee As ElementEnumerator
    Dim el As Element
    Dim tel As TagElement
    Dim telLen As TagElement
    Dim prt As clsPart
    Dim prtCurEl As clsPart
    Dim strPartName As String
    '    Dim bOk As Boolean
    Dim RS As New ADODB.Recordset
    
    Dim esc As ElementScanCriteria
    Set esc = New ElementScanCriteria
    esc.ExcludeNonGraphical
    
    Dim r As OfftIntRange3D
    
    Set ee = mr.Scan(esc)
    
    Dim lngClr As Long
    Dim strMes As String
    'Dim strPartNameParams As String
    
    Dim i As Integer
    
    
    '============================
    Do While ee.MoveNext
        
        Set el = ee.Current
        lngClr = lngRowWinColor
        strMes = ""
        
        bRowAdded = False
        
        
        '        If el.HasAnyDatabaseLinks(msdDatabaseLinkageOleDb, 11) Then
        '
        '            Dim ar() As DatabaseLink
        '
        '            ar = el.GetDatabaseLinks(msdDatabaseLinkageOleDb, 11)
        '
        '            If ar(0).Mslink > 0 Then
        '
        '
        '                Set prt = getPartByID(partsOK, ar(0).Mslink)
        '            Else
        '            End If
        '
        '
        '        ElseIf el.HasAnyTags Then
        
        strPartName = ""
        'strPartNameParams = ""

        
        If el.HasAnyTags Then
            
            
            Set tel = getTagElement(ts, el, "name")
            
            If Not tel Is Nothing Then
                
                strPartName = tel.Value
                
            Else
                ' в элементе нет набора тегов strTSName
            End If
            
            
        ElseIf bIFC Then
        
            Dim oPH As PropertyHandler
            Set oPH = CreatePropertyHandler(el)
            
            'Dim ars() As String
            'ars = oPH.GetAccessStrings() "GlobalId"
            
            Dim sID As String
            
            If oPH.SelectByAccessString("GlobalId") Then
                sID = oPH.GetDisplayString
                
                CadInputQueue.SendCommand "simvw ifcinfo " & sID
                
                ' get strPartName by sID ...
                strPartName = GetCExpressionValue("partname", "simvw")
                
                If Trim(strPartName) = "" Then strPartName = "NONAME"
                
            End If
        
            
        Else
            ' в элементе нет тегов
            
            If el.IsShapeElement Then
            
                Dim shel As ShapeElement
                Set shel = el.AsShapeElement
                
                If shel.VerticesCount = 5 And shel.Class = msdElementClassPrimary Then
                    AddRow lngLightRed, , , "Возможно полоса, в которой потерян тег", CStr(DLongToLong(el.ID)), CStr(mr.MdlModelRefP)
                    FG.ShowCell FG.Rows - 1, 1
                    If bRowAdded Then FG.Refresh
                End If
            
            
            ElseIf checkElemIsTube2Flan(el) Then
            
                AddRow lngLightRed, , , "Возможно проходка, в которой потерян тег", CStr(DLongToLong(el.ID)), CStr(mr.MdlModelRefP)
                
                FG.ShowCell FG.Rows - 1, 1
                If bRowAdded Then FG.Refresh
            
            
            End If
            
        End If
                
                
        If Not (Len(strPartName) = 0 Or strPartName = "not found") Then
            
            strPartName = correctPartName(strPartName)
            
            'If left(strPartName, 1) = "T" Then
            '    Print ""
            'End If
            
            Set prtCurEl = New clsPart
            prtCurEl.partName = strPartName
            prtCurEl.partNameOld = strPartName
            
            If bPrm And Not curFrml Is Nothing Then
            
                Dim splt_qty As Integer
                Dim prms_qty As Integer
                Dim bPasst As Boolean
            
                bPasst = False
            
                If curFrml.props.existsProperty("pattern") Then
                    Dim rgxp As New RegExp
                    rgxp.Pattern = curFrml.props("pattern").propValue
                    If rgxp.Test(strPartName) Then
                        bPasst = True
                    End If
                Else
                    bPasst = True
                End If
                
                If bPasst Then
                
                    If curFrml.props.existsProperty("splitter_quantity") Then
                        splt_qty = Val(curFrml.props("splitter_quantity").propValue)
                    Else
                        splt_qty = 2 ' default
                    End If
                    
                    If curFrml.props.existsProperty("params_quantity") Then
                        prms_qty = Val(curFrml.props("params_quantity").propValue)
                    Else
                        prms_qty = 1 ' default
                    End If
                
                    Dim ar() As String
                    ar = Split(strPartName, "-")
                    
                    If UBound(ar) = splt_qty Then
                    
                        prtCurEl.partNameOld = ""
                        For i = 0 To (splt_qty - prms_qty)
                            If Len(prtCurEl.partNameOld) > 0 Then prtCurEl.partNameOld = prtCurEl.partNameOld & "-"
                            prtCurEl.partNameOld = prtCurEl.partNameOld & ar(i)
                        Next i
                        
                        For i = (splt_qty - prms_qty + 1) To UBound(ar)
                            prtCurEl.prms.Add CLng(Val(ar(i)))
                            'If Len(strPartNameParams) > 0 Then strPartNameParams = strPartNameParams & "-"
                            'strPartNameParams = strPartNameParams & ar(i)
                        Next i
                    
                        '====================
                        'If UBound(ar) > 0 Then
                        '    prtCurEl.partNameOld = ar(0) & "-" & ar(1) ' обрезание
                        'End If
                        '====================
                    
                    End If
                    
                End If
                
            
            End If
            
            'If bPrm Then
            '    prtCurEl.partName = strPartName & "-" & strPartNameParams
            'End If
            
            
            prtCurEl.s_elID = DLongToString(el.ID)
            prtCurEl.ts_mrPtr = mr.MdlModelRefP
            
            prtCurEl.setRange el.Range.low.x, el.Range.low.Y, el.Range.low.z, el.Range.high.x, el.Range.high.Y, el.Range.high.z
            
            prtCurEl.partOK = True
            
            If tsName = "" Then
                strMes = strPartName
            Else
                strMes = strPartName & " (" & tsName & ")" & "(тип " & el.Type & ")"
            End If
            
            prtCurEl.catName = mr.DesignFile.Name
            
            
            Set prt = getPartByName(parts, CStr(prtCurEl.s_elID & "-" & prtCurEl.ts_mrPtr))
            If prt Is Nothing Then
                parts.Add prtCurEl, CStr(prtCurEl.s_elID & "-" & prtCurEl.ts_mrPtr)
                Set prt = prtCurEl
            Else ' дублированеи тега
                lngClr = lngLightRed
                strMes = strMes & ", дублирование тегов"
            End If
            
            prt.colTagSetNames.Add tsName
            
            
            
            Set telLen = getTagElement(ts, el, "l")
            If Not telLen Is Nothing Then
                prt.partRunMetQty = Val(telLen.Value) * 0.001
            End If
            
            prt.partQty = 1
            
            
'                If prt.partName = "MD-4" Then
'                Debug.Print
'                End If
            
            
            RS.Open "select distinct catID, partID, dbo.isPartRun(partID) as partMainPosEP, [link] from view_part2 where partName = '" & _
                        prt.partNameOld & "' and " & sCatIds & " and deleted = 0 and partStatusID <> 3", cn_data, adOpenStatic, adLockReadOnly
            
            
            
            Dim prtID As Long
            prt.iMaxPosNumber = 0
            prtID = 0
            
            If Not RS.EOF Then
                RS.MoveFirst
                
                prt.catID = RS.fields("catID").Value
                prt.partID = RS.fields("partID").Value
                If Not bPrm Then prt.bRunMet = getBool(RS.fields("partMainPosEP").Value)
                
                
                Do
                    If RS.fields("partID").Value <> prtID Then
                        prt.iMaxPosNumber = prt.iMaxPosNumber + 1
                        prtID = RS.fields("partID").Value
                    End If
                
                    RS.MoveNext
                Loop Until RS.EOF
            End If
            
            RS.Close
            Set RS = Nothing
            
            
            
            ' === parameters ===
            If Not curFrml Is Nothing And prtCurEl.prms.Count > 0 Then
            
                Set RS = New ADODB.Recordset
                Dim sposID As String
                Dim expr As String
                
                RS.Open "select * from [view_position] where partID = " & prt.partID, cn_data, adOpenStatic, adLockReadOnly
                If Not RS.EOF Then
                    RS.MoveFirst
                    Do
                        expr = "1"  ' koef
                        
                        sposID = CStr(RS.fields("posID").Value)
                        
                        Dim obj As New clsObj
                        obj.props.AddProp "posNumber", RS.fields("posNumber").Value
                        
                        obj.props.AddProp "expr", expr
                        
                        ' считаем partQty при сохранении
    
                        prt.koefs.Add obj, sposID
                        
                        Set obj = Nothing
                    
                        RS.MoveNext
                    Loop Until RS.EOF
                    
                End If
                
                RS.NextRecordset
                
                
                
                Dim o As clsObj
                i = 0
                For Each o In curFrml.kinder
                    
                    RS.Open "select * from [view_position] where partID = " & prt.partID & " and " & o.props("criteria").propValue, cn_data, adOpenStatic, adLockReadOnly
                    
                    i = i + 1
                    
                    If Not RS.EOF Then
                        RS.MoveFirst
                        
                        sposID = CStr(RS.fields("posID").Value)
                        
                        expr = o.props("expr").propValue ' strSpecFormula
                        
                        Dim objj As clsObj
                        Set objj = getColItem(prt.koefs, sposID)
                        
                        If Not objj Is Nothing Then
                            objj.props("expr").propValue = expr
                        End If
                        
                        ' считаем partQty при сохранении

                    ElseIf i = 1 Then
                    
                        lngClr = lngLightRed
                        strMes = strMes & ", некорректный параметр основной позиции"
                    
                    End If
                    
                    RS.NextRecordset
                    
                    
                Next o
                
                
                Set RS = Nothing
                
            End If
            '====================
            
            
            ' prt.iMaxPosNumber > 1 - одинаковых изделий (не ссылок) больше чем одно, ошибка
            ' prt.iMaxPosNumber = 1 - найдено, одинаковых изделий нет, ок
            ' prt.iMaxPosNumber = 0 - изделие не найдено
            
            
            
            If prt.iMaxPosNumber >= 1 Then
                
                If prt.bRunMet And prt.partRunMetQty = 0 Then
                    ' в базе как погонные метры, но длина в теге не определена"
                    lngClr = lngLightRed
                    strMes = strMes & ", нет длины в теге для пог.метров, пропущена"
                End If
                
            Else
                ' не найдена в каталогах проекта"
                lngClr = lngLightRed
                strMes = strMes & ", не найдена каталогах, пропущена"
                
            End If
            
            
            If prt.iMaxPosNumber > 1 Then
            
                ' присутствует в разных каталогах, нет вомзожности ассоциировать"
                lngClr = lngLightRed
                strMes = strMes & ", дублирование в каталогах, проверьте идентичность"
                
            End If
            
            
            Dim prtInCol As clsPart
            For Each prtInCol In parts
                If checkPartByRange(prt, prtInCol) = False Then
                    lngClr = lngLightRed
                    strMes = strMes & ", наложение друг на друга"
                    prtInCol.bIsLink = True
                    prt.bIsLink = True
                    Exit For
                End If
            Next prtInCol
            
            
            
            
            
            If lngClr = lngRowWinColor Then strMes = strMes & " ok"
            AddRow lngClr, , , strMes, prt.s_elID, CStr(prt.ts_mrPtr)
            
            FG.ShowCell FG.Rows - 1, 1
            If bRowAdded Then FG.Refresh
            
            
         End If
                
                
'            Else
'                ' в элементе нет набора тегов strTSName
'            End If
            
            
'        Else
'            ' в элементе нет тегов
'
'            If el.IsShapeElement Then
'
'                Dim shel As ShapeElement
'                Set shel = el.AsShapeElement
'
'                If shel.VerticesCount = 5 And shel.Class = msdElementClassPrimary Then
'                    AddRow lngLightRed, , , "Возможно полоса, в которой потерян тег", CStr(DLongToLong(el.ID)), CStr(mr.MdlModelRefP)
'                    FG.ShowCell FG.Rows - 1, 1
'                    If bRowAdded Then FG.Refresh
'                End If
'
'
'            ElseIf checkElemIsTube2Flan(el) Then
'
'                AddRow lngLightRed, , , "Возможно проходка, в которой потерян тег", CStr(DLongToLong(el.ID)), CStr(mr.MdlModelRefP)
'
'                FG.ShowCell FG.Rows - 1, 1
'                If bRowAdded Then FG.Refresh
'
'
'            End If
'
'        End If
        
    Loop
    
    
Exit Sub

processTagSet_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "processTagSet - Error"

End Sub

'/******************************************************************************
Private Sub mnuShowFileSave_Click()
'/******************************************************************************

    On Error GoTo mnuShowFileSave_Click_ERR

    Dim sFileName As String

    Dim OFN As OPENFILENAME
    OFN.lStructSize = Len(OFN)
    OFN.hWndOwner = Me.hwnd
    OFN.hInstance = App.hInstance
    OFN.lpstrFilter = "Excel Files (*.xls)" + Chr$(0) + "*.xls" + Chr$(0) + "All Files (*.*)" + Chr$(0) + "*.*" + Chr$(0)
    OFN.lpstrFile = Space$(254)
    OFN.nMaxFile = 255
    OFN.lpstrFileTitle = Space$(254)
    OFN.nMaxFileTitle = 255
    OFN.lpstrInitialDir = CurDir
    OFN.lpstrTitle = "Сохранить таблицу в файл"
    OFN.flags = 0
    Dim a
    a = GetSaveFileName(OFN)
    If (a) Then
        sFileName = LCase(Trim$(OFN.lpstrFile))
    Else
        Exit Sub
    End If

    If Asc(right(sFileName, 1)) = 0 Then sFileName = left(sFileName, Len(sFileName) - 1)
    
    If Not right(sFileName, 4) = ".xls" Then
        sFileName = sFileName & ".xls"
    End If
    
    FG.SaveGrid sFileName, flexFileExcel
    
Exit Sub

mnuShowFileSave_Click_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "mnuShowFileSave_Click - Error"

End Sub

Private Sub mnuZkkzCalc_Click()

    mnuZkkzCalc.Checked = Not mnuZkkzCalc.Checked

End Sub
