VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Begin VB.Form frmAccess 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "ƒоступ"
   ClientHeight    =   3225
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5505
   Icon            =   "frmAccess.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3225
   ScaleWidth      =   5505
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.CheckBox chkChildren 
      Caption         =   "применить ко всем подкаталогам"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   2760
      Width           =   4095
   End
   Begin VB.CheckBox Check1 
      Caption         =   "каталог открыт дл€ всех пользователей без ограничени€"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   2400
      Width           =   5175
   End
   Begin VB.CommandButton Command1 
      Caption         =   "ќ "
      Height          =   375
      Left            =   4440
      TabIndex        =   1
      Top             =   2760
      Width           =   975
   End
   Begin VSFlex8Ctl.VSFlexGrid fgUsers 
      Height          =   1935
      Left            =   120
      TabIndex        =   0
      Top             =   360
      Width           =   5295
      _cx             =   75834492
      _cy             =   75828565
      Appearance      =   3
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
      SheetBorder     =   -2147483632
      FocusRect       =   3
      HighLight       =   0
      AllowSelection  =   0   'False
      AllowBigSelection=   0   'False
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   2
      Cols            =   10
      FixedRows       =   0
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
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
   Begin VB.Label Label1 
      Caption         =   "ѕравка содержимого каталога доступна пользовател€м:"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   4815
   End
   Begin VB.Menu mnuPopup 
      Caption         =   "mnuPopup"
      Visible         =   0   'False
      Begin VB.Menu mnuPopoupDelete 
         Caption         =   "”далить"
      End
   End
End
Attribute VB_Name = "frmAccess"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public cat As clsCat


Public bChanged As Boolean

'/******************************************************************************
Public Sub loadGrid(catID As Long)
'/******************************************************************************
    
    On Error GoTo loadGrid_ERR
    
    Set cat = cCats(CStr(catID))
    
    
    
    
    Me.Check1.Value = Abs(CInt(cat.bOpen))
    
    Dim RS As New ADODB.Recordset
    RS.Open "select relID, usrID, usrLogin from view_r_usr_catalog where catID = " & catID, cn_data, adOpenStatic, adLockReadOnly
    
    Set fgUsers.DataSource = RS
    
    
    fgUsers.AddItem 0 & vbTab & 0 & vbTab & ""
    
    Me.fgUsers.ColHidden(0) = True
    Me.fgUsers.ColHidden(1) = True
    
    RS.NextRecordset
    
    RS.Open "select usrID, usrLogin, usrFName, usrName, depName from view_usr order by depID,usrLogin", cn_srtm, adOpenStatic, adLockReadOnly
    
    
    Dim s As String
    
    s = fgUsers.BuildComboList(RS, "*usrLogin,usrFName,usrName,depName", "usrID")
    
    fgUsers.ColComboList(2) = s
    
    RS.Close
    Set RS = Nothing
    
    
    
    Exit Sub
    
loadGrid_ERR:
    Set RS = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadGrid - Error"
    
End Sub





Private Sub Check1_Click()
    bChanged = True
End Sub

'/******************************************************************************
Private Function updateCatInfo(cat As clsCat, isOpen As Integer) As Boolean
'/******************************************************************************

    On Error GoTo updateCatInfo_ERR

    Dim nd As Node

    If updateTableInBase(cn_data, "i_catalog", "catOpen", isOpen, "catID", cat.catID) Then
    
        cat.bOpen = CBool(isOpen)
        
        Set nd = tvGetTreeNode(F1.tvCats, "catalog" & cat.catID)
        If Not nd Is Nothing Then nd.Image = cat.getTreeNodeImage
        
        If cat.bOpen Then
            Call writeOperationS(operModify, "catalog", cat.catID, "открыт общий доступ")
        Else
            Call writeOperationS(operModify, "catalog", cat.catID, "закрыт общий доступ")
        End If
    End If
    
    

    
    Dim iRecordsAffected As Integer
    Dim cmd As New ADODB.Command
    cmd.ActiveConnection = cn_data
    cmd.CommandText = "delete from [r_usr_catalog] where catID = " & cat.catID
    cmd.Execute iRecordsAffected
    
    
    Dim I As Long
    Dim usrID As Long
    
    For I = 0 To Me.fgUsers.Rows - 1
        usrID = Val(fgUsers.TextMatrix(I, 1))
        If usrID > 0 And selectLongFromBase(cn_data, "r_usr_catalog", "relID", "usrID", usrID, "catID", cat.catID) = 0 Then
            If insertDataInBase(cn_data, "r_usr_catalog", "usrID", usrID, "catID", cat.catID) > 0 Then
                Call writeOperationS(operModify, "catalog", cat.catID, "добавлен доступ дл€ пользовател€ " & fgUsers.TextMatrix(I, 2))
            End If
        End If
    Next I
    
    






Exit Function

updateCatInfo_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "updateCatInfo - Error"

End Function



'/******************************************************************************
Private Sub Command1_Click()
'/******************************************************************************

    On Error GoTo Command1_Click_ERR


    Dim nd As Node
    Dim ndc As Node
    Dim ndx As Node
    Dim sSuf As String
    Dim I As Integer
    Dim catID As Long
    
    Dim catchild As clsCat
    
    F1.PB.Min = 0

    If bChanged Then
    
        ' главный каталог
    
        Call updateCatInfo(cat, Me.Check1.Value)
        
        Set nd = tvGetTreeNode(F1.tvCats, "catalog" & cat.catID)
    
        ' подкаталоги
    
        If Me.chkChildren.Value = 1 And Not nd Is Nothing Then
        
            If nd.children > 5 Then F1.PB.Min = 0
            If nd.children > 5 Then F1.PB.Max = nd.children
        
            If nd.children > 0 Then
                
                Set ndx = nd.Child.FirstSibling
                
                For I = 1 To nd.children
                
                    If (left(ndx.Tag, Len("catalog"))) = "catalog" Then
                    
                        catID = Val(right(ndx.KEY, Len(ndx.KEY) - Len("catalog")))
                        
                        Set catchild = cCats(CStr(catID))
                        
                        Call updateCatInfo(catchild, Me.Check1.Value)
                        
                        If nd.children > 5 Then F1.PB.Value = I
                        
                    End If
                    
                    Set ndx = ndx.Next
                Next
            End If
        
        
        End If
    
    End If
    
    F1.PB.Value = 0

    Unload Me

Exit Sub

Command1_Click_ERR:
    F1.PB.Value = 0
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "Command1_Click - Error"

End Sub

'/******************************************************************************
Private Sub fgUsers_AfterEdit(ByVal Row As Long, ByVal Col As Long)
'/******************************************************************************

    On Error GoTo fgUsers_AfterEdit_ERR

    Dim usrID As Long

    usrID = Val(fgUsers.ComboData(fgUsers.ComboIndex))
    If usrID = 0 Then Exit Sub
    
    If fgUsers.TextMatrix(Row, 2) = "" Then Exit Sub
    
'    If selectLongFromBase(cn_data, "r_usr_catalog", "relID", "usrID", usrID, "catID", cat.catID) > 0 Then
'        fgUsers.TextMatrix(Row, 0) = 0
'        fgUsers.TextMatrix(Row, 1) = 0
'        fgUsers.TextMatrix(Row, 2) = ""
'        Exit Sub
'    End If

    fgUsers.TextMatrix(Row, 0) = selectLongFromBase(cn_data, "r_usr_catalog", "relID", "usrID", usrID, "catID", cat.catID)
    fgUsers.TextMatrix(Row, 1) = usrID

    If Row = fgUsers.Rows - 1 Then
        fgUsers.AddItem 0 & vbTab & 0 & vbTab & ""
    End If

    bChanged = True
    
    
    
Exit Sub

fgUsers_AfterEdit_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "fgUsers_AfterEdit - Error"

End Sub

Private Sub fgUsers_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)

'    If Val(fgUsers.TextMatrix(Row, 0)) > 0 Then Cancel = True ' редактируем только нижнюю строку

End Sub

'/******************************************************************************
Private Sub fgUsers_KeyDown(KeyCode As Integer, Shift As Integer)
'/******************************************************************************

    On Error GoTo fgUsers_KeyDown_ERR

    If KeyCode = 46 Then
    
        Dim ID As Long
        ID = fgUsers.TextMatrix(fgUsers.Row, 0)
        
        If ID = 0 Then Exit Sub
        
        fgUsers.RemoveItem fgUsers.Row
    
    End If



Exit Sub

fgUsers_KeyDown_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "fgUsers_KeyDown - Error"

End Sub

'Private Sub fgUsers_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'
'If Button = 2 Then
'    Me.PopupMenu mnuPopup
'End If
'
'End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked

End Sub
