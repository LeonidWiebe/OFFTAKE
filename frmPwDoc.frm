VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmPwDoc 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "ProjectWise Reference Explorer"
   ClientHeight    =   10275
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   17910
   Icon            =   "frmPwDoc.frx":0000
   LinkTopic       =   "frmPwDoc"
   MaxButton       =   0   'False
   ScaleHeight     =   10275
   ScaleWidth      =   17910
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   10920
      Top             =   240
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPwDoc.frx":0E42
            Key             =   "aecosim"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPwDoc.frx":1194
            Key             =   "model"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPwDoc.frx":14E6
            Key             =   "ref"
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Clear Tree Colors"
      Height          =   375
      Left            =   13920
      TabIndex        =   10
      Top             =   600
      Width           =   1935
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Save"
      Height          =   375
      Left            =   16320
      TabIndex        =   6
      Top             =   600
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Fill List"
      Height          =   375
      Left            =   12480
      TabIndex        =   5
      Top             =   600
      Width           =   1335
   End
   Begin VB.ListBox List1 
      Height          =   9030
      Left            =   12480
      Sorted          =   -1  'True
      TabIndex        =   4
      Top             =   1080
      Width           =   5295
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Reload Root Node"
      Height          =   375
      Left            =   6000
      TabIndex        =   3
      Top             =   480
      Width           =   1935
   End
   Begin VB.TextBox Text2 
      BackColor       =   &H8000000F&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   9000
      Locked          =   -1  'True
      TabIndex        =   2
      Top             =   480
      Width           =   975
   End
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Text            =   "6527c210-b19c-41f6-953b-f0dcce6d8ca5"
      Top             =   480
      Width           =   5655
   End
   Begin MSComctlLib.TreeView TreeView1 
      Height          =   9015
      Left            =   120
      TabIndex        =   0
      Top             =   1080
      Width           =   12135
      _ExtentX        =   21405
      _ExtentY        =   15901
      _Version        =   393217
      Indentation     =   706
      LabelEdit       =   1
      LineStyle       =   1
      Style           =   7
      ImageList       =   "ImageList1"
      Appearance      =   1
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      Caption         =   "Depth"
      Height          =   255
      Left            =   7800
      TabIndex        =   9
      Top             =   600
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   "Root Item"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   240
      Width           =   3615
   End
   Begin VB.Label Label1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   204
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   12480
      TabIndex        =   7
      Top             =   120
      Width           =   1935
   End
End
Attribute VB_Name = "frmPwDoc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public cn As ADODB.Connection

Dim Col As New Collection

'SELECT TOP 1000 [o_refelemid]
'      ,[o_masterguid]
'      ,[o_mastermodelid]
'      ,[o_referenceguid]
'      ,[o_referencemodelid]
'      ,[o_referencetype]
'      ,[o_nestdepth]
'      ,[o_flags]
'  FROM [PW_AEP].[dbo].[dms_refinfo] where o_masterguid=  '6527c210-b19c-41f6-953b-f0dcce6d8ca5'


Function addTreeNode(parKey As String, rel As TreeRelationshipConstants, chKey As String, itname As String) As Node

    On Error GoTo err
    
    Dim nd As Node
    
    If parKey = "" And rel = 0 Then
        Set nd = Me.TreeView1.Nodes.Add(, , chKey, itname)
    Else
        Set nd = Me.TreeView1.Nodes.Add(parKey, rel, chKey, itname)
    End If
    
    If Not nd Is Nothing Then
        log nd.KEY
    End If
    
    Set addTreeNode = nd
    
    Exit Function
    
err:
    

End Function


'/******************************************************************************
Public Sub addToCol(sVal As String, sKey As String)
'/******************************************************************************

    On Error GoTo addToCol_ERR
    
    Col.Add sVal, sKey
    
    Label1.Caption = Col.Count & " items"

Exit Sub

addToCol_ERR:

End Sub


'/******************************************************************************
Public Sub Command1_Click()
'/******************************************************************************

    On Error GoTo Command1_Click_ERR

    Command1.Enabled = False
    
    Set Col = New Collection
    Me.Label1.Caption = ""

    TreeView1.Nodes.Clear

'    sConnString = "Provider=SQLOLEDB;Persist Security Info=False;Timeout=5;User ID=sa;Initial Catalog=" & Trim(Text4.Text) & ";Data Source=" & Trim(Text3.Text)
'    sConnString = "Provider=SQLOLEDB;Persist Security Info=False;Timeout=5;Integrated Security=SSPI;Initial Catalog=" & Trim(Text4.text) & ";Data Source=" & Trim(Text3.text)
    
    If Not cn Is Nothing Then
        If cn.State = adStateOpen Then cn.Close
    End If

    Set cn = New ADODB.Connection
'
''    cn.Open sConnString, sUser, sPass
'    cn.Open sConnString

    cn.Open pwset.constring, pwset.login, pwset.login






    Dim masterguid As String
    Dim refguid As String
    
    Dim itname As String
       
    Dim imastermodelid As Integer
    Dim irefmodelid As Integer
       
    Dim idepth As Integer
    
    Dim RS As New ADODB.Recordset
    
    Dim nd As Node
    
    RS.Open "select o_docguid, o_itemname from dms_doc where o_docguid = '" & Trim(Text1.text) & "'", cn, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
    
        RS.MoveFirst
        Do
        
            itname = RS.fields("o_itemname").Value & ""
            masterguid = RS.fields("o_docguid").Value & ""
            
            
            Set nd = addTreeNode("", 0, "file_" & masterguid & "_0", itname)
            
            If Not nd Is Nothing Then
                nd.Tag = -1
                Set nd = addTreeNode("file_" & masterguid & "_0", tvwChild, "file_" & masterguid & "_0" & "#", "")
                addToCol itname, masterguid
                'SaveSetting "pwloop", "main", "guid", Trim(Text1.text)
            End If
            
    
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    
    RS.Close
    Set RS = Nothing
    
    Command1.Enabled = True
    
    If TreeView1.Nodes.Count > 0 Then
        TreeView1.Nodes(1).Expanded = True
        TreeView1.Nodes(1).Image = "aecosim"
    End If


Exit Sub

Command1_Click_ERR:
    Command1.Enabled = True
    MsgBox err.Description

End Sub

'/******************************************************************************
Private Sub Command2_Click()
'/******************************************************************************

    On Error GoTo Command2_Click_ERR

    Dim str As Variant
    
    
    List1.Clear
    
    For Each str In Col
    
        Me.List1.AddItem str
    
    Next
    
    
    

Exit Sub

Command2_Click_ERR:

End Sub

'/******************************************************************************
Private Sub Command3_Click()
'/******************************************************************************

    On Error GoTo Command3_Click_ERR

'    If List1.ListCount = 0 Then Exit Sub
'
'    Dim str As Variant
'
'    Dim fn As Integer
'    Dim I As Long
'    fn = FreeFile
'
'    Open App.Path & "\list.txt" For Output As fn
'
'    For I = 0 To List1.ListCount - 1
'
'        Print #fn, List1.List(I)
'
'    Next
'
'    Close fn

Exit Sub

Command3_Click_ERR:

End Sub

'/******************************************************************************
Private Sub Command4_Click()
'/******************************************************************************

    On Error GoTo Command4_Click_ERR

    Dim i As Long
    
    For i = 1 To TreeView1.Nodes.Count
        
        TreeView1.Nodes(i).bOld = False
        TreeView1.Nodes(i).ForeColor = &H80000008
        TreeView1.Nodes(i).BackColor = &H80000005
    
    Next i


Exit Sub

Command4_Click_ERR:

End Sub

'/******************************************************************************
Private Sub Form_Load()
'/******************************************************************************

    On Error GoTo Form_Load_ERR

    Me.Caption = "ProjectWise Link Explorer"
    
    'Text1.text = GetSetting("pwloop", "main", "guid", Text1.text)

    'Command1_Click


Exit Sub

Form_Load_ERR:

End Sub



'/******************************************************************************
Public Sub loadWiseTreeNode(nd As Node, bModels As Boolean, Optional bLoadExpandSettings As Boolean = True)
'/******************************************************************************
    
    
    On Error GoTo Form_Load_ERR
    
    
    
    Dim sNow As String
    
    
    Dim i As Integer
    
    Dim masterguid As String
    Dim refguid As String
    
    Dim itname As String
    Dim modname As String
    
    Dim imastermodelid As Integer
    Dim irefmodelid As Integer
    
    Dim irefelemid As Long
    
    Dim ar0() As String
    Dim ar() As String
    Dim strSQL As String
    
    Dim idepth As Integer
    Dim irdepth As Integer
    
    Dim RS As New ADODB.Recordset
    
    Dim ndd As Node
    
    
    Randomize
    sNow = CStr(Int(1000000000# * Rnd))
    
    
    If left(nd.KEY, 4) = "file" And bModels Then
        
        ar = Split(nd.KEY, "_")
        
        masterguid = ar(1)
        
'        strSQL = "select * from dms_refinfo where o_masterguid = '" & masterguid & "'"

        strSQL = "select dms_refinfo.*, dms_modelinfo.o_modelname as mname from dms_refinfo"
        strSQL = strSQL & " inner join dms_modelinfo"
        strSQL = strSQL & " on dms_modelinfo.o_docguid = dms_refinfo.o_masterguid"
        strSQL = strSQL & " and dms_modelinfo.o_modelid = dms_refinfo.o_mastermodelid"
        strSQL = strSQL & " where o_masterguid = '" & masterguid & "'"
        
        RS.Open strSQL, cn, adOpenForwardOnly, adLockReadOnly
        
        If Not RS.EOF Then
            
            RS.MoveFirst
            Do
                
                imastermodelid = RS.fields("o_mastermodelid").Value
                irefelemid = 0 ' RS.fields("o_refelemid").Value
                modname = RS.fields("mname").Value
                
                
                Set ndd = addTreeNode(nd.KEY, tvwChild, "model_" & masterguid & "_" & imastermodelid, modname)
                If Not ndd Is Nothing Then
                    ndd.Image = "model"
                    ndd.Tag = -1
                    Set ndd = addTreeNode("model_" & masterguid & "_" & imastermodelid, tvwChild, "model_" & masterguid & "_" & imastermodelid & "+", "")
                End If
                
'                If ndd Is Nothing Then Me.BackColor = &HC0C0FF
                
                RS.MoveNext
            Loop Until RS.EOF
        End If
        
        

    ElseIf left(nd.KEY, 5) = "model" Or (left(nd.KEY, 4) = "file" And Not bModels) Then
    
        If nd.Tag = 0 Then Exit Sub
        
        ar0 = Split(nd.KEY, " \ ")
        
        If UBound(ar0) < 0 Then Exit Sub
        
        ar = Split(ar0(UBound(ar0)), "_")
    
        If UBound(ar) < 2 Then Exit Sub
    
        masterguid = ar(1)
        imastermodelid = Val(ar(2))
        
        strSQL = "select dms_refinfo.*, dms_doc.o_itemname as itname from dms_refinfo"
        strSQL = strSQL & " inner join dms_doc on dms_doc.o_docguid=dms_refinfo.o_referenceguid"
        strSQL = strSQL & " where dms_refinfo.o_masterguid = '" & masterguid & "'"
        strSQL = strSQL & " and dms_refinfo.o_mastermodelid = " & imastermodelid
    
        RS.Open strSQL, cn, adOpenForwardOnly, adLockReadOnly

        If Not RS.EOF Then

            RS.MoveFirst
            Do

                itname = RS.fields("itname").Value & ""
                masterguid = RS.fields("o_masterguid").Value & ""
                refguid = RS.fields("o_referenceguid").Value & ""
                imastermodelid = RS.fields("o_mastermodelid").Value
                irefmodelid = RS.fields("o_referencemodelid").Value
                idepth = RS.fields("o_nestdepth").Value
                irefelemid = 0 ' RS.fields("o_refelemid").Value

                
                If Val(nd.Tag) >= 0 Then
                    irdepth = nd.Tag - 1
                Else
                    irdepth = idepth
                End If
                
                If irdepth > idepth Then irdepth = idepth
                
                Dim strFileKey As String
                strFileKey = "file_" & refguid & "_" & irefmodelid  '  "file_" & refguid & "_" & irefmodelid & "_" & irefelemid

                Set ndd = addTreeNode(nd.KEY, tvwChild, _
                        nd.KEY & " \ " & strFileKey, itname & " [" & idepth & "]")
                        
                If Not ndd Is Nothing Then
                
                    ndd.Image = "ref"
                
                    Dim bEx As Boolean
                    Dim Arr() As String
                    Arr = Split(nd.KEY, " \ ")
                    bEx = False
                    For i = 0 To UBound(Arr)
                        If Arr(i) = strFileKey Then
                            bEx = True
                            ndd.BackColor = &HFFFF&
                        End If
                    Next i
                
                    ndd.Tag = irdepth
                    
                    If irdepth > 0 And bEx = False Then
                        Set ndd = addTreeNode( _
                            nd.KEY & " \ " & strFileKey, _
                            tvwChild, _
                            nd.KEY & " \ " & strFileKey & "+", "")
                    End If
                    
                    addToCol itname, refguid
                    
                End If

'                If ndd Is Nothing Then Me.BackColor = &HC0C0FF


                RS.MoveNext
            Loop Until RS.EOF
        End If
    
    
    Else
    End If
    
    
    
    
    RS.Close
    Set RS = Nothing
    
    
    

    
    Exit Sub
    
Form_Load_ERR:
Me.BackColor = &HFF&
    
End Sub

Public Sub log(what As String)

On Error GoTo err

Dim fn As Integer

fn = FreeFile

Open App.Path & "\__pw_doc_log.txt" For Append As fn

Print #fn, Replace(what, "-", "")

Close fn



Exit Sub
err:


End Sub



'/******************************************************************************
Private Sub Form_Unload(Cancel As Integer)
'/******************************************************************************

    On Error GoTo Form_Unload_ERR


    If frmPwDoc.cn.State = adStateOpen Then
        cn.Close
    End If

    
    Set cn = Nothing


Exit Sub

Form_Unload_ERR:

End Sub

'/******************************************************************************
Private Sub List1_DblClick()
'/******************************************************************************

    On Error GoTo List1_DblClick_ERR

    Dim i As Long
    
    For i = 1 To TreeView1.Nodes.Count
        
        TreeView1.Nodes(i).bOld = False
        TreeView1.Nodes(i).ForeColor = &H80000008
        TreeView1.Nodes(i).Expanded = False
        
        If left(TreeView1.Nodes(i).text, Len(Me.List1.text)) = Me.List1.text Then
            TreeView1.Nodes(i).bOld = True
            TreeView1.Nodes(i).ForeColor = &HFF0000
            TreeView1.Nodes(i).BackColor = &H8000000F
            TreeView1.Nodes(i).Expanded = True
            TreeView1.Nodes(i).EnsureVisible
        End If
    
    Next i


Exit Sub

List1_DblClick_ERR:

End Sub

'/******************************************************************************
Private Sub Text1_DblClick()
'/******************************************************************************


    On Error GoTo Text1_DblClick_ERR
    
    'Text1.text = GetSetting("pwloop", "main", "guid", Text1.text)


Exit Sub

Text1_DblClick_ERR:

End Sub

'/******************************************************************************
Private Sub TreeView1_Expand(ByVal nd As MSComctlLib.Node)
'/******************************************************************************
    
    On Error GoTo TreeView1_Expand_ERR
    
'    Dim ar() As String
'    ar = Split(nd.FullPath, "\")
'
'    If UBound(ar) > 10 Then Exit Sub
    
    If right(nd.Child.KEY, 1) = "#" Then
        TreeView1.Visible = False
        TreeView1.Nodes.Remove nd.Child.KEY
        loadWiseTreeNode nd, True
        TreeView1.Visible = True
    ElseIf right(nd.Child.KEY, 1) = "+" Then
        TreeView1.Visible = False
        TreeView1.Nodes.Remove nd.Child.KEY
        loadWiseTreeNode nd, False
        TreeView1.Visible = True
    End If
    
    
    
    Exit Sub
    
TreeView1_Expand_ERR:
    TreeView1.Visible = True
    
End Sub

'/******************************************************************************
Private Sub TreeView1_NodeClick(ByVal Node As MSComctlLib.Node)
'/******************************************************************************

    On Error GoTo TreeView1_NodeClick_ERR


    Me.Text2.text = Node.Tag

Exit Sub

TreeView1_NodeClick_ERR:

End Sub
