Attribute VB_Name = "Rein"
Option Explicit


'/******************************************************************************
Public Function armCompareBar(pos As clsPos, eqpts As Collection) As Boolean
'/******************************************************************************
    
    On Error GoTo armCompareBar_ERR
    
    If pos Is Nothing Then Exit Function
    If pos.parentPart Is Nothing Then Exit Function
    
    Dim catID As Long
    Dim partID As Long
    Dim partIDbar As Long
    Dim iMain As Integer
    Dim iCounter As Integer
    Dim partIDfromRS As Long
    Dim iDiam As Integer
    Dim iDiamFromRS As Integer
    
    Dim ptsToCmp As Collection
    Dim ptsToCmpAlt As Collection
    
    Set eqpts = New Collection
    
    catID = pos.parentPart.catID
    partID = pos.parentPart.partID
    
    If catID = 0 Then Exit Function
    If partID = 0 Then Exit Function
    
    Dim propDiam As clsProp
    Set propDiam = pos.pos_props("diameter")
    If propDiam Is Nothing Then Exit Function
    
    iDiam = Val(propDiam.propValue)
    If iDiam = 0 Then Exit Function
    
    Dim prt As New clsPart

    
    Dim bIsEq(1 To 4) As Boolean
    
    Dim I As Integer
    
    Dim RS As New ADODB.Recordset
    
    If bUseCursorClient Then RS.CursorLocation = adUseClient
    
    
    
    
    Dim strSQL As String
    
    strSQL = "SELECT "
    
    strSQL = strSQL & conn.strBaseName & ".dbo.view_r_part_reinpoints.*, "
    strSQL = strSQL & conn.strSrtmName & ".dbo.r_sortament_property.diameter as [diameter] " '' вообще-то можно взять из сортамента по srtmID и брать diameter оттуда
    
    strSQL = strSQL & "FROM "
    strSQL = strSQL & conn.strBaseName & ".dbo.view_r_part_reinpoints "
    
    strSQL = strSQL & "INNER JOIN "
    strSQL = strSQL & conn.strSrtmName & ".dbo.r_sortament_property "
    strSQL = strSQL & "ON "
    strSQL = strSQL & conn.strBaseName & ".dbo.view_r_part_reinpoints.srtmID "
    strSQL = strSQL & "= "
    strSQL = strSQL & conn.strSrtmName & ".dbo.r_sortament_property.srtmID "
    
    strSQL = strSQL & "WHERE "
    strSQL = strSQL & conn.strBaseName & ".dbo.view_r_part_reinpoints.catID = " & catID & " "
    
    strSQL = strSQL & "AND "
    strSQL = strSQL & conn.strBaseName & ".dbo.view_r_part_reinpoints.deleted = 0"
    
'    strSQL = strSQL & "AND "
'    strSQL = strSQL & conn.strBaseName & ".dbo.view_r_part_reinpoints.isOk = 1"
    
    
    RS.Open strSQL, cn_data, adOpenForwardOnly, adLockReadOnly
    
    Dim bDebug As Boolean
'    bDebug = True
    
'    if bDebug then Debug.Print "=========="
    
    
    If Not RS.EOF Then
        RS.MoveFirst
        
        Do
            Dim p As OfftPoint2D
            Dim pa As OfftPoint2D
            
            If Not RS.EOF Then
                partIDfromRS = RS.fields("partID").Value
            Else
                partIDfromRS = 0
            End If
            
            If partIDbar <> partIDfromRS Then
                
                If partIDbar > 0 Then ' сравниваем
                    
                    bIsEq(1) = True
                    bIsEq(2) = True
                    bIsEq(3) = True
                    bIsEq(4) = True
                    
                    If ptsToCmp.Count <> pos.pointsComp.Count Then
                        bIsEq(1) = False
                        bIsEq(2) = False
                        bIsEq(3) = False
                        bIsEq(4) = False
                    Else
                        If bDebug Then Debug.Print "1     =========="
                        For I = 1 To ptsToCmp.Count
                            If bDebug Then Debug.Print I, " x -> ", ptsToCmp(I).X & " = " & pos.pointsComp(I).X, " y -> ", ptsToCmp(I).Y & " = " & pos.pointsComp(I).Y
                            If Not (ptsToCmp(I).X = pos.pointsComp(I).X And ptsToCmp(I).Y = pos.pointsComp(I).Y And iDiam = iDiamFromRS) Then
                                bIsEq(1) = False
                                Exit For
                            End If
                        Next I
                        If bDebug Then Debug.Print "2     =========="
                        For I = 1 To ptsToCmp.Count
                            If bDebug Then Debug.Print I, " x -> ", ptsToCmp(I).X & " = " & pos.pointsComp(I).X, " y -> ", ptsToCmp(I).Y & " = " & -pos.pointsComp(I).Y
                            If Not (ptsToCmp(I).X = pos.pointsComp(I).X And ptsToCmp(I).Y = -pos.pointsComp(I).Y And iDiam = iDiamFromRS) Then
                                bIsEq(2) = False
                                Exit For
                            End If
                        Next I
                        If bDebug Then Debug.Print "3     =========="
                        For I = 1 To ptsToCmpAlt.Count
                            If bDebug Then Debug.Print I, " x -> ", ptsToCmpAlt(I).X & " = " & pos.pointsComp(I).X, " y -> ", ptsToCmpAlt(I).Y & " = " & pos.pointsComp(I).Y
                            If Not (ptsToCmpAlt(I).X = pos.pointsComp(I).X And ptsToCmpAlt(I).Y = pos.pointsComp(I).Y And iDiam = iDiamFromRS) Then
                                bIsEq(3) = False
                                Exit For
                            End If
                        Next I
                        If bDebug Then Debug.Print "4     =========="
                        For I = 1 To ptsToCmpAlt.Count
                            If bDebug Then Debug.Print I, " x -> ", ptsToCmpAlt(I).X & " = " & pos.pointsComp(I).X, " y -> ", ptsToCmpAlt(I).Y & " = " & -pos.pointsComp(I).Y
                            If Not (ptsToCmpAlt(I).X = pos.pointsComp(I).X And ptsToCmpAlt(I).Y = -pos.pointsComp(I).Y And iDiam = iDiamFromRS) Then
                                bIsEq(4) = False
                                Exit For
                            End If
                        Next I
                    End If
                    
                    If bDebug Then Debug.Print bIsEq(1), bIsEq(2), bIsEq(3), bIsEq(4)
                    
                    If (bIsEq(1) Or bIsEq(2) Or bIsEq(3) Or bIsEq(4)) And partID <> partIDbar Then
                        prt.setIDv2 partIDbar, False, False, False
                        eqpts.Add prt
                        Set prt = Nothing
                    End If
                    
                    
                End If
                
                If RS.EOF Then
                    Set ptsToCmp = Nothing
                    Set ptsToCmpAlt = Nothing
                    Exit Do
                End If
                
                Set ptsToCmp = New Collection
                Set ptsToCmpAlt = New Collection
                partIDbar = partIDfromRS
                iCounter = 0
                
            End If
            
            p.X = RS.fields("x").Value
            p.Y = RS.fields("y").Value
            pa.X = RS.fields("xa").Value
            pa.Y = RS.fields("ya").Value
            
            iDiamFromRS = Val(RS.fields("diameter").Value & "")
            
            If RS.fields("isMain").Value Then
                iMain = iCounter
            End If
            
            ptsToCmp.Add p
            ptsToCmpAlt.Add pa
            iCounter = iCounter + 1
            
            RS.MoveNext
            
            
            
        Loop
        
        
    End If
    
    
    RS.Close
    Set RS = Nothing
    
    If eqpts.Count > 0 Then
        If bMainFormLoaded Then F1.SB.Panels("status").text = "  совпадения: "
        For I = 1 To eqpts.Count
            Set prt = eqpts(I)
            If I > 1 Then F1.SB.Panels("status").text = F1.SB.Panels("status").text & ","
            F1.SB.Panels("status").text = F1.SB.Panels("status").text & prt.partName
        Next I
    Else
        If bMainFormLoaded Then F1.SB.Panels("status").text = "  нет совпадений"
    End If
    
    armCompareBar = CBool(eqpts.Count)
    
    Exit Function
    
armCompareBar_ERR:
    Set RS = Nothing
'        MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "armCompareBar - Error"
    If bMainFormLoaded Then F1.SB.Panels("status").text = "armCompareBar - Error - [" & err.Number & "] - " & err.Description
    
End Function

'/******************************************************************************
Public Function armLoadSketch(pos As clsPos) As Integer
'/******************************************************************************

    On Error GoTo armLoadSketch_ERR

    Dim prop As clsProp
    
    
    Dim I As Integer
    
    Dim iMain As Integer
    iMain = 0
    
    
    Dim pp As OfftPoint2D
    Dim pt As OfftPoint2D
    
    
    Set prop = pos.pos_props("length")
    
    If prop Is Nothing Then
        Exit Function
    End If
    
    
    Set pos.pointsDraw = New Collection
    Set pos.pointsSkch = New Collection
    
    
    Dim RS As New ADODB.Recordset
    
    If bUseCursorClient Then RS.CursorLocation = adUseClient
    
    RS.Open "select * from r_part_reinpoints where partID = " & pos.partID, cn_data, adOpenStatic, adLockReadOnly
    
    
    If Not RS.EOF Then
        
        RS.MoveFirst
        
'        Debug.Print "update points"
        Do
            Dim p As OfftPoint2D
            Dim ps As OfftPoint2D
            
            p.X = RS.fields("xd").Value
            p.Y = RS.fields("yd").Value
            
            If RS.fields("isMain").Value Then
                iMain = RS.AbsolutePosition - 1
                pos.bCont = CBool(RS.fields("isCont").Value)
            End If
            
            If CBool(RS.fields("isSketchOk").Value) Then
                ps.X = RS.fields("xs").Value
                ps.Y = RS.fields("ys").Value
            Else
                ps.X = p.X
                ps.Y = p.Y
            End If
            
'            Debug.Print "upd", Format(ps.x, "0"), Format(ps.y, "0"), Format(p.x, "0"), Format(p.y, "0")
            
            pos.pointsDraw.Add p
            pos.pointsSkch.Add ps
            
            
            RS.MoveNext
        Loop Until RS.EOF
        
        
        
        If iMain >= (pos.pointsDraw.Count - 1) Then
            iMain = pos.pointsDraw.Count - 2
        End If
        
        
        RS.Close
        
        RS.Open "select * from r_part_reinsketch where partID = " & pos.partID, cn_data, adOpenStatic, adLockReadOnly
        
        If Not RS.EOF Then
            RS.MoveFirst
            
            pos.termBegType = RS.fields("sketchStartType").Value
            pos.termBegAngle = RS.fields("sketchStartAngle").Value
            pos.termBegLength = RS.fields("sketchStartLength").Value
            
            
            pos.termEndType = RS.fields("sketchEndType").Value
            pos.termEndAngle = RS.fields("sketchEndAngle").Value
            pos.termEndLength = RS.fields("sketchEndLength").Value
            
        
        End If
        
        
        
        pos.iMainLine = iMain
        
        Rein.armCalcPointsFromDraw pos, False
        Rein.armCalcPointsFromDraw pos, True
        
    End If
    
    RS.Close
    Set RS = Nothing
    
    armLoadSketch = pos.pointsDraw.Count
    

Exit Function

armLoadSketch_ERR:
    Set RS = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "armLoadSketch - Error"

End Function




'/******************************************************************************
Public Function armUpdateSketch(vd As Rein2d, pos As clsPos, Optional bLoad As Boolean = True, Optional bUpdateControl As Boolean = True) As Integer
'/******************************************************************************
    
    On Error GoTo updateSketch_ERR
    
    If pos Is Nothing Then Exit Function
    If vd Is Nothing Then Exit Function
    
    
    Dim prop As clsProp
    Dim I As Integer
    Dim ps As OfftPoint2D
    Dim p As OfftPoint2D
    Dim eqpts As New Collection
    
    
    If bMainFormLoaded Then F1.SB.Panels("status").text = "  ---"
    
    
    If bLoad Then armLoadSketch pos
    
    
    
    
    vd.Clear
    
    If Not pos.bSketch Or pos.pointsDraw.Count = 0 Then
    
        Set prop = pos.pos_props("length")
        
        If prop Is Nothing Then
            vd.NewDrawing
        Else
            vd.NewDrawing prop.PVAL
        End If
        
        If bUpdateControl Then vd.Fit 2
        
        Exit Function
    
    End If
    

    
    
    Dim diam As Double
    
    Set prop = pos.POS_SRTM.srtm_props("diameter")
    If Not prop Is Nothing Then
        diam = prop.PVAL
        vd.setRForEnds prop.PVAL * 2.25 ' 2.25*D
    Else
        vd.setRForEnds 100#
    End If
    
    
    Dim bUseFilletFromDB As Boolean
    
    If iUseReinFilletByProject = 1 Then
        bUseFilletFromDB = True
    ElseIf iUseReinFilletByProject = -1 Then
        bUseFilletFromDB = False
    Else
        bUseFilletFromDB = bUseReinFilletBySettings
    End If
    
    
    Set prop = pos.POS_SRTM.srtm_props("fillet_radius")
    If Not prop Is Nothing Then
        If Val(prop.PVAL) = 0 Then
            vd.setR 0#
        ElseIf bUseFilletFromDB Then
            vd.setR prop.PVAL ' радиус скругления
        Else
            vd.setR (diam * 5# + diam / 2#)  ' радиус скругления
        End If
    Else
        vd.setR 0#
    End If
    
    
'    vd.iShift = rndGlobal.iArmArc
'    vd.iShift2 = rndGlobal.iArmSegm
    
    For I = 1 To pos.pointsDraw.Count
    
        ps = pos.pointsSkch(I)
        p = pos.pointsDraw(I)
    
        vd.AddPoint ps.X, ps.Y, p.X, p.Y
    
    Next I
    

    
    Set prop = pos.pos_props("radiusinn")
    If Not prop Is Nothing Then
        vd.RArc = prop.PVAL ' должно идти после добавления точек... - ?
    End If
    
    vd.setMainLine CLng(pos.iMainLine), False
    
    
    
    
    
    If pos.bCont Then
    
        vd.bCont = True
    
        Set prop = pos.pos_props("lenmin")
        If Not prop Is Nothing Then
            vd.dContMin = prop.PVAL '
        End If
        
        Set prop = pos.pos_props("lenmax")
        If Not prop Is Nothing Then
            vd.dContMax = prop.PVAL '
        End If
        
        Set prop = pos.pos_props("lenmid")
        If Not prop Is Nothing Then
            vd.dContMid = prop.PVAL '
        Else
            vd.bCont = False
        End If
        
    End If
    
    
    
    
    '========== get segm lengths =======================
    Dim p1() As Double
    Dim p2() As Double

    Call vd.getLengths(p1, p2)
    
    pos.sSegmArcLens = ""
    pos.sSegmLineLens = ""

    If SafeArrayGetDim(p1) > 0 And pos.pointsSkch.Count > 0 Then

        For I = LBound(p1) To UBound(p1)
            If I > LBound(p1) Then pos.sSegmLineLens = pos.sSegmLineLens & ";"
            pos.sSegmLineLens = pos.sSegmLineLens & Format(p1(I), "0")
        Next I


        If SafeArrayGetDim(p2) > 0 Then
            For I = LBound(p2) To UBound(p2)
                If I > LBound(p2) Then pos.sSegmArcLens = pos.sSegmArcLens & ";"
                pos.sSegmArcLens = pos.sSegmArcLens & Format(p2(I), "0")
            Next I
        End If
    
    End If
    '====================================================
    
    If pos.termBegType > 0 Then vd.SetBegin pos.termBegType, pos.termBegAngle, pos.termBegLength
    If pos.termEndType > 0 Then vd.SetEnd pos.termEndType, pos.termEndAngle, pos.termEndLength
    
    
    If bUpdateControl Then
    
        vd.Fit 2
        
        armCompareBar pos, eqpts
    
    End If
    
    
    armUpdateSketch = pos.pointsDraw.Count
    Exit Function
    
updateSketch_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "updateSketch - Error"
    If bMainFormLoaded Then F1.SB.Panels("status").text = "armUpdateSketch - Error - [" & err.Number & "] - " & err.Description

    
End Function



Public Function armSavePoints(pointsSkch() As DPOINT2D, pointsReal() As DPOINT2D, iMainLine As Long, pos As clsPos) As Boolean
    
    On Error GoTo Arm_2D1_CmdClick_ERR


    If pos Is Nothing Then Exit Function

    Dim iLastIndex As Integer
    iLastIndex = UBound(pointsReal)
    
    Dim I As Integer
    
    Set pos.pointsDraw = New Collection
    Set pos.pointsSkch = New Collection
    
    
    For I = 0 To iLastIndex
    
        Dim p As OfftPoint2D
        Dim ps As OfftPoint2D
        
        p.X = pointsReal(I).X
        p.Y = pointsReal(I).Y
        
        ps.X = pointsSkch(I).X
        ps.Y = pointsSkch(I).Y
        
        pos.pointsDraw.Add p
        pos.pointsSkch.Add ps
    
    Next I
    
    
    If iMainLine >= pos.pointsDraw.Count - 1 Then iMainLine = pos.pointsDraw.Count - 2 ' глючок контрола - если добавлять сегмент слева, то iMainLine == кол-ву сегментов
    
    pos.iMainLine = iMainLine
    
    '=========================================
    armSavePoints = pos.saveArmPoints(True)
    '=========================================


Exit Function

Arm_2D1_CmdClick_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "Arm_2D1_CmdClick - Error"

End Function

'/******************************************************************************
' NOT USING
Public Function getBarLength(pos As clsPos) As Double ' не исп., взамен нее Arm2d.getTotalLength
'/******************************************************************************
    
    On Error GoTo getBarLength_ERR
    
    Dim I, j As Integer
    Dim dist As Double
    Dim p1(0 To 1) As OfftPoint2D
    Dim p2(0 To 1) As OfftPoint2D
    Dim rad As Double
    Dim prop As clsProp
    Dim bNoPoints As Boolean
    
    Dim strTempStatus As String
    
    Dim segm_lens() As Double
    Dim arc_lens() As Double
    Dim arc_angles() As Double
    Dim arc_cuts() As Double
    
    Dim segm_cnt As Integer
    Dim verts_cnt As Integer
    
    F1.SB.Panels("status").text = ""
    
    If pos Is Nothing Then Exit Function
    If pos.pointsDraw Is Nothing Then bNoPoints = True
    If pos.pointsDraw.Count < 2 Then bNoPoints = True
    
    If bNoPoints Then
        Set prop = pos.pos_props("length")
        If Not prop Is Nothing Then
            If prop.hasValue Then
                getBarLength = getDbl(prop.getReinStringValue)
            End If
        End If
        Exit Function
    End If
    
    
    Set prop = pos.POS_SRTM.srtm_props("fillet_radius")
    If Not prop Is Nothing Then rad = prop.PVAL
    
    segm_cnt = pos.pointsDraw.Count - 1
    verts_cnt = pos.pointsDraw.Count - 2
    
    ReDim segm_lens(1 To segm_cnt)
    
    If verts_cnt > 0 Then
        ReDim arc_lens(1 To verts_cnt)
        ReDim arc_angles(1 To verts_cnt)
        ReDim arc_cuts(1 To verts_cnt)
    End If
    
    For I = 1 To segm_cnt
        
        p1(0) = pos.pointsDraw(I)
        p1(1) = pos.pointsDraw(I + 1)
        
        dist = Sqr((p1(1).X - p1(0).X) ^ 2 + (p1(1).Y - p1(0).Y) ^ 2)
        
        segm_lens(I) = roundShaman(dist, 0, , rndGlobal.iArmSegm)
        
    Next I
    
    If verts_cnt > 0 And rad > 0 Then
        
        For I = 1 To verts_cnt
            
            p1(0) = pos.pointsDraw(I + 1)
            p1(1) = pos.pointsDraw(I)
            
            p2(0) = pos.pointsDraw(I + 1)
            p2(1) = pos.pointsDraw(I + 2)
            
            arc_angles(I) = Rein.getAngle(p1, p2)
            
            arc_cuts(I) = rad / (Tan(Abs(arc_angles(I)) / 2))
            
            arc_lens(I) = roundShaman((pi - Abs(arc_angles(I))) * rad, -1, , rndGlobal.iArmArc)
            
            segm_lens(I) = roundShaman(segm_lens(I) - arc_cuts(I), -1, 5, rndGlobal.iArmSegm)
            segm_lens(I + 1) = roundShaman(segm_lens(I + 1) - arc_cuts(I), -1, 5, rndGlobal.iArmSegm)
            
        Next I
        
        
    End If
    
    ' окончательный подсчет
    dist = 0
    strTempStatus = pos.parentPart.partName & " : R = " & rad & " ; L = "
    
    For I = 1 To segm_cnt
        dist = dist + segm_lens(I)
        
        If I > 1 Then strTempStatus = strTempStatus & " + "
        strTempStatus = strTempStatus & segm_lens(I)
        
        If I <= verts_cnt Then strTempStatus = strTempStatus & " + (" & arc_lens(I) & ")"
        
    Next I
    
    If verts_cnt > 0 Then
        For I = 1 To verts_cnt
            dist = dist + arc_lens(I)
        Next I
    End If
    
    dist = getDbl(Format(dist, "#"))
    
    getBarLength = dist
    
    strTempStatus = strTempStatus & " = " & str(dist)
    
    
    F1.SB.Panels("status").text = strTempStatus
    
    
    Exit Function
    
getBarLength_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "getBarLength - Error"
    
End Function





Public Function getAngle(p1() As OfftPoint2D, p2() As OfftPoint2D)

    
    Dim cs, ss As Double
    Dim x1, x2, y1, y2 As Double
    
    x1 = p1(1).X - p1(0).X
    y1 = p1(1).Y - p1(0).Y
    
    x2 = p2(1).X - p2(0).X
    y2 = p2(1).Y - p2(0).Y
    
    cs = (x1 * x2 + y1 * y2) / Sqr((x1 * x1 + y1 * y1) * (x2 * x2 + y2 * y2))
    
    If cs > 0 And cs <= 1# Then
        cs = Atn(Sqr(1 - cs ^ 2) / cs)
    ElseIf cs < 0 And cs >= -1# Then
        cs = pi + Atn(Sqr(1 - cs ^ 2) / cs)
    Else
        cs = 2 * Atn(1)
    End If
    
    
    ss = x1 * y2 - y1 * x2
    
    If ss < 0 Then cs = -1 * cs
    
    getAngle = cs

End Function


'/******************************************************************************
Public Function armCalcPointsFromDraw(pos As clsPos, bAlt As Boolean) As Boolean
'/******************************************************************************

    On Error GoTo calcPoints_ERR

    Dim p1(0 To 1) As OfftPoint2D
    Dim p2(0 To 1) As OfftPoint2D
    
    Dim p As OfftPoint2D
    Dim pMain As OfftPoint2D
    
    
    Dim dAn As Double

    If pos Is Nothing Then Exit Function

    If pos.pointsDraw.Count < 2 Then
        Exit Function
    End If
    
    Dim pts As New Collection
    Dim pts_rev As New Collection
    Dim pts_rem As New Collection
    Dim pts_cmp As Collection ' ссылка для создания массива точек для сравнения
    
    If bAlt Then
        pMain = pos.pointsDraw(pos.pointsDraw.Count) ' конечная
        Set pos.pointsCompAlt = New Collection
        Set pts_cmp = pos.pointsCompAlt
    Else
        pMain = pos.pointsDraw(1) ' начальная
        Set pos.pointsComp = New Collection
        Set pts_cmp = pos.pointsComp
    End If
    
    
    
    ' получаем массив точек
    '===================================
    
    Dim I As Integer
    
    For I = 1 To pos.pointsDraw.Count
    
        p = pos.pointsDraw(I)
        
        p.X = p.X - pMain.X
        p.Y = p.Y - pMain.Y
        
        pts.Add p
    
    Next I
    
    If bAlt Then
    
        For I = pts.Count To 1 Step -1
            p = pts(I)
            
            pts_rev.Add p
        Next I
        
        Set pts = Nothing
        
        Set pts = pts_rev
    
    End If
    
    ' получаем угол наклона
    
    p1(0) = pts(1)
    p1(1) = pts(2)

    p2(0).X = 0
    p2(0).Y = 0
    p2(1).X = 1000
    p2(1).Y = 0
    
    dAn = getAngle(p1, p2)
    
    ' поворачиваем точки
    
    For I = 1 To pts.Count
    
        p.X = getDbl(FormatNumber(pts(I).X * Cos(dAn) - pts(I).Y * Sin(dAn), 0, , , vbFalse))
        p.Y = getDbl(FormatNumber(pts(I).X * Sin(dAn) + pts(I).Y * Cos(dAn), 0, , , vbFalse))
    
        pts_rem.Add p
        
    Next I
    
    
    
    
   
    Dim pRem As OfftPoint2D
    Dim pp(0 To 1) As OfftPoint2D
    pp(0) = pts_rem(pos.iMainLine + 2)
    pp(1) = pts_rem(pos.iMainLine + 1)
    
    pRem.X = pp(1).X - pp(0).X
    pRem.Y = pp(1).Y - pp(0).Y
    
    For I = 1 To pts_rem.Count
    
        Dim ppp As OfftPoint2D
        
        ppp = pts_rem(I)
        
        If pos.bCont And I > pos.iMainLine + 1 Then
        
            ppp.X = pRem.X - ppp.X
            ppp.Y = pRem.Y - ppp.Y
        
'            ppp = Point2dSubtract(ppp, pRem)
        End If
        
        pts_cmp.Add ppp
    
    Next I
        
    
    
    
    Set pts = Nothing
    Set pts_rem = Nothing
    
    
    armCalcPointsFromDraw = True

Exit Function

calcPoints_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "calcPoints - Error"

End Function




