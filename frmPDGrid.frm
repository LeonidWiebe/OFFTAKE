VERSION 5.00
Object = "{0AFE7BE0-11B7-4A3E-978D-D4501E9A57FE}#1.0#0"; "C1Sizer.ocx"
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Begin VB.Form frmStds 
   Caption         =   "Стандарты"
   ClientHeight    =   7035
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10755
   Icon            =   "frmPDGrid.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7035
   ScaleWidth      =   10755
   StartUpPosition =   1  'CenterOwner
   Begin C1SizerLibCtl.C1Elastic C1Elastic1 
      Height          =   6675
      Left            =   0
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   360
      Width           =   10755
      _cx             =   18971
      _cy             =   11774
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
         Height          =   6495
         Left            =   90
         TabIndex        =   2
         Top             =   90
         Width           =   10575
         _cx             =   77744349
         _cy             =   77737152
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
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   360
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10755
      _ExtentX        =   18971
      _ExtentY        =   635
      ButtonWidth     =   2170
      ButtonHeight    =   582
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Caption         =   "Добавить к типу позиции"
            Key             =   "AddToPosDef"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "Сохранить"
            Key             =   "Save"
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "frmStds"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim st As clsStd

Dim strToRem As String


Private Sub FG_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    
    
    Dim stdTypeID As Long
    
    stdTypeID = Val(FG.TextMatrix(Row, FG.ColIndex("stdTypeID")))
    
    
    
    
    
    If Col = FG.ColIndex("stdUsing") Then
    
        If st.stdID = 0 Then Exit Sub
    
        Dim RS As New ADODB.Recordset
        
        RS.Open "select stdUsing from standard where stdID = " & Val(FG.TextMatrix(Row, FG.ColIndex("stdID"))), cn_srtm, adOpenForwardOnly, adLockOptimistic
        
        If Not RS.EOF Then
            RS.MoveFirst
            RS.Fields("stdUsing").Value = CBool(FG.TextMatrix(Row, FG.ColIndex("stdUsing")))
            RS.Update
            F1.loadSrtmTree
        End If
        
        RS.Close
        Set RS = Nothing
    
    
    ElseIf Col = FG.ColIndex("stdTypeName") Then
        
        If stdTypeID = Val(FG.ComboData(FG.ComboIndex)) Then Exit Sub
        stdTypeID = Val(FG.ComboData(FG.ComboIndex))
        
        If stdTypeID = 0 Then
            Set st = New clsStd
        Else
            If st.setStdTypeID(stdTypeID) Then FG.TextMatrix(Row, FG.ColIndex("stdTypeID")) = stdTypeID
        End If
        
        
    ElseIf Col = FG.ColIndex("stdNumber") Then
    
        If strToRem = FG.TextMatrix(Row, Col) Then Exit Sub
        st.setNumber Trim(FG.TextMatrix(Row, Col)) ' bChanged = true уже там
    
    
    ElseIf Col = FG.ColIndex("stdName") Then
    
        If strToRem = FG.TextMatrix(Row, Col) Then Exit Sub
        st.stdName = Trim(FG.TextMatrix(Row, Col))
        st.bChanged = True
    
    End If
    
    Toolbar1.Buttons("Save").Enabled = st.bChanged
    Toolbar1.Buttons("AddToPosDef").Enabled = Not st.bChanged And usrCurrent.trusted
    
'    FG.Cell(flexcpFontBold, Row, 0, Row, FG.Cols - 1) = st.bChanged
    If st.bChanged Then
        FG.Cell(flexcpForeColor, FG.Row, 0, FG.Row, FG.cols - 1) = lngRed
    Else
        FG.Cell(flexcpForeColor, FG.Row, 0, FG.Row, FG.cols - 1) = lngTextColor
    End If
    
End Sub

Private Sub FG_AfterRowColChange(ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long)

    If NewRow = OldRow Then Exit Sub

    If BRYS = True Then Exit Sub

    Dim stdID As Long
    
    stdID = Val(FG.TextMatrix(FG.Row, FG.ColIndex("stdID")))
    
    If stdID > 0 Then
    
        Set st = globStds(CStr(stdID))
        
        Toolbar1.Buttons("AddToPosDef").Enabled = Not st.bChanged And usrCurrent.trusted
        
        
    Else
    
        Set st = New clsStd
        
        If Val(FG.TextMatrix(FG.Row, FG.ColIndex("stdTypeID"))) > 0 Then st.setStdTypeID Val(FG.TextMatrix(FG.Row, FG.ColIndex("stdTypeID")))
        st.setNumber FG.TextMatrix(FG.Row, 4)
        st.stdName = FG.TextMatrix(FG.Row, 5)
        
        
        
    End If
    
'    Toolbar1.Buttons("Save").Enabled = st.bChanged
    Toolbar1.Buttons("AddToPosDef").Enabled = Not st.bChanged And usrCurrent.trusted


End Sub

Private Sub FG_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)

        If checkGroupPerm(usrCurrent.groupID, "standard", operModify) = False Then
            Cancel = True
            Exit Sub
        End If

        Dim RS As New ADODB.Recordset
        
        
        If Col = FG.ColIndex("stdTypeName") Then
            RS.Open "select * from standardtype", cn_srtm, adOpenForwardOnly, adLockReadOnly
            FG.ComboList = FG.BuildComboList(RS, "stdTypeName", "stdTypeID")
            RS.Close
            strToRem = FG.TextMatrix(Row, Col)
        ElseIf Col = FG.ColIndex("spcnt") Then
            Cancel = True
        ElseIf Col = FG.ColIndex("matcnt") Then
            Cancel = True
        Else
            FG.ComboList = ""
            strToRem = FG.TextMatrix(Row, Col)
        End If
        
        Set RS = Nothing



End Sub

Private Sub FG_BeforeRowColChange(ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long, Cancel As Boolean)

    If OldRow <> NewRow Then Cancel = st.bChanged


End Sub

'/******************************************************************************
Private Sub Form_Load()
'/******************************************************************************

    On Error GoTo Form_Load_ERR


    Dim RS As New ADODB.Recordset
    
    RS.Open "select stdID, stdTypeID, stdUsing as [Исп], spcnt as [П], matcnt as [М], stdTypeName as [Тип], stdNumber as [Номер], stdName as [Наименование] from view_standard order by stdFullNumber", _
                cn_srtm, adOpenStatic, adLockOptimistic
    
    BRYS = True
    Set FG.DataSource = RS
    BRYS = False
    
    FG.ColKey(0) = "stdID"
    FG.ColKey(1) = "stdTypeID"
    FG.ColKey(2) = "stdUsing"
    FG.ColKey(3) = "spcnt"
    FG.ColKey(4) = "matcnt"
    FG.ColKey(5) = "stdTypeName"
    FG.ColKey(6) = "stdNumber"
    FG.ColKey(7) = "stdName"
    
    FG.ColHidden(FG.ColIndex("stdID")) = True
    FG.ColHidden(FG.ColIndex("stdTypeID")) = True
    
    FG.ColAlignment(FG.ColIndex("spcnt")) = flexAlignCenterCenter
    FG.ColAlignment(FG.ColIndex("matcnt")) = flexAlignCenterCenter
    

    Dim I As Integer
    For I = 1 To FG.Rows - 1
    
        If Val(FG.TextMatrix(I, FG.ColIndex("spcnt"))) = 0 And Val(FG.TextMatrix(I, FG.ColIndex("matcnt"))) = 0 Then
            FG.Cell(flexcpForeColor, I, 0, I, FG.cols - 1) = &H80000011
        End If
    
    Next I

    FG.AddItem ""
    
    FG_AfterRowColChange 1, 0, 0, 0



Exit Sub

Form_Load_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "Form_Load - Error"

End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked
End Sub

'/******************************************************************************
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
'/******************************************************************************

    On Error GoTo Toolbar1_ButtonClick_ERR

    
    Dim bExists As Boolean
    
    If Button.KEY = "Save" Then
        
        If st.save(bExists) Then
            
            If Not bExists Then
                FG.TextMatrix(FG.Row, FG.ColIndex("stdID")) = st.stdID
                FG.TextMatrix(FG.Row, FG.ColIndex("stdTypeID")) = st.stdTypeID
                FG.TextMatrix(FG.Row, FG.ColIndex("stdUsing")) = True
                globStds.AddStd st, CStr(st.stdID)
                FG.AddItem ""
            End If
            
            Me.Toolbar1.Buttons("Save").Enabled = False
            Toolbar1.Buttons("AddToPosDef").Enabled = usrCurrent.trusted
            
'            FG.Cell(flexcpFontBold, FG.Row, 0, FG.Row, FG.Cols - 1) = st.bChanged
            If st.bChanged Then
                FG.Cell(flexcpForeColor, FG.Row, 0, FG.Row, FG.cols - 1) = lngRed
            Else
                FG.Cell(flexcpForeColor, FG.Row, 0, FG.Row, FG.cols - 1) = lngTextColor
            End If
            
        End If
        
        
    ElseIf Button.KEY = "AddToPosDef" Then
    
        Dim pdID As Long
        
        pdID = Val(Me.Tag)
        
        If st.stdID = 0 Then Exit Sub
        If pdID = 0 Then Exit Sub
        
        Dim RS As New ADODB.Recordset
        
        RS.Open "select * from r_standard_posdef where stdID = " & st.stdID & " and posdefID = " & pdID, cn_srtm, adOpenForwardOnly, adLockOptimistic
        
        If RS.EOF Then
            RS.AddNew
            RS.Fields("stdID").Value = st.stdID
            RS.Fields("posdefID").Value = pdID
            RS.Update
        Else
            RS.MoveFirst
            RS.Fields("using").Value = True
            RS.Update
        End If
        
        F1.loadSrtmTree
        
        RS.Close
        Set RS = Nothing
        
        
        loadPosdefStd
    
    
    End If
    
Exit Sub

Toolbar1_ButtonClick_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "Toolbar1_ButtonClick - Error"

End Sub
