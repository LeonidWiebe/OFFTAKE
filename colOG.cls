VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "colOG"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Collection" ,"clsOU"
Attribute VB_Ext_KEY = "Member0" ,"clsOU"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Attribute VB_Ext_KEY = "Member1" ,"colMat"
Option Explicit

Public iSumCount As Integer
Public iPosCount As Integer

Private AC(1 To 6) As Collection
Public colMat As Collection

Public dCellWidth As Double
Public dCellSumWidth As Double

Public dCommSumWidth As Double
Public cCommSum As clsOCell

Private origin As Point3d

Public offt_width As Double
Public offt_height As Double


Public dTextHeight As Double
Public dTextWidth As Double

'local variable to hold collection
Private mCol As Collection

Public bComonMass As Boolean
Public partdefID As Long

Public iFirstRow As Integer
Public iLastRow As Integer

Private widths(1 To 6) As Double

Public iMassLevCount As Integer

Public ouOfftSum As New clsOU

Dim msapp As Object

'/******************************************************************************
Public Property Get KEY() As String
'/******************************************************************************

    On Error GoTo KEY_ERR
    
    Dim strRet As String

    strRet = Format(Abs(CInt(bComonMass)), "0")
    
    strRet = strRet & "-" & Format(globPartDefs(CStr(partdefID)).partdefSort, "000")
    
    KEY = strRet


Exit Property

KEY_ERR:
    KEY = ""

End Property


'/******************************************************************************
Public Function getWidth()
'/******************************************************************************

    On Error GoTo getWidth_ERR
    
    
    widths(1) = 0#
    widths(2) = 0#
    widths(3) = 0#
    widths(4) = 0#
    widths(5) = 0#
    widths(6) = 0#
    
    Dim c As clsOCell
    
    For Each c In AC(1)
        widths(1) = widths(1) + c.offt_cell_width
    Next c
    
'    For Each c In ac(2)
'        widths(2) = widths(2) + c.width
'    Next c
'
'    For Each c In ac(3)
'        widths(3) = widths(3) + c.width
'    Next c
'
'    For Each c In ac(4)
'        widths(4) = widths(4) + c.width
'    Next c
'
'    For Each c In ac(5)
'        widths(5) = widths(5) + c.width
'    Next c
'
'    For Each c In ac(6)
'        widths(6) = widths(6) + c.width
'    Next c
    
    getWidth = widths(1)
    
    

Exit Function

getWidth_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "getWidth - Error"

End Function



Public Function Add(obj As clsOU, Optional sKey As String, Optional sKeyAfter As String) As clsOU
    
   
    
    If Len(sKey) = 0 And Len(sKeyAfter) = 0 Then
        mCol.Add obj
    ElseIf Len(sKey) > 0 And Len(sKeyAfter) = 0 Then
        mCol.Add obj, sKey
    ElseIf Len(sKey) = 0 And Len(sKeyAfter) > 0 Then
        mCol.Add obj, , , sKeyAfter
    ElseIf Len(sKey) > 0 And Len(sKeyAfter) > 0 Then
        mCol.Add obj, sKey, , sKeyAfter
    End If
    
    If obj.srtmID = 0 Then iSumCount = iSumCount + 1 Else iPosCount = iPosCount + 1
    
    
    refreshNxtPrv
    
    
End Function


'/******************************************************************************
Private Function getOfftCellItem(cl As Collection, strKey As String) As clsOCell
'/******************************************************************************

    On Error GoTo getOfftCellItem_ERR

    Set getOfftCellItem = cl(strKey)

Exit Function

getOfftCellItem_ERR:
    Set getOfftCellItem = New clsOCell

End Function


'/******************************************************************************
Private Function checkMatEmpty(strKey As String) As Boolean
'/******************************************************************************

    On Error GoTo checkMat_ERR

    Dim ou As clsOU
    Dim obj As clsObj
    
    Set ou = Me(strKey)
    Set obj = Me.colMat(ou.pos.POS_PD.PD_NAME)
    
    If obj.objID = 0 Then
        checkMatEmpty = True
    End If



Exit Function

checkMat_ERR:

End Function




'/******************************************************************************
Private Sub makeCells(iLev As Integer, strColKey As String, dHeight As Double, Optional bItogoIfOne As Boolean = True)
'/******************************************************************************
    
    On Error GoTo makeCell_ERR
    
    Dim strVal As String
    Dim strValPrev As String
    
    Dim w As Double
    Dim curc As clsOCell
    
    Dim i As Integer
    Dim c As clsOCell
    
    Dim strKey As String
    
    Dim cnt As Integer
    
    
    
    With F1.fgOfftake
        
        
        For i = iFirstRow To iLastRow + 1
            
            strVal = .TextMatrix(i, .ColIndex(strColKey))
            strKey = .TextMatrix(i, .ColIndex("key"))
            
            ' check material is empty
            If strColKey = "Mat" And Len(strVal) = 0 And Val(.TextMatrix(i, .ColIndex("offt"))) > 0 Then
            
                Set curc = getOfftCellItem(AC(iLev - 1), CStr(i))
                
                If checkMatEmpty(strKey) Then
                    curc.offt_cell_height = curc.offt_cell_height + curc.offt_cell_height
                    Set curc = Nothing
                    GoTo continue
                End If
            
            End If
            
            ' translate first part of std if needed
            If strColKey = "Std" And curSpecCfg.iTrans = 2 Then
                
                Dim s As String
                Dim ar() As String
                ar = Split(strVal, " ")
                If UBound(ar) > 0 Then
                    s = getTrans(ar(0), "", 2)
                    strVal = Replace(strVal, ar(0) & " ", s & " ")
                End If
            
            End If
            
            
            If Len(strKey) > 0 And (Not (strVal = strValPrev) Or Len(strValPrev) = 0) Then
                
                Set curc = Nothing
                
                Set c = New clsOCell
                
                c.sText = getTrans(strVal, " / ", curSpecCfg.iTrans)
                c.offt_cell_height = dHeight
                c.iLevel = iLev
                
                AC(iLev).Add c, CStr(i)
                
                Set curc = AC(iLev)(AC(iLev).Count)
                
                w = 0#
                
                
            End If
            
            
            If Len(strKey) > 0 Then
                w = w + dCellWidth
            Else
                w = w + dCellSumWidth
            End If
            
            If Not curc Is Nothing Then curc.offt_cell_width = w
            
            
            
            
            
            strValPrev = strVal
            
continue:
            
            
            
        Next i
        
        
    End With
    
    Exit Sub
    
makeCell_ERR:
    '    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "makeCell - Error"
    
    
End Sub


'/******************************************************************************
Public Sub createStructCom(Index As Integer)
'/******************************************************************************

    On Error GoTo createStructCom_ERR

    
    
    '    fgOfftake.ColKey(1) = "PrtD"
    '    fgOfftake.ColKey(2) = "PDG"
    '    fgOfftake.ColKey(3) = "Mat"
    '    fgOfftake.ColKey(4) = "Std"
    '    fgOfftake.ColKey(5) = "PD"
    '    fgOfftake.ColKey(6) = "PN"
    '    fgOfftake.ColKey(7) = "mass"
    '    fgOfftake.ColKey(8) = "key"
    '    fgOfftake.ColKey(9) = "srtmID"
    '    fgOfftake.ColKey(10) = "mc"
    '
    '    fgOfftake.ColHidden(fgOfftake.ColIndex("key")) = True
    '    fgOfftake.ColHidden(fgOfftake.ColIndex("srtmID")) = True
    '    fgOfftake.ColHidden(fgOfftake.ColIndex("mc")) = True
    
    
    
    Dim strVal As String
    Dim strValPrev As String
    
    Dim w As Double
    Dim curc As clsOCell
    Dim c As clsOCell
    
    Set AC(1) = New Collection
    Set AC(2) = New Collection
    Set AC(3) = New Collection
    Set AC(4) = New Collection
    Set AC(5) = New Collection
    Set AC(6) = New Collection
    
    
    iFirstRow = 0
    iLastRow = 0
    
    With F1.fgOfftake
        
        
        Dim i As Integer
        
        
        For i = 1 To .Rows - 1
        
            If iFirstRow = 0 And Val(.TextMatrix(i, .ColIndex("offt"))) = Index Then iFirstRow = i
            If Val(.TextMatrix(i, .ColIndex("offt"))) = Index Then iLastRow = i

        Next i
        
    
        If CBool(.TextMatrix(iFirstRow, .ColIndex("mc"))) Then bComonMass = True
    
        '==========================================
        
        makeCells 1, "PDG", arOfftRow(1) + arOfftRow(2) + arOfftRow(3)
        
        makeCells 4, "Std", arOfftRow(4)
        
        
        
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        Dim ou As clsOU
        Dim cnt As Integer
        
        cnt = 0
        
        
        For i = iFirstRow To iLastRow + 1
        
            Set c = New clsOCell
            c.offt_cell_height = arOfftRow(5)
            c.iLevel = 5
            
            If Len(.TextMatrix(i, .ColIndex("key"))) > 0 Then
            
                Set ou = Me(.TextMatrix(i, .ColIndex("key")))
                c.sText = ou.DRAW_SIGN & CStr(ou.smName)
                
                c.offt_cell_width = dCellWidth
                
                AC(5).Add c
                
                cnt = cnt + 1
                
            ElseIf cnt > 1 Then
            
                c.sText = "Итого"
                c.offt_cell_width = dCellSumWidth
                AC(5).Add c
                
                cnt = 0
                
            ElseIf cnt = 1 Then
            
                AC(5)(AC(5).Count).offt_cell_width = dCellWidth + dCellSumWidth
                
                cnt = 0
            
            End If
            
            
        Next i
        
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        Dim ouSum As New clsOU
        
        For i = iFirstRow To iLastRow + 1
        
            Set c = New clsOCell
            c.offt_cell_height = arOfftRow(6) + arOfftRow(6) * iMassLevCount
            c.iLevel = 6
            c.sText = Format(getDbl(.TextMatrix(i, .ColIndex("mass"))), sFmt0)
            
            Set ou = Me(.TextMatrix(i, .ColIndex("key")))
            
            If iMassLevCount > 0 Then
            
                c.offt_cell_height = c.offt_cell_height / 1.5
            
                Dim j As Integer
                If ou Is Nothing Then
                    For j = 1 To iMassLevCount
                        If j = 1 Then c.sText = "" ' чтобы не печаталась сумма по столбцу
                        If .TextMatrix(i, 5) = "Итого" Then c.sText = getSepText(c.sText, ouSum.arOuMass(j))
                        If .TextMatrix(i, 1) = "Всего" Then c.sText = getSepText(c.sText, ouOfftSum.arOuMass(j))
                    Next j
                    Set ouSum = New clsOU
                Else
                    For j = 1 To iMassLevCount
                        If j = 1 Then c.sText = "" ' чтобы не печаталась сумма по столбцу
                        c.sText = getSepText(c.sText, ou.arOuMass(j))
                        ouSum.arOuMass(j) = ouSum.arOuMass(j) + ou.arOuMass(j)
                        ouOfftSum.arOuMass(j) = ouOfftSum.arOuMass(j) + ou.arOuMass(j)
                        ouGlobSum.arOuMass(j) = ouGlobSum.arOuMass(j) + ou.arOuMass(j)
                    Next j
                End If
            End If
            
            If curSpecCfg.spcfgUseDots Then c.sText = Replace(c.sText, ",", ".")
            
            
            If Len(.TextMatrix(i, .ColIndex("key"))) > 0 Then
            
                c.offt_cell_width = dCellWidth
                
                AC(6).Add c
                
                cnt = cnt + 1
                
            ElseIf cnt > 1 Then
            
                c.offt_cell_width = dCellSumWidth
                c.iTextColorOver = 0
                AC(6).Add c
                
                cnt = 0
                
            ElseIf cnt = 1 Then
            
                AC(6)(AC(6).Count).offt_cell_width = dCellWidth + dCellSumWidth
                
                cnt = 0
            
            End If
            
        Next i
        
        
        
        
        
    End With
    
    
    getWidth
    
Exit Sub

createStructCom_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "createStructCom - Error"

End Sub



'/******************************************************************************
Public Sub createStructMet(Index As Integer)
'/******************************************************************************

    On Error GoTo createStructMet_ERR

    
    
    '    fgOfftake.ColKey(1) = "PrtD"
    '    fgOfftake.ColKey(2) = "PDG"
    '    fgOfftake.ColKey(3) = "Mat"
    '    fgOfftake.ColKey(4) = "Std"
    '    fgOfftake.ColKey(5) = "PD"
    '    fgOfftake.ColKey(6) = "PN"
    '    fgOfftake.ColKey(7) = "mass"
    '    fgOfftake.ColKey(8) = "key"
    '    fgOfftake.ColKey(9) = "srtmID"
    '    fgOfftake.ColKey(10) = "mc"
    '
    '    fgOfftake.ColHidden(fgOfftake.ColIndex("key")) = True
    '    fgOfftake.ColHidden(fgOfftake.ColIndex("srtmID")) = True
    '    fgOfftake.ColHidden(fgOfftake.ColIndex("mc")) = True
    
    
    
    Dim strVal As String
    Dim strValPrev As String
    
    Dim w As Double
    Dim curc As clsOCell
    
    Dim c As clsOCell
    
    Set AC(1) = New Collection
    Set AC(2) = New Collection
    Set AC(3) = New Collection
    Set AC(4) = New Collection
    Set AC(5) = New Collection
    Set AC(6) = New Collection
    
    
    iFirstRow = 0
    iLastRow = 0
    
    With F1.fgOfftake
        
        
        Dim i As Integer
        
        
        For i = 1 To .Rows - 1
        
            If iFirstRow = 0 And Val(.TextMatrix(i, .ColIndex("offt"))) = Index Then iFirstRow = i
            If Val(.TextMatrix(i, .ColIndex("offt"))) = Index Then iLastRow = i

        Next i
    
        If CBool(.TextMatrix(iFirstRow, .ColIndex("mc"))) Then bComonMass = True
    
        '==========================================
        
        For i = iFirstRow To iLastRow + 1
            
            If Len(.TextMatrix(i, .ColIndex("key"))) > 0 Then
                w = w + dCellWidth
            Else
                w = w + dCellSumWidth
            End If
            
        Next i
        
        Set c = New clsOCell
        c.sText = .TextMatrix(iFirstRow, .ColIndex("PrtD"))
        c.sText = getTrans(c.sText, " / ", curSpecCfg.iTrans)  ' " | "
        c.offt_cell_height = arOfftRow(1)
        c.iLevel = 1
        c.offt_cell_width = w + dCellSumWidth ' плюс всего
        AC(1).Add c
        
        '==========================================
        
        makeCells 2, "PDG", arOfftRow(2)
        
        
        Set c = New clsOCell
        c.sText = getTrans("Всего", , curSpecCfg.iTrans)
        c.offt_cell_height = arOfftRow(2) + arOfftRow(3) + arOfftRow(4) + arOfftRow(5)
        c.iLevel = 2
        c.offt_cell_width = dCellSumWidth
        AC(2).Add c
        
        '==========================================
        
        makeCells 3, "Mat", arOfftRow(3)
        
        makeCells 4, "Std", arOfftRow(4)
        
        

        
        
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        Dim ou As clsOU
        
        
        For i = iFirstRow To iLastRow + 1
        
            Set c = New clsOCell
            c.offt_cell_height = arOfftRow(5)
            c.iLevel = 5
            
            If Len(.TextMatrix(i, .ColIndex("key"))) > 0 Then
                Set ou = Me(.TextMatrix(i, .ColIndex("key")))
                c.sText = ou.DRAW_SIGN & CStr(ou.smName)
                If ou.pd.bDrawName Then
                    If curSpecCfg.iTrans Then
                        c.sText = getTrans(ou.pd.PD_NAME, , curSpecCfg.iTrans) & "|" & CStr(ou.smName)
                    Else
                        c.sText = ou.pd.PD_NAME & "|" & CStr(ou.smName)
                    End If
                End If
                c.offt_cell_width = dCellWidth
            Else
                c.sText = getTrans("Итого", , curSpecCfg.iTrans)
                c.offt_cell_width = dCellSumWidth
            End If
            
            AC(5).Add c
            
        Next i
        
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        Dim ouSum As New clsOU
        
        
        For i = iFirstRow To iLastRow + 2
        
            Set c = New clsOCell
            c.offt_cell_height = arOfftRow(6) + arOfftRow(6) * iMassLevCount
            c.iLevel = 6
            c.sText = Format(getDbl(.TextMatrix(i, .ColIndex("mass"))), sFmt0)
            
            Set ou = Me(.TextMatrix(i, .ColIndex("key")))
            
            If iMassLevCount > 0 Then
            
                c.offt_cell_height = c.offt_cell_height / 1.5
                
                Dim j As Integer
                If ou Is Nothing Then
                    For j = 1 To iMassLevCount
                        If j = 1 Then c.sText = "" ' чтобы не печаталась сумма по столбцу
                        If .TextMatrix(i, 5) = "Итого" Then c.sText = getSepText(c.sText, ouSum.arOuMass(j))
                        If .TextMatrix(i, 1) = "Всего" Then c.sText = getSepText(c.sText, ouOfftSum.arOuMass(j))
                    Next j
                    Set ouSum = New clsOU
                Else
                    For j = 1 To iMassLevCount
                        If j = 1 Then c.sText = "" ' чтобы не печаталась сумма по столбцу
                        c.sText = getSepText(c.sText, ou.arOuMass(j))
                        ouSum.arOuMass(j) = ouSum.arOuMass(j) + ou.arOuMass(j)
                        ouOfftSum.arOuMass(j) = ouOfftSum.arOuMass(j) + ou.arOuMass(j)
                        ouGlobSum.arOuMass(j) = ouGlobSum.arOuMass(j) + ou.arOuMass(j)
                    Next j
                End If
            End If
            
            If Len(.TextMatrix(i, .ColIndex("key"))) > 0 Then
                c.offt_cell_width = dCellWidth
            Else
                c.offt_cell_width = dCellSumWidth
                c.iTextColorOver = 0
            End If
            
            If curSpecCfg.spcfgUseDots Then c.sText = Replace(c.sText, ",", ".")
            
            AC(6).Add c
            
        Next i
        
        
        
        
        
    End With
    
    
    getWidth
    
Exit Sub

createStructMet_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "createStructMet - Error"

End Sub




'/******************************************************************************
Public Sub refreshNxtPrv()
'/******************************************************************************
    
    On Error GoTo refreshNxtPrv_ERR
    
    
    Dim ou As clsOU
    
    Dim i As Integer
    
    If mCol.Count = 0 Then Exit Sub
    
    For i = 1 To mCol.Count
        
        Set ou = mCol(i)
        
        If i > 1 Then Set ou.prv = mCol(i - 1) Else Set ou.prv = Nothing
        If i < mCol.Count Then Set ou.nxt = mCol(i + 1) Else Set ou.nxt = Nothing
        
    Next i
    
    
    
    
    
    Exit Sub
    
refreshNxtPrv_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "refreshNxtPrv - Error"
    
End Sub


'/******************************************************************************
Public Property Get Item(vntIndexKey As Variant) As clsOU
Attribute Item.VB_UserMemId = 0
'/******************************************************************************

    On Error GoTo Item_ERR

  Set Item = mCol(vntIndexKey)
Exit Property

Item_ERR:
  Set Item = Nothing

End Property

'/******************************************************************************
Public Property Get CMASS() As Double
'/******************************************************************************
    
    
    On Error GoTo CMASS_ERR
    
    Dim ou As clsOU
    Dim m As Double
    
    
    For Each ou In mCol
        
        If ou.srtmID > 0 Then m = m + ou.arOuMass(0)
        
    Next ou
    
    CMASS = m
    
    
    
    Exit Property
    
CMASS_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "CMASS - Error"
    
End Property


Public Property Get Count() As Long
    'used when retrieving the number of elements in the
    'collection. Syntax: Debug.Print x.Count
    Count = mCol.Count
End Property


'/******************************************************************************
Public Sub Remove(vntIndexKey As Variant)
'/******************************************************************************

    On Error GoTo Remove_ERR

    'used when removing an element from the collection
    'vntIndexKey contains either the Index or Key, which is why
    'it is declared as a Variant
    'Syntax: x.Remove(xyz)

    Dim ou As clsOU
    Set ou = mCol(vntIndexKey)

    If ou.srtmID = 0 Then iSumCount = iSumCount - 1 Else iPosCount = iPosCount - 1
    
    mCol.Remove vntIndexKey

    
    refreshNxtPrv
    
Exit Sub

Remove_ERR:

End Sub


Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
    'this property allows you to enumerate
    'this collection with the For...Each syntax
    Set NewEnum = mCol.[_NewEnum]
End Property


Private Sub Class_Initialize()
    'creates the collection when this class is created
    Set mCol = New Collection
    
    Set AC(1) = New Collection
    Set AC(2) = New Collection
    Set AC(3) = New Collection
    Set AC(4) = New Collection
    Set AC(5) = New Collection
    Set AC(6) = New Collection
    
    dCellWidth = 16# * dSpecCmnScale
    dCellSumWidth = 18# * dSpecCmnScale
    dCommSumWidth = 20# * dSpecCmnScale
    
    
    Set msapp = getMS
    
    
End Sub


Private Sub Class_Terminate()
    'destroys collection when this class is terminated
    Set mCol = Nothing
    
    Set AC(1) = Nothing
    Set AC(2) = Nothing
    Set AC(3) = Nothing
    Set AC(4) = Nothing
    Set AC(5) = Nothing
    Set AC(6) = Nothing
    
    Set msapp = Nothing
    
End Sub


'/******************************************************************************
Public Sub draw()
'/******************************************************************************
    
    On Error GoTo draw_ERR
    
    If msapp Is Nothing Then Exit Sub
    
    Dim p1 As Point3d
    Dim p2 As Point3d
    
    p1.X = origin.X
    p2.X = origin.X
    
    p1.Y = origin.Y
    p2.Y = origin.Y - Me.getHeight(1, 6)
    
    If Not drawLinePP(msapp, p1, p2, curSpecCfg.spec_v_line_wdt) Then Exit Sub
    
    
    p1.X = origin.X + Me.getWidth
    p2.X = origin.X + Me.getWidth
    
    If Not drawLinePP(msapp, p1, p2, curSpecCfg.spec_v_line_wdt) Then Exit Sub
    
    
    
    
    Dim c As clsOCell
    Dim w As Double
    
    For Each c In AC(1)
        c.setOriginXY origin.X + w, origin.Y
        c.drawOfftCell
        w = w + c.offt_cell_width
    Next c
    
    w = 0#
    
    For Each c In AC(2)
        c.setOriginXY origin.X + w, origin.Y - getHeight(1, 1)
        c.drawOfftCell
        w = w + c.offt_cell_width
    Next c
    
    w = 0#
   
    For Each c In AC(3)
        c.setOriginXY origin.X + w, origin.Y - getHeight(1, 2)
        c.drawOfftCell
        w = w + c.offt_cell_width
    Next c
    
    w = 0#
    
    For Each c In AC(4)
        c.setOriginXY origin.X + w, origin.Y - getHeight(1, 3)
        c.drawOfftCell
        w = w + c.offt_cell_width
    Next c
    
    w = 0#
    
    For Each c In AC(5)
        c.setOriginXY origin.X + w, origin.Y - getHeight(1, 4)
        c.drawOfftCell
        w = w + c.offt_cell_width
    Next c
    
    w = 0#
    
    For Each c In AC(6)
        c.setOriginXY origin.X + w, origin.Y - getHeight(1, 5)
        c.drawOfftCell
        w = w + c.offt_cell_width
    Next c
    
    
    
    Exit Sub
    
draw_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "draw - Error"
    
End Sub

'/******************************************************************************
Public Sub setOriginXY(X As Double, Y As Double)
'/******************************************************************************

    On Error GoTo setOrigin_ERR


    
    origin.X = X
    origin.Y = Y


Exit Sub

setOrigin_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setOrigin - Error"

End Sub


'/******************************************************************************
Public Sub setOriginP(p As Point3d)
'/******************************************************************************

    On Error GoTo setOriginP_ERR


    origin.X = p.X
    origin.Y = p.Y
    origin.z = p.z


Exit Sub

setOriginP_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setOriginP - Error"

End Sub

'/******************************************************************************
Public Property Get ORGN() As Point3d
'/******************************************************************************

    On Error GoTo ORGN_ERR

    ORGN = origin

Exit Property

ORGN_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "ORGN - Error"

End Property

Public Function getHeight(levFrom As Integer, levTo As Integer) As Double
    
    Dim h As Double
    Dim c As clsOCell
    
    
    Dim i As Integer
    For i = levFrom To levTo
        
        If AC(i).Count > 0 Then
            
            Set c = AC(i)(1)
            h = h + c.offt_cell_height
            
        End If
        
    Next i
    
    getHeight = h
    
    
End Function


'/******************************************************************************
Public Function sort() As Boolean
'/******************************************************************************

    On Error GoTo sort_ERR
    
    Set mCol = sortCollection(mCol)
    
    sort = True




Exit Function

sort_ERR:

End Function


Public Function checkPosdefIsMatEmpty() As Boolean


    Dim ou As clsOU
    Dim obj As clsObj
    
    Set colMat = New Collection
    
    For Each ou In Me
    
        Set obj = getColItem(colMat, ou.pos.POS_PD.PD_NAME)
        
        If obj Is Nothing Then
            Set obj = New clsObj
            obj.objID = ou.pos.POS_MAT.matID
            obj.KEY = ou.pos.POS_PD.PD_NAME
            colMat.Add obj, ou.pos.POS_PD.PD_NAME
        Else
            obj.objID = obj.objID + ou.pos.POS_MAT.matID
        End If
    
        Set obj = Nothing
    
    
    Next ou
    

    checkPosdefIsMatEmpty = True

End Function

'/******************************************************************************
Private Function getColItem(Col As Collection, sKey As String) As clsObj
'/******************************************************************************

    On Error GoTo getColItem_ERR
    
    Set getColItem = Col(sKey)

Exit Function

getColItem_ERR:
    Set getColItem = Nothing

End Function

