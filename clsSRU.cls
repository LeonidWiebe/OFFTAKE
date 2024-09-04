VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSRU"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public sru_width As Double
Public sru_height As Double

Public text As String

Public sru_offsetX As Double
Public sru_offsetY As Double

Public prntRow As clsSR

Public rtc As Collection

Public sCellName As String

Public iLevel As Integer

Public msapp As Object

Private Sub Class_Initialize()

    Set rtc = New Collection
    
    Set msapp = getMS

End Sub

'/******************************************************************************
Public Sub setParams(w As Double, h As Double, X As Double, prnt As clsSR, Optional iLev As Integer = 0)
'/******************************************************************************

    sru_width = w
    sru_height = h
    sru_offsetX = X
    iLevel = iLev
    Set prntRow = prnt



End Sub



'/******************************************************************************
Public Sub drawRowUnit(Optional bDrawLeftLine As Boolean = True, Optional bDrawRightLine As Boolean = True, Optional bDrawBottomLine As Boolean = True)
'/******************************************************************************
    
    On Error GoTo draw_ERR
    
    Dim txt As TextElement
    Dim txtn As TextNodeElement
    Dim i As Integer
    Dim rt As clsSRUT
    Dim p As Point3d
    Dim a As Integer
    
    Dim X As Double
    Dim Y As Double
    
    If prntRow Is Nothing Then
        X = sru_offsetX + mspoint.X
    Else
        X = prntRow.prnt.offsetX + sru_offsetX + mspoint.X
    End If
    Y = -sru_offsetY + mspoint.Y
    
    Dim hgt As Double
    Dim wdt As Double
    
    If sru_height = 0# And Not prntRow Is Nothing Then
        hgt = prntRow.row_height
    Else
        hgt = sru_height
    End If
    
    wdt = sru_width
    
    If bDrawLeftLine Then
    
        If Not drawLineXY(msapp, X, _
                   Y, _
                   X, _
                   Y - hgt) Then Exit Sub
    
    End If
    
    If bDrawRightLine Then
    
        If Not drawLineXY(msapp, X + wdt, _
                   Y, _
                   X + wdt, _
                   Y - hgt) Then Exit Sub
    
    End If
    
    
    If bDrawBottomLine Then
    
        If Not drawLineXY(msapp, X, _
                   Y - hgt, _
                   X + wdt, _
                   Y - hgt) Then Exit Sub
    End If
               
    
    If rtc.Count > 0 Then
        
        For i = 1 To rtc.Count
            
            Set rt = rtc(i)
            
            rt.drawTextUnit X, Y - hgt * rt.dScaleY, wdt, hgt
            
        Next i
        
    End If
    
    
    
    If Len(Trim(sCellName)) > 0 Then
        
        If msapp.IsCellLibraryAttached Then
            
            p.X = X
            p.Y = Y
            
            Dim pScale As Point3d
            
            pScale.X = 1000# / ActiveModelReference.MasterUnit.UnitsPerBaseNumerator * dSpecCmnScale * 0.01 ' 0.01 - потому что нарисовано в масштабе 100
            pScale.Y = 1000# / ActiveModelReference.MasterUnit.UnitsPerBaseNumerator * dSpecCmnScale * 0.01
            pScale.z = 1000# / ActiveModelReference.MasterUnit.UnitsPerBaseNumerator * dSpecCmnScale * 0.01
            
             
            
            Dim ele As CellElement
            Set ele = msapp.CreateCellElement2(sCellName, p, pScale, True, msapp.Matrix3dIdentity)
            ele.GraphicGroup = msapp.CurrentGraphicGroup
            ActiveModelReference.AddElement ele
            
            
            ele.redraw msdDrawingModeNormal
            
            
        End If
        
        
    End If
    
    
    Exit Sub
    
draw_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "drawRowUnit - Error"
    
End Sub



Private Sub Class_Terminate()

    Set rtc = Nothing
    
    Set msapp = Nothing
    
End Sub
