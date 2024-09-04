VERSION 5.00
Object = "{0AFE7BE0-11B7-4A3E-978D-D4501E9A57FE}#1.0#0"; "C1Sizer.ocx"
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Begin VB.Form frmSearch 
   Caption         =   "Поиск изделий"
   ClientHeight    =   7620
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12270
   Icon            =   "frmSearch.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7620
   ScaleWidth      =   12270
   StartUpPosition =   1  'CenterOwner
   Begin VB.PictureBox Picture1 
      Align           =   1  'Align Top
      BorderStyle     =   0  'None
      Height          =   1155
      Left            =   0
      ScaleHeight     =   1155
      ScaleWidth      =   12270
      TabIndex        =   2
      Top             =   0
      Width           =   12270
      Begin VB.CommandButton btnFindKKS 
         Caption         =   "Найти по KKS"
         Height          =   375
         Left            =   9360
         TabIndex        =   10
         Top             =   480
         Width           =   1935
      End
      Begin VSFlex8Ctl.VSFlexGrid fgFindKKS 
         Height          =   375
         Left            =   7440
         TabIndex        =   9
         Top             =   120
         Width           =   4095
         _cx             =   110894135
         _cy             =   110887573
         Appearance      =   2
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
         Rows            =   1
         Cols            =   4
         FixedRows       =   0
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
      Begin VB.CheckBox chkRgt 
         Caption         =   "возможны символы справа"
         Height          =   255
         Left            =   1440
         TabIndex        =   6
         Top             =   720
         Width           =   2775
      End
      Begin VB.CommandButton btnSearch 
         Caption         =   "Найти по имени"
         Height          =   375
         Left            =   4440
         TabIndex        =   4
         Top             =   480
         Width           =   1815
      End
      Begin VB.TextBox txtWhat 
         Height          =   285
         Left            =   2760
         TabIndex        =   3
         Top             =   120
         Width           =   3495
      End
      Begin VB.CheckBox chkLft 
         Caption         =   "возможны символы слева"
         Height          =   255
         Left            =   1440
         TabIndex        =   5
         Top             =   480
         Width           =   2775
      End
      Begin VB.Label Label2 
         Caption         =   "Найдено:"
         Height          =   255
         Left            =   120
         TabIndex        =   8
         Top             =   840
         Width           =   3135
      End
      Begin VB.Label Label1 
         Alignment       =   1  'Right Justify
         Caption         =   "Наименование изделия:"
         Height          =   255
         Left            =   240
         TabIndex        =   7
         Top             =   120
         Width           =   2415
      End
   End
   Begin C1SizerLibCtl.C1Elastic C1Elastic1 
      Height          =   6465
      Left            =   0
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   1155
      Width           =   12270
      _cx             =   21643
      _cy             =   11404
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
         Height          =   6285
         Left            =   90
         Negotiate       =   -1  'True
         TabIndex        =   1
         Top             =   90
         Width           =   12090
         _cx             =   110908237
         _cy             =   110897998
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
         FocusRect       =   0
         HighLight       =   1
         AllowSelection  =   0   'False
         AllowBigSelection=   0   'False
         AllowUserResizing=   0
         SelectionMode   =   1
         GridLines       =   1
         GridLinesFixed  =   2
         GridLineWidth   =   1
         Rows            =   1
         Cols            =   4
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
Attribute VB_Name = "frmSearch"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'/******************************************************************************
Private Sub btnFindKKS_Click()
'/******************************************************************************

    On Error GoTo btnFindKKS_Click_ERR
    
    Dim iBlock As Integer
    Dim strSys As String
    Dim strDiv As String
    Dim iNum As Integer
    
    iBlock = Val(Me.fgFindKKS.TextMatrix(0, 0))
    strSys = UCase(Trim(Me.fgFindKKS.TextMatrix(0, 1)))
    strDiv = UCase(Trim(Me.fgFindKKS.TextMatrix(0, 2)))
    iNum = Val(Me.fgFindKKS.TextMatrix(0, 3))
    
    Dim strSQL As String
    Dim strCnd As String
    
    strSQL = "select distinct partID, partName, catID from view_r_part_kks"
    strCnd = "where"
    
    If iBlock > 0 Then strSQL = strSQL & " " & strCnd & " blockNumber = " & iBlock: strCnd = "and"
    If Len(strSys) > 0 Then strSQL = strSQL & " " & strCnd & " kksSys = '" & strSys & "'": strCnd = "and"
    If Len(strDiv) > 0 Then strSQL = strSQL & " " & strCnd & " kksDiv = '" & strDiv & "'": strCnd = "and"
    If iNum > 0 Then strSQL = strSQL & " " & strCnd & " kksNum = " & iNum: strCnd = "and"
    strSQL = strSQL & " " & strCnd & " deleted = 0"
    
    geSearch strSQL



Exit Sub

btnFindKKS_Click_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "btnFindKKS_Click - Error"

End Sub


'/******************************************************************************
Public Sub geSearch(strSQL As String)
'/******************************************************************************

    On Error GoTo geSearch_ERR

    Me.FG.Rows = 1
    
    Dim catID As Long
    Dim nd As Node

    Dim RS As New ADODB.Recordset
    Dim cnt As Long
    cnt = 0

    RS.Open strSQL, cn_data, adOpenForwardOnly, adLockReadOnly
    
    FG.TextMatrix(0, 0) = "catID"
    FG.TextMatrix(0, 1) = "partID"
    
    If Not RS.EOF Then
        
        RS.MoveFirst
        Do
            
            catID = RS.Fields("catID").Value
            
            Set nd = tvGetTreeNode(F1.tvCats, "catalog" & catID)
            
            If Not nd Is Nothing Then
                
                FG.AddItem RS.Fields("catID").Value & vbTab & RS.Fields("partID").Value & vbTab & RS.Fields("partName").Value & vbTab & nd.FullPath
                cnt = cnt + 1
                
            End If
            
            RS.MoveNext
        Loop Until RS.EOF
        
    End If
    
    RS.Close
    Set RS = Nothing
    
    FG.AutoSize 0, FG.cols - 1
    
    If Not usrCurrent.trusted Then FG.ColHidden(0) = True
    If Not usrCurrent.trusted Then FG.ColHidden(1) = True
    
    Label2.Caption = "Найдено: " & cnt
    
    If FG.Rows > 1 Then
        
        FG.Select 1, 3
        
        FG.sort = flexSortGenericAscending
        
    End If



Exit Sub

geSearch_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "geSearch - Error"

End Sub

'/******************************************************************************
Private Sub btnSearch_Click()
'/******************************************************************************
    
    On Error GoTo btnSearch_Click_ERR
    
    Dim strPN As String
    
    strPN = correctPartName(Trim(txtWhat.text))
    
    If chkLft.Value = 1 Then strPN = "%" & strPN
    If chkRgt.Value = 1 Then strPN = strPN & "%"
    
    
    Dim strSQL As String
    strSQL = "select partID, partName, catID from part where partName like '" & strPN & "' and deleted = 0"
'    If Not usrCurrent.trusted Then strSQL = strSQL & " order by catID"
    
    geSearch strSQL
    
    Exit Sub
    
btnSearch_Click_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "btnSearch_Click - Error"
    
End Sub

'/******************************************************************************
Private Sub FG_DblClick()
'/******************************************************************************

    On Error GoTo FG_DblClick_ERR

    Dim nd As Node

    If FG.MouseRow > 0 And FG.MouseCol = 3 Then
        Set nd = tvGetTreeNode(F1.tvCats, "catalog" & Val(FG.TextMatrix(FG.Row, 0)))
        If Not nd Is Nothing Then
            nd.EnsureVisible
            nd.Selected = True
        End If
    ElseIf FG.MouseRow > 0 And FG.MouseCol = 2 Then
        Dim ctID As Long
        Dim ptID As Long
        ctID = Val(Val(FG.TextMatrix(FG.Row, 0)))
        ptID = Val(Val(FG.TextMatrix(FG.Row, 1)))
        F1.loadCatalog ctID, False, ptID, True, False, ctEmb
    ElseIf FG.MouseRow = 0 Then
        FG.Select 0, FG.Col
        FG.sort = flexSortGenericAscending
    End If



Exit Sub

FG_DblClick_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "FG_DblClick - Error"

End Sub

'/******************************************************************************
Private Sub fgFindKKS_AfterEdit(ByVal Row As Long, ByVal Col As Long)
'/******************************************************************************

    On Error GoTo fgFindKKS_AfterEdit_ERR

    If Col = 0 Then Me.fgFindKKS.TextMatrix(Row, Col) = Val(Me.fgFindKKS.TextMatrix(Row, Col))
    If Col = 1 Then Me.fgFindKKS.TextMatrix(Row, Col) = Trim(UCase(Me.fgFindKKS.TextMatrix(Row, Col)))
    If Col = 2 Then Me.fgFindKKS.TextMatrix(Row, Col) = Trim(UCase(Me.fgFindKKS.TextMatrix(Row, Col)))
    If Col = 3 Then Me.fgFindKKS.TextMatrix(Row, Col) = Val(Me.fgFindKKS.TextMatrix(Row, Col))


    

Exit Sub

fgFindKKS_AfterEdit_ERR:

End Sub

'/******************************************************************************
Private Sub fgFindKKS_KeyDown(KeyCode As Integer, Shift As Integer)
'/******************************************************************************

    On Error GoTo fgFindKKS_KeyDown_ERR

    If KeyCode = 46 Then
        Me.fgFindKKS.TextMatrix(0, fgFindKKS.Col) = ""
    End If

Exit Sub

fgFindKKS_KeyDown_ERR:

End Sub

Private Sub Form_Load()

    fgFindKKS.ColWidth(0) = 300
    fgFindKKS.ColWidth(1) = 1000
    fgFindKKS.ColWidth(2) = 500
    fgFindKKS.ColWidth(3) = 700

End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked

End Sub

