VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Begin VB.Form frmPartKks 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   9780
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   14775
   Icon            =   "frmPartKks.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   9780
   ScaleWidth      =   14775
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   9000
      Top             =   4920
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   1
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPartKks.frx":000C
            Key             =   "excl"
         EndProperty
      EndProperty
   End
   Begin MSComCtl2.UpDown UpDown4 
      Height          =   315
      Left            =   615
      TabIndex        =   20
      Top             =   360
      Width           =   240
      _ExtentX        =   423
      _ExtentY        =   556
      _Version        =   393216
      Value           =   1
      BuddyControl    =   "txtRows"
      BuddyDispid     =   196619
      OrigLeft        =   7200
      OrigTop         =   2520
      OrigRight       =   7440
      OrigBottom      =   3855
      Max             =   50
      Min             =   1
      SyncBuddy       =   -1  'True
      BuddyProperty   =   0
      Enabled         =   -1  'True
   End
   Begin MSComCtl2.UpDown UpDown3 
      Height          =   315
      Left            =   1455
      TabIndex        =   19
      Top             =   360
      Width           =   240
      _ExtentX        =   423
      _ExtentY        =   556
      _Version        =   393216
      Value           =   1
      BuddyControl    =   "txtCols"
      BuddyDispid     =   196611
      OrigLeft        =   8760
      OrigTop         =   3120
      OrigRight       =   9000
      OrigBottom      =   3855
      Min             =   1
      SyncBuddy       =   -1  'True
      BuddyProperty   =   0
      Enabled         =   -1  'True
   End
   Begin MSComCtl2.UpDown UpDown2 
      Height          =   315
      Left            =   1455
      TabIndex        =   18
      Top             =   1320
      Width           =   240
      _ExtentX        =   423
      _ExtentY        =   556
      _Version        =   393216
      BuddyControl    =   "txtSN"
      BuddyDispid     =   196609
      OrigLeft        =   8040
      OrigTop         =   3600
      OrigRight       =   8280
      OrigBottom      =   4095
      Max             =   99
      SyncBuddy       =   -1  'True
      Wrap            =   -1  'True
      BuddyProperty   =   0
      Enabled         =   -1  'True
   End
   Begin VB.TextBox txtSN 
      Height          =   315
      Left            =   960
      TabIndex        =   17
      Top             =   1320
      Width           =   495
   End
   Begin VB.CommandButton btnCancel 
      Caption         =   "выход"
      Height          =   375
      Left            =   120
      TabIndex        =   16
      Top             =   3600
      Width           =   1215
   End
   Begin VB.TextBox txtCols 
      Height          =   315
      Left            =   960
      TabIndex        =   14
      Text            =   "1"
      Top             =   360
      Width           =   495
   End
   Begin VB.CommandButton btnCols 
      Caption         =   "set"
      Height          =   255
      Left            =   960
      TabIndex        =   13
      Top             =   720
      Width           =   735
   End
   Begin MSComCtl2.UpDown UpDown1 
      Height          =   315
      Left            =   840
      TabIndex        =   12
      Top             =   2280
      Width           =   240
      _ExtentX        =   423
      _ExtentY        =   556
      _Version        =   393216
      Value           =   1
      BuddyControl    =   "txtNum"
      BuddyDispid     =   196617
      OrigLeft        =   840
      OrigTop         =   2640
      OrigRight       =   1080
      OrigBottom      =   2895
      Max             =   999
      Min             =   1
      SyncBuddy       =   -1  'True
      Wrap            =   -1  'True
      BuddyProperty   =   0
      Enabled         =   -1  'True
   End
   Begin VB.ComboBox txtSys 
      Height          =   315
      Left            =   120
      TabIndex        =   11
      Top             =   1320
      Width           =   855
   End
   Begin VB.CommandButton btnSave 
      Caption         =   "сохранить"
      Height          =   375
      Left            =   120
      TabIndex        =   10
      Top             =   3120
      Width           =   1215
   End
   Begin VB.CommandButton btnRows 
      Caption         =   "set"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   720
      Width           =   735
   End
   Begin VB.CommandButton btnNum 
      Caption         =   "set"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   2640
      Width           =   975
   End
   Begin VB.TextBox txtNum 
      Height          =   315
      Left            =   120
      TabIndex        =   5
      Top             =   2280
      Width           =   735
   End
   Begin VB.CommandButton btnSys 
      Caption         =   "set"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   1680
      Width           =   1575
   End
   Begin VB.TextBox txtRows 
      Height          =   315
      Left            =   120
      TabIndex        =   1
      Text            =   "1"
      Top             =   360
      Width           =   495
   End
   Begin VSFlex8Ctl.VSFlexGrid fgKKS 
      Height          =   3375
      Index           =   0
      Left            =   1800
      TabIndex        =   0
      Top             =   480
      Width           =   2655
      _cx             =   75174475
      _cy             =   75175745
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
      BackColor       =   -2147483633
      ForeColor       =   -2147483640
      BackColorFixed  =   -2147483633
      ForeColorFixed  =   -2147483630
      BackColorSel    =   -2147483635
      ForeColorSel    =   -2147483634
      BackColorBkg    =   -2147483636
      BackColorAlternate=   -2147483633
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483632
      TreeColor       =   -2147483632
      FloodColor      =   192
      SheetBorder     =   -2147483642
      FocusRect       =   2
      HighLight       =   1
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   5
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
      Editable        =   1
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
   Begin VB.CheckBox chkKks 
      Height          =   255
      Index           =   0
      Left            =   1800
      TabIndex        =   9
      Top             =   120
      Width           =   495
   End
   Begin VB.Label Label4 
      Caption         =   "компл.:"
      Height          =   255
      Left            =   120
      TabIndex        =   15
      Top             =   120
      Width           =   615
   End
   Begin VB.Label Label3 
      Caption         =   "номер"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   2040
      Width           =   735
   End
   Begin VB.Label Label2 
      Caption         =   "система"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   1080
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "опоры:"
      Height          =   255
      Left            =   960
      TabIndex        =   2
      Top             =   120
      Width           =   615
   End
End
Attribute VB_Name = "frmPartKks"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public iGridMaxIndex As Integer

Public iColMax As Long
Public iRowMax As Long

Public iRows As Long
Public iCols As Long

Public sKksDiv As String

Dim tt As CBalloonToolTip

'/******************************************************************************
Public Sub loadSysCombo()
'/******************************************************************************

    On Error GoTo loadSysCombo_ERR

    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from partsys where projectID = " & lngCurProjectID, cn_data, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            txtSys.AddItem RS.fields("sysName").Value & ""
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    RS.Close
    Set RS = Nothing

Exit Sub

loadSysCombo_ERR:

End Sub



'/******************************************************************************
Public Sub loadKksGrid(Index As Integer)
'/******************************************************************************

    On Error GoTo loadKksGrid_ERR

    Dim RS As New ADODB.Recordset
    Dim r As Long
    

'    F1.curPart.partDocSetPartListID = -iGridMaxIndex
'    F1.curPart.partDocSetDrawingsID = -iRows


    
    RS.Open "select * from r_part_kks where partID = " & F1.curPart.partID & " and formcol = " & Index, cn_data, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            r = RS.fields("formrow").Value
            
            If r < Me.fgKKS(Index).Rows Then Me.fgKKS(Index).TextMatrix(r, Me.fgKKS(Index).ColIndex("kksSys")) = RS.fields("kksSys").Value
            If r < Me.fgKKS(Index).Rows Then Me.fgKKS(Index).TextMatrix(r, Me.fgKKS(Index).ColIndex("kksNum")) = Format(RS.fields("kksNum").Value, "000")
        
        
            RS.MoveNext
        Loop Until RS.EOF
    
    End If

    RS.Close
    Set RS = Nothing


Exit Sub

loadKksGrid_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadKksGrid - Error"

End Sub



Private Sub btnCancel_Click()

    Unload Me


End Sub

Private Sub btnCols_Click()

    iCols = Val(txtCols.text)
    
    If iCols > 9 Then iCols = 9
    
    txtCols.text = iCols
    
    Me.width = (Me.fgKKS(0).width + 50) * iCols + 150 + 1700




End Sub

Private Sub btnNum_Click()


    Dim k As Integer
    Dim i As Long
    
    
    Dim r1 As Long
    Dim r2 As Long
    Dim c1 As Long
    Dim c2 As Long
    
    Dim stp As Integer
    
    
    Dim num As Integer
    num = Val(Trim(UCase(txtNum.text)))
    
    For k = 0 To iCols
    
        If chkKks(k).Value = 0 Then GoTo cnt
    
        Me.fgKKS(k).GetSelection r1, c1, r2, c2
        
        If Me.fgKKS(k).RowSel < Me.fgKKS(k).Row Then stp = -1 Else stp = 1
        
    
        For i = Me.fgKKS(k).Row To Me.fgKKS(k).RowSel Step stp
        
            If c1 = Me.fgKKS(k).ColIndex("kksNum") Or c2 = Me.fgKKS(k).ColIndex("kksNum") Then
        
                Me.fgKKS(k).TextMatrix(i, Me.fgKKS(k).ColIndex("kksNum")) = Format(num, "000")
                num = num + 1
            
            End If
        
        Next i
        
cnt:
    Next k



End Sub

Private Sub btnRows_Click()

    Dim i As Integer
    
    iRows = Val(Trim(txtRows.text))
    
    If iRows <= 0 Then iRows = 1
    
    For i = 0 To iGridMaxIndex
        Me.fgKKS(i).Visible = False
        setGrid Me.fgKKS(i), Me.chkKks(i), i, False
        Me.fgKKS(i).Visible = True
    Next i

    Me.Height = fgKKS(0).top + fgKKS(0).Height + 500
    If Me.Height < 4600 Then Me.Height = 4600

End Sub

'/******************************************************************************
Private Sub btnSave_Click()
'/******************************************************************************

    On Error GoTo btnSave_Click_ERR

    Me.MousePointer = 11

'    partDocSetPartListID = RS.Fields("dsPartListID").Value ' iGridMaxIndex
'    partDocSetDrawingsID = RS.Fields("dsDrawingsID").Value ' iRows

    F1.curPart.partDocSetPartListID = -(iCols - 1)
    F1.curPart.partDocSetDrawingsID = -iRows

    If updateTableInBase(cn_data, "part", "dsPartListID", F1.curPart.partDocSetPartListID, "partID", F1.curPart.partID) Then
        If updateTableInBase(cn_data, "part", "dsDrawingsID", F1.curPart.partDocSetDrawingsID, "partID", F1.curPart.partID) Then
        End If
    Else
        err.Raise 100, , "Ошибка при сохранении"
    End If
    
    
    
    ' delete...
    Dim cmd As New ADODB.Command
    cmd.ActiveConnection = cn_data
    
    If iRows > 0 Then
        cmd.CommandText = "delete from [r_part_kks] where partID = " & F1.curPart.partID & " and formrow > " & iRows - 1
        cmd.Execute
    End If
    
    If iCols > 0 Then
        cmd.CommandText = "delete from [r_part_kks] where partID = " & F1.curPart.partID & " and formcol > " & iCols - 1
        cmd.Execute
    End If
    
    Set cmd = Nothing
    
    
    Dim k As Integer
    Dim i As Long
    
    Dim strSys As String
    Dim strDiv As String
    Dim iNum As Integer
    Dim iBlk As Integer
    
    Dim RS As New ADODB.Recordset
    
    
    For k = 0 To iCols
    
        If chkKks(k).Value = 0 Then GoTo cnt
    
        For i = 0 To Me.fgKKS(k).Rows - 1
        
            Me.fgKKS(k).Cell(flexcpBackColor, i, 0, i, Me.fgKKS(k).cols - 1) = lngRowWinColor
            
            Me.fgKKS(k).TextMatrix(i, Me.fgKKS(k).ColIndex("tip")) = ""
        
            strSys = Trim(Me.fgKKS(k).TextMatrix(i, Me.fgKKS(k).ColIndex("kksSys")))
            strDiv = Trim(Me.fgKKS(k).TextMatrix(i, Me.fgKKS(k).ColIndex("kksDiv")))
            iNum = CInt(Val(Me.fgKKS(k).TextMatrix(i, Me.fgKKS(k).ColIndex("kksNum"))))
            iBlk = CInt(Val(Me.fgKKS(k).TextMatrix(i, Me.fgKKS(k).ColIndex("kksBlock"))))
        
            If Len(strSys) <> 5 Then
'                If Len(strSys) > 0 Then Me.fgKKS(k).Cell(flexcpPicture, I, Me.fgKKS(k).ColIndex("kksSys")) = Me.ImageList1.ListImages("excl").ExtractIcon
                Me.fgKKS(k).Cell(flexcpBackColor, i, 0, i, Me.fgKKS(k).cols - 1) = lngLightRed
                GoTo cnt
            End If
            
            If RS.State = adStateOpen Then RS.Close
            
            Dim strSQL As String
            strSQL = "select partName, catID, count(partName) as cnt from view_r_part_kks where blockNumber = " & iBlk
            strSQL = strSQL & " and kksSys = '" & strSys & "'"
            strSQL = strSQL & " and kksDiv = '" & strDiv & "'"
            strSQL = strSQL & " and kksNum = " & iNum
            strSQL = strSQL & " and projectID = " & lngCurProjectID
            strSQL = strSQL & " and deleted = 0"
            If iVersDB > 200600005 Then strSQL = strSQL & " and catdel = 0"
            strSQL = strSQL & " and partID != " & F1.curPart.partID
'            strSQL = strSQL & " and (formrow != " & i & " or formcol != " & k & ")"
            strSQL = strSQL & " group by partName, catID"
            
            RS.Open strSQL, cn_data, adOpenForwardOnly, adLockReadOnly
                                
            If Not RS.EOF Then
'                Me.fgKKS(k).Cell(flexcpPicture, I, Me.fgKKS(k).ColIndex("kksBlock")) = Me.ImageList1.ListImages("excl").ExtractIcon
                Me.fgKKS(k).Cell(flexcpBackColor, i, 0, i, Me.fgKKS(k).cols - 1) = lngRed
                RS.MoveFirst
                Dim n As Node
                Dim strtip As String
                strtip = ""
                Me.fgKKS(k).TextMatrix(i, Me.fgKKS(k).ColIndex("tip")) = ""
                Do
                    If Len(strtip) > 0 Then strtip = strtip & vbNewLine
                    Dim strPath As String
                    strPath = cCats(CStr(RS.fields("catID").Value)).getCatPath(True)
'                    Set n = tvGetTreeNode(F1.tvCats, "catalog" & RS.fields("catID").Value)
'                    If n Is Nothing Then
'                        strtip = strtip & "(" & RS.fields("cnt").Value & ") " & RS.fields("partName").Value
'                    Else
                        strtip = strtip & "(" & RS.fields("cnt").Value & ") " & RS.fields("partName").Value & ", " & strPath
'                    End If
                    RS.MoveNext
                Loop Until RS.EOF
                Me.fgKKS(k).TextMatrix(i, Me.fgKKS(k).ColIndex("tip")) = strtip
                GoTo cnt
            Else
            End If
            
            
            If iNum = 0 Then
                Me.fgKKS(k).Cell(flexcpBackColor, i, 0, i, Me.fgKKS(k).cols - 1) = lngLightRed
                GoTo cnt
            End If
            
            
            'save...
            
            If RS.State = adStateOpen Then RS.Close
            
            RS.Open "select * from r_part_kks where partID = " & F1.curPart.partID & " and formrow = " & i & " and formcol = " & k, cn_data, adOpenStatic, adLockOptimistic
            If RS.EOF Then
                RS.AddNew
            Else
                RS.MoveFirst
            End If
            
            RS.fields("kksSys").Value = Me.fgKKS(k).TextMatrix(i, Me.fgKKS(k).ColIndex("kksSys"))
            RS.fields("kksNum").Value = CInt(Val(Me.fgKKS(k).TextMatrix(i, Me.fgKKS(k).ColIndex("kksNum"))))
            RS.fields("projectID").Value = lngCurProjectID
            RS.fields("partID").Value = F1.curPart.partID
            RS.fields("formrow").Value = i
            RS.fields("formcol").Value = k
            RS.Update
            
            
            
cnt:
            
            
        Next i
    Next k

    If RS.State = adStateOpen Then RS.Close
    Set RS = Nothing


    Me.MousePointer = 0

Exit Sub

btnSave_Click_ERR:
    Set RS = Nothing
    Me.MousePointer = 0
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "btnSave_Click - Error"

End Sub

Private Sub btnSys_Click()

    Dim k As Integer
    Dim i As Long
    
    
    Dim r1 As Long
    Dim r2 As Long
    Dim c1 As Long
    Dim c2 As Long
    
    For k = 0 To iCols
    
        If chkKks(k).Value = 0 Then GoTo cnt
    
        Me.fgKKS(k).GetSelection r1, c1, r2, c2
    
        For i = r1 To r2
        
            If c1 = Me.fgKKS(k).ColIndex("kksSys") Or c2 = Me.fgKKS(k).ColIndex("kksSys") Then
        
                Me.fgKKS(k).TextMatrix(i, Me.fgKKS(k).ColIndex("kksSys")) = Trim(UCase(txtSys.text)) & Format(Val(Trim(txtSN.text)), "00")
            
            End If
        
        Next i
cnt:
    Next k
    


End Sub

Private Sub chkKks_Click(Index As Integer)

    If chkKks(Index).Value = 1 Then Me.fgKKS(Index).BackColor = &H80000005 Else Me.fgKKS(Index).BackColor = &H8000000F


End Sub

''/******************************************************************************
'Private Sub Command1_Click()
''/******************************************************************************
'
'    On Error GoTo Command1_Click_ERR
'
'    newGrid
'
'Exit Sub
'
'Command1_Click_ERR:
'
'End Sub

Private Sub fgKKS_AfterEdit(Index As Integer, ByVal Row As Long, ByVal Col As Long)

    Dim strSys As String
    Dim strNum As String
    
    strSys = Me.fgKKS(Index).TextMatrix(Row, Me.fgKKS(Index).ColIndex("kksSys"))
    strNum = Format(Val(Me.fgKKS(Index).TextMatrix(Row, Me.fgKKS(Index).ColIndex("kksNum"))), "000")
    
    strSys = Trim(UCase(strSys))

    If Col = Me.fgKKS(Index).ColIndex("kksSys") Then Me.fgKKS(Index).TextMatrix(Row, Me.fgKKS(Index).ColIndex("kksSys")) = strSys
    If Col = Me.fgKKS(Index).ColIndex("kksNum") Then Me.fgKKS(Index).TextMatrix(Row, Me.fgKKS(Index).ColIndex("kksNum")) = strNum

End Sub

'/******************************************************************************
Private Sub fgKKS_AfterRowColChange(Index As Integer, ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long)
'/******************************************************************************

    On Error GoTo fgKKS_AfterRowColChange_ERR


'    Me.fgKKS(Index).ToolTipText =


    Dim strtip As String
    
    strtip = Me.fgKKS(Index).TextMatrix(NewRow, Me.fgKKS(Index).ColIndex("tip"))

    If Len(strtip) > 0 Then
        Set tt = New CBalloonToolTip
        tt.Icon = TTNoIcon
        tt.Title = "Дубликаты KKS в изделиях:"
        tt.PopupOnDemand = False
        'tt.ForeColor = vbBlue
        tt.Style = TTStandard
        tt.TipText = strtip
        tt.VisibleTime = 3000
        tt.DelayTime = 3000
        tt.CreateToolTip Me.hwnd
        tt.Show
    Else
        Set tt = Nothing
    End If




Exit Sub

fgKKS_AfterRowColChange_ERR:

End Sub

Private Sub fgKKS_BeforeEdit(Index As Integer, ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)

    If Col = fgKKS(Index).ColIndex("kksBlock") Then Cancel = True: Exit Sub
    If Col = fgKKS(Index).ColIndex("kksDiv") Then Cancel = True: Exit Sub
    
    If chkKks(Index).Value = 0 Then Cancel = True: Exit Sub

End Sub

Private Sub fgKKS_BeforeRowColChange(Index As Integer, ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long, Cancel As Boolean)

    If NewCol = fgKKS(Index).ColIndex("kksBlock") Then Cancel = True: Exit Sub
    If NewCol = fgKKS(Index).ColIndex("kksDiv") Then Cancel = True: Exit Sub


End Sub

Private Sub fgKKS_BeforeSelChange(Index As Integer, ByVal OldRowSel As Long, ByVal OldColSel As Long, ByVal NewRowSel As Long, ByVal NewColSel As Long, Cancel As Boolean)
    If NewColSel = fgKKS(Index).ColIndex("kksBlock") Then Cancel = True: Exit Sub
    If NewColSel = fgKKS(Index).ColIndex("kksDiv") Then Cancel = True: Exit Sub
    
'    If Abs(NewColSel - OldColSel) > 1 Then Cancel = True: Exit Sub

End Sub

'/******************************************************************************
Private Sub fgKKS_DblClick(Index As Integer)
'/******************************************************************************

    On Error GoTo fgKKS_DblClick_ERR

    If Me.fgKKS(Index).Col = Me.fgKKS(Index).ColIndex("kksSys") Then Me.txtSys.text = left(Me.fgKKS(Index).TextMatrix(Me.fgKKS(Index).Row, Me.fgKKS(Index).ColIndex("kksSys")), 3)
    If Me.fgKKS(Index).Col = Me.fgKKS(Index).ColIndex("kksSys") Then Me.txtSN.text = right(Me.fgKKS(Index).TextMatrix(Me.fgKKS(Index).Row, Me.fgKKS(Index).ColIndex("kksSys")), 2)
    If Me.fgKKS(Index).Col = Me.fgKKS(Index).ColIndex("kksNum") Then Me.txtNum.text = Val(Me.fgKKS(Index).TextMatrix(Me.fgKKS(Index).Row, Me.fgKKS(Index).ColIndex("kksNum")))

Exit Sub

fgKKS_DblClick_ERR:

End Sub

Private Sub fgKKS_LostFocus(Index As Integer)


    Set tt = Nothing

End Sub

'/******************************************************************************
Private Sub Form_Load()
'/******************************************************************************

    On Error GoTo Form_Load_ERR

'    iRows = 40
'    setGrid Me.fgKKS(iGridMaxIndex), 0

    loadSysCombo
    
    newGrid
    newGrid
    newGrid
    newGrid
    newGrid
    newGrid
    newGrid
    newGrid
    newGrid
    newGrid
    
    Me.txtCols.text = GetSetting("Offtake2", "frmPartKks", "txtCols.text", 1)
    Me.txtNum.text = GetSetting("Offtake2", "frmPartKks", "txtNum.text", 1)
    Me.txtRows.text = GetSetting("Offtake2", "frmPartKks", "txtRows.text", 15)
    Me.txtSN.text = GetSetting("Offtake2", "frmPartKks", "txtSN.text", "00")
    Me.txtSys.text = GetSetting("Offtake2", "frmPartKks", "txtSys.text", "")

    DisableCloseButton Me

Exit Sub

Form_Load_ERR:

End Sub

'/******************************************************************************
Public Function setGrid(FG As VSFlexGrid, chk As CheckBox, Optional ind As Integer = 0, Optional bNew As Boolean = True) As Boolean
'/******************************************************************************
    
    On Error GoTo setGrid_ERR
    
    
    FG.cols = 5
    FG.Col = 1
    FG.Rows = iRows
    
    FG.ColHidden(4) = True
    
    FG.Height = FG.Rows * 240 + 50
    
    If bNew Then
        
        FG.ColKey(0) = "kksBlock"
        FG.ColKey(1) = "kksSys"
        FG.ColKey(2) = "kksDiv"
        FG.ColKey(3) = "kksNum"
        FG.ColKey(4) = "tip"
        
        FG.ColWidth(FG.ColIndex("kksBlock")) = 300
        FG.ColWidth(FG.ColIndex("kksSys")) = 700
        FG.ColWidth(FG.ColIndex("kksDiv")) = 400
        FG.ColWidth(FG.ColIndex("kksNum")) = 500
        
        FG.width = FG.ColWidth(FG.ColIndex("kksBlock")) + FG.ColWidth(FG.ColIndex("kksSys")) + FG.ColWidth(FG.ColIndex("kksDiv")) + FG.ColWidth(FG.ColIndex("kksNum"))
        
        FG.Move (FG.width + 50) * ind + 80 + 1700
        FG.Visible = True
        
        chk.Move (FG.width + 50) * ind + 80 + 1700
        chk.Visible = True
        
'        Me.width = (FG.width + 50) * (ind + 1) + 150 + 1700
        
        
    End If
    
    Dim iBlockNum As Integer
    iBlockNum = selectLongFromBase(cn_data, "i_block", "blockNumber", "blockID", lngCurBlockID)
    
    Dim i As Long
    For i = 0 To FG.Rows - 1
        FG.TextMatrix(i, FG.ColIndex("kksBlock")) = iBlockNum
        FG.TextMatrix(i, FG.ColIndex("kksDiv")) = sKksDiv
    Next i
    
    
    
    setGrid = True
    
    Exit Function
    
setGrid_ERR:
    
End Function


'/******************************************************************************
Public Sub newGrid()
'/******************************************************************************

    On Error GoTo newGrid_ERR
    
    Dim iNewIndex As Integer
    
    iNewIndex = iGridMaxIndex + 1
    
    Load Me.fgKKS(iNewIndex)
    Load Me.chkKks(iNewIndex)
    
    setGrid Me.fgKKS(iNewIndex), Me.chkKks(iNewIndex), iNewIndex
    
    
    
    
    

    iGridMaxIndex = iNewIndex

Exit Sub

newGrid_ERR:

End Sub

Private Sub Form_Unload(Cancel As Integer)

    SaveSetting "Offtake2", "frmPartKks", "txtCols.text", Me.txtCols.text
    SaveSetting "Offtake2", "frmPartKks", "txtNum.text", Me.txtNum.text
    SaveSetting "Offtake2", "frmPartKks", "txtRows.text", Me.txtRows.text
    SaveSetting "Offtake2", "frmPartKks", "txtSN.text", Me.txtSN.text
    SaveSetting "Offtake2", "frmPartKks", "txtSys.text", Me.txtSys.text

End Sub

Private Sub txtSys_LostFocus()

    txtSys.text = Trim(UCase(txtSys.text))
    
'    If Len(txtSys.text) = 5 Then
'        btnSys.Enabled = True
'    Else
'        btnSys.Enabled = False
'    End If

End Sub
