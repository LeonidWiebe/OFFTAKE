VERSION 5.00
Object = "{0AFE7BE0-11B7-4A3E-978D-D4501E9A57FE}#1.0#0"; "c1sizer.ocx"
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsFlex8.ocx"
Begin VB.Form frmBeton 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Бетон"
   ClientHeight    =   8250
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   11880
   Icon            =   "frmBeton.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8250
   ScaleWidth      =   11880
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command4 
      Caption         =   "Открыть файлы..."
      Height          =   375
      Left            =   9000
      TabIndex        =   14
      Top             =   960
      Width           =   2775
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Перезагрузить данные из каталога"
      Height          =   255
      Left            =   4560
      TabIndex        =   8
      Top             =   120
      Width           =   3735
   End
   Begin VB.OptionButton optAeco 
      Caption         =   "AECOsim"
      Height          =   255
      Left            =   2040
      TabIndex        =   7
      Top             =   120
      Value           =   -1  'True
      Width           =   1575
   End
   Begin VB.OptionButton optSpeed 
      Caption         =   "Speedikon"
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   120
      Width           =   1575
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Сохранить в каталог"
      Enabled         =   0   'False
      Height          =   255
      Left            =   8520
      TabIndex        =   1
      Top             =   120
      Width           =   3255
   End
   Begin C1SizerLibCtl.C1Tab C1Tab1 
      Height          =   7095
      Left            =   120
      TabIndex        =   0
      Top             =   1080
      Width           =   11655
      _cx             =   20558
      _cy             =   12515
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
      Caption         =   "Источник|Данные|Результат"
      Align           =   0
      CurrTab         =   0
      FirstTab        =   0
      Style           =   3
      Position        =   0
      AutoSwitch      =   -1  'True
      AutoScroll      =   -1  'True
      TabPreview      =   -1  'True
      ShowFocusRect   =   -1  'True
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
      Begin C1SizerLibCtl.C1Elastic C1Elastic1 
         Height          =   6720
         Left            =   45
         TabIndex        =   2
         TabStop         =   0   'False
         Top             =   330
         Width           =   11565
         _cx             =   20399
         _cy             =   11853
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
         Begin VB.ComboBox cmbBetStd 
            Height          =   315
            Left            =   3240
            Style           =   2  'Dropdown List
            TabIndex        =   13
            Top             =   6240
            Width           =   3015
         End
         Begin VB.CheckBox chkAutoSrtmUpdate 
            Caption         =   "автозаполнение сортамента для"
            Height          =   255
            Left            =   240
            TabIndex        =   12
            Top             =   6240
            Width           =   3375
         End
         Begin VSFlex8Ctl.VSFlexGrid fgFiles 
            Height          =   5895
            Left            =   240
            TabIndex        =   10
            Top             =   240
            Width           =   11055
            _cx             =   122178604
            _cy             =   122169502
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
            AllowUserResizing=   1
            SelectionMode   =   0
            GridLines       =   1
            GridLinesFixed  =   2
            GridLineWidth   =   1
            Rows            =   4
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
         Begin VB.CommandButton Command2 
            Caption         =   "Загрузить"
            Height          =   375
            Left            =   10080
            TabIndex        =   5
            Top             =   6240
            Width           =   1215
         End
         Begin VB.Label Label4 
            BorderStyle     =   1  'Fixed Single
            Height          =   375
            Left            =   8400
            TabIndex        =   9
            Top             =   6240
            Width           =   1575
         End
      End
      Begin VSFlex8Ctl.VSFlexGrid fgData 
         Height          =   6720
         Left            =   12300
         TabIndex        =   3
         Top             =   330
         Width           =   11565
         _cx             =   122179503
         _cy             =   122170957
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
         FocusRect       =   1
         HighLight       =   1
         AllowSelection  =   -1  'True
         AllowBigSelection=   -1  'True
         AllowUserResizing=   0
         SelectionMode   =   1
         GridLines       =   1
         GridLinesFixed  =   2
         GridLineWidth   =   1
         Rows            =   1
         Cols            =   7
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
      Begin VSFlex8Ctl.VSFlexGrid fgRes 
         Height          =   6720
         Left            =   12600
         TabIndex        =   4
         Top             =   330
         Width           =   11565
         _cx             =   122179503
         _cy             =   122170957
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
         FocusRect       =   1
         HighLight       =   1
         AllowSelection  =   -1  'True
         AllowBigSelection=   -1  'True
         AllowUserResizing=   0
         SelectionMode   =   1
         GridLines       =   1
         GridLinesFixed  =   2
         GridLineWidth   =   1
         Rows            =   1
         Cols            =   7
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
   Begin VB.Label Label2 
      Height          =   495
      Left            =   120
      TabIndex        =   11
      Top             =   480
      Width           =   11655
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "frmBeton"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'Public strFileName As String
Public catID As Long

Dim cl As New colProp
Dim cs As New colSrtm

Dim iErrs As Integer

Dim iCurBetStdPdID As Long

Public iMode As Integer


Private Sub cmbBetStd_Click()
    
    
    iCurBetStdPdID = cmbBetStd.ItemData(cmbBetStd.ListIndex)
    
    If iCurBetStdPdID > 0 Then
        chkAutoSrtmUpdate.Value = 1
        chkAutoSrtmUpdate.Enabled = True
    Else
        chkAutoSrtmUpdate.Value = 0
        chkAutoSrtmUpdate.Enabled = False
    End If
    
    
End Sub

Private Sub Command1_Click()

    loadCatPositions



End Sub

'/******************************************************************************
Private Sub Command2_Click()
'/******************************************************************************

    On Error GoTo Command2_Click_ERR
    
    
    
    If optSpeed.Value Then iMode = 1
    If optAeco.Value Then iMode = 2
    
    iErrs = 0
    
    Dim sm As clsSrtm
    
    Set cl = New colProp
    
    Set cs = New colSrtm
    
    For Each sm In globSrtm
        If Me.chkAutoSrtmUpdate.Value > 0 And iCurBetStdPdID > 0 Then
            If sm.SRTM_STDPD.pdID = 96 And sm.SRTM_STDPD.stdpdID = iCurBetStdPdID Then
                cs.AddSimple sm
            End If
        Else
            If sm.SRTM_STDPD.pdID = 96 And sm.srtm_props.existsProperty("speedmat") Then
                cs.AddSimple sm
            End If
        End If
    Next sm
    
    
    fgData.Rows = 1
    
    
    Dim i As Integer
    Dim iLevel As Integer
    
    For i = 1 To fgFiles.Rows - 1
    
        If CBool(fgFiles.TextMatrix(i, 0)) And FileExists(Trim(fgFiles.TextMatrix(i, 2)) & Trim(fgFiles.TextMatrix(i, 3))) Then
        
            If fgFiles.RowData(i) = 0 Then iLevel = 0
            If fgFiles.RowData(i) = 1 Then iLevel = 1
            If fgFiles.RowData(i) = 2 Then iLevel = -1
        
            If Not loadData(Trim(fgFiles.TextMatrix(i, 2)) & Trim(fgFiles.TextMatrix(i, 3)), iLevel) Then
                fgFiles.Cell(flexcpBackColor, i, 0, i, fgFiles.cols - 1) = lngLightRed
            End If
        
        ElseIf Not FileExists(Trim(fgFiles.TextMatrix(i, 2)) & Trim(fgFiles.TextMatrix(i, 3))) Then
            fgFiles.Cell(flexcpBackColor, i, 2, i, 3) = lngLightRed
        
        End If
    
    
    Next i
    
    
    fgData.Subtotal flexSTSum, -1, fgData.ColIndex("volume"), "0.000", lngGrey, , True, "Всего"
    fgData.Subtotal flexSTSum, -1, fgData.ColIndex("area"), "0.000", lngGrey, , True, "Всего"
    
    
'    If chkPath(0).Value = 1 And FileExists(Trim(txtPath(0).text)) Then
'        loadData Trim(txtPath(0).text)
'    End If
'
'    If chkPath(1).Value = 1 And FileExists(Trim(txtPath(1).text)) Then
'        loadData Trim(txtPath(1).text)
'    End If
'
'    If chkPath(2).Value = 1 And FileExists(Trim(txtPath(2).text)) Then
'        loadData Trim(txtPath(2).text)
'    End If
'
'    If chkPath(3).Value = 1 And FileExists(Trim(txtPath(3).text)) Then
'        loadData Trim(txtPath(3).text)
'    End If
    
    
    
    
    loadDataRes
    
'    Me.C1Tab1.CurrTab = 2

    If iErrs > 0 Then
        Label4.Caption = "Ошибок: " & iErrs
    Else
        Label4.Caption = "Ошибок нет"
    End If
    
    
    If Me.fgRes.Rows > 1 Then Command3.Enabled = True
    
    
    If fgData.Rows > 1 Then fgData.Cell(flexcpFontBold, 1, 4, fgData.Rows - 1, 4) = True
    
    fgData.AutoSize 0, fgData.cols - 1
    fgRes.AutoSize 0, fgRes.cols - 1
    
    
    Call SaveSetting("Offtake2", "Size", "cmbBetStd.ListIndex", cmbBetStd.ListIndex)
    
    Call SaveSetting("Offtake2", "Size", "optSpeed.Value", optSpeed.Value)
    Call SaveSetting("Offtake2", "Size", "optAeco.Value", optAeco.Value)

Exit Sub

Command2_Click_ERR:
    F1.SB.Panels("status").text = "Command2_Click" & "() - " & err.Description

End Sub


'/******************************************************************************
Private Function loadData(strFileName As String, Optional iLev As Integer = 0) As Boolean
'/******************************************************************************

    On Error GoTo loadData_ERR

    
    
    Dim sm As clsSrtm
    Dim cd As clsCatDef
    
    
    loadData = False
    
    
    Dim fn As Integer
    Dim ar() As String
    Dim Arr() As String
    Dim catdefID As Long
    Dim speedmatID As Long
    Dim betthck As Double
    Dim sechgt As Double
    Dim secwdt As Double
    Dim length As Double
    Dim betrad As Double
    Dim betvol As Double
    Dim betarea As Double
    Dim pr As clsProp
    Dim strKey As String
    Dim strLine As String
    Dim cnt As Long
    Dim i As Integer
    
    fn = FreeFile
    
    Open strFileName For Input As fn
    
    
    
    If iMode = 1 Then ' speedikon


        Dim iKeyCol As Integer
        Dim iMatCol As Integer
        Dim iWidCol As Integer
        Dim iRadCol As Integer
        Dim iVolCol As Integer
        Dim iUseCol As Integer

        Do

            Line Input #fn, strLine
            'beton;wall;floor: 1;part:40;element: 76;material:400;width:    300.0;netvol:      8.928;use: Interior...

            cnt = 0

            If Len(Trim(strLine)) = 0 Then GoTo cnt


            If left(LCase(Trim(strLine)), 5) = "beton" Then

                ar = Split(strLine, ";", , vbTextCompare)

                '====================

                iKeyCol = 1
                iUseCol = -1

                For i = 0 To UBound(ar)

                    If left(ar(i), 8) = "material" Then iMatCol = i
                    If left(ar(i), 5) = "width" Then iWidCol = i
                    If left(ar(i), 6) = "radius" Then iRadCol = i
                    If left(ar(i), 6) = "netvol" Then iVolCol = i
                    If left(ar(i), 3) = "use" Then iUseCol = i

                Next i

                '====================

'                If InStr(1, strLine, "element:347") Then
'                Debug.Print
'                End If


                catdefID = 0
                For Each cd In globCatDefs
                    If iUseCol < 0 Then
                        If cd.speedKey = ar(iKeyCol) Then
                            catdefID = cd.cdID
                            Exit For
                        End If
                    Else

                        Dim s As String
                        Arr = Split(ar(iUseCol), ":")
                        s = Trim(Arr(1))

                        If Len(cd.speedKey) > 0 Then
                            If s Like cd.speedKey & "*" Then
                                catdefID = cd.cdID
                                Exit For
                            End If
                        End If
                    End If

                Next cd

                If catdefID = 0 Then Set cd = New clsCatDef

                speedmatID = 0
                Arr = Split(ar(iMatCol), ":")
                For Each sm In cs

                    If Val(Trim(Arr(1))) = sm.srtm_props("speedmat").propValue Then
                        speedmatID = sm.srtmID
                        Exit For
                    End If

                Next sm

                If speedmatID = 0 Then Set sm = New clsSrtm

                Arr = Split(ar(iWidCol), ":")
                betthck = getDbl(Trim(Arr(1)))
                

                Arr = Split(ar(iVolCol), ":")
                betvol = getDbl(Trim(Arr(1)))

                If UBound(ar) >= iRadCol Then
                    Arr = Split(ar(iRadCol), ":")
                    betrad = getDbl(Trim(Arr(1)))
                End If

                '====================

                If catdefID = 0 Or speedmatID = 0 Then
                    iErrs = iErrs + 1
                End If

                fgData.AddItem cd.cdName & vbTab & sm.srtmName & vbTab & betthck & vbTab & betrad & vbTab & betvol

                strKey = catdefID & "-" & speedmatID & "-" & Format(betthck, "0") & "-" & Format(betrad, "0") & "-" & iLev

                If cl.existsProperty(strKey) Then
                    Set pr = cl(strKey)
                Else
                    Set pr = New clsProp
                    pr.muID = catdefID
                    pr.muSrtmID = speedmatID
                    pr.propK = betthck
                    pr.iSortOrder = betrad
                    pr.propID = iLev
                    cl.AddSimple pr, strKey
                End If

                pr.propValue = pr.propValue + betvol

                Set pr = Nothing


            ElseIf left(LCase(Trim(strLine)), 5) = "error" Then
            Else
            End If

            cnt = cnt + 1

cnt:
        Loop Until EOF(fn)


    ElseIf iMode = 2 Then ' aecosim
        
        cnt = 0
        
        Dim iTypeCol As Integer
        Dim bSection As Boolean
        
        Dim iWidthCol As Integer
        Dim iSectCol As Integer
        Dim iLengthCol As Integer
'        Dim iClassCol As Integer
        Dim arClassCol(5) As Integer
        Dim sPartDef As String
        Dim iCurvedCol As Integer
        Dim iVolumeCol As Integer
        Dim sAreaCol As String
        Dim iFileCol As Integer
        Dim arf() As String
        Dim a As Long
        Dim sDelim As String
        
        sDelim = ","
        
        
        
        Line Input #fn, strLine ' ZB: External Walls,400.0mm,C50/60 XS1 G2400,,31.6890 m3,
        
        arf = Split(strLine, vbLf)
        
        If UBound(arf) = 0 Then ' vblf + vbcr
            Do
                Line Input #fn, strLine
                cnt = cnt + 1
                ReDim Preserve arf(0 To cnt)
                arf(cnt) = strLine
            Loop Until EOF(fn)
        End If
        
        Close fn
        
        
        cnt = 0
        iTypeCol = -1
        arClassCol(0) = -1
        arClassCol(1) = -1
        arClassCol(2) = -1
        arClassCol(3) = -1
        arClassCol(4) = -1
        arClassCol(5) = -1
        
        
        
        For a = 0 To UBound(arf)
            
            strLine = arf(a)
            
            ar = Split(strLine, sDelim, , vbTextCompare)
            
            If UBound(ar) = 0 Then
                sDelim = ";"
                ar = Split(strLine, sDelim, , vbTextCompare)
            End If
            
            catdefID = 0
            speedmatID = 0
            betthck = 0#
            betvol = 0#
            betarea = 0#
            secwdt = 0#
            sechgt = 0#
            
            
            If cnt = 0 Then ' первая строчка - названия столбцов
                
                For i = 0 To UBound(ar)
                    
                    If InStr(LCase(ar(i)), "type") > 0 Then iTypeCol = i
                    If InStr(LCase(ar(i)), "structural") > 0 Then
                        iTypeCol = i ' structural type: beam, column, wall console, ....
                        bSection = True
                    End If
                    
                    
                    If InStr(LCase(ar(i)), "width") > 0 Or InStr(LCase(ar(i)), "slab thickness") > 0 Then iWidthCol = i
'                    If ar(I) = "Part Definition" Then iClassCol = I
                    If ar(i) = "Material" Or InStr(LCase(ar(i)), "class") Then arClassCol(0) = i
                    If ar(i) = "XA" Then arClassCol(1) = i
                    If ar(i) = "XC" Then arClassCol(2) = i
                    If ar(i) = "XD" Then arClassCol(3) = i
                    If ar(i) = "XF" Then arClassCol(4) = i
                    If ar(i) = "XS" Then arClassCol(5) = i
                    If ar(i) = "Curved" Then iCurvedCol = i
                    If ar(i) = "File" Then iFileCol = i
                    If InStr(LCase(ar(i)), "section") > 0 Then iSectCol = i
                    If InStr(LCase(ar(i)), "length") > 0 Then iLengthCol = i
                    If InStr(LCase(ar(i)), "volume") > 0 Then iVolumeCol = i
                    
                    If bSection Then
                    Else
                        If InStr(LCase(ar(i)), "area") Then
'                            sAreaCol = sAreaCol & " " & I
                            If InStr(LCase(ar(i)), "bottom") > 0 Then sAreaCol = sAreaCol & " " & i
                            If InStr(LCase(ar(i)), "left") > 0 Then sAreaCol = sAreaCol & " " & i
                            If InStr(LCase(ar(i)), "right") > 0 Then sAreaCol = sAreaCol & " " & i
                        End If
                    End If
                    
                Next i
            Else
                
                '====================
                
                For Each cd In globCatDefs
                    If Len(cd.simKey) > 0 Then
                        If ar(iTypeCol) Like "*" & cd.simKey & "*" Then
                            catdefID = cd.cdID
                            Exit For
                        End If
                    End If
                Next cd
                
                If catdefID = 0 Then Set cd = New clsCatDef
                
                
                
'                If iClassCol > 0 Then
'                    For Each sm In cs
'                        If InStr(Trim(ar(iClassCol)), sm.srtmName) > 0 Then
'                            speedmatID = sm.srtmID
'                            Exit For
'                        End If
'                    Next sm
'
'                    If speedmatID = 0 Then ' попытка 2
'                        For Each sm In cs
'                            If InStr(Trim(ar(iClassCol)), Replace(sm.srtmName, "/", "_")) > 0 Then
'                                speedmatID = sm.srtmID
'                                Exit For
'                            End If
'                        Next sm
'                    End If
'                Else


                    sPartDef = ""

                    If arClassCol(0) > -1 Then
                        If Len(Trim(ar(arClassCol(0)))) > 0 Then sPartDef = Trim(ar(arClassCol(0)))
                    End If
                    
                    If arClassCol(1) > -1 Then
                        If Len(Trim(ar(arClassCol(1)))) > 0 Then sPartDef = sPartDef & " " & Trim(ar(arClassCol(1)))
                    End If
                    
                    If arClassCol(2) > -1 Then
                        If Len(Trim(ar(arClassCol(2)))) > 0 Then sPartDef = sPartDef & " " & Trim(ar(arClassCol(2)))
                    End If
                    
                    If arClassCol(3) > -1 Then
                        If Len(Trim(ar(arClassCol(3)))) > 0 Then sPartDef = sPartDef & " " & Trim(ar(arClassCol(3)))
                    End If
                    
                    If arClassCol(4) > -1 Then
                        If Len(Trim(ar(arClassCol(4)))) > 0 Then sPartDef = sPartDef & " " & Trim(ar(arClassCol(4)))
                    End If
                    
                    If arClassCol(5) > -1 Then
                        If Len(Trim(ar(arClassCol(5)))) > 0 Then sPartDef = sPartDef & " " & Trim(ar(arClassCol(5)))
                    End If
                    
                    sPartDef = Trim(sPartDef)
                    
                    For Each sm In cs
'                        If InStr(sPartDef, sm.srtmName) > 0 Then
                        If StrComp(sPartDef, sm.srtmName, vbTextCompare) = 0 Then
                            speedmatID = sm.srtmID
                            Exit For
                        End If
                    Next sm
                    
'                End If
                
                If Me.chkAutoSrtmUpdate.Value <> 0 Then
                If speedmatID = 0 And Len(Trim(sPartDef)) > 0 And iCurBetStdPdID > 0 Then
                    Set sm = New clsSrtm
                    sm.srtmName = sPartDef
                    sm.stdpdID = iCurBetStdPdID
                    If sm.saveSrtm("по внесению бетона (catID=" & catID & ")") Then ' С О Х Р А Н Е Н И Е   В   С О Р Т А М Е Н Т
                        speedmatID = sm.srtmID
                        cs.AddSimple sm
                    End If
                End If
                End If
                
                ' ===== SECTION =====
                If bSection Then
                    Dim ssec As String
                    Dim arsec() As String
                    
                    ssec = LCase(ar(iSectCol))
                    
                    length = Val(ar(iLengthCol))
                    
                    arsec = Split(ssec, "_")
                    If UBound(arsec) > 0 Then ' zb "cns_1650x1050"
                        ssec = arsec(1)
                    End If
                    
                    arsec = Split(ssec, "x")
                    
                    secwdt = 0#
                    sechgt = 0#
                    
                    If UBound(arsec) = 0 Then
                        secwdt = Val(arsec(0))
                        sechgt = Val(arsec(0))
                    ElseIf UBound(arsec) = 1 Then
                        secwdt = Val(arsec(0))
                        sechgt = Val(arsec(1))
                        If secwdt > sechgt Then ' sechgt must be > secwdt
                            Dim qwe As Double
                            qwe = secwdt
                            secwdt = sechgt
                            sechgt = qwe
                        End If
                    Else
                    End If
                    
                    betarea = (secwdt * 2 + sechgt * 2) * length * 0.000001
                    
                Else
                
                    Dim aar() As String
                    aar = Split(sAreaCol, " ")
                    For i = 1 To UBound(aar)
                        betarea = betarea + getDbl(Trim(ar(Val(aar(i)))))
                    Next i
                
                End If
                
                ' ===== THICK =====
                If iWidthCol > 0 Then betthck = getDbl(Trim(ar(iWidthCol)))
                
                '============
                betrad = 0
                If iCurvedCol > 0 And Len(Trim(ar(iCurvedCol))) > 0 Then
                    If CBool(ar(iCurvedCol)) Then betrad = 1
                End If
                
                '============
                betvol = getDbl(Trim(ar(iVolumeCol)))
                '============
                
                
                
                If bSection Then
                    fgData.AddItem cd.cdName & vbTab & sm.srtmName & vbTab & sechgt & vbTab & secwdt & vbTab & betvol & vbTab & betarea & vbTab & ar(iFileCol)
                    strKey = catdefID & "-" & speedmatID & "-" & Format(sechgt, "0") & "-" & Format(secwdt, "0") & "-" & iLev
                Else
                    fgData.AddItem cd.cdName & vbTab & sm.srtmName & vbTab & betthck & vbTab & betrad & vbTab & betvol & vbTab & betarea & vbTab & ar(iFileCol)
                    strKey = catdefID & "-" & speedmatID & "-" & Format(betthck, "0") & "-" & Format(betrad, "0") & "-" & iLev
                End If
                
                
                If catdefID = 0 Then
                    fgData.Cell(flexcpBackColor, fgData.Rows - 1, 0, fgData.Rows - 1, fgData.cols - 1) = lngLightRed
                End If
                
                If speedmatID = 0 Then
                    fgData.Cell(flexcpBackColor, fgData.Rows - 1, 0, fgData.Rows - 1, fgData.cols - 1) = lngLightRed
                End If
                
                If catdefID = 0 Or speedmatID = 0 Then iErrs = iErrs + 1
                
                
                If cl.existsProperty(strKey) Then
                    Set pr = cl(strKey)
                    
'                    If pr.bMassCalc Then pr.bPosProp = True ' обновлено то что загружено из базы
                    
                Else
                    Set pr = New clsProp
                    pr.muID = catdefID
                    pr.muSrtmID = speedmatID
                    If bSection Then
                        pr.propK = sechgt
                        pr.iSortOrder = secwdt
                    Else
                        pr.propK = betthck
                        pr.iSortOrder = betrad
                    End If
                    pr.bEditable = bSection
                    pr.propID = iLev
                    cl.AddSimple pr, strKey
                End If
                
                pr.propValue = pr.propValue + betvol
                pr.propDefValue = pr.propDefValue + betarea
                
                Set pr = Nothing
                
            End If
            
            
            
            
            cnt = cnt + 1
            
        Next a
        
    Else
        Exit Function
    End If
    
    
    
    '================================
    
    
    loadData = True

    
Exit Function

loadData_ERR:
    F1.SB.Panels("status").text = "loadData" & "() - ошибка при обработке файла" & vbNewLine & strFileName & vbNewLine & err.Description

End Function

'/******************************************************************************
Public Sub loadDataRes()
'/******************************************************************************

    On Error GoTo loadDataRes_ERR

    fgRes.Rows = 1
    
    Dim pr As clsProp
    Dim sm As clsSrtm
    Dim cd As clsCatDef
    
    For Each pr In cl
        
        If pr.muSrtmID > 0 And pr.muID > 0 Then
            
            Set cd = globCatDefs(CStr(pr.muID))
            Set sm = globSrtm(CStr(pr.muSrtmID))
            
            fgRes.AddItem getLevSign(pr.propID) & vbTab & cd.cdName & vbTab & sm.srtmName & vbTab & pr.propK & vbTab & pr.iSortOrder & vbTab & Round(pr.propValue, 1) & vbTab & Round(pr.propDefValue, 1)
            
            If Not pr.bEditable Then
                If pr.iSortOrder Then fgRes.TextMatrix(fgRes.Rows - 1, 4) = "рад" Else fgRes.TextMatrix(fgRes.Rows - 1, 4) = "лин"
            End If
            
        Else
            fgRes.AddItem getLevSign(pr.propID) & vbTab & "" & vbTab & "" & vbTab & pr.propK & vbTab & pr.iSortOrder & vbTab & Round(pr.propValue, 1) & vbTab & Round(pr.propDefValue, 1)
        
        
        End If
        
'        If pr.bPosProp Then fgRes.Cell(flexcpBackColor, fgRes.Rows - 1, 0, fgRes.Rows - 1, fgRes.cols - 1) = lngGreen
'        If pr.bMassCalc = False Then fgRes.Cell(flexcpBackColor, fgRes.Rows - 1, 0, fgRes.Rows - 1, fgRes.cols - 1) = lngBlue
        
    Next pr
    
    
    
    
    fgRes.Subtotal flexSTSum, -1, fgRes.ColIndex("volume"), "0.000", lngGrey, , True, "Всего"
    fgRes.Subtotal flexSTSum, -1, fgRes.ColIndex("area"), "0.000", lngGrey, , True, "Всего"

    
Exit Sub

loadDataRes_ERR:
    F1.SB.Panels("status").text = "loadDataRes" & "() - " & err.Description

End Sub



'/******************************************************************************
Private Sub Command3_Click()
'/******************************************************************************

    On Error GoTo Command3_Click_ERR


    
    Dim cmd As New ADODB.Command
    cmd.ActiveConnection = cn_data
    cmd.CommandText = "delete from r_catpos_property where posID in (select posID from catpos where partID = " & catID & ")"
    cmd.Execute
    cmd.CommandText = "delete from catpos where partID = " & catID
    cmd.Execute
    
    
    Dim pr As clsProp
    Dim catposID As Long
    Dim cpropID As Long
    
    For Each pr In cl
        
        If pr.muSrtmID > 0 Then
            
            catposID = insertDataInBase(cn_data, "catpos", "partID", catID, "srtmID", pr.muSrtmID, "posQuantity", Round(pr.propValue, 1))
            
            If catposID > 0 Then
                
                If pr.bEditable Then ' section
                
                    cpropID = insertDataInBase(cn_data, "r_catpos_property", "posID", catposID, "catdef", pr.muID, "width", CDbl(pr.iSortOrder), "height", pr.propK)
                    
                Else
                
                    cpropID = insertDataInBase(cn_data, "r_catpos_property", "posID", catposID, "catdef", pr.muID, "thickness", pr.propK)
                    
                    If cpropID > 0 And pr.iSortOrder > 0 Then
                        Call updateTableInBase(cn_data, "r_catpos_property", "radiusinn", CDbl(pr.iSortOrder), "relID", cpropID)
                    End If
                    
                End If
                
                
                If cpropID > 0 And pr.propID <> 0 Then
                    Call updateTableInBase(cn_data, "r_catpos_property", "glevel", CDbl(pr.propID), "relID", cpropID)
                End If
                
                If cpropID > 0 And pr.propDefValue > 0 Then
                    Call updateTableInBase(cn_data, "r_catpos_property", "area", CDbl(pr.propDefValue), "relID", cpropID)
                End If
                
                writeOperationS operCreate, "catpos", catposID, "создание позиции из отчета"
                
            End If
            
        End If
        
    Next pr
    
    
    F1.fgCatsAddPositions catID



Exit Sub

Command3_Click_ERR:
    F1.SB.Panels("status").text = "Command3_Click" & "() - " & err.Description

End Sub


'/******************************************************************************
Public Sub loadCatPositions()
'/******************************************************************************

    On Error GoTo loadPositions_ERR
    
    Dim prt As New clsPart
    
    prt.setPartFromCat Me.catID, True, True, False
    
    Dim ps As clsPos
    Dim strKey As String
    
    Set cl = New colProp
    
    For Each ps In prt.ps.pe
        
        Dim pr As New clsProp
        
        If ps.pos_props.existsProperty("width") And ps.pos_props.existsProperty("height") Then
            pr.bEditable = True ' section
        End If
        
        If ps.pos_props.existsProperty("catdef") Then
            pr.muID = ps.pos_props("catdef").propValue
        Else
            '''
        End If
        
        pr.muSrtmID = ps.POS_SRTM.srtmID
        
        If pr.bEditable Then
            pr.propK = ps.pos_props("height").propValue
            pr.iSortOrder = ps.pos_props("width").propValue
        Else
            If ps.pos_props.existsProperty("thickness") Then pr.propK = ps.pos_props("thickness").propValue
            If ps.pos_props.existsProperty("radiusinn") Then pr.iSortOrder = ps.pos_props("radiusinn").propValue
        End If
        
        If ps.pos_props.existsProperty("area") Then pr.propDefValue = ps.pos_props("area").propValue
        
        pr.propValue = ps.posQty
        
        
        If ps.pos_props.existsProperty("glevel") Then pr.propID = ps.pos_props("glevel").propValue
        
        
        strKey = pr.muID & "-" & pr.muSrtmID & "-" & Format(pr.propK, "0") & "-" & Format(pr.iSortOrder, "0") & "-" & pr.propID
        
'        pr.bMassCalc = True  ' уже есть в базе
        
        cl.AddSimple pr, strKey
        
        Set pr = Nothing
        
    Next ps

    loadDataRes

    fgRes.AutoSize 0, fgRes.cols - 1





Exit Sub

loadPositions_ERR:
    F1.SB.Panels("status").text = "loadCatPositions" & "() - " & err.Description

End Sub

'/******************************************************************************
Private Sub Command4_Click()
'/******************************************************************************
    
    On Error GoTo Command4_Click_ERR
    
    
    
    Dim arFiles() As String
    Dim arFiles2() As String
    Dim res As Integer
    Dim i As Integer
    
    res = getTaskFiles(arFiles, Me)
    
    If res = -1 Then
        loadFilesTable0 arFiles
    ElseIf res > 0 Then
        For i = 1 To UBound(arFiles)
            ReDim Preserve arFiles2(i - 1)
            arFiles2(i - 1) = arFiles(0) & "\" & arFiles(i)
        Next i
        loadFilesTable0 arFiles2
    Else
        MsgBox "error"
    End If
    
    
    
    
'    Dim iRecordsAffected As Integer
'    Dim cmd As New ADODB.Command
'    cmd.ActiveConnection = cn_data
'    cmd.CommandText = "delete from [filestable] where catID = " & catID
'    cmd.Execute iRecordsAffected
'    Set cmd = Nothing
    
    
    
'    Dim I As Integer
'
'    For I = 0 To UBound(arFiles)
'        Call insertDataInBase(cn_data, "filestable", "fileFullPath", arFiles(0) & "\", "fileDescr", arFiles(I), "catID", catID)
'    Next I

    


    
    
    Exit Sub
    
Command4_Click_ERR:
    F1.SB.Panels("status").text = "Command4_Click" & "() - " & err.Description
    
End Sub

''/******************************************************************************
'Public Function getLevSign(iLev As Integer) As String
''/******************************************************************************
'
'    On Error GoTo getLevSign_ERR
'
'    If iLev = 0 Then
'        getLevSign = "-"
'    ElseIf iLev = 1 Then
'        getLevSign = "надземн"
'    ElseIf iLev = -1 Then
'        getLevSign = "подземн"
'    ElseIf iLev = 2 Then
'        getLevSign = "подземн"
'    Else
'        getLevSign = "?"
'    End If
'
'Exit Function
'
'getLevSign_ERR:
'    getLevSign = "?"
'
'End Function



'/******************************************************************************
Private Sub fgFiles_AfterEdit(ByVal Row As Long, ByVal Col As Long)
'/******************************************************************************

    On Error GoTo fgFiles_AfterEdit_ERR


    If Col <> 1 Then Exit Sub

    
    Dim i As Integer
    Dim ID As Long
    i = Val(fgFiles.ComboData(fgFiles.ComboIndex))
    ID = Val(fgFiles.TextMatrix(Row, 4))
    
    fgFiles.RowData(Row) = i
    
    Call updateTableInBase(cn_data, "filestable", "fileSheetNum", i, "fileID", ID)
    
    
Exit Sub

fgFiles_AfterEdit_ERR:
    F1.SB.Panels("status").text = "fgFiles_AfterEdit" & "() - " & err.Description

End Sub

Private Sub fgFiles_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)

    If fgFiles.Col = 2 Then
        fgFiles.ComboList = "..."
    ElseIf fgFiles.Col = 1 Then
        fgFiles.ComboList = "#0;" & getLevSign(0) & "|#1;" & getLevSign(1) & "|#2;" & getLevSign(2) & ""
    ElseIf fgFiles.Col = 0 Then
        fgFiles.ComboList = ""
    Else
        fgFiles.ComboList = ""
        Cancel = True
    End If


End Sub

'/******************************************************************************
Private Sub fgFiles_CellButtonClick(ByVal Row As Long, ByVal Col As Long)
'/******************************************************************************

    On Error GoTo fgFiles_CellButtonClick_ERR


    Dim OFN As OPENFILENAME
    Dim strFN As String
    Dim strLine As String
    Dim strFileName As String
    
    OFN.lStructSize = Len(OFN)
    OFN.hWndOwner = Me.hwnd
    OFN.hInstance = App.hInstance
    If Me.optSpeed.Value Then
        OFN.lpstrFilter = "TXT Files (*.txt)" + Chr$(0) + "*.txt" + Chr$(0) + "All Files (*.*)" + Chr$(0) + "*.*" + Chr$(0)
    Else
        OFN.lpstrFilter = "CSV Files (*.txt)" + Chr$(0) + "*.csv" + Chr$(0) + "All Files (*.*)" + Chr$(0) + "*.*" + Chr$(0)
    End If
    OFN.lpstrFile = Space$(254)
    OFN.nMaxFile = 255
    
    OFN.lpstrFileTitle = Space$(254)
    OFN.nMaxFileTitle = 255
    OFN.lpstrInitialDir = GetSetting("Offtake2", "Size", "BetonReport", App.Path)
    OFN.lpstrTitle = "Отчет по бетону"
    OFN.flags = 0
    Dim a
    a = GetOpenFileName(OFN)
    If (a) Then
        strFileName = Trim$(OFN.lpstrFile)
        If right(strFileName, 1) = Chr(0) Then strFileName = left(strFileName, Len(strFileName) - 1)
    Else
        Exit Sub
    End If
    
    
    Dim ar() As String
    ar = Split(strFileName, "\")
    
    If UBound(ar) < 1 Then Exit Sub
    
    
    
    Dim bUpd As Boolean
    Dim str1 As String
    Dim str2 As String
    Dim ID As Long
    str1 = left(strFileName, Len(strFileName) - Len(ar(UBound(ar))))
    str2 = ar(UBound(ar))
    ID = Val(fgFiles.TextMatrix(Row, 4))
    
    If ID > 0 Then
        bUpd = updateTableInBase(cn_data, "filestable", "fileFullPath", str1, "fileID", ID)
        bUpd = updateTableInBase(cn_data, "filestable", "fileDescr", str2, "fileID", ID)
    Else
        ID = insertDataInBase(cn_data, "filestable", "fileFullPath", str1, "fileDescr", str2, "catID", catID)
    End If
    
    
    
    If bUpd Or ID > 0 Then
        fgFiles.TextMatrix(Row, 2) = str1
        fgFiles.TextMatrix(Row, 3) = str2
        
        fgFiles.TextMatrix(Row, 0) = True
        
        If Row = fgFiles.Rows - 1 Then
            fgFiles.AddItem ""
            fgFiles.TextMatrix(fgFiles.Rows - 1, 0) = False
            fgFiles.TextMatrix(fgFiles.Rows - 1, 1) = getLevSign(0)
            fgFiles.RowData(fgFiles.Rows - 1) = 0
        End If
        
    End If
    
    
    
Exit Sub

fgFiles_CellButtonClick_ERR:
    F1.SB.Panels("status").text = "fgFiles_CellButtonClick" & "() - " & err.Description

End Sub

'/******************************************************************************
Private Sub fgFiles_KeyDown(KeyCode As Integer, Shift As Integer)
'/******************************************************************************

    On Error GoTo fgFiles_KeyDown_ERR


    If KeyCode = 46 Then
    
        If fgFiles.Row >= 0 And fgFiles.Row < fgFiles.Rows - 1 Then
        
            Dim ID As Long
            ID = Val(fgFiles.TextMatrix(fgFiles.Row, 4))
            If ID = 0 Then Exit Sub
            
            Dim iRecordsAffected As Integer
            Dim cmd As New ADODB.Command
            cmd.ActiveConnection = cn_data
            cmd.CommandText = "delete from [filestable] where fileID = " & ID
            cmd.Execute iRecordsAffected
            Set cmd = Nothing
            
            If iRecordsAffected = 1 Then fgFiles.RemoveItem fgFiles.Row
        
        End If
    
    End If

Exit Sub

fgFiles_KeyDown_ERR:
    F1.SB.Panels("status").text = "fgFiles_KeyDown" & "() - " & err.Description

End Sub




'/******************************************************************************
Private Sub Form_Load()
'/******************************************************************************

    On Error GoTo Form_Load_ERR


    fgRes.ColKey(5) = "volume"
    fgRes.ColKey(6) = "area"
    fgRes.TextMatrix(0, fgRes.ColIndex("volume")) = "объем"
    fgRes.TextMatrix(0, fgRes.ColIndex("area")) = "площадь"
    
    fgData.ColKey(4) = "volume"
    fgData.ColKey(5) = "area"
    fgData.TextMatrix(0, fgData.ColIndex("volume")) = "объем"
    fgData.TextMatrix(0, fgData.ColIndex("area")) = "площадь"



    
    loadCatPositions
    
    
    fgFiles.ColDataType(0) = flexDTBoolean
    
    
    
'    Dim str As String
'    Dim str2 As String
'    Dim iUse As Integer
'    Dim iLev As Integer
'    Dim I As Integer
'
'    I = 1
'
'    Do
'        iUse = Val(GetSetting("Offtake2", "Size", "chkPath(" & I & ").Value", 0))
'        iLev = Val(GetSetting("Offtake2", "Size", "BetonReportLevel" & I, 0))
'        str = GetSetting("Offtake2", "Size", "BetonReportPath" & I, "")
'        str2 = GetSetting("Offtake2", "Size", "BetonReportFile" & I, "")
'
'        If Len(Trim(str)) = 0 Then Exit Do
'        If Len(Trim(str2)) = 0 Then Exit Do
'
'        fgFiles.AddItem ""
'
'        fgFiles.TextMatrix(I, 0) = CBool(iUse)
'        fgFiles.TextMatrix(I, 1) = getLevSign(iLev)
'        fgFiles.TextMatrix(I, 2) = str
'        fgFiles.TextMatrix(I, 3) = str2
'
'        fgFiles.RowData(I) = iLev
'
'        I = I + 1
'    Loop
    
    
    loadFilesTable
    
    
    
    Dim stdpd As clsStdPd
    Dim iDefInd As Integer
    For Each stdpd In globStdPosdefs
        If stdpd.pdID = 96 Then
            cmbBetStd.AddItem stdpd.SP_STD.FULLNUMBER
            cmbBetStd.ItemData(cmbBetStd.NewIndex) = stdpd.stdpdID
            If stdpd.stdpdID = 281 Then iDefInd = cmbBetStd.NewIndex ' бетон финский
        End If
    Next
'    If cmbBetStd.ListCount > 0 Then cmbBetStd.ListIndex = 0
    
    
    cmbBetStd.ListIndex = GetSetting("Offtake2", "Size", "cmbBetStd.ListIndex", iDefInd)
    
    optSpeed.Value = GetSetting("Offtake2", "Size", "optSpeed.Value", False)
    optAeco.Value = GetSetting("Offtake2", "Size", "optAeco.Value", True)
    

Exit Sub

Form_Load_ERR:
    F1.SB.Panels("status").text = "Form_Load" & "() - " & err.Description

End Sub

'/******************************************************************************
Private Sub Form_Unload(Cancel As Integer)
'/******************************************************************************

    On Error GoTo Form_Unload_ERR

'    Dim str As String
'    Dim iUse As Integer
'    Dim iLev As Integer
'    Dim I As Integer
'
'    For I = 1 To fgFiles.Rows - 1
'
'        Call SaveSetting("Offtake2", "Size", "chkPath(" & I & ").Value", Abs(CInt(CBool(fgFiles.TextMatrix(I, 0)))))
'        Call SaveSetting("Offtake2", "Size", "BetonReportLevel" & I, fgFiles.RowData(I))
'        Call SaveSetting("Offtake2", "Size", "BetonReportPath" & I, fgFiles.TextMatrix(I, 2))
'        Call SaveSetting("Offtake2", "Size", "BetonReportFile" & I, fgFiles.TextMatrix(I, 3))
'
'
'    Next I


Exit Sub

Form_Unload_ERR:

End Sub

'/******************************************************************************
Public Sub loadFilesTable0(arFiles() As String)
'/******************************************************************************

    On Error GoTo loadFilesTable0_ERR

    fgFiles.Rows = 1


    Dim i As Integer

    For i = 0 To UBound(arFiles)
        fgFiles.AddItem ""
        fgFiles.TextMatrix(fgFiles.Rows - 1, 0) = False
'        fgFiles.TextMatrix(fgFiles.Rows - 1, 1) = getLevSign(0)
        fgFiles.TextMatrix(fgFiles.Rows - 1, 2) = arFiles(i)
        fgFiles.TextMatrix(fgFiles.Rows - 1, 4) = 0
        fgFiles.RowData(fgFiles.Rows - 1) = 0
    Next i




    fgFiles.AutoSize 0, fgFiles.cols - 1
    
    fgFiles.ColWidth(1) = 1200
'    fgFiles.ColWidthMax = 3000
    
    fgFiles.ColHidden(3) = True
    fgFiles.ColHidden(4) = True


Exit Sub

loadFilesTable0_ERR:

End Sub



'/******************************************************************************
Public Sub loadFilesTable()
'/******************************************************************************
    
    On Error GoTo loadFiles_ERR
    
    
    fgFiles.Rows = 1
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from filestable where catID = " & catID, cn_data, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            fgFiles.AddItem ""
            fgFiles.TextMatrix(fgFiles.Rows - 1, 0) = CBool(RS.fields("fileUse").Value)
            fgFiles.TextMatrix(fgFiles.Rows - 1, 1) = getLevSign(RS.fields("fileSheetNum").Value)
            fgFiles.TextMatrix(fgFiles.Rows - 1, 2) = RS.fields("fileFullPath").Value & ""
            fgFiles.TextMatrix(fgFiles.Rows - 1, 3) = RS.fields("fileDescr").Value & ""
            fgFiles.TextMatrix(fgFiles.Rows - 1, 4) = RS.fields("fileID").Value
            
            fgFiles.RowData(fgFiles.Rows - 1) = RS.fields("fileSheetNum").Value
            
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    RS.Close
    Set RS = Nothing
    
    
    fgFiles.AddItem ""
    fgFiles.TextMatrix(fgFiles.Rows - 1, 0) = False
    fgFiles.TextMatrix(fgFiles.Rows - 1, 1) = getLevSign(0)
    fgFiles.TextMatrix(fgFiles.Rows - 1, 4) = 0
    fgFiles.RowData(fgFiles.Rows - 1) = 0
    
    
    
    fgFiles.AutoSize 0, fgFiles.cols - 1
    
    fgFiles.ColWidth(1) = 1200
'    fgFiles.ColWidthMax = 3000
    
    
    fgFiles.ColHidden(4) = True
    
    
    
    Exit Sub
    
loadFiles_ERR:
    F1.SB.Panels("status").text = "loadFiles" & "() - " & err.Description
    
End Sub


Private Sub optAeco_Click()


    If optAeco.Value Then
        chkAutoSrtmUpdate.Enabled = True
    End If


End Sub

Private Sub optSpeed_Click()


    If optSpeed.Value Then
        Me.chkAutoSrtmUpdate.Value = 0
        chkAutoSrtmUpdate.Enabled = False
    Else
        chkAutoSrtmUpdate.Enabled = True
    End If

End Sub
