VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Begin VB.Form frmExcelExport 
   AutoRedraw      =   -1  'True
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Настройки экспорта Excel"
   ClientHeight    =   4440
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5640
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4440
   ScaleWidth      =   5640
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton btnBrows 
      Caption         =   "..."
      Height          =   375
      Left            =   5040
      TabIndex        =   4
      Top             =   3480
      Width           =   495
   End
   Begin VB.TextBox txtFolder 
      Height          =   375
      Left            =   120
      TabIndex        =   3
      Top             =   3480
      Width           =   4815
   End
   Begin VB.CommandButton btnCancel 
      Cancel          =   -1  'True
      Caption         =   "Отмена"
      Height          =   375
      Left            =   4440
      TabIndex        =   1
      Top             =   3960
      Width           =   1095
   End
   Begin VB.CommandButton btnStart 
      Caption         =   "Старт"
      Default         =   -1  'True
      Enabled         =   0   'False
      Height          =   375
      Left            =   3240
      TabIndex        =   0
      Top             =   3960
      Width           =   1095
   End
   Begin VSFlex8Ctl.VSFlexGrid fgProps 
      Height          =   3015
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   5415
      _cx             =   1998398799
      _cy             =   1998394566
      Appearance      =   0
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
      FocusRect       =   1
      HighLight       =   1
      AllowSelection  =   -1  'True
      AllowBigSelection=   0   'False
      AllowUserResizing=   1
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   2
      Cols            =   2
      FixedRows       =   1
      FixedCols       =   1
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   1700
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
      FillStyle       =   1
      RightToLeft     =   0   'False
      PictureType     =   0
      TabBehavior     =   1
      OwnerDraw       =   0
      Editable        =   2
      ShowComboButton =   0
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
   Begin VB.Label Label1 
      Caption         =   "Каталог экспорта:"
      Height          =   200
      Left            =   120
      TabIndex        =   5
      Top             =   3240
      Width           =   2895
   End
End
Attribute VB_Name = "frmExcelExport"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private pResult As Boolean
Public bData%, bFolder%

Public ExcelApp As Object 'Excel.Application
Private fso As New FileSystemObject

'Флаг нажатия кнопок "Старт" или "Отмена"
Public Property Get Result() As Boolean
    Result = pResult
End Property

Public Sub btnBrows_Click()
    If ExcelApp Is Nothing Then Exit Sub
    
    Dim fldr: Set fldr = ExcelApp.FileDialog(4) 'msoFileDialogFolderPicker = 4 (Office Object library 12.0)
    With fldr
        .Title = "Select a Folder"
        .AllowMultiSelect = False
        .InitialFileName = txtFolder.text
        If .Show <> -1 Then
            txtFolder.text = txtFolder.text
        Else
            txtFolder.text = .SelectedItems(1)
        End If
    End With
End Sub

Private Sub btnCancel_Click()
    pResult = False
    Me.Hide
End Sub

Private Sub btnStart_Click()
    pResult = True
    Me.Hide
End Sub

Private Sub fgProps_CellChanged(ByVal Row As Long, ByVal Col As Long)
    Dim i%
    bData = 1
    With fgProps
        For i = 1 To .Rows - 1
            If Len(.TextMatrix(i, 1)) = 0 Then
                bData = 0: Exit For
            End If
        Next
    End With
    resetButtons
End Sub

Private Sub txtFolder_Change()
    If fso.FolderExists(txtFolder) Then
        txtFolder.ForeColor = vbBlack
        bFolder = 1
    Else
        txtFolder.ForeColor = vbRed
        bFolder = 0
    End If
    resetButtons
End Sub

Private Sub resetButtons()
    btnStart.Enabled = CBool(bData * bFolder)
End Sub
