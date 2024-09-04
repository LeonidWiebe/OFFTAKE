VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Begin VB.Form frmSpecParams 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Параметры спецификации"
   ClientHeight    =   6000
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5385
   Icon            =   "frmSpecParams.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6000
   ScaleWidth      =   5385
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.CheckBox chkCommonMass 
      Caption         =   "Общая масса (дополнительная строчка)"
      Height          =   255
      Left            =   1200
      TabIndex        =   29
      Top             =   1600
      Width           =   3735
   End
   Begin VB.Frame Frame4 
      Caption         =   "Текст"
      Height          =   975
      Left            =   120
      TabIndex        =   22
      Top             =   4440
      Width           =   5175
      Begin VB.TextBox txtTextScale 
         Height          =   285
         Left            =   3720
         TabIndex        =   25
         Top             =   600
         Width           =   1335
      End
      Begin VB.TextBox txtTextWidth 
         Height          =   285
         Left            =   3720
         TabIndex        =   24
         Top             =   240
         Width           =   1335
      End
      Begin VB.TextBox txtTextHeight 
         Height          =   285
         Left            =   1320
         TabIndex        =   23
         Top             =   240
         Width           =   1335
      End
      Begin VB.Label Label7 
         Alignment       =   1  'Right Justify
         Caption         =   "Уменьшение при переносе строки"
         Height          =   255
         Left            =   240
         TabIndex        =   28
         Top             =   600
         Width           =   3375
      End
      Begin VB.Label Label6 
         Alignment       =   1  'Right Justify
         Caption         =   "Ширина"
         Height          =   255
         Left            =   2760
         TabIndex        =   27
         Top             =   240
         Width           =   855
      End
      Begin VB.Label Label5 
         Alignment       =   1  'Right Justify
         Caption         =   "Высота"
         Height          =   255
         Left            =   480
         TabIndex        =   26
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Арматура"
      Height          =   855
      Left            =   120
      TabIndex        =   19
      Top             =   3480
      Width           =   5175
      Begin VB.CheckBox chkSkipEmpty 
         Caption         =   "Пропускать отсутствующие позиции"
         Height          =   255
         Left            =   120
         TabIndex        =   21
         Top             =   480
         Width           =   4935
      End
      Begin VB.CheckBox chkSortDiam 
         Caption         =   "Группировать по материалу и диаметру"
         Height          =   195
         Left            =   120
         TabIndex        =   20
         Top             =   240
         Width           =   4335
      End
   End
   Begin VB.CheckBox chkDrawCap 
      Caption         =   "Заголовок спецификации (шапка)"
      Height          =   255
      Left            =   1200
      TabIndex        =   18
      Top             =   1350
      Width           =   3735
   End
   Begin VB.Frame Frame2 
      Caption         =   "Хвать"
      Height          =   1140
      Left            =   240
      TabIndex        =   13
      Top             =   600
      Width           =   800
      Begin VB.OptionButton optSnap 
         Caption         =   "Option1"
         Height          =   195
         Index           =   3
         Left            =   480
         TabIndex        =   17
         Top             =   720
         Width           =   255
      End
      Begin VB.OptionButton optSnap 
         Caption         =   "Option1"
         Height          =   195
         Index           =   2
         Left            =   120
         TabIndex        =   16
         Top             =   720
         Width           =   255
      End
      Begin VB.OptionButton optSnap 
         Caption         =   "Option1"
         Height          =   195
         Index           =   1
         Left            =   480
         TabIndex        =   15
         Top             =   360
         Width           =   255
      End
      Begin VB.OptionButton optSnap 
         Caption         =   "Option1"
         Height          =   195
         Index           =   0
         Left            =   120
         TabIndex        =   14
         Top             =   360
         Value           =   -1  'True
         Width           =   255
      End
   End
   Begin VB.TextBox txtFirstRows 
      Height          =   285
      Left            =   4320
      TabIndex        =   11
      Top             =   440
      Width           =   855
   End
   Begin VB.Frame Frame1 
      Caption         =   "Общие настройки"
      Height          =   1455
      Left            =   120
      TabIndex        =   7
      Top             =   1920
      Width           =   5175
      Begin VB.TextBox txtSpecScale 
         Height          =   285
         Left            =   4320
         TabIndex        =   30
         Text            =   "100"
         Top             =   240
         Width           =   615
      End
      Begin VB.ComboBox cmbSpecConfig 
         Height          =   315
         ItemData        =   "frmSpecParams.frx":000C
         Left            =   240
         List            =   "frmSpecParams.frx":000E
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   240
         Width           =   3015
      End
      Begin VSFlex8Ctl.VSFlexGrid FG 
         Height          =   495
         Left            =   120
         TabIndex        =   9
         Top             =   840
         Width           =   4935
         _cx             =   88416769
         _cy             =   88408937
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
         HighLight       =   2
         AllowSelection  =   0   'False
         AllowBigSelection=   0   'False
         AllowUserResizing=   0
         SelectionMode   =   0
         GridLines       =   1
         GridLinesFixed  =   2
         GridLineWidth   =   1
         Rows            =   2
         Cols            =   8
         FixedRows       =   1
         FixedCols       =   0
         RowHeightMin    =   0
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   0   'False
         FormatString    =   ""
         ScrollTrack     =   0   'False
         ScrollBars      =   0
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
      Begin VB.Label Label8 
         Alignment       =   1  'Right Justify
         Caption         =   "Масштаб"
         Height          =   255
         Left            =   3360
         TabIndex        =   31
         Top             =   240
         Width           =   855
      End
      Begin VB.Label Label3 
         Caption         =   "Ширина колонок:"
         Height          =   255
         Left            =   240
         TabIndex        =   10
         Top             =   600
         Width           =   2775
      End
   End
   Begin VB.CheckBox chkRows 
      Caption         =   "Высота последней секции равна остальным"
      Height          =   255
      Left            =   1200
      TabIndex        =   5
      Top             =   1100
      Width           =   3855
   End
   Begin VB.CommandButton btnCancel 
      Cancel          =   -1  'True
      Caption         =   "Отмена"
      Height          =   375
      Left            =   120
      TabIndex        =   4
      Top             =   5520
      Width           =   2055
   End
   Begin VB.CommandButton btnOk 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   2400
      TabIndex        =   3
      Top             =   5520
      Width           =   2895
   End
   Begin VB.TextBox txtLastRows 
      Height          =   285
      Left            =   4320
      TabIndex        =   2
      Top             =   760
      Width           =   855
   End
   Begin VB.TextBox txtSpecRows 
      Height          =   285
      Left            =   4320
      TabIndex        =   0
      Top             =   120
      Width           =   855
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      Caption         =   "Количество пустых строк вначале"
      Height          =   255
      Left            =   1440
      TabIndex        =   12
      Top             =   440
      Width           =   2775
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      Caption         =   "Количество последних пустых строк"
      Height          =   255
      Left            =   1440
      TabIndex        =   6
      Top             =   760
      Width           =   2775
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      Caption         =   "Максимальное количество строк каждой секции"
      Height          =   255
      Left            =   360
      TabIndex        =   1
      Top             =   120
      Width           =   3855
   End
End
Attribute VB_Name = "frmSpecParams"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public bOk As Boolean

Private Sub btnCancel_Click()

    bOk = False
    
    Unload Me

End Sub

Private Sub btnOK_Click()


    lngSpecDefaultRows = Val(Me.txtSpecRows.text)
    lngSpecLastRows = Val(Me.txtLastRows.text)
    lngSpecFirstRows = Val(Me.txtFirstRows.text)
    
    If lngSpecDefaultRows = 0 Then lngSpecDefaultRows = 100
    
    Dim ID As Long
    ID = cmbSpecConfig.ItemData(cmbSpecConfig.ListIndex)
    
'    Dim sKey As String
'    sKey = arSpecConfigKeys(cmbSpecConfig.ListIndex)
    
    dSpecCmnScale = getDbl(txtSpecScale.text)
    
    dSpecTextHeight = getDbl(txtTextHeight.text) * dSpecCmnScale
    dSpecTextWidth = getDbl(txtTextWidth.text) * dSpecCmnScale
    dSpecTextScale = getDbl(txtTextScale.text)
    
    setSpecConfig ID
    
    
    blnSpecLastRows = CBool(chkRows.Value)
    blnDrawSpecCap = CBool(chkDrawCap.Value)
    
    blnSortDiam = CBool(chkSortDiam.Value)
    blnSkipEmpty = CBool(chkSkipEmpty.Value)
    
    blnSpecCmnMass = CBool(chkCommonMass.Value)

    
    bOk = True
    
    'Call SaveSetting("Offtake2", "SpecParams", "cmbSpecConfig.ListIndex", cmbSpecConfig.ListIndex)
    Call SaveSetting("Offtake2", "SpecParams", "cmbSpecConfig.Text", cmbSpecConfig.text)
    Call SaveSetting("Offtake2", "SpecParams", "dSpecCmnScale", dSpecCmnScale)
    Call SaveSetting("Offtake2", "SpecParams", "iSpecAlign", iSpecAlign)

    
    Unload Me


End Sub

'/******************************************************************************
Public Sub goSum()
'/******************************************************************************

    On Error GoTo goSum_ERR

    Dim sum As Double
    
    Dim I As Integer
    
    For I = 0 To Me.FG.cols - 1
        sum = sum + Val(Me.FG.TextMatrix(1, I))
    Next I

'    lblSpecWidth.Caption = sum
                            
    btnOK.Enabled = True ' CBool(sum = dSpecWidth)

Exit Sub

goSum_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "goSum - Error"

End Sub


'/******************************************************************************
Private Sub cmbSpecConfig_Change()
'/******************************************************************************

    Dim ID As Long
    ID = cmbSpecConfig.ItemData(cmbSpecConfig.ListIndex)

    Dim scfg As clsSCfg

    Dim sv As clsConfigSimView
    For Each sv In Config.SimViews
        If Not sv.MS_SpecConfig Is Nothing Then
            If sv.MS_SpecConfig.spcfgID = ID Then
                Set scfg = sv.MS_SpecConfig
            End If
        End If
    Next


    If scfg Is Nothing Then
        Set scfg = scfgs(CStr(ID))
        
        Dim ar() As String
        ar = Split(scfg.spcfgColWidths, "-")
    
    
        Dim I As Integer
        
        Me.FG.cols = UBound(ar) + 1
        
        For I = 0 To UBound(ar)
            Me.FG.TextMatrix(1, I) = Val(ar(I)) * dSpecCmnScale
        Next I
        
        Me.FG.AutoSize 0, Me.FG.cols - 1
        
        
    Else
        Me.FG.cols = 0
    End If
    
    If scfg.dTextScale > 0# Then
        Me.txtTextScale.text = Round(scfg.dTextScale, 3)
    End If

    If scfg.dTextHgt > 0# Then
        Me.txtTextHeight.text = Round(scfg.dTextHgt, 3)
    End If

    If scfg.dTextWdt > 0# Then
        Me.txtTextWidth.text = Round(scfg.dTextWdt, 3)
    End If

   

    goSum


Exit Sub

cmbSpecConfig_Change_ERR:

End Sub


Private Sub cmbSpecConfig_Click()
cmbSpecConfig_Change
End Sub

'/******************************************************************************
Private Sub Form_Load()
'/******************************************************************************

    On Error GoTo Form_Load_ERR

    optSnap(iSpecAlign).Value = True

    Me.txtSpecRows.text = lngSpecDefaultRows
    Me.txtLastRows.text = lngSpecLastRows
    Me.txtFirstRows.text = lngSpecFirstRows
    
   
    If blnSpecLastRows Then chkRows.Value = 1 Else chkRows.Value = 0
    If blnDrawSpecCap Then chkDrawCap.Value = 1 Else chkDrawCap.Value = 0
    
    If blnSortDiam Then chkSortDiam.Value = 1 Else chkSortDiam.Value = 0
    If blnSkipEmpty Then chkSkipEmpty.Value = 1 Else chkSkipEmpty.Value = 0
    
    bOk = False
    
'    Me.FG.TextMatrix(0, 0) = "Поз."
'    Me.FG.TextMatrix(0, 1) = "Обозн."
'    Me.FG.TextMatrix(0, 2) = "Наим."
'    Me.FG.TextMatrix(0, 3) = "Кол."
'    Me.FG.TextMatrix(0, 4) = "Ед.м."
'    Me.FG.TextMatrix(0, 5) = "Об.м."
'    Me.FG.TextMatrix(0, 6) = "Прим."
    
    FG.cols = 8
    
    FG.ColAlignment(0) = flexAlignCenterCenter
    FG.ColAlignment(1) = flexAlignCenterCenter
    FG.ColAlignment(2) = flexAlignCenterCenter
    FG.ColAlignment(3) = flexAlignCenterCenter
    FG.ColAlignment(4) = flexAlignCenterCenter
    FG.ColAlignment(5) = flexAlignCenterCenter
    FG.ColAlignment(6) = flexAlignCenterCenter
    FG.ColAlignment(7) = flexAlignCenterCenter
    
    goSum
    
    cmbSpecConfig.Clear
    
    Dim spcfg As clsSCfg
    Dim sv As clsConfigSimView
    
    Dim curIndex As Integer
    Dim curID As Long
    
    curIndex = -1000
    
    If Not curSpecCfg Is Nothing Then curID = curSpecCfg.spcfgID
    
    For Each spcfg In scfgs
        cmbSpecConfig.AddItem spcfg.spcfgListName
        cmbSpecConfig.ItemData(cmbSpecConfig.NewIndex) = spcfg.spcfgID
'        If curID > 0 And spcfg.spcfgID = curID Then curIndex = cmbSpecConfig.NewIndex
    Next spcfg
    
    'For Each sv In Config.SimViews
    '    If Not sv.MS_SpecConfig Is Nothing Then
    '        cmbSpecConfig.AddItem sv.MS_SpecConfig.spcfgListName
    '        cmbSpecConfig.ItemData(cmbSpecConfig.NewIndex) = sv.MS_SpecConfig.spcfgID
    '        If curID > 0 And sv.MS_SpecConfig.spcfgID = curID Then curIndex = cmbSpecConfig.NewIndex
    '    End If
    'Next sv
    
    If curIndex > -1 Then
        cmbSpecConfig.ListIndex = curIndex
    Else
    
        Dim sComboText As String
        sComboText = GetSetting("Offtake2", "SpecParams", "cmbSpecConfig.Text", "")
        
        If Len(sComboText) > 0 Then
            Dim I As Integer
            For I = 0 To cmbSpecConfig.ListCount - 1
                If cmbSpecConfig.List(I) = sComboText Then
                
                    cmbSpecConfig.ListIndex = I
                    Exit For
                
                End If
            Next I
        
        Else
        End If
    
        'cmbSpecConfig.ListIndex = GetSetting("Offtake2", "SpecParams", "cmbSpecConfig.ListIndex", 0)
    End If
    
    
    txtSpecScale.text = dSpecCmnScale
    
    cmbSpecConfig_Change
    

Exit Sub

Form_Load_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "Form_Load - Error"

End Sub


Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked
End Sub

Private Sub optSnap_Click(Index As Integer)
    iSpecAlign = Index
End Sub

Private Sub txtSpecScale_LostFocus()

    Dim dSc As Double
    
    dSc = getDbl(txtSpecScale.text)
    
    If dSc <= 0 Then dSc = scfgCmn.spec_table_scale

    txtSpecScale.text = dSc

End Sub
