VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSpecLine"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit


Public prntRow As clsSpecRow

Public msID As Long

Public msWeight As Long
Public msColor As Long
Public msLevel As Long

Public lin_startX As Double
Public lin_startY As Double
Public lin_startZ As Double

Public lin_endX As Double
Public lin_endY As Double
Public lin_endZ As Double

' œ–» ƒŒ¡¿¬À≈Õ»» œ¿–¿Ã≈“–Œ¬ Õ≈ «¿¡€¬¿“¸ œ–Œ INIT


Public Function Init(pt As clsSpecLine, sr As clsSpecRow)

    Set prntRow = sr

    msID = pt.msID
    
    lin_startX = pt.lin_startX
    lin_startY = pt.lin_startY
    lin_startZ = pt.lin_startZ
    
    lin_endX = pt.lin_endX
    lin_endY = pt.lin_endY
    lin_endZ = pt.lin_endZ
    
    msWeight = pt.msWeight
    msColor = pt.msColor
    msLevel = pt.msLevel

End Function


Public Function createFromMSLine(ByRef msline As LineElement, sr As clsSpecRow, Optional pOffset As clsSpecLine = Nothing) As Boolean

    On Error GoTo err
    
    Dim dOffsX As Double
    Dim dOffsY As Double
    Dim dOffsZ As Double
    
    Set prntRow = sr
    
    If msline Is Nothing Then Exit Function
    
    If Not pOffset Is Nothing Then
        dOffsX = pOffset.lin_endX
        dOffsY = pOffset.lin_endY
        dOffsZ = pOffset.lin_endZ
    End If
    
    
'    msID = DLongToLong(msline.ID) ' msapp...
    
    lin_startX = msline.StartPoint.X - dOffsX
    lin_startY = msline.StartPoint.Y - dOffsY
    lin_startZ = msline.StartPoint.z - dOffsZ
    
    lin_endX = msline.EndPoint.X - dOffsX
    lin_endY = msline.EndPoint.Y - dOffsY
    lin_endZ = msline.EndPoint.z - dOffsZ
    
    msWeight = msline.LineWeight
    msColor = msline.Color
    msLevel = msline.Level.ID
    
    createFromMSLine = True
    
    Exit Function
err:
    createFromMSLine = False

End Function

Public Function createMSLine(ByRef msapp As Object) As LineElement


    Dim lin As LineElement
    
    Dim p1 As Point3d
    Dim p2 As Point3d
    
    Dim p As clsSpecLine
    
    Set p = Me.prntRow.SPECROW_POINT_UNIT
    

    
    p1.X = p.lin_startX + Me.lin_startX
    p1.Y = p.lin_startY + Me.lin_startY
    p1.z = p.lin_startZ + Me.lin_startZ
    
    p2.X = p.lin_endX + Me.lin_endX
    p2.Y = p.lin_endY + Me.lin_endY
    p2.z = p.lin_endZ + Me.lin_endZ
    
    
    
    
    
    Set lin = msapp.CreateLineElement2(Nothing, p1, p2)
    
    lin.Color = Me.msColor
    lin.LineWeight = Me.msWeight
    lin.GraphicGroup = msapp.CurrentGraphicGroup
    
    Set createMSLine = lin


End Function
