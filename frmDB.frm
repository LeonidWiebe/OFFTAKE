VERSION 5.00
Begin VB.Form frmDB 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Подключение к базе данных"
   ClientHeight    =   2295
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6135
   ControlBox      =   0   'False
   Icon            =   "frmDB.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2295
   ScaleWidth      =   6135
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox chkSkipLoadData 
      Caption         =   "skip load data"
      Height          =   255
      Left            =   1320
      TabIndex        =   9
      Top             =   1080
      Width           =   1575
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Выход"
      Height          =   375
      Left            =   120
      TabIndex        =   8
      Top             =   840
      Width           =   855
   End
   Begin VB.CommandButton Command2 
      Height          =   255
      Left            =   3960
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   720
      Width           =   495
   End
   Begin VB.ComboBox cmbServer 
      Height          =   315
      Left            =   1320
      TabIndex        =   6
      Top             =   120
      Width           =   2535
   End
   Begin VB.ComboBox cmbBase 
      Height          =   315
      Left            =   1320
      TabIndex        =   5
      Top             =   480
      Width           =   2535
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Продолжить"
      Default         =   -1  'True
      Height          =   2295
      Left            =   4680
      MouseIcon       =   "frmDB.frx":000C
      MousePointer    =   99  'Custom
      TabIndex        =   3
      Top             =   0
      Width           =   1455
   End
   Begin VB.CheckBox chkRem 
      Caption         =   "использовать в дальнейшем"
      Height          =   255
      Left            =   1320
      TabIndex        =   7
      Top             =   840
      Width           =   2655
   End
   Begin VB.Label lblErr 
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   855
      Left            =   120
      TabIndex        =   4
      Top             =   1500
      Width           =   4335
   End
   Begin VB.Image imgConn 
      Height          =   480
      Left            =   3960
      Picture         =   "frmDB.frx":08D6
      Top             =   120
      Visible         =   0   'False
      Width           =   480
   End
   Begin VB.Image imgDisc 
      Height          =   480
      Left            =   3960
      Picture         =   "frmDB.frx":0D18
      Top             =   120
      Visible         =   0   'False
      Width           =   480
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      Caption         =   "Данные:"
      Height          =   255
      Left            =   -240
      TabIndex        =   1
      Top             =   480
      Width           =   1455
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      Caption         =   "Сервер:"
      Height          =   255
      Left            =   360
      TabIndex        =   0
      Top             =   120
      Width           =   855
   End
End
Attribute VB_Name = "frmDB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public ofcn As ADODB.Connection

Public bFromStart As Boolean

Public sSRVstart As String
Public sDBstart As String

Private Sub chkRem_Click()

    checkConnectionState


End Sub

Private Sub chkSkipLoadData_Click()

    bSkipLoadData = CBool(chkSkipLoadData.Value)

End Sub

'/******************************************************************************
Private Sub Command1_Click()
'/******************************************************************************
    On Error GoTo err

    If bFromStart Or Me.chkRem.Value = 1 Then
        strCurServer = cmbServer.text
        strCurDataBase = cmbBase.text
    End If



    If Me.chkRem.Value = 1 Then
        Call SaveSetting("Offtake2", "Source", "DB_rem", strCurDataBase)
        Call SaveSetting("Offtake2", "Source", "SRV_rem", strCurServer)
    Else
        Call DeleteSetting("Offtake2", "Source", "DB_rem")
        Call DeleteSetting("Offtake2", "Source", "SRV_rem")
    End If
err:
    Unload Me


End Sub

'/******************************************************************************
Private Sub Command2_Click()
'/******************************************************************************

    On Error GoTo Command2_Click_ERR

    
    
    lblErr.Caption = ""
    
    If ofcn Is Nothing Then
    
        Set ofcn = New ADODB.Connection
        
        Me.MousePointer = 11
        
        ofcn.Open "Provider=SQLOLEDB.1;Persist Security Info=False;Timeout=2;User ID=" & conn.strUser & _
                    ";Initial Catalog=" & Trim(cmbBase.text) & ";Data Source=" & Trim(cmbServer.text), conn.strUser, conn.strPass
                    
        Me.MousePointer = 0
    
    Else
    
        If ofcn.State = adStateOpen Then ofcn.Close
        Set ofcn = Nothing

    End If
    
    checkConnectionState
    
    
Exit Sub

Command2_Click_ERR:
    Me.MousePointer = 0
    Me.lblErr = err.Description
    checkConnectionState

End Sub

Private Sub Command3_Click()


bBaseConnected = False
Unload Me

End Sub

''/******************************************************************************
'Public Function cloasAll()
''/******************************************************************************
'
'    On Error GoTo cloasAll_ERR
'
'    If Not cn_data Is Nothing Then
'        If cn_data.State = adStateOpen Then cn_data.Close
'        Set cn_data = Nothing
'    End If
'
'    If Not cn_srtm Is Nothing Then
'        If cn_srtm.State = adStateOpen Then cn_srtm.Close
'        Set cn_srtm = Nothing
'    End If
'
'
'    Exit Function
'
'cloasAll_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "cloasAll - Error"
'
'End Function


Private Sub loadCombo()
On Error GoTo err
    Dim i As Integer
    For i = 0 To UBound(arServers)
        cmbServer.AddItem arServers(i)
    Next i
    
    For i = 0 To UBound(arBases)
        cmbBase.AddItem arBases(i)
    Next i


err:
End Sub



Private Sub Form_Load()
    
    Dim i As Integer
    
   loadCombo
   
    sRememberedDB = GetSetting("Offtake2", "Source", "DB_rem", "")
    sRememberedSRV = GetSetting("Offtake2", "Source", "SRV_rem", "")
   
   
   cmbServer.text = strCurServer
   cmbBase.text = strCurDataBase
   
   sSRVstart = strCurServer
   sDBstart = strCurDataBase
   
   If bSkipLoadData Then chkSkipLoadData.Value = 1
   
   If Not bMainFormLoaded Then bFromStart = True
   
'   If Len(strCurServer) = 0 And Len(sRememberedSRV) > 0 Then
'   cmbServer.text = sRememberedSRV
'   ElseIf Len(strCurServer) = 0 Then
'   cmbServer.text = cmbServer.List(0)
'   Else
'    cmbServer.text = strCurServer
'   End If
'
'
'   If Len(strCurDataBase) = 0 And Len(sRememberedDB) > 0 Then
'   cmbBase.text = sRememberedDB
'   ElseIf Len(strCurDataBase) = 0 Then
'   cmbBase.text = cmbBase.List(0)
'   Else
'    cmbBase.text = strCurDataBase
'   End If
   
   
   If Len(sRememberedSRV) > 0 And Len(sRememberedDB) > 0 Then
    Me.chkRem.Value = 1
   End If

   
    
    
    Command2_Click
    
    
End Sub

'/******************************************************************************
Public Function checkConnectionState()
'/******************************************************************************
    
    On Error GoTo checkConnectionState_ERR
    
    'adStateClosed
    '0
    'Indicates that the object is closed.
    '
    'adStateOpen
    '1
    'Indicates that the object is open.
    '
    'adStateConnecting
    '2
    'Indicates that the object is connecting.
    '
    'adStateExecuting
    '4
    'Indicates that the object is executing a command.
    '
    'adStateFetching
    '8
    'Indicates that the rows of the object are being retrieved.
    
    
    Dim str As String
    If bFromStart Then
        str = "Подлкючение будет произведено:"
    Else
        str = "Подлкючение после перезагрузки:"
    End If
    
    If ofcn Is Nothing Then
        Me.imgConn.Visible = False
        Me.imgDisc.Visible = True
        Me.Command1.Enabled = False
        Me.Command2.Caption = ">>>"
        Me.Command2.ToolTipText = "Установить соединение"
        Me.cmbBase.Enabled = True
        Me.cmbServer.Enabled = True
'        Me.chkRem.Value = 0
'        Me.chkRem.Enabled = False
        bBaseConnected = False
        Me.lblErr.Caption = "Для подключения выберите параметры и нажмите кнопку >>>"
    ElseIf ofcn.State <> adStateOpen Then
        Set ofcn = Nothing
        Me.imgConn.Visible = False
        Me.imgDisc.Visible = True
        Me.Command1.Enabled = False
        Me.Command2.Caption = ">>>"
        Me.Command2.ToolTipText = "Установить соединение"
        Me.cmbBase.Enabled = True
        Me.cmbServer.Enabled = True
'        Me.chkRem.Value = 0
'        Me.chkRem.Enabled = False
        bBaseConnected = False
'        Me.lblErr.Caption = conn.strErrMessage
    Else
        Me.imgConn.Visible = True
        Me.imgDisc.Visible = False
        Me.Command1.Enabled = True
        Me.Command2.Caption = "xxx"
        Me.Command2.ToolTipText = "Разорвать соединение"
        Me.cmbBase.Enabled = False
        Me.cmbServer.Enabled = False
'        Me.chkRem.Enabled = True
        bBaseConnected = True
        If Me.chkRem.Value = 1 Then
            Me.lblErr.Caption = str & vbNewLine & "own: " & cmbServer.text & " : " & cmbBase.text & vbNewLine & _
                "pw : " & pwset.server & " : " & pwset.database & vbNewLine & _
                "sim: " & strCurSimBase
        Else
            Me.lblErr.Caption = str & vbNewLine & "own: " & strCurServer & " : " & strCurDataBase & vbNewLine & _
                "pw : " & pwset.server & " : " & pwset.database & vbNewLine & _
                "sim: " & strCurSimBase
        End If
    End If
    
    
'    If bMainFormLoaded Then
'        F1.SB.Panels("prov").text = conn.strProvStatus
'
'        If StrComp(conn.strSrtmName, conn.strBaseName, vbTextCompare) = 0 Then
'            F1.SB.Panels("srv").text = conn.strServerName & " : " & conn.strBaseName & "  "
'        Else
'            F1.SB.Panels("srv").text = conn.strServerName & " srtm: " & conn.strSrtmName & " data: " & conn.strBaseName & "  "
'        End If
'
'        F1.SB.Panels("srv").AutoSize = sbrContents
'    End If
    
    
    Exit Function
    
checkConnectionState_ERR:
    
End Function





'/******************************************************************************
Private Sub Form_Unload(Cancel As Integer)
'/******************************************************************************

    On Error GoTo Form_Unload_ERR
    
    If Not bFromStart And (StrComp(sSRVstart, strCurServer, vbTextCompare) <> 0 Or StrComp(sDBstart, strCurDataBase, vbTextCompare) <> 0) Then
        MsgBox "   Для изменения источника данных необходимо перезагрузить Offtake   ", vbInformation, ""
    End If

    If ofcn.State = adStateOpen Then
        ofcn.Close
    End If
    
    Set ofcn = Nothing

Exit Sub

Form_Unload_ERR:
    Set ofcn = Nothing

End Sub

