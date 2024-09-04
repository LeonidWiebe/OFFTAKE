VERSION 5.00
Object = "{0AFE7BE0-11B7-4A3E-978D-D4501E9A57FE}#1.0#0"; "C1Sizer.ocx"
Object = "{05BFD3F1-6319-4F30-B752-C7A22889BCC4}#1.0#0"; "AcroPDF.dll"
Begin VB.Form frmPartImage 
   Caption         =   "Изображение"
   ClientHeight    =   6450
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7905
   Icon            =   "frmPartImage.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6450
   ScaleWidth      =   7905
   StartUpPosition =   3  'Windows Default
   Begin C1SizerLibCtl.C1Elastic C1Elastic1 
      Height          =   6450
      Left            =   0
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   0
      Width           =   7905
      _cx             =   13944
      _cy             =   11377
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
      Appearance      =   5
      MousePointer    =   0
      Version         =   801
      BackColor       =   -2147483633
      ForeColor       =   -2147483630
      FloodColor      =   6553600
      ForeColorDisabled=   -2147483631
      Caption         =   ""
      Align           =   5
      AutoSizeChildren=   1
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
      Begin AcroPDFLibCtl.AcroPDF AcroPDF1 
         Height          =   6270
         Left            =   90
         TabIndex        =   1
         Top             =   90
         Visible         =   0   'False
         Width           =   7725
         _cx             =   5080
         _cy             =   5080
      End
   End
End
Attribute VB_Name = "frmPartImage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()

    Dim ar(1 To 2) As Single


    ar(1) = GetSetting("Offtake2", "Size", "partImage.Top", F1.Top)
    ar(2) = GetSetting("Offtake2", "Size", "partImage.Left", F1.Left + F1.width)
    Me.height = GetSetting("Offtake2", "Size", "partImage.Height", Me.height)
    Me.width = GetSetting("Offtake2", "Size", "partImage.Width", Me.width)

    If ar(1) > Screen.height Then ar(1) = F1.Top
    If ar(2) > Screen.width Then ar(2) = F1.Left + F1.width
    
    Me.Top = ar(1)
    Me.Left = ar(2)
    
    F1.mnuViewShowPart.Checked = True
    
'    AcroPDF1.setShowToolbar False
    AcroPDF1.setLayoutMode "SinglePage"
    AcroPDF1.setPageMode "none"

End Sub

Private Sub Form_Paint()
    SetAlwaysOnTopMode Me.hwnd, F1.mnuViewOnTop.Checked

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then F1.mnuViewShowPart.Checked = False

End Sub

Private Sub Form_Unload(Cancel As Integer)

    If Me.WindowState = 0 Then
    
        Call SaveSetting("Offtake2", "Size", "partImage.Top", Me.Top)
        Call SaveSetting("Offtake2", "Size", "partImage.Left", Me.Left)
        Call SaveSetting("Offtake2", "Size", "partImage.Height", Me.height)
        Call SaveSetting("Offtake2", "Size", "partImage.Width", Me.width)
    
    End If
    
    

End Sub
