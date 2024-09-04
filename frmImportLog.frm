VERSION 5.00
Object = "{0AFE7BE0-11B7-4A3E-978D-D4501E9A57FE}#1.0#0"; "c1sizer.ocx"
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Begin VB.Form FLog 
   Caption         =   "Import"
   ClientHeight    =   5355
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   11400
   Icon            =   "frmImportLog.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5355
   ScaleWidth      =   11400
   StartUpPosition =   1  'CenterOwner
   Begin C1SizerLibCtl.C1Elastic C1Elastic1 
      Height          =   5355
      Left            =   0
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   0
      Width           =   11400
      _cx             =   20108
      _cy             =   9446
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
      FrameStyle      =   2
      FrameWidth      =   2
      FrameColor      =   -2147483628
      FrameShadow     =   -2147483632
      FloodStyle      =   1
      _GridInfo       =   ""
      AccessibleName  =   ""
      AccessibleDescription=   ""
      AccessibleValue =   ""
      AccessibleRole  =   9
      Begin VSFlex8Ctl.VSFlexGrid fgLog 
         Height          =   5175
         Left            =   90
         TabIndex        =   1
         Top             =   90
         Width           =   11220
         _cx             =   19791
         _cy             =   9128
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
         BackColorAlternate=   14737632
         GridColor       =   -2147483643
         GridColorFixed  =   -2147483632
         TreeColor       =   -2147483632
         FloodColor      =   192
         SheetBorder     =   -2147483642
         FocusRect       =   0
         HighLight       =   0
         AllowSelection  =   0   'False
         AllowBigSelection=   0   'False
         AllowUserResizing=   1
         SelectionMode   =   0
         GridLines       =   0
         GridLinesFixed  =   0
         GridLineWidth   =   0
         Rows            =   1
         Cols            =   3
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
         AutoSizeMode    =   1
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
         WordWrap        =   -1  'True
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
   Begin VB.Menu mnuImportSave 
      Caption         =   "Сохранить (отмены операции нет)"
   End
   Begin VB.Menu mnuImportDist 
      Caption         =   "Расстояние между строками"
   End
   Begin VB.Menu mnuImportRefresh 
      Caption         =   "Обновить таблицу"
   End
End
Attribute VB_Name = "FLog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public fn As Integer
Public cErr As Collection

'/******************************************************************************
Public Sub addLog(s1 As Variant, s2 As Variant, s3 As String, bErr As Boolean, Optional bAddLog As Boolean = False)
'/******************************************************************************
    
    On Error GoTo addLog_ERR
    
    Dim s As String
    
    s = s1 & vbTab & s2 & vbTab & s3
    
'    fgLog.AddItem s
    
    If bErr Then
'        fgLog.Cell(flexcpBackColor, fgLog.Rows - 1, 0, fgLog.Rows - 1, fgLog.Cols - 1) = lngLightRed
        If bAddLog Then addErr s3, s3
    End If
    
    
    Exit Sub
    
addLog_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "addLog - Error"
    
End Sub


Private Sub fgLog_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)

    On Error GoTo err

    Me.fgLog.ComboList = ""
    
    If Row = 1 And Col > 3 And Col < 8 Then
    
        Me.fgLog.ComboList = "#0;" & "+" & "|#1;" & "-"
    ElseIf Row = 1 Or (Col > 0 And Col <= 3) Then
        Cancel = True
    Else
        Dim ID As Long
        ID = fgLog.RowData(Row)
        If ID = 0 Then Cancel = True
    End If
    
err:

End Sub

'/******************************************************************************
Private Sub Form_Load()
'/******************************************************************************

    On Error GoTo Form_Load_ERR

    
    Set cErr = New Collection
    
    
    
    
Exit Sub

Form_Load_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "Form_Load - Error"

End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked
End Sub

Private Sub Form_Unload(Cancel As Integer)

    On Error Resume Next
    
    Set cErr = Nothing
    
    Dim str As String
    Dim i As Long
    
    str = ""
    For i = 0 To fgLog.cols - 1
        If i = 0 Then
            str = fgLog.TextMatrix(1, i)
        Else
            str = str & vbTab & fgLog.TextMatrix(1, i)
        End If
    Next
    
    SaveSetting "Offtake2", "SpecDgnImport", "formatstring", str
    



End Sub

'/******************************************************************************
Private Sub addErr(s As String, k As String)
'/******************************************************************************

    On Error GoTo addErr_ERR

    cErr.Add s, k



Exit Sub

addErr_ERR:


End Sub


'/******************************************************************************
Public Sub printErr()
'/******************************************************************************

    On Error GoTo printErr_ERR
    
    Dim s As String
    Dim i As Integer
    
    fn = FreeFile
    Open App.Path & "\log_" & Format(Now, "YYYY.MM.DD_HH.mm.ss") & ".txt" For Output As fn
    

    Print #fn, "Импорт произведен: " & usrCurrent.strLogin
    
    For i = 1 To cErr.Count
    
    Print #fn, cErr(i)
    Next i
    
    Close fn
    
Exit Sub

printErr_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "printErr - Error"

End Sub

Private Sub mnuImportDist_Click()

    On Error GoTo err

    Dim iVal As Integer

    iVal = Val(InputBox("Расстояние между строками спецификации, от которого зависит точность их опознавания", "", iSpecImportRowHeight))

    If iVal > 0 Then
        iSpecImportRowHeight = iVal
        Call SaveSetting("Offtake2", "SpecDgnImport", "iSpecImportRowHeight", iSpecImportRowHeight)
    Else
    
    End If

err:

End Sub

Private Sub mnuImportRefresh_Click()

    On Error GoTo err
    
    F1.msImportSpec False
    
err:

End Sub

Private Sub mnuImportSave_Click()

    On Error GoTo err

    If colRein2 Is Nothing Then Exit Sub
    If colRein2.Count = 0 Then Exit Sub
    If Me.fgLog.Rows < 3 Then Exit Sub
    Dim P As clsPos
    Dim bFound As Boolean
    Dim bPosChanged As Boolean
    
    Dim i As Long
    Dim II As Long
    Dim Row As Long
    
    For i = 2 To Me.fgLog.Rows - 1
    
        If CBool(fgLog.TextMatrix(i, 0)) Then ' galka
        
            bFound = False
            bPosChanged = False
            
            For Each P In colRein2
                If CLng(fgLog.RowData(i)) = P.getPartID Then
                    bFound = True ' found, position is ready for editing
                    Exit For
                End If
            Next P
            
            Row = Val(fgLog.TextMatrix(i, fgLog.ColIndex("row")))
            
            If bFound And Row > 0 Then
                'p.... set props, save, update grid
                
                
                Dim prop As clsProp
                Dim bLap As Boolean
                Dim dDblValue As Double
                
                With F1.fgCatParts
                
                    
                    ' ==== LENGTH ====
                    
                    If fgLog.TextMatrix(1, fgLog.ColIndex("length")) = "+" Then
                    
                        dDblValue = getDbl(fgLog.TextMatrix(i, fgLog.ColIndex("length")))
                        
                        If P.pos_props.existsProperty("length") Then
                            Set prop = P.pos_props("length")
                            prop.setValue dDblValue
                            Set prop = Nothing
                            bPosChanged = True
                        End If
                        
                        If bPosChanged Then
                            .TextMatrix(Row, .ColIndex("length")) = P.getPosLength(P.bCalcLap, bLap)
                            .Cell(flexcpFontBold, Row, .ColIndex("length"), Row, .ColIndex("length")) = True
                            .Cell(flexcpFontUnderline, Row, .ColIndex("length")) = bLap
                        End If
                        
                    End If
                    
                    'armUpdateSketch Arm_2D1, curPos
                    
                    ' ==== QTY ====
                    
                    If fgLog.TextMatrix(1, fgLog.ColIndex("qty")) = "+" Then
                    
                        dDblValue = getDbl(fgLog.TextMatrix(i, fgLog.ColIndex("qty")))
                        If P.posQty <> dDblValue Then
                            P.posQty = dDblValue
                            .TextMatrix(Row, .ColIndex("qty")) = dDblValue
                            .Cell(flexcpFontBold, Row, .ColIndex("qty"), Row, .ColIndex("qty")) = True
                            bPosChanged = True
                        End If
                    
                    End If
            
                    ' ==== UMASS ====
                    
                    If fgLog.TextMatrix(1, fgLog.ColIndex("umass")) = "+" Then
                    
                        dDblValue = getDbl(fgLog.TextMatrix(i, fgLog.ColIndex("umass")))
                        If dDblValue <> P.posUMass Then
                            .Cell(flexcpBackColor, Row, .ColIndex("umass"), Row, .ColIndex("umass")) = lngGrey
                            P.bUMCalc = False
                            P.posUMass = dDblValue
                            bPosChanged = True
                            .Cell(flexcpFontBold, Row, .ColIndex("umass"), Row, .ColIndex("umass")) = True
                        End If
                    
                    End If
            
                    ' ==== CMASS ====
            
                    If fgLog.TextMatrix(1, fgLog.ColIndex("cmass")) = "+" Then
            
                        dDblValue = getDbl(fgLog.TextMatrix(i, fgLog.ColIndex("cmass")))
                        If dDblValue <> P.posCMass Then
                            .Cell(flexcpBackColor, Row, .ColIndex("cmass"), Row, .ColIndex("cmass")) = lngGrey
                            P.bCMCalc = False
                            P.posCMass = dDblValue
                            bPosChanged = True
                            .Cell(flexcpFontBold, Row, .ColIndex("cmass"), Row, .ColIndex("cmass")) = True
                        End If
                    
                    End If
            
                End With
                
                If bPosChanged Then
                    P.savePos
                    F1.fgCatPartsSetRowData Row, P, False, False
                End If
                
                
            End If
        
        Else
        End If
    
    
    Next i
    
    F1.calcReinGridSum
    

    
    Exit Sub
err:
    MsgBox err.Description
    

End Sub
