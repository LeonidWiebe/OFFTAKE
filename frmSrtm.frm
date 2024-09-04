VERSION 5.00
Object = "{D76D7128-4A96-11D3-BD95-D296DC2DD072}#1.0#0"; "Vsflex7.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form Form2 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Сортамент"
   ClientHeight    =   5775
   ClientLeft      =   45
   ClientTop       =   525
   ClientWidth     =   8295
   Icon            =   "frmSrtm.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   5775
   ScaleWidth      =   8295
   StartUpPosition =   1  'CenterOwner
   Begin TabDlg.SSTab tabSteel 
      Height          =   5775
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8295
      _ExtentX        =   14631
      _ExtentY        =   10186
      _Version        =   393216
      Style           =   1
      TabsPerRow      =   4
      TabHeight       =   520
      WordWrap        =   0   'False
      ShowFocusRect   =   0   'False
      TabCaption(0)   =   "   Сортамент   "
      TabPicture(0)   =   "frmSrtm.frx":000C
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Label4"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Label5"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "fgSrtm"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "chkShowUnused(0)"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "cmbStandartNumber(0)"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).Control(5)=   "cmbStandartName(0)"
      Tab(0).Control(5).Enabled=   0   'False
      Tab(0).Control(6)=   "txtSrtmName"
      Tab(0).Control(6).Enabled=   0   'False
      Tab(0).Control(7)=   "txtSrtmMass"
      Tab(0).Control(7).Enabled=   0   'False
      Tab(0).Control(8)=   "cmdSrtmAdd"
      Tab(0).Control(8).Enabled=   0   'False
      Tab(0).Control(9)=   "cmdSrtmDel"
      Tab(0).Control(9).Enabled=   0   'False
      Tab(0).ControlCount=   10
      TabCaption(1)   =   "   Марки стали   "
      TabPicture(1)   =   "frmSrtm.frx":0028
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Label6"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).Control(1)=   "Label7"
      Tab(1).Control(1).Enabled=   0   'False
      Tab(1).Control(2)=   "fgMaterial"
      Tab(1).Control(2).Enabled=   0   'False
      Tab(1).Control(3)=   "cmbStandartName(1)"
      Tab(1).Control(3).Enabled=   0   'False
      Tab(1).Control(4)=   "cmbStandartNumber(1)"
      Tab(1).Control(4).Enabled=   0   'False
      Tab(1).Control(5)=   "chkShowUnused(1)"
      Tab(1).Control(5).Enabled=   0   'False
      Tab(1).Control(6)=   "cmdMatDel"
      Tab(1).Control(6).Enabled=   0   'False
      Tab(1).Control(7)=   "cmdMatAdd"
      Tab(1).Control(7).Enabled=   0   'False
      Tab(1).Control(8)=   "txtMatName"
      Tab(1).Control(8).Enabled=   0   'False
      Tab(1).Control(9)=   "cmbMatStandart"
      Tab(1).Control(9).Enabled=   0   'False
      Tab(1).ControlCount=   10
      TabCaption(2)   =   "   Стандарты   "
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "Command1"
      Tab(2).Control(1)=   "cmdStandartDel"
      Tab(2).Control(2)=   "cmdStandartAdd"
      Tab(2).Control(3)=   "chkShowUnused(2)"
      Tab(2).Control(4)=   "txtStandartName"
      Tab(2).Control(5)=   "txtStandartNumber"
      Tab(2).Control(6)=   "lstStandartType"
      Tab(2).Control(7)=   "fgStandart"
      Tab(2).Control(8)=   "Label3"
      Tab(2).Control(9)=   "Label2"
      Tab(2).Control(10)=   "Label1"
      Tab(2).ControlCount=   11
      Begin VB.CommandButton Command1 
         Caption         =   "сохранить наименование"
         Height          =   255
         Left            =   -71040
         TabIndex        =   31
         Top             =   4920
         Width           =   4215
      End
      Begin VB.ComboBox cmbMatStandart 
         Height          =   315
         Left            =   -72600
         Style           =   2  'Dropdown List
         TabIndex        =   29
         Top             =   5160
         Width           =   2655
      End
      Begin VB.CommandButton cmdStandartDel 
         Caption         =   "Удалить"
         Height          =   315
         Left            =   -71040
         TabIndex        =   28
         Top             =   5240
         Width           =   1335
      End
      Begin VB.CommandButton cmdStandartAdd 
         Caption         =   "Добавить стандарт"
         Height          =   315
         Left            =   -69600
         TabIndex        =   27
         Top             =   5240
         Width           =   2775
      End
      Begin VB.TextBox txtMatName 
         Height          =   285
         Left            =   -74760
         TabIndex        =   25
         Top             =   5160
         Width           =   1575
      End
      Begin VB.CommandButton cmdMatAdd 
         Caption         =   "Добавить в стандарт"
         Enabled         =   0   'False
         Height          =   375
         Left            =   -69720
         TabIndex        =   24
         Top             =   4800
         Width           =   2775
      End
      Begin VB.CommandButton cmdMatDel 
         Caption         =   "Удалить строку"
         Height          =   255
         Left            =   -69720
         TabIndex        =   23
         Top             =   5280
         Width           =   2775
      End
      Begin VB.CheckBox chkShowUnused 
         Caption         =   "показать неиспользуемые"
         Height          =   255
         Index           =   2
         Left            =   -69720
         TabIndex        =   22
         Top             =   4030
         Width           =   2895
      End
      Begin VB.CheckBox chkShowUnused 
         Caption         =   "показать неиспользуемые"
         Height          =   255
         Index           =   1
         Left            =   -70440
         TabIndex        =   21
         Top             =   4440
         Width           =   2895
      End
      Begin VB.ComboBox cmbStandartNumber 
         Height          =   315
         Index           =   1
         Left            =   -74880
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   4440
         Width           =   4335
      End
      Begin VB.ComboBox cmbStandartName 
         Height          =   315
         Index           =   1
         Left            =   -74880
         Style           =   2  'Dropdown List
         TabIndex        =   19
         Top             =   4080
         Width           =   8055
      End
      Begin VB.CommandButton cmdSrtmDel 
         Caption         =   "Удалить строку"
         Height          =   255
         Left            =   5280
         TabIndex        =   18
         Top             =   5280
         Width           =   2775
      End
      Begin VB.CommandButton cmdSrtmAdd 
         Caption         =   "Добавить в сортамент"
         Enabled         =   0   'False
         Height          =   375
         Left            =   5280
         TabIndex        =   17
         Top             =   4800
         Width           =   2775
      End
      Begin VB.TextBox txtSrtmMass 
         Height          =   285
         Left            =   2040
         TabIndex        =   15
         Top             =   5160
         Width           =   2055
      End
      Begin VB.TextBox txtSrtmName 
         Height          =   285
         Left            =   240
         TabIndex        =   13
         Top             =   5160
         Width           =   1575
      End
      Begin VSFlex7Ctl.VSFlexGrid fgMaterial 
         Height          =   3615
         Left            =   -74880
         TabIndex        =   9
         Top             =   360
         Width           =   8055
         _cx             =   14208
         _cy             =   6376
         _ConvInfo       =   1
         Appearance      =   1
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
         FocusRect       =   5
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
         FixedCols       =   1
         RowHeightMin    =   0
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   -1  'True
         FormatString    =   ""
         ScrollTrack     =   -1  'True
         ScrollBars      =   3
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
      Begin VB.TextBox txtStandartName 
         Height          =   555
         Left            =   -73680
         MultiLine       =   -1  'True
         TabIndex        =   8
         Top             =   4320
         Width           =   6855
      End
      Begin VB.TextBox txtStandartNumber 
         Height          =   315
         Left            =   -73680
         TabIndex        =   7
         Top             =   5220
         Width           =   2415
      End
      Begin VB.ListBox lstStandartType 
         Height          =   1230
         Left            =   -74880
         TabIndex        =   6
         Top             =   4320
         Width           =   1095
      End
      Begin VSFlex7Ctl.VSFlexGrid fgStandart 
         Height          =   3615
         Left            =   -74880
         TabIndex        =   5
         Top             =   360
         Width           =   8055
         _cx             =   14208
         _cy             =   6376
         _ConvInfo       =   1
         Appearance      =   1
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
         FocusRect       =   5
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
      Begin VB.ComboBox cmbStandartName 
         Height          =   315
         Index           =   0
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   4080
         Width           =   8055
      End
      Begin VB.ComboBox cmbStandartNumber 
         Height          =   315
         Index           =   0
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   4440
         Width           =   4335
      End
      Begin VB.CheckBox chkShowUnused 
         Caption         =   "показать неиспользуемые"
         Height          =   255
         Index           =   0
         Left            =   4560
         TabIndex        =   2
         Top             =   4440
         Width           =   2895
      End
      Begin VSFlex7Ctl.VSFlexGrid fgSrtm 
         Height          =   3615
         Left            =   120
         TabIndex        =   1
         Top             =   360
         Width           =   8055
         _cx             =   14208
         _cy             =   6376
         _ConvInfo       =   1
         Appearance      =   1
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
         FocusRect       =   5
         HighLight       =   1
         AllowSelection  =   0   'False
         AllowBigSelection=   0   'False
         AllowUserResizing=   1
         SelectionMode   =   1
         GridLines       =   1
         GridLinesFixed  =   2
         GridLineWidth   =   1
         Rows            =   5
         Cols            =   10
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
      Begin VB.Label Label7 
         Alignment       =   2  'Center
         Caption         =   "по"
         Height          =   255
         Left            =   -73080
         TabIndex        =   30
         Top             =   5280
         Width           =   375
      End
      Begin VB.Label Label6 
         Caption         =   "Наименование"
         Height          =   255
         Left            =   -74760
         TabIndex        =   26
         Top             =   4920
         Width           =   1575
      End
      Begin VB.Label Label5 
         Caption         =   "Масса единицы, кг"
         Height          =   255
         Left            =   2040
         TabIndex        =   16
         Top             =   4920
         Width           =   2655
      End
      Begin VB.Label Label4 
         Caption         =   "Наименование"
         Height          =   255
         Left            =   240
         TabIndex        =   14
         Top             =   4920
         Width           =   1575
      End
      Begin VB.Label Label3 
         Caption         =   "Стандарт"
         Height          =   255
         Left            =   -74880
         TabIndex        =   12
         Top             =   4080
         Width           =   1095
      End
      Begin VB.Label Label2 
         Caption         =   "Номер стандарта"
         Height          =   255
         Left            =   -73680
         TabIndex        =   11
         Top             =   5000
         Width           =   1575
      End
      Begin VB.Label Label1 
         Caption         =   "Наименование стандарта"
         Height          =   255
         Left            =   -73680
         TabIndex        =   10
         Top             =   4080
         Width           =   4095
      End
   End
   Begin VB.Menu mnuStandTypeMain 
      Caption         =   "StandTypeMain"
      Visible         =   0   'False
      Begin VB.Menu mnuStandTypeAdd 
         Caption         =   "Добавить..."
      End
      Begin VB.Menu mnuStandTypeDel 
         Caption         =   "Удалить"
      End
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private arrSrtm As Variant
Private arrStandartType As Variant
Private blnLoading As Boolean
Private strPos As String
Private lngStandartTypeID As Long
Private lngNotFoundPosDefID As Long
Private lngNotFoundMassCalcID As Long

Type tStdType
    stdTypeID As Long
    stdTypeName As String
    stdTypeDevision As String
    stdTypeFromLeft As Boolean
End Type

Type tStd
    stdID As Long
    stdNumber As String
    stdName As String
    stdType As tStdType
    stdUsing As Boolean
End Type



Private Sub chkShowUnused_Click(Index As Integer)
    
    If Not blnLoading Then
        
        If Index = 0 Then
            LoadSortamentGrid
        ElseIf Index = 1 Then
            LoadMaterialGrid
        ElseIf Index = 2 Then
            LoadStandartGrid
        End If
        
    End If
    
End Sub


Private Sub cmbStandartName_Click(Index As Integer)
    
    If Me.cmbStandartNumber(Index).ListIndex <> cmbStandartName(Index).ListIndex And Not blnLoading Then
        Me.cmbStandartNumber(Index).ListIndex = cmbStandartName(Index).ListIndex
        If Index = 0 Then LoadSortamentGrid Else LoadMaterialGrid
    End If
    
    
End Sub


Private Sub cmbStandartNumber_Click(Index As Integer)
    
    If cmbStandartNumber(Index).ListIndex <> cmbStandartName(Index).ListIndex And Not blnLoading Then
        cmbStandartName(Index).ListIndex = cmbStandartNumber(Index).ListIndex
        If Index = 0 Then LoadSortamentGrid Else LoadMaterialGrid
    End If
    
End Sub


Private Sub cmdMatAdd_Click()
    
    Dim lngStandartID As Long
    Dim srtStandartFullNumber As String
    Dim srtStandartName As String
    Dim RS As New ADODB.Recordset
    Dim RS0 As New ADODB.Recordset
    
    
    If cmbMatStandart.Text = "" Then
        lngStandartID = arrMaterialStandart(1, cmbStandartNumber(1).ListIndex + 1)
        srtStandartName = arrMaterialStandart(2, cmbStandartNumber(1).ListIndex + 1)
        srtStandartFullNumber = arrMaterialStandart(3, cmbStandartNumber(1).ListIndex + 1)
    Else
        RS0.Open "select [StandartID], [StandartName] from [Standart] where [StandartFullNumber] = '" & Trim(cmbMatStandart.Text) & "'", cn, adOpenStatic, adLockReadOnly
        If RS0.RecordCount = 1 Then
            RS0.MoveFirst
            lngStandartID = RS0![StandartID]
            srtStandartName = RS0![StandartName]
            srtStandartFullNumber = cmbMatStandart.Text
        Else
            lngStandartID = arrMaterialStandart(1, cmbStandartNumber(1).ListIndex + 1)
            srtStandartName = arrMaterialStandart(2, cmbStandartNumber(1).ListIndex + 1)
            srtStandartFullNumber = arrMaterialStandart(3, cmbStandartNumber(1).ListIndex + 1)
        End If
    End If
    
    If MsgBox("   Добавить марку стали:   " & vbNewLine & _
       "   - " & Trim(txtMatName.Text) & "   " & vbNewLine & _
       "   - " & srtStandartFullNumber & "   " & vbNewLine & _
       "   - " & srtStandartName, vbOKCancel, "") = vbCancel Then Exit Sub
        
        
        
        RS.Open "select * from Material", cn, adOpenStatic, adLockOptimistic
        
        
        RS.AddNew
        
        RS![MaterialName] = Trim(txtMatName.Text)
        RS![StandartID] = lngStandartID
        RS![Using] = True
        
        RS.Update
        
        LoadMaterialGrid
        
        
    End Sub

Private Sub cmdMatDel_Click()
    
    If MsgBox("   Удалить марку стали:                        " & vbNewLine & "   - " & Trim(Me.fgMaterial.TextMatrix(fgMaterial.Row, 3)), vbOKCancel, "") = vbCancel Then Exit Sub
    
    Dim strSQL As String
    
    strSQL = "delete from [Material] where [MaterialID] = " & Str(Val(Me.fgMaterial.TextMatrix(Me.fgMaterial.Row, 1)))
    
    Dim RC As New ADODB.Command
    RC.ActiveConnection = cn
    RC.CommandType = adCmdText
    RC.CommandText = strSQL
    RC.Execute
    
    LoadMaterialGrid
    
End Sub

Private Sub cmdSrtmAdd_Click()
    
    If MsgBox("   Добавить в сортамент позицию:   " & vbNewLine & _
       "   - " & arrStandart(3, cmbStandartNumber(0).ListIndex + 1) & "   " & vbNewLine & _
       "   - " & arrStandart(2, cmbStandartNumber(0).ListIndex + 1) & "   " & vbNewLine & _
       "   - " & Trim(txtSrtmName.Text) & vbNewLine & _
       "   - " & FormatNumber(GetDblValue(txtSrtmMass.Text), 5) & " кг", vbOKCancel, "") = vbCancel Then Exit Sub
        
        Dim v As String
        If Val(txtSrtmMass.Text) = 7851 Then
            v = InputBox("   Подтвердите толщину позиции   " & vbNewLine & "   Это важно для расчетов!   ", "", Val(Trim(txtSrtmName.Text)))
            If v = "" Then Exit Sub
        End If
        
        Dim RS As New ADODB.Recordset
        
        RS.Open "select * from Sortament", cn, adOpenStatic, adLockOptimistic
        
        
        RS.AddNew
        
        RS![srtmName] = Trim(txtSrtmName.Text)
        RS![SrtmMass] = GetDblValue(txtSrtmMass.Text)
        RS![StandartID] = arrStandart(1, cmbStandartNumber(0).ListIndex + 1)
        If Val(txtSrtmMass.Text) = 7851 Then RS![SrtmHeight] = Val(v)
        RS![Using] = True
        
        RS.Update
        
        LoadSortamentGrid
        
        
    End Sub

Private Sub cmdSrtmDel_Click()
    
    If MsgBox("   Удалить позицию:                        " & vbNewLine & "   - " & Trim(Me.fgSrtm.TextMatrix(fgSrtm.Row, 3)), vbOKCancel, "") = vbCancel Then Exit Sub
    
    Dim strSQL As String
    
    strSQL = "delete from [Sortament] where [SrtmID] = " & Str(Val(Me.fgSrtm.TextMatrix(Me.fgSrtm.Row, 1)))
    
    Dim RC As New ADODB.Command
    RC.ActiveConnection = cn
    RC.CommandType = adCmdText
    RC.CommandText = strSQL
    RC.Execute
    
    LoadSortamentGrid
    
    
End Sub



Private Sub cmdStandartAdd_Click()
    
    
    
    
    
    If MsgBox("   Добавить новый стандарт:   " & vbNewLine & _
       "   - " & lstStandartType.Text & " " & txtStandartNumber.Text & "   " & vbNewLine & _
       "   - " & txtStandartName.Text & "   ", vbOKCancel, "") = vbCancel Then Exit Sub
        
        
        Dim RS As New ADODB.Recordset
        
        RS.Open "select * from Standart", cn, adOpenStatic, adLockOptimistic
        
        
        RS.AddNew
        
        RS![StandartNumber] = Trim(txtStandartNumber.Text)
        RS![StandartFullNumber] = Trim(lstStandartType.Text) & " " & Trim(txtStandartNumber.Text)
        RS![StandartName] = Trim(txtStandartName.Text)
        RS![StandartTypeID] = lngStandartTypeID
        RS![PositionDefID] = lngNotFoundPosDefID
        RS![MassCalcMethodID] = lngNotFoundMassCalcID
        RS![Using] = True
        
        RS.Update
        
        LoadStandartGrid
        
        
    End Sub

Private Sub cmdStandartDel_Click()
    
    
    If MsgBox("   Удалить стандарт из базы данных:   " & vbNewLine & _
       "   - " & fgStandart.TextMatrix(fgStandart.Row, 6) & "   " & vbNewLine & _
       "   - " & fgStandart.TextMatrix(fgStandart.Row, 8) & "   ", vbOKCancel, "") = vbCancel Then
        Exit Sub
    End If
    
    
    
    Dim strSQL As String
    
    strSQL = "delete from [Standart] where [StandartID] = " & Str(Val(fgStandart.TextMatrix(fgStandart.Row, 1)))
    
    Dim RC As New ADODB.Command
    RC.ActiveConnection = cn
    RC.CommandType = adCmdText
    RC.CommandText = strSQL
    RC.Execute
    
    LoadStandartGrid
    
End Sub

Private Sub Command1_Click()
    Dim longID As Long
    Dim strCol As String
    Dim strValue As String
    longID = Val(fgStandart.TextMatrix(fgStandart.Row, 1))
    Dim strSQL As String
    
    
    
    If longID = 0 Then Exit Sub
    
    strValue = Trim(txtStandartName.Text)
    
    strSQL = "update [Standart] set [StandartName] = '" & strValue & "'" & " where [StandartID] = " & Str(Val(longID))
    
    Dim RC As New ADODB.Command
    RC.ActiveConnection = cn
    RC.CommandType = adCmdText
    RC.CommandText = strSQL
    RC.Execute
    
    fgStandart.TextMatrix(Me.fgStandart.Row, 8) = strValue
    
    Me.Command1.Enabled = False
    
End Sub

Private Sub fgMaterial_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    
    
    Dim longID As Long
    Dim strCol As String
    Dim strValue As String
    longID = Val(fgMaterial.TextMatrix(Row, 1))
    Dim strSQL As String
    
    
    
    If longID = 0 Then Exit Sub
    
    strCol = "Using"
    If fgMaterial.TextMatrix(Row, Col) = "-1" Then strValue = "True" Else strValue = "False"
    
    strSQL = "update [Material] set [" & strCol & "] = " & strValue
    strSQL = strSQL & " where MaterialID = " & Str(longID)
    
    Dim RC As New ADODB.Command
    RC.ActiveConnection = cn
    RC.CommandType = adCmdText
    RC.CommandText = strSQL
    RC.Execute
    
    
End Sub

Private Sub fgMaterial_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    
    If Col <> 2 Then Cancel = True
    
End Sub


Private Sub fgSrtm_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    
    If Col = 3 Then Cancel = True
    
End Sub

Private Sub fgStandart_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    
    Dim longID As Long
    Dim longPosDefID As Long
    Dim longMCID As Long
    Dim RC As New ADODB.Command
    Dim RS As New ADODB.Recordset
    
    longID = Val(fgStandart.TextMatrix(Row, 1))
    
    
    
    If Col = 4 Then
        
        
        Dim strCol As String
        Dim strValue As String
        Dim strSQL As String
        
        
        
        If longID = 0 Then Exit Sub
        
        strCol = "Using"
        If fgStandart.TextMatrix(Row, Col) = "-1" Then strValue = "True" Else strValue = "False"
        
        strSQL = "update [Standart] set [" & strCol & "] = " & strValue
        strSQL = strSQL & " where StandartID = " & Val(longID)
        
        RC.ActiveConnection = cn
        RC.CommandType = adCmdText
        RC.CommandText = strSQL
        RC.Execute
        
    ElseIf Col = 5 Then
        
        If Trim(fgStandart.TextMatrix(Row, Col)) = strPos Then Exit Sub
        
        If fgStandart.ComboData() = -1 Then
            If MsgBox("   Подтвердите использование нового типа позиции:   " & vbNewLine & "   - " & fgStandart.TextMatrix(Row, Col), vbYesNo, "") = vbYes Then
                ' вносим новую позицию
                strSQL = "insert into [PositionDef] ([PositionDefName]) values ('" & Trim(fgStandart.TextMatrix(Row, Col)) & "')"
                
                RC.ActiveConnection = cn
                RC.CommandType = adCmdText
                RC.CommandText = strSQL
                RC.Execute
                
                ' получаем ее идент.
                RS.Open "select [PositionDefID] from [PositionDef] where [PositionDefName] = '" & Trim(fgStandart.TextMatrix(Row, Col)) & "'", cn, adOpenStatic, adLockReadOnly
                If RS.RecordCount = 1 Then
                    RS.MoveFirst
                    longPosDefID = RS![PositionDefID]
                Else
                    Exit Sub
                End If
                
            Else
                fgStandart.TextMatrix(Row, Col) = strPos
                Exit Sub
            End If
        Else
            longPosDefID = fgStandart.ComboData()
        End If
        
        strSQL = "update [Standart] set [PositionDefID] = " & Trim(Str(longPosDefID))
        strSQL = strSQL & " where StandartID = " & Val(longID)
        
        RC.ActiveConnection = cn
        RC.CommandType = adCmdText
        RC.CommandText = strSQL
        RC.Execute
        
    ElseIf Col = 9 Then
        
        If Trim(fgStandart.TextMatrix(Row, Col)) = strPos Then Exit Sub
        
        If fgStandart.ComboData() = -1 Then
            fgStandart.TextMatrix(Row, Col) = strPos
            Exit Sub
        Else
            longMCID = fgStandart.ComboData()
        End If
        
        strSQL = "update [Standart] set [MassCalcMethodID] = " & Trim(Str(longMCID))
        strSQL = strSQL & " where StandartID = " & Val(longID)
        
        RC.ActiveConnection = cn
        RC.CommandType = adCmdText
        RC.CommandText = strSQL
        RC.Execute
        
    End If
    
    
End Sub

Private Sub fgStandart_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    
    
    If Col <> 4 And Col <> 5 And Col <> 9 Then Cancel = True
    
    Dim strSQL As String
    Dim strCombo As String
    Dim RS0 As New ADODB.Recordset
    
    
    If Col = 5 Then
        
        strPos = Trim(fgStandart.TextMatrix(Row, Col))
        strSQL = "SELECT distinct [PositionDefID],[PositionDefName] FROM [PositionDef]"
        
        RS0.Open strSQL, cn, adOpenStatic, adLockReadOnly
        
        If RS0.RecordCount > 0 Then
            strCombo = "|"
            RS0.MoveFirst
            Do
                strCombo = strCombo & "#" & Trim(Str(RS0![PositionDefID])) & ";" & RS0![PositionDefName] & "|"
                RS0.MoveNext
            Loop Until RS0.EOF
            fgStandart.ComboList = strCombo
        Else
            fgStandart.ComboList = ""
        End If
        
        
    ElseIf Col = 9 Then
        strPos = Trim(fgStandart.TextMatrix(Row, Col))
        strSQL = "SELECT distinct [MassCalcMethodID],[MassCalcMethodName] FROM [MassCalcMethod]"
        
        RS0.Open strSQL, cn, adOpenStatic, adLockReadOnly
        
        If RS0.RecordCount > 0 Then
            strCombo = ""
            RS0.MoveFirst
            Do
                strCombo = strCombo & "#" & Trim(Str(RS0![MassCalcMethodID])) & ";" & RS0![MassCalcMethodName] & "|"
                RS0.MoveNext
            Loop Until RS0.EOF
            fgStandart.ComboList = strCombo
        Else
            fgStandart.ComboList = ""
        End If
    Else
        fgStandart.ComboList = ""
    End If
    
    
    
End Sub

Private Sub fgStandart_RowColChange()
    
    lstStandartType.Text = Me.fgStandart.TextMatrix(Me.fgStandart.Row, 2)
    txtStandartNumber.Text = Me.fgStandart.TextMatrix(Me.fgStandart.Row, 3)
    txtStandartName.Text = Me.fgStandart.TextMatrix(Me.fgStandart.Row, 8)
    
    
End Sub

Private Sub Form_Load()
    
    blnLoading = True
    
    Dim strSQL As String
    
    
    Dim RS As New ADODB.Recordset
    Dim RS1 As New ADODB.Recordset
    Dim RS2 As New ADODB.Recordset
    Dim RS3 As New ADODB.Recordset
    
    Dim intCount As Integer
    Dim I As Integer
    
    ' определяем максимальное значение ID типа стандарта
    Dim intMaxStTypeID As Long
    RS2.Open "select max(stdTypeID) as [Mx] from standartype", cn, adOpenForwardOnly, adLockReadOnly
    intMaxStTypeID = RS2.Fields("Mx").Value
    
    ' заполняем массив типов стандартов
    RS1.Open "select * from standartype", cn, adOpenStatic, adLockReadOnly
    
    ReDim arrStandartType(1 To 2, 1 To intMaxStTypeID)
    I = 0
    If Not RS1.EOF Then
        RS1.MoveFirst
        Do
            I = I + 1
            arrStandartType(1, RS1![stdTypeID]) = RS1![stdTypeName]
            Me.lstStandartType.AddItem RS1![stdTypeName]
            arrStandartType(2, RS1![stdTypeID]) = Replace((RS1![stdTypeDevision] & ""), "_", " ")
            RS1.MoveNext
        Loop Until RS1.EOF
    End If
    
    
    '---------------------------------------
    strSQL = "select * from [standard] where [stdUsing] = 1"
    RS.Open strSQL, cn, adOpenForwardOnly, adLockReadOnly
    
    ReDim arrStandart(1 To 3, 1 To intCount)
    
    I = 0
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            I = I + 1
            arrStandart(1, I) = RS![stdID]
            arrStandart(2, I) = RS![stdName]
            arrStandart(3, I) = arrStandartType(1, RS![stdTypeID]) & arrStandartType(2, RS![stdTypeID]) & RS![stdNumber]
            cmbStandartName(0).AddItem arrStandart(2, I)
            cmbStandartNumber(0).AddItem arrStandart(3, I)
            cmbMatStandart.AddItem arrStandart(3, I)
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    cmbStandartName(0).AddItem "все"
    cmbStandartNumber(0).AddItem "все"
    '---------------------------------------
    
    
    strSQL = "select * from Standart where StandartID in (select distinct StandartID from Material)"
    RS3.Open strSQL, cn, adOpenStatic, adLockReadOnly
    intCount = RS3.RecordCount
    
    ReDim arrMaterialStandart(1 To 3, 1 To intCount)
    
    I = 0
    If intCount > 0 Then
        Do
            I = I + 1
            arrMaterialStandart(1, I) = RS3![stdID]
            arrMaterialStandart(2, I) = RS3![stdName]
            arrMaterialStandart(3, I) = arrStandartType(1, RS3![stdTypeID]) & arrStandartType(2, RS3![stdTypeID]) & RS3![stdNumber]
            cmbStandartName(1).AddItem arrMaterialStandart(2, I)
            cmbStandartNumber(1).AddItem arrMaterialStandart(3, I)
            RS3.MoveNext
        Loop Until RS3.EOF
    End If
    
    cmbStandartName(1).AddItem "все"
    cmbStandartNumber(1).AddItem "все"
    
    
    
    
    On Error Resume Next
    
    cmbStandartName(0).Text = GetSetting("OmkBase", "Sortament", "cmbStandartName", "все")
    cmbStandartNumber(0).Text = GetSetting("OmkBase", "Sortament", "cmbStandartNumber", "все")
    cmbStandartName(1).Text = GetSetting("OmkBase", "Sortament", "cmbStandartName1", "все")
    cmbStandartNumber(1).Text = GetSetting("OmkBase", "Sortament", "cmbStandartNumber1", "все")
    chkShowUnused(0).Value = GetSetting("OmkBase", "Sortament", "chkShowUnused", 0)
    chkShowUnused(1).Value = GetSetting("OmkBase", "Sortament", "chkShowUnused1", 0)
    chkShowUnused(2).Value = GetSetting("OmkBase", "Sortament", "chkShowUnused2", 0)
    
    
    tabSteel.Tab = GetSetting("OmkBase", "Sortament", "tabSteelTab", 0)
    
    
    LoadSortamentGrid
    LoadMaterialGrid
    LoadStandartGrid
    
    blnLoading = False
    
    
    
    
End Sub

Private Sub LoadMaterialGrid()
    
    Dim RS As New ADODB.Recordset
    Dim strSQL As String
    
    If chkShowUnused(1).Value = 1 Then
        strSQL = "select [MaterialID] as [ID], [Using] as [Исп], [MaterialName] as [Наименование] from Material"
        If cmbStandartNumber(1).Text <> "все" Then
            strSQL = strSQL & " where [stdID] = " & arrMaterialStandart(1, cmbStandartNumber(1).ListIndex + 1)
            'Me.cmdSrtmAdd.Enabled = True
        Else
            'Me.cmdSrtmAdd.Enabled = False
        End If
    Else
        strSQL = "select [MaterialID] as [ID], [Using] as [Исп], [MaterialName] as [Наименование] from Material where [Using] = true"
        If cmbStandartNumber(1).Text <> "все" Then
            strSQL = strSQL & " and [stdID] = " & arrMaterialStandart(1, cmbStandartNumber(1).ListIndex + 1)
            'Me.cmdSrtmAdd.Enabled = True
        Else
            'Me.cmdSrtmAdd.Enabled = False
        End If
    End If
    
    
    RS.Open strSQL, cn, adOpenStatic, adLockReadOnly
    
    
    Set fgMaterial.DataSource = RS
    
    fgMaterial.ColWidth(1) = 0
    
    
End Sub


Private Sub LoadSortamentGrid()
    
    Dim RS As New ADODB.Recordset
    Dim strSQL As String
    
    If chkShowUnused(0).Value = 1 Then
        strSQL = "select [Sortament].[SrtmID] as [ID], [Sortament].[Using] as [Исп], [PositionDef].[PositionDefName] as [Позиция], [Sortament].[SrtmName] as [Наименование], " & _
               "[Sortament].[SrtmDiameter] as [Диаметр],[Sortament].[SrtmLength] as [Длина],[Sortament].[SrtmHeight] as [Высота],[Sortament].[SrtmWidth] as [Ширина]," & _
               "[Sortament].[SrtmMass] as [Масса] from [Sortament], [Standart], [PositionDef] " & _
               "where [Sortament].[stdID] = [Standart].[stdID] and [Standart].[PositionDefID] = [PositionDef].[PositionDefID]"
        If cmbStandartNumber(0).Text <> "все" Then
            strSQL = strSQL & " and [Standart].[StandartID] = " & arrStandart(1, cmbStandartNumber(0).ListIndex + 1)
        End If
    Else
        strSQL = "select [Sortament].[SrtmID] as [ID], [Sortament].[Using] as [Исп], [PositionDef].[PositionDefName] as [Позиция], [Sortament].[SrtmName] as [Наименование], " & _
               "[Sortament].[SrtmDiameter] as [Диаметр],[Sortament].[SrtmLength] as [Длина],[Sortament].[SrtmHeight] as [Высота],[Sortament].[SrtmWidth] as [Ширина]," & _
               "[Sortament].[SrtmMass] as [Масса] from [Sortament], [Standart], [PositionDef] " & _
               "where [Sortament].[stdID] = [Standart].[stdID] and [Standart].[PositionDefID] = [PositionDef].[PositionDefID] and [Sortament].[Using] = true"
        If cmbStandartNumber(0).Text <> "все" Then
            strSQL = strSQL & " and [Standart].[stdID] = " & arrStandart(1, cmbStandartNumber(0).ListIndex + 1)
        End If
    End If
    
    
    RS.Open strSQL, cn, adOpenStatic, adLockReadOnly
    
    
    Set fgSrtm.DataSource = RS
    
    fgSrtm.ColFormat(fgSrtm.Cols - 1) = "0.00"
    
    fgSrtm.ColWidth(1) = 0
    
    txtSrtmName_Change
    
End Sub

Private Sub LoadStandartGrid()
    
    
    Dim RS As New ADODB.Recordset
    Dim RS0 As New ADODB.Recordset
    Dim RS1 As New ADODB.Recordset
    Dim strSQL As String
    
    
    strSQL = "select [Standart].[StandartID] as [ID], [StandartType].[StandartTypeName] as [SID], [Standart].[StandartNumber] as [SN], " & _
           "[Standart].[Using] as [Исп], [PositionDef].[PositionDefName] as [Позиция], [Standart].[StandartFullNumber] as [Номер], [PositionDef].[PositionDefID] as [PDID], " & _
           "[Standart].[StandartName], [MassCalcMethod].[MassCalcMethodName] as [Расчет массы] from [Standart], [StandartType], [PositionDef], [MassCalcMethod] " & _
           "where [Standart].[StandartTypeID] = [StandartType].[StandartTypeID] " & _
           "and [Standart].[PositionDefID] = [PositionDef].[PositionDefID] " & _
           "and [Standart].[MassCalcMethodID] = [MassCalcMethod].[MassCalcMethodID]"
    
    If chkShowUnused(2).Value = 0 Then
        strSQL = strSQL & " and [Using] = true"
    End If
    
    
    
    RS.Open strSQL, cn, adOpenStatic, adLockReadOnly
    
    Set fgStandart.DataSource = RS
    
    fgStandart.ColWidth(1) = 0
    fgStandart.ColWidth(2) = 0
    fgStandart.ColWidth(3) = 0
    fgStandart.ColWidth(5) = fgStandart.ColWidth(5) + 300
    fgStandart.ColWidth(6) = fgStandart.ColWidth(5) + 500
    fgStandart.ColWidth(7) = 0
    fgStandart.ColWidth(8) = 0
    
    strSQL = "select [PositionDefID] from [PositionDef] where [PositionDefName] = 'не определено'"
    RS0.Open strSQL, cn, adOpenStatic, adLockReadOnly
    If RS0.RecordCount > 0 Then
        lngNotFoundPosDefID = RS0![PositionDefID]
    Else
        lngNotFoundPosDefID = 9
    End If
    
    strSQL = "select [MassCalcMethodID] from [MassCalcMethod] where [MassCalcMethodName] = 'не определено'"
    RS1.Open strSQL, cn, adOpenStatic, adLockReadOnly
    If RS1.RecordCount > 0 Then
        lngNotFoundMassCalcID = RS1![MassCalcMethodID]
    Else
        lngNotFoundMassCalcID = 5
    End If
    
    
    
    
    fgStandart_RowColChange
    
    
    
    
End Sub


Private Sub fgSrtm_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    
    Dim longSrtmID As Long
    Dim strCol As String
    Dim strValue As String
    Dim dblValue As Double
    longSrtmID = Val(fgSrtm.TextMatrix(Row, 1))
    Dim strSQL As String
    Dim blnDouble As Boolean
    
    
    
    If longSrtmID = 0 Then Exit Sub
    
    If fgSrtm.TextMatrix(0, Col) = "Исп" Then
        strCol = "Using"
        If fgSrtm.TextMatrix(Row, Col) = "-1" Then strValue = "True" Else strValue = "False"
        blnDouble = False
    ElseIf fgSrtm.TextMatrix(0, Col) = "Наименование" Then
        strCol = "SrtmName"
        strValue = "'" & fgSrtm.TextMatrix(Row, Col) & "'"
        blnDouble = False
    ElseIf fgSrtm.TextMatrix(0, Col) = "Диаметр" Then
        strCol = "SrtmDiameter"
        dblValue = GetDblValue(fgSrtm.TextMatrix(Row, Col))
        blnDouble = True
    ElseIf fgSrtm.TextMatrix(0, Col) = "Длина" Then
        strCol = "SrtmLength"
        dblValue = GetDblValue(fgSrtm.TextMatrix(Row, Col))
        blnDouble = True
    ElseIf fgSrtm.TextMatrix(0, Col) = "Высота" Then
        strCol = "SrtmHeight"
        dblValue = GetDblValue(fgSrtm.TextMatrix(Row, Col))
        blnDouble = True
    ElseIf fgSrtm.TextMatrix(0, Col) = "Ширина" Then
        strCol = "SrtmWidth"
        dblValue = GetDblValue(fgSrtm.TextMatrix(Row, Col))
        blnDouble = True
    ElseIf fgSrtm.TextMatrix(0, Col) = "Масса" Then
        strCol = "SrtmMass"
        dblValue = GetDblValue(fgSrtm.TextMatrix(Row, Col))
        blnDouble = True
    End If
    
    If blnDouble Then
        Dim asd As Double
        Dim sdf As Double
        asd = Int(dblValue)
        sdf = dblValue - asd
        sdf = sdf * 1000
        strValue = Trim(Format(asd, "0") & "." & Format(sdf, "0"))
        fgSrtm.TextMatrix(Row, Col) = dblValue
    End If
    
    
    
    
    strSQL = "update [Sortament] set [" & strCol & "] = " & strValue
    
    
    strSQL = strSQL & " where SrtmID = " & Val(longSrtmID)
    
    Dim RC As New ADODB.Command
    RC.ActiveConnection = cn
    RC.CommandType = adCmdText
    RC.CommandText = strSQL
    RC.Execute
    
    
    
End Sub


Private Sub Form_Unload(Cancel As Integer)
    
    
    
    SaveSetting "OmkBase", "Sortament", "cmbStandartName", cmbStandartName(0).Text
    SaveSetting "OmkBase", "Sortament", "cmbStandartNumber", cmbStandartNumber(0).Text
    SaveSetting "OmkBase", "Sortament", "cmbStandartName1", cmbStandartName(1).Text
    SaveSetting "OmkBase", "Sortament", "cmbStandartNumber1", cmbStandartNumber(1).Text
    SaveSetting "OmkBase", "Sortament", "chkShowUnused", chkShowUnused(0).Value
    SaveSetting "OmkBase", "Sortament", "chkShowUnused1", chkShowUnused(1).Value
    SaveSetting "OmkBase", "Sortament", "chkShowUnused2", chkShowUnused(2).Value
    
    SaveSetting "OmkBase", "Sortament", "tabSteelTab", tabSteel.Tab
    
End Sub

Private Sub lstStandartType_Click()
    CheckStandart
End Sub

Private Sub lstStandartType_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    
    If Button = 2 Then
        Me.PopupMenu Me.mnuStandTypeMain, , lstStandartType.Left + X, lstStandartType.Top + Y
    End If
    
End Sub

Private Sub mnuStandTypeAdd_Click()
    
    Dim strStandType As String
    strStandType = Trim(InputBox("Введите новый тип стандарта" & vbNewLine & "например - ГОСТ" & vbNewLine & "кавычек и прочих вспомогательных символов" & vbNewLine & "вводить не нужно", "Новый тип стандарта", ""))
    
    
    If strStandType = "" Then Exit Sub
    
    If MsgBox("   Добавить новый тип стандарта:   " & vbNewLine & _
       "   - " & strStandType, vbOKCancel, "") = vbCancel Then Exit Sub
        
        
        Dim RS As New ADODB.Recordset
        
        RS.Open "select * from StandartType", cn, adOpenStatic, adLockOptimistic
        
        
        RS.AddNew
        
        RS![stdTypeName] = strStandType
        RS![stdTypePosition] = 0
        RS![stdTypeDevision] = "_"
        RS![stdTypeFromLeft] = True
        
        RS.Update
        
        lstStandartType.AddItem strStandType
        
        '
    End Sub

Private Sub mnuStandTypeDel_Click()
    
    If MsgBox("   Удалить тип стандарта:                        " & vbNewLine & "   - " & Trim(lstStandartType.Text) & vbNewLine & "   Будьте внимательны! Удаление используемого типа стандарта" & vbNewLine & "   может привести к потере данных!", vbOKCancel, "") = vbCancel Then Exit Sub
    
    Dim strSQL As String
    
    strSQL = "delete from [stdType] where [stdTypeID] = " & Str(lngStandartTypeID)
    
    Dim RC As New ADODB.Command
    RC.ActiveConnection = cn
    RC.CommandType = adCmdText
    RC.CommandText = strSQL
    RC.Execute
    
    lstStandartType.RemoveItem lstStandartType.ListIndex
    
    If lstStandartType.ListCount > 0 Then lstStandartType.ListIndex = 0
    
    
    
End Sub

Private Sub txtMatName_Change()
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from Material where MaterialName = '" & Trim(txtMatName.Text) & "'", cn, adOpenStatic, adLockReadOnly
    
    If RS.RecordCount > 0 Or cmbStandartNumber(1).Text = "все" Or Trim(txtMatName.Text) = "" Then
        Me.cmdMatAdd.Enabled = False
    Else
        Me.cmdMatAdd.Enabled = True
    End If
    
End Sub

Private Sub txtSrtmName_Change()
    
    Dim RS As New ADODB.Recordset
    Dim strSQL As String
    
    strSQL = "select * from Sortament where SrtmName = '" & Trim(txtSrtmName.Text) & "'"
    
    If cmbStandartNumber(0).Text <> "все" Then
        strSQL = strSQL & " and [Sortament].[stdID] = " & arrStandart(1, cmbStandartNumber(0).ListIndex + 1)
    End If
    
    
    RS.Open strSQL, cn, adOpenStatic, adLockReadOnly
    
    If RS.RecordCount > 0 Or cmbStandartNumber(0).Text = "все" Or Trim(txtSrtmName.Text) = "" Then
        Me.cmdSrtmAdd.Enabled = False
    Else
        Me.cmdSrtmAdd.Enabled = True
    End If
    
End Sub

Private Sub txtStandartName_Change()
    
    
    Dim longID As Long
    longID = Val(fgStandart.TextMatrix(fgStandart.Row, 1))
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from [Standart] where [stdName] = '" & Trim(txtStandartName.Text) & "' and [stdID] = " & Str(longID), cn, adOpenStatic, adLockReadOnly
    
    If RS.RecordCount > 0 Then
        Me.Command1.Enabled = False
    Else
        Me.Command1.Enabled = True
    End If
    
    
    
End Sub

Private Sub txtStandartNumber_Change()
    CheckStandart
End Sub

Private Sub CheckStandart()
    
    Dim RS As New ADODB.Recordset
    Dim RS0 As New ADODB.Recordset
    Dim strSQL As String
    
    strSQL = "select [stdType].[stdTypeName], [Standart].[StandartNumber], [Standart].[StandartTypeID] as [STID] from [Standart],[StandartType] " & _
           "where [Standart].[StandartTypeID] = [StandartType].[StandartTypeID]" & _
           " and [StandartType].[StandartTypeName] = '" & lstStandartType.Text & "'" & _
           " and [Standart].[StandartNumber] = '" & txtStandartNumber.Text & "'"
    
    
    RS.Open strSQL, cn, adOpenStatic, adLockReadOnly
    If RS.RecordCount > 0 Then
        cmdStandartAdd.Enabled = False
    Else
        cmdStandartAdd.Enabled = True
    End If
    
    strSQL = "select [stdTypeID] from [stdType] where [StandartTypeName] = '" & lstStandartType.Text & "'"
    
    RS0.Open strSQL, cn, adOpenStatic, adLockReadOnly
    If RS0.RecordCount > 0 Then
        lngStandartTypeID = RS0![StandartTypeID]
    End If
    
End Sub

