VERSION 5.00
Begin VB.Form frmReinPosProps 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Дополнительные свойства"
   ClientHeight    =   1200
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3120
   Icon            =   "frmReinPosProps.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1200
   ScaleWidth      =   3120
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton btnCancel 
      Caption         =   "Отмена"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   840
      Width           =   1335
   End
   Begin VB.CommandButton btnOK 
      Caption         =   "OK"
      Height          =   495
      Left            =   1920
      TabIndex        =   2
      Top             =   600
      Width           =   1095
   End
   Begin VB.TextBox txtRadius 
      Height          =   285
      Left            =   1560
      TabIndex        =   0
      Top             =   120
      Width           =   1455
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      Caption         =   "радиус"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   1335
   End
End
Attribute VB_Name = "frmReinPosProps"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

