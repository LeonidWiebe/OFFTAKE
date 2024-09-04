VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Begin VB.Form frmDocSet 
   Caption         =   "Документы"
   ClientHeight    =   2730
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5550
   Icon            =   "frmDocSet.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2730
   ScaleWidth      =   5550
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton btnSet 
      Caption         =   "Установить"
      Height          =   495
      Left            =   3360
      TabIndex        =   11
      Top             =   2160
      Width           =   2055
   End
   Begin VB.Frame Frame2 
      Caption         =   "Данные комплекта"
      Height          =   1935
      Left            =   720
      TabIndex        =   5
      Top             =   3240
      Width           =   6135
      Begin VB.TextBox txtNum 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   2
         Left            =   3720
         TabIndex        =   8
         Top             =   360
         Width           =   1335
      End
      Begin VB.TextBox txtLev 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   2
         Left            =   1080
         TabIndex        =   7
         Top             =   360
         Width           =   1335
      End
      Begin MSComCtl2.UpDown UpDown2 
         Height          =   285
         Left            =   2415
         TabIndex        =   6
         Top             =   360
         Width           =   240
         _ExtentX        =   423
         _ExtentY        =   503
         _Version        =   393216
         OrigLeft        =   4440
         OrigTop         =   1200
         OrigRight       =   4680
         OrigBottom      =   1695
         Max             =   99
         Wrap            =   -1  'True
         Enabled         =   -1  'True
      End
      Begin MSComCtl2.UpDown UpDown3 
         Height          =   285
         Left            =   5040
         TabIndex        =   12
         Top             =   360
         Width           =   240
         _ExtentX        =   423
         _ExtentY        =   503
         _Version        =   393216
         BuddyControl    =   "txtNum(2)"
         BuddyDispid     =   196611
         BuddyIndex      =   2
         OrigLeft        =   4320
         OrigTop         =   1080
         OrigRight       =   4560
         OrigBottom      =   1575
         Max             =   9999
         SyncBuddy       =   -1  'True
         Wrap            =   -1  'True
         BuddyProperty   =   0
         Enabled         =   -1  'True
      End
      Begin VB.Label Label3 
         Caption         =   "Уровень"
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   10
         Top             =   360
         Width           =   855
      End
      Begin VB.Label Label3 
         Caption         =   "Номер"
         Height          =   255
         Index           =   1
         Left            =   3000
         TabIndex        =   9
         Top             =   360
         Width           =   615
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Установка ссылки на объект"
      Height          =   1935
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5295
      Begin VB.CheckBox chkSet 
         Height          =   255
         Index           =   2
         Left            =   4800
         TabIndex        =   14
         Top             =   1320
         Width           =   255
      End
      Begin VB.ComboBox cmbNum 
         Height          =   315
         Index           =   2
         Left            =   360
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   1320
         Width           =   4215
      End
      Begin VB.ComboBox cmbNum 
         Height          =   315
         Index           =   1
         Left            =   360
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   600
         Width           =   4215
      End
      Begin VB.CheckBox chkSet 
         Height          =   255
         Index           =   1
         Left            =   4800
         TabIndex        =   1
         Top             =   600
         Width           =   255
      End
      Begin VB.Label Label1 
         Caption         =   "Ведомости"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   204
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   360
         TabIndex        =   3
         Top             =   360
         Width           =   1935
      End
      Begin VB.Label Label2 
         Caption         =   "Комплекты чертежей"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   204
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   360
         TabIndex        =   2
         Top             =   1080
         Width           =   2415
      End
   End
End
Attribute VB_Name = "frmDocSet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public bOk As Boolean

Public iPartListID  As Long
Public iDrawingsID  As Long

'/******************************************************************************
Public Function setIDs(plID As Long, drID As Long)
'/******************************************************************************

    On Error GoTo setIDs_ERR
    
    iPartListID = plID
    iDrawingsID = drID
    
    
    cmbNum(1).ListIndex = 0
    cmbNum(2).ListIndex = 0
    
    
    Dim i As Integer
    
    If iPartListID >= 0 Then
        For i = 0 To cmbNum(1).ListCount - 1
            If cmbNum(1).ItemData(i) = iPartListID Then
                cmbNum(1).ListIndex = i
                Exit For
            End If
        Next i
    End If
    
    
    If iDrawingsID >= 0 Then
        For i = 0 To cmbNum(2).ListCount - 1
            If cmbNum(2).ItemData(i) = iDrawingsID Then
                cmbNum(2).ListIndex = i
                Exit For
            End If
        Next i
    End If
    

'    If iDrawingsID > 0 Then
'        txtLev(2).text = selectLongFromBase(cn_data, "docset", "dsLevel", "dsID", iDrawingsID)
'        txtNum(2).text = selectLongFromBase(cn_data, "docset", "dsNum", "dsID", iDrawingsID)
'    End If
    

Exit Function

setIDs_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "setIDs - Error"

End Function


'/******************************************************************************
Private Sub btnSet_Click()
'/******************************************************************************

    On Error GoTo btnSet_Click_ERR
    
    iPartListID = -1
    iDrawingsID = -1
    
    If chkSet(1).Value = 1 Then
        iPartListID = cmbNum(1).ItemData(cmbNum(1).ListIndex)
    End If
    

    If chkSet(2).Value = 1 Then
        iDrawingsID = cmbNum(2).ItemData(cmbNum(2).ListIndex)
    End If

'        iDrawingsID = selectLongFromBase(cn_data, "docset", "dsTypeID", 2, "dsID", "dsNum", CInt(Val(txtNum(2).text)), "dsLevel", CInt(Val(txtLev(2).text)))
'
'        If iDrawingsID = 0 Then
'            iDrawingsID = insertDataInBase(cn_data, "docset", "dsTypeID", 2, "dsNum", CInt(Val(txtNum(2).text)), "dsLevel", CInt(Val(txtLev(2).text)))
'        End If


    bOk = True
    
    Unload Me

Exit Sub

btnSet_Click_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "btnSet_Click - Error"

End Sub

'/******************************************************************************
Private Sub Form_Load()
'/******************************************************************************
    
    On Error GoTo Form_Load_ERR
    
    
    cmbNum(1).AddItem "нет привязки"
    cmbNum(1).ItemData(cmbNum(1).NewIndex) = 0
    
    cmbNum(2).AddItem "нет привязки"
    cmbNum(2).ItemData(cmbNum(2).NewIndex) = 0
    
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from docset where dsNumber is not null order by dsNumber", cn_data, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        
        RS.MoveFirst
        Do
            If RS.fields("projectID").Value = lngCurProjectID Then
                If RS.fields("dsTypeID").Value = dstype.dsPartList Then
                    cmbNum(1).AddItem RS.fields("dsNumber").Value
                    cmbNum(1).ItemData(cmbNum(1).NewIndex) = RS.fields("dsID").Value
                ElseIf RS.fields("dsTypeID").Value = dstype.dsDrawings Then
                    cmbNum(2).AddItem RS.fields("dsNumber").Value
                    cmbNum(2).ItemData(cmbNum(2).NewIndex) = RS.fields("dsID").Value
                Else
                End If
            End If
        
            RS.MoveNext
        Loop Until RS.EOF
        
        
    End If
    
    RS.Close
    Set RS = Nothing
    
    
    Exit Sub
    
Form_Load_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "Form_Load - Error"
    
End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked

End Sub

'Private Sub txtNum_KeyPress(Index As Integer, KeyAscii As Integer)
'
'    Const Numbers$ = "0123456789"
'
'    If KeyAscii <> 8 Then
'        If InStr(Numbers, Chr(KeyAscii)) = 0 Then
'            Beep
'            KeyAscii = 0
'            Exit Sub
'        End If
'    End If
'
'
'End Sub
