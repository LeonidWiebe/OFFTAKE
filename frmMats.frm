VERSION 5.00
Object = "{0AFE7BE0-11B7-4A3E-978D-D4501E9A57FE}#1.0#0"; "C1Sizer.ocx"
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Begin VB.Form frmMats 
   Caption         =   "Материалы"
   ClientHeight    =   8010
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11520
   Icon            =   "frmMats.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8010
   ScaleWidth      =   11520
   StartUpPosition =   1  'CenterOwner
   Begin C1SizerLibCtl.C1Elastic C1Elastic1 
      Height          =   7320
      Left            =   0
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   360
      Width           =   11520
      _cx             =   20320
      _cy             =   12912
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
         Height          =   7140
         Left            =   90
         TabIndex        =   2
         Top             =   90
         Width           =   11340
         _cx             =   99044898
         _cy             =   99037490
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
      Width           =   11520
      _ExtentX        =   20320
      _ExtentY        =   635
      ButtonWidth     =   2619
      ButtonHeight    =   582
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "Сохранить"
            Key             =   "Save"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Сброс/Отмена"
            Key             =   "Reload"
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "По имени"
            Key             =   "sortByName"
            Style           =   1
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   330
      Left            =   0
      TabIndex        =   3
      Top             =   7680
      Width           =   11520
      _ExtentX        =   20320
      _ExtentY        =   582
      Style           =   1
      SimpleText      =   "Чтобы изменить сортировку материалов, перетащите строчку, удерживая клавишу [Shift] или [Ctrl]"
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmMats"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mat As clsMat

Dim stdID As Long
Dim bByName As Boolean

Dim strToRem As String

'/******************************************************************************
Private Sub FG_AfterEdit(ByVal Row As Long, ByVal Col As Long)
'/******************************************************************************

    On Error GoTo FG_AfterEdit_ERR

    
    
    If Col = FG.ColIndex("stdUsing") Then

        If mat.matID = 0 Then Exit Sub
        
        If updateTableInBase(cn_srtm, "material", "matUsing", CInt(getBool(FG.TextMatrix(Row, FG.ColIndex("matUsing")))), "matID", mat.matID) Then
        Else
            MsgBox "Ошибка при сохранении"
        End If

    ElseIf Col = FG.ColIndex("stdFullNumber") Then
    
        mat.matStdID = Val(FG.ComboData(FG.ComboIndex))
        
        If FG.TextMatrix(Row, FG.ColIndex("stdFullNumber")) = "" Then Exit Sub
        
        stdID = Val(FG.ComboData(FG.ComboIndex))
        
        If stdID = 0 Then
            Set mat = New clsMat
        Else
            mat.matStdID = stdID
        End If
        mat.bChanged = True
        
        FG.TextMatrix(Row, FG.ColIndex("stdName")) = selectStringFromBase(cn_srtm, "standard", "stdName", "stdID", stdID)
    
    ElseIf Col = FG.ColIndex("armclassName") Then
    
        If strToRem = FG.TextMatrix(Row, Col) Then Exit Sub
        
        mat.armClassID = Val(FG.ComboData(FG.ComboIndex))
        
        mat.bChanged = True
    
    ElseIf Col = FG.ColIndex("matName") Then

        If strToRem = FG.TextMatrix(Row, Col) Then Exit Sub
        mat.matName = Trim(FG.TextMatrix(Row, Col))
        mat.bChanged = True

    ElseIf Col = FG.ColIndex("matMassCorrect") Then

        If strToRem = FG.TextMatrix(Row, Col) Then Exit Sub
        mat.matMassCorrect = getDbl(FG.TextMatrix(Row, Col))
        If mat.matMassCorrect <= 0# Then
            FG.TextMatrix(Row, Col) = ""
        Else
            FG.TextMatrix(Row, Col) = mat.matMassCorrect
        End If
        mat.bChanged = True

    End If
    
    Toolbar1.Buttons("Save").Enabled = mat.bChanged
    
'    FG.Cell(flexcpFontBold, Row, 0, Row, FG.Cols - 1) = mat.bChanged
    If mat.bChanged Then
        FG.Cell(flexcpForeColor, FG.Row, 0, FG.Row, FG.cols - 1) = lngRed
    Else
        FG.Cell(flexcpForeColor, FG.Row, 0, FG.Row, FG.cols - 1) = lngTextColor
    End If

    
Exit Sub

FG_AfterEdit_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "FG_AfterEdit - Error"

End Sub

'/******************************************************************************
Private Sub FG_AfterMoveRow(ByVal Row As Long, Position As Long)
'/******************************************************************************

    On Error GoTo FG_AfterMoveRow_ERR


    Dim strSQL As String
    Dim I As Long
    Dim str As String
    
    For I = 1 To FG.Rows - 1
    
       str = str & "UPDATE material SET matSortNumber = " & I * 10 & " WHERE matID = " & Val(FG.TextMatrix(I, FG.ColIndex("matID"))) & ";"
       FG.TextMatrix(I, FG.ColIndex("msn")) = I * 10
    
    Next I

    Dim iRecordsAffected As Integer

    Dim cmd As New ADODB.Command
    cmd.ActiveConnection = cn_srtm
    cmd.CommandText = str
    cmd.Execute iRecordsAffected

    If iRecordsAffected = 0 Then err.Raise 100, , "Database not updated"



'    Dim msn As Long
'    Dim matID As Long
'
'    Dim iFrom, iTo As Long
'
'    If Position > Row Then
'
'        iFrom = Row
'        iTo = Position
'
'    ElseIf Position < Row Then
'
'        iFrom = Position
'        iTo = Row
'
'    Else
'        Exit Sub
'
'    End If
'
'
'
'
'    Dim I As Long
'    For I = iFrom To iTo
'
'        matID = Val(FG.TextMatrix(I, FG.ColIndex("matID")))
'
'        If updateTableInBase(cn_srtm, "material", "matSortNumber", I * 10, "matID", matID) Then
'            FG.TextMatrix(I, FG.ColIndex("msn")) = I * 10
'        Else
'            err.Raise 100, "Offt", "Ошибка при сохранении номера сортировки в базе"
'        End If
'
'    Next I
    

Exit Sub

FG_AfterMoveRow_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "FG_AfterMoveRow - Error"

End Sub

Private Sub FG_AfterRowColChange(ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long)

    If NewRow = OldRow Then Exit Sub
    
    If BRYS = True Then Exit Sub


    Dim matID As Long

    matID = Val(FG.TextMatrix(FG.Row, FG.ColIndex("matID")))

    If matID > 0 Then

        Set mat = globMats(CStr(matID))

    Else

        Set mat = New clsMat

        If FG.Row >= 0 Then
            mat.matName = FG.TextMatrix(FG.Row, FG.ColIndex("matName"))
        End If

    End If
    



End Sub

Private Sub FG_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)


    If Not usrCurrent.trusted Then ' tmp
        Cancel = True
        Exit Sub
    End If

    If checkGroupPerm(usrCurrent.groupID, "material", operModify) = False Then
        Cancel = True
        Exit Sub
    End If



    If Col = FG.ColIndex("stdName") Then
        Cancel = True
    Else
        strToRem = FG.TextMatrix(Row, Col)
    End If



    Dim RS As New ADODB.Recordset

    If Col = FG.ColIndex("stdFullNumber") Then
        RS.Open "select * from view_standard where stdUsing = 1 order by stdFullNumber", cn_srtm, adOpenForwardOnly, adLockReadOnly
        FG.ComboList = FG.BuildComboList(RS, "stdFullNumber", "stdID")
        RS.Close
    ElseIf Col = FG.ColIndex("armclassName") Then
        RS.Open "select * from armclass", cn_srtm, adOpenForwardOnly, adLockReadOnly
        FG.ComboList = "#0;|" & FG.BuildComboList(RS, "armclassName", "armclassID")
        RS.Close
    Else
        FG.ComboList = ""
    End If

    Set RS = Nothing



End Sub


Private Sub fg_BeforeMouseDown(ByVal Button As Integer, ByVal Shift As Integer, ByVal X As Single, ByVal Y As Single, Cancel As Boolean)
    
    
    
    With FG
        
        If Shift > 0 And bByName = False Then
            
            Cancel = True
            
            Dim r%
            
            r = .MouseRow
            
            .Row = r
            
            r = .DragRow(r)
            
        End If
        
    End With
    
    
    
    
    
End Sub

Private Sub FG_BeforeRowColChange(ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long, Cancel As Boolean)
    If OldRow <> NewRow Then Cancel = mat.bChanged
End Sub

'/******************************************************************************
Private Sub reload()
'/******************************************************************************

    On Error GoTo reload_ERR

    Dim RS As New ADODB.Recordset
    
    Dim strSQL As String
    
    strSQL = "select matID, stdID, armclassID, matSortNumber as [msn]"
    strSQL = strSQL & ", matUsing as [Исп], matMassCorrect as [мас], matName as [Материал], armclassName as [Класс], stdFullNumber as [Стандарт]"
    strSQL = strSQL & ", stdName as [Наименование стандарта]"
    
    If Me.Toolbar1.Buttons("sortByName").Value = tbrUnpressed Then
        strSQL = strSQL & " from view_r_material_standard order by matSortNumber"
        bByName = False
    Else
        strSQL = strSQL & " from view_r_material_standard order by Материал,Стандарт"
        bByName = True
    End If
    
    RS.Open strSQL, cn_srtm, adOpenStatic, adLockOptimistic
    
    
    BRYS = True
    Set FG.DataSource = RS
    BRYS = False
    
    
    
    FG.ColKey(0) = "matID"
    FG.ColKey(1) = "stdID"
    FG.ColKey(2) = "armclassID"
    FG.ColKey(3) = "msn"
    FG.ColKey(4) = "matUsing"
    FG.ColKey(5) = "matMassCorrect"
    FG.ColKey(6) = "matName"
    FG.ColKey(7) = "armclassName"
    FG.ColKey(8) = "stdFullNumber"
    FG.ColKey(9) = "stdName"
    
    FG.ColHidden(FG.ColIndex("matID")) = True
    FG.ColHidden(FG.ColIndex("stdID")) = True
    FG.ColHidden(FG.ColIndex("armclassID")) = True
'    FG.ColHidden(FG.ColIndex("msn")) = True
    
    FG.ColWidth(FG.ColIndex("armclassName")) = FG.ColWidth(FG.ColIndex("armclassName")) + 300
    FG.ColWidth(FG.ColIndex("stdFullNumber")) = FG.ColWidth(FG.ColIndex("stdFullNumber")) + 300

    FG.AddItem ""
    
    FG_AfterRowColChange 1, 0, 0, 0



Exit Sub

reload_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "reload - Error"

End Sub



'/******************************************************************************
Private Sub Form_Load()
'/******************************************************************************

    On Error GoTo Form_Load_ERR


    reload


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
        
        If mat.save(bExists) Then

            If Not bExists Then
                FG.TextMatrix(FG.Row, FG.ColIndex("matID")) = mat.matID
                FG.TextMatrix(FG.Row, FG.ColIndex("stdID")) = mat.matStdID
                FG.TextMatrix(FG.Row, FG.ColIndex("armclassID")) = mat.ARM_CLASS.armClassID
                FG.TextMatrix(FG.Row, FG.ColIndex("matUsing")) = True
                FG.TextMatrix(FG.Row, FG.ColIndex("msn")) = selectLongFromBase(cn_srtm, "material", "matSortNumber", "matID", mat.matID)
                globMats.AddMat mat, CStr(mat.matID)
                FG.AddItem ""
            End If

            Me.Toolbar1.Buttons("Save").Enabled = False
            
'            FG.Cell(flexcpFontBold, FG.Row, 0, FG.Row, FG.Cols - 1) = mat.bChanged
            If mat.bChanged Then
                FG.Cell(flexcpForeColor, FG.Row, 0, FG.Row, FG.cols - 1) = lngRed
            Else
                FG.Cell(flexcpForeColor, FG.Row, 0, FG.Row, FG.cols - 1) = lngTextColor
            End If

        End If
        
    ElseIf Button.KEY = "Reload" Then
        
        Dim r, tr As Long
        r = Me.FG.Row
        tr = Me.FG.TopRow
        mat.bChanged = False
        Form_Load
        Me.FG.Row = r
        Me.FG.TopRow = tr
        Me.Toolbar1.Buttons("Save").Enabled = False
        
    ElseIf Button.KEY = "sortByName" Then
    
        reload
        
    End If
    
Exit Sub

Toolbar1_ButtonClick_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "Toolbar1_ButtonClick - Error"

End Sub
