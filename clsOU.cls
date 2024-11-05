VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsOU"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public prtd As clsPD
Public pdg As clsPD
Public mt As clsMat
Public std As clsStd
Public pd As clsPD

Public nxt As clsOU
Public prv As clsOU

Private arMass(500) As Double
Public qty As Double

Public srtmID As Long
Public smName As String
Public sm As clsSrtm

Public pos As clsPos

'Public bPartDefSum As Boolean

Public sDrawSignOver As String
Public bDrawSignOver As Boolean

Public Property Get arOuMass(Index As Integer) As Double

    arOuMass = arMass(Index)


End Property

Public Property Let arOuMass(Index As Integer, ByVal lData As Double)

    arMass(Index) = lData


End Property



'Public Function arOuMass(Index As Integer) As Double
'
'    arOuMass = arMass(Index)
'
'
'End Function



'/******************************************************************************
Public Property Get KEY() As String
'/******************************************************************************

    On Error GoTo KEY_ERR
    
    Dim strRet As String
    
    Dim pd As clsPartDef
    Set pd = globPartDefs(CStr(pos.parentPart.partdefID))

    strRet = Format(Abs(CInt(pos.POS_PD.bMassCommon)), "0")
    
    strRet = strRet & "." & Format(pd.partdefSort, "000")
    
    strRet = strRet & "." & Format(pos.POS_PD.sortNumber, "000")

    strRet = strRet & "." & Format(pos.POS_MAT.sortNum, "000")

    strRet = strRet & "." & pos.POS_STD_FULLNUMBER


    If pos.pos_props.existsProperty("diameter") Then
        strRet = strRet & "." & Format(Val(pos.pos_props("diameter").propValue), "0000")
    Else
        strRet = strRet & ".0000"
    End If

    If pos.pos_props.existsProperty("width") Then
        strRet = strRet & "." & Format(Val(pos.pos_props("width").propValue), "0000")
    Else
        strRet = strRet & ".0000"
    End If

    If pos.pos_props.existsProperty("height") Then
        strRet = strRet & "." & Format(Val(pos.pos_props("height").propValue), "0000")
    Else
        strRet = strRet & ".0000"
    End If

    If pos.pos_props.existsProperty("thickness") Then
        strRet = strRet & "." & Format(Val(pos.pos_props("thickness").propValue), "0000")
    Else
        strRet = strRet & ".0000"
    End If
    
    strRet = strRet & "." & pos.POS_SRTM.srtmID
    
    strRet = Replace(strRet, "*", "")
    strRet = Replace(strRet, " ", "")
    
    KEY = strRet


Exit Property

KEY_ERR:
    KEY = ""

End Property

'/******************************************************************************
Public Property Get DRAW_SIGN() As String
'/******************************************************************************

    On Error GoTo DRAW_SIGN_ERR

    If bDrawSignOver Then
        DRAW_SIGN = sDrawSignOver
    Else
        If Not pd Is Nothing Then
            DRAW_SIGN = pd.pdDrawSign
        Else
            DRAW_SIGN = ""
        End If
    End If

Exit Property

DRAW_SIGN_ERR:
    DRAW_SIGN = ""

End Property

Private Sub Class_Initialize()

    Set pos = New clsPos

End Sub

Private Sub Class_Terminate()

    Set pos = Nothing

End Sub
