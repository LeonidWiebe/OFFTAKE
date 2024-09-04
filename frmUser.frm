VERSION 5.00
Begin VB.Form frmUser 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Пользователь"
   ClientHeight    =   4185
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3525
   Icon            =   "frmUser.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4185
   ScaleWidth      =   3525
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command3 
      Caption         =   "x"
      Height          =   255
      Left            =   2520
      TabIndex        =   9
      Top             =   840
      Width           =   375
   End
   Begin VB.TextBox txtLogin 
      Height          =   285
      Left            =   120
      TabIndex        =   8
      Top             =   840
      Width           =   2295
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Отмена"
      Height          =   375
      Left            =   120
      TabIndex        =   5
      Top             =   3720
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Default         =   -1  'True
      Enabled         =   0   'False
      Height          =   375
      Left            =   1440
      TabIndex        =   4
      Top             =   3720
      Width           =   1935
   End
   Begin VB.ComboBox cmbDep 
      Height          =   315
      Left            =   960
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Top             =   3240
      Width           =   2415
   End
   Begin VB.TextBox txtO 
      Height          =   285
      Left            =   960
      TabIndex        =   2
      Top             =   2880
      Width           =   2415
   End
   Begin VB.TextBox txtI 
      Height          =   285
      Left            =   960
      TabIndex        =   1
      Top             =   2520
      Width           =   2415
   End
   Begin VB.TextBox txtF 
      Height          =   285
      Left            =   960
      TabIndex        =   0
      Top             =   2160
      Width           =   2415
   End
   Begin VB.Label Label6 
      Caption         =   "Отдел"
      Height          =   255
      Left            =   120
      TabIndex        =   13
      Top             =   3240
      Width           =   735
   End
   Begin VB.Label Label5 
      Caption         =   "Отчество"
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   2880
      Width           =   735
   End
   Begin VB.Label Label4 
      Caption         =   "Имя"
      Height          =   255
      Left            =   120
      TabIndex        =   11
      Top             =   2520
      Width           =   735
   End
   Begin VB.Label Label3 
      Caption         =   "Фамилия"
      Height          =   255
      Left            =   120
      TabIndex        =   10
      Top             =   2160
      Width           =   735
   End
   Begin VB.Label Label2 
      Caption         =   "Если Вы работали ранее в Offtake, введите Ваш предыдущий логин Windows чтобы использовать его данные"
      Height          =   615
      Left            =   120
      TabIndex        =   7
      Top             =   120
      Width           =   3255
   End
   Begin VB.Label Label1 
      Caption         =   $"frmUser.frx":000C
      Height          =   855
      Left            =   120
      TabIndex        =   6
      Top             =   1250
      Width           =   3255
   End
End
Attribute VB_Name = "frmUser"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public bOk As Boolean
Public depID As Long
Public userID As Long


'/******************************************************************************
Private Sub cmbDep_Change()
'/******************************************************************************
    
    If cmbDep.ListIndex >= 0 Then
        
        depID = cmbDep.ItemData(cmbDep.ListIndex)
        usrCurrent.depID = depID
        
    End If
    
    Me.Command1.Enabled = enab
    
    
End Sub

Private Sub cmbDep_Click()
cmbDep_Change
End Sub

Private Sub Command1_Click()

bOk = True
Unload Me

End Sub

Private Sub Command2_Click()

Unload Me
End Sub

Private Sub Command3_Click()

    Me.txtLogin.text = ""
    Me.txtLogin.Locked = False
    Me.txtLogin.BackColor = &H80000005
    Me.userID = 0


End Sub

Private Sub Form_Load()

    On Error GoTo err
    
    
    Dim RS As New ADODB.Recordset
    
    Me.Caption = "Ваш логин: " & usrCurrent.strLogin
    
    
    cmbDep.AddItem "не определено"
    cmbDep.ItemData(cmbDep.NewIndex) = 0
    
    RS.Open "select * from department", cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        
        RS.MoveFirst
        Do
            cmbDep.AddItem RS.fields("depName").Value
            cmbDep.ItemData(cmbDep.NewIndex) = RS.fields("depID").Value
            
            RS.MoveNext
        Loop Until RS.EOF
        
        
    End If
    
    RS.Close
    Set RS = Nothing
    
    bOk = False
    
    
    cmbDep.ListIndex = 0
    
    
    If pwset.connected Then
        Dim strFIO As String
        Dim cnpw As New ADODB.Connection
        cnpw.Open pwset.constring, pwset.login, pwset.login
            
        Dim RSS As New ADODB.Recordset
        RSS.Open "select * from dms_user where o_username = '" & usrCurrent.strLogin & "'", cnpw, adOpenStatic, adLockReadOnly
        
        If Not RSS.EOF Then
            RSS.MoveFirst
            Do
                strFIO = RSS.fields("o_userdesc").Value & ""
                If Len(Trim(strFIO)) > 0 Then
                    Exit Do
                End If
                RS.MoveNext
            Loop Until RS.EOF
        End If
        
        RSS.Close
        Set RSS = Nothing
            
        cnpw.Close
        Set cnpw = Nothing
        
        
        'strFIO = "Кукушкин"
        
        Dim ar() As String
        If Len(Trim(strFIO)) > 0 Then
            ar = Split(strFIO, " ")
            If UBound(ar) > -1 Then txtF.text = ar(0)
            If UBound(ar) > 0 Then txtI.text = ar(1)
            If UBound(ar) > 1 Then txtO.text = ar(2)
        End If
    End If
    
    
    
    
'    usrCurrent.strFIO(1) = Trim(txtF.text)
'    usrCurrent.strFIO(2) = Trim(txtI.text)
'    usrCurrent.strFIO(3) = Trim(txtO.text)
    
    Exit Sub
err:
    Set RS = Nothing
    
    
    
End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, True

End Sub

'/******************************************************************************
Private Sub txtF_Change()
'/******************************************************************************

usrCurrent.strFIO(1) = Trim(txtF.text)
Me.Command1.Enabled = enab

End Sub

'/******************************************************************************
Private Function enab() As Boolean
'/******************************************************************************
    
    enab = True
    
    If Len(usrCurrent.strFIO(1)) = 0 Then enab = False
    If Len(usrCurrent.strFIO(2)) = 0 Then enab = False
'    If depID = 0 Then enab = False
    
    
End Function

Private Sub txtI_Change()
    usrCurrent.strFIO(2) = Trim(txtI.text)

    Me.Command1.Enabled = enab
End Sub

Private Sub txtLogin_Change()
On Error GoTo err

    
    If Len(Trim(txtLogin.text)) = 0 Then Exit Sub
    
    Dim RS As New ADODB.Recordset
    
    Dim deprtID As Long
    
    
    RS.Open "select * from usr where usrLogin = '" & txtLogin.text & "'", cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        
        RS.MoveFirst
        
        Me.txtF.text = RS.fields("usrFName").Value & ""
        Me.txtI.text = RS.fields("usrName").Value & ""
        Me.txtO.text = RS.fields("usrOName").Value & ""
        deprtID = RS.fields("depID").Value
        userID = RS.fields("usrID").Value
        
        Dim i As Integer
        For i = 0 To cmbDep.ListCount - 1
            If cmbDep.ItemData(i) = deprtID Then
                cmbDep.ListIndex = i
                depID = deprtID
                txtLogin.Locked = True
                txtLogin.BackColor = &HC0FFC0
                Exit For
            End If
        Next i
        
        
        
        
    End If



Exit Sub
err:


End Sub

Private Sub txtO_Change()
usrCurrent.strFIO(3) = Trim(txtO.text)
Me.Command1.Enabled = enab

End Sub
