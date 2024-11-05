VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsPos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Attribute VB_Ext_KEY = "Member0" ,"colProp"
Option Explicit


Public pos_props As colProp


Public numDigits As Integer

Public partID As Long

Public posID As Long
Public posIDold As Long

Public posNote As String

Private mcIDover As Long

Private pdID As Long

'Public std As clsStd
'Private stdID As Long

'Public stdpd As clsStdPd
Private stdpdID As Long

Public matID As Long
'Public matName As String
'Public matStd As clsStd
'Public mt As clsMat

'Public sm As clsSrtm
Private srtmID As Long

Public posPrtName As String
Public posPrtCatID As Long
Public posPrtCatPath As String
Public posPrtMass As Double

Public posQty As Double

Public posUMass As Double
Public posCMass As Double
'Public posUMassSrtm As Double ' заменена на POS_MASS_SRTM
'Public posUMassCat As Double
Public posMassKoef As Double

Public bUMCalc As Boolean
Public bCMCalc As Boolean

Public bSketch As Boolean

Public bCalcLap As Boolean

Public fgp As VSFlexGrid

Public parentPart As clsPart

'Public OK As Boolean

Public fgRowToEdit As Long

Public posNumber As Double


Private flds() As Variant
Private vls() As Variant
Dim vls_new() As Variant


'RaiseEvent srtmChanged[(arg1, arg2, ... , argn)]
Public Event srtmChanged(ByVal srtmID As Long)

Public pointsSkch As Collection

Public pointsDraw As Collection

Public pointsComp As Collection
Public pointsCompAlt As Collection ' альтернативные для сравнения

Public termBegType As Long
Public termBegAngle As Long
Public termBegLength As Long

Public termEndType As Long
Public termEndAngle As Long
Public termEndLength As Long

Public iMainLine As Integer

Public bCont As Boolean ' при сравнении не учитывается длина основного сегмента

Public sSegmLineLens As String
Public sSegmArcLens As String

Dim strChanged As String
Dim strColumns As String
Dim strValues As String

Public bIsReinDefault As Boolean

Public bMustUpdate As Boolean

Public bNotOnly As Boolean
Public bDups As Boolean

Private pos_objID As Long

Public bTranslateStdType As Boolean



'/******************************************************************************
Public Function getPartID() As Long
'/******************************************************************************

    On Error GoTo getPartID_ERR

    If Not parentPart Is Nothing Then
        If parentPart.partID = 0 And partID > 0 Then
            getPartID = partID
        Else
            getPartID = parentPart.partID
        End If
    Else
        getPartID = partID
    End If

Exit Function

getPartID_ERR:
    getPartID = partID

End Function




'/******************************************************************************
Public Function getIndex() As Long ' get index of current position
'/******************************************************************************
    
    Dim i As Long
    
    For i = 1 To parentPart.ps.pm.Count
    
        Dim pos As clsPos
        Set pos = parentPart.ps.pm(i)
        
        If pos.posID = Me.posID Then
            
            getIndex = i
            Exit Function
            
        End If
        
    Next i
    
    getIndex = 0

End Function

'/******************************************************************************
Public Property Get POS_MAT() As clsMat
'/******************************************************************************

    On Error GoTo POS_MAT_ERR

    Set POS_MAT = globMats(CStr(matID))

Exit Property

POS_MAT_ERR:
    Set POS_MAT = New clsMat

End Property


'/******************************************************************************
Public Property Get POS_PD_NAME() As String
'/******************************************************************************

    On Error GoTo stand

    If Me.POS_STDPD.stdpdID = 0 Then
        GoTo stand
    End If
    
    If Len(Trim(Me.POS_STDPD.pdNameAlt)) > 0 Then
        POS_PD_NAME = Trim(Me.POS_STDPD.pdNameAlt)
    Else
        GoTo stand
    End If
    
    


Exit Property

stand:
    If Me.POS_PD.pdID = 0 Then
        POS_PD_NAME = ""
    Else
        POS_PD_NAME = POS_PD.PD_NAME
    End If

End Property



'/******************************************************************************
Public Property Get POS_PD() As clsPD
'/******************************************************************************

    On Error GoTo POS_PD_ERR
    
    If getPosdefID > 0 Then
        Set POS_PD = globPosdefs(CStr(getPosdefID))
    Else
        Set POS_PD = New clsPD
    End If
    

Exit Property

POS_PD_ERR:
    Set POS_PD = New clsPD

End Property



'/******************************************************************************
Public Function getDescr() As String
'/******************************************************************************

    On Error GoTo getDescr_ERR

    
    Dim a As String
    Dim b As String
    Dim L As Long
    
    a = ""
    L = getIndex
    
    If L > 0 Then
        a = L & ". "
    End If
    
    If POS_SRTM.srtmID < 0 Then
        a = a & Me.posPrtName
        getDescr = a
        Exit Function
    Else
        a = a & Trim(POS_PD_NAME & " " & POS_SRTM.srtmName)
    End If
    

    
    
    If POS_MCALC.mcID = -1 Then
        b = ", без массы"
    ElseIf POS_MCALC.mcID = 0 Then
        b = ", ..."
    ElseIf POS_MCALC.mcID = 1 Then
        b = ", штуки"
    ElseIf POS_MCALC.mcID = 2 Then
    
        If CBool(isInRunMet) Then
            b = ", пог. метры"
        Else
            b = ", штуки"
        End If
    
    ElseIf POS_MCALC.mcID = 3 Then
        b = ", площадь (кв.м)"
    ElseIf POS_MCALC.mcID = 4 Then
        b = ", объем (куб.м)"
    ElseIf POS_MCALC.mcID = 5 Then
        b = ", проценты"
    ElseIf POS_MCALC.mcID = 6 Then
        b = ", толщина на площадь"
    ElseIf POS_MCALC.mcID = 7 Then
        
        If CBool(isInRunMet) Then
            b = ", пог. метры"
        ElseIf getEmptyPropsQty = 2 Then
            b = ", площадь (кв.м)"
        ElseIf getEmptyPropsQty = 3 Then
            b = ", объем (куб.м)"
        Else
            b = ", по трем сторонам"
        End If
    ElseIf POS_MCALC.mcID = 8 Then
        b = ", по радиусу"
    ElseIf POS_MCALC.mcID = 11 Then
        b = ", по диаметру"
    ElseIf POS_MCALC.mcID = 9 Then
        If CBool(isInRunMet) Then
            b = ", пог. метры"
        ElseIf getEmptyPropsQty = 2 Then
            b = ", площадь (кв.м)"
        Else
            b = ", по двум сторонам"
        End If
    ElseIf POS_MCALC.mcID = 10 Then
        b = ", общая масса"
    ElseIf POS_MCALC.mcID = 12 Then
        If pos_props("thickness").hasValue Then
            b = ", заданная толщина"
        Else
            b = ", общий объем"
        End If
    ElseIf POS_MCALC.mcID = 13 Then
        b = ", анкер с шагом"
    ElseIf POS_MCALC.mcID = 14 Then
        b = ", усиление анкера"
    Else
        b = ", " & POS_MCALC.mcName
        
        If CBool(isInRunMet) Then
            b = b & " (пог. метры)"
        End If
    End If
    
    a = a & b
    
    
    
    
    If POS_STD.stdID > 0 Then a = a & vbNewLine & POS_STD_FULLNUMBER
    If matID > 0 Then a = a & ", " & POS_MAT.matName & " " & POS_MAT.MAT_STD.FULLNUMBER
    If POS_MAT.matScndID > 0 Then a = a & " (" & POS_MAT.MAT_SCND.matName & "...)"
    
    getDescr = a
    
    
Exit Function

getDescr_ERR:
    getDescr = "Ошибка в getDescr() - " & err.Description

End Function


'Public Property Let u(ByVal v As Double)
'End Property
'Public Property Get u() As Double
'End Property

'/******************************************************************************
Public Function setStandard(ByVal ID As Long, Optional bResetPos As Boolean = True)
'/******************************************************************************
    
    On Error GoTo setStandard_ERR
    
    
    If POS_STD.stdID = ID Then Exit Function
    
    
    If ID = 0 Then
        stdpdID = 0
    Else
        Dim stdpd As clsStdPd
        Set stdpd = globStdPosdefs.fromIDs(ID, POS_PD.pdID)
        If stdpd Is Nothing Then
            stdpdID = 0
        Else
            stdpdID = stdpd.stdpdID
        End If
    End If
    
    If bResetPos Then
        setSrtm 0, False
    End If
    
    
    Exit Function
    
setStandard_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setStandard - Error"
    
End Function

'/******************************************************************************
Public Function getPosdefID() As Long
'/******************************************************************************
    
    On Error GoTo getPosdefID_ERR
    
    getPosdefID = 0
    
    
    If Not POS_STDPD.stdpdID = 0 Then
        getPosdefID = POS_STDPD.SP_PD.pdID
        Exit Function
    End If
    
    getPosdefID = pdID ' posdef определен, стандарт еще нет
    
    Exit Function
    
getPosdefID_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getPosdefID - Error"
    
End Function



'/******************************************************************************
Public Function setPosdefID(ByVal ID As Long, Optional bReserved As Boolean = False, Optional bResetPos As Boolean = True)
'/******************************************************************************
    
    On Error GoTo POSDEF_ERR
    
    If getPosdefID = ID Then Exit Function
    
    
    pdID = ID
    
    If ID = 0 Then
        mcIDover = 0
    End If
    
    ' сам posdef не сохраняем так как это не окончательное свойство позиции
    
    bUMCalc = True
    bCMCalc = True
    
    If bResetPos Then
        mcIDover = 0 ' обнуляем, так как возможен другой расчет массы
        setMaterial 0, False ' обнуляем материал
        setStandard 0
        setSrtm 0, False
    End If
    
    posQty = Round(POS_PD.pdDefQty, 5)
    
    Exit Function
    
POSDEF_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "POSDEF - Error"
    
End Function

'/******************************************************************************
Public Function setMatParams(ByVal ID As Long) As Boolean
'/******************************************************************************
    
    On Error GoTo setMatParams_ERR
    
'    If ID = 0 Then
'        Set mt = Nothing
'        matID = 0
'        matName = ""
''        Set matStd = Nothing
'    Else
'        Set mt = globMats(CStr(ID))
'        matID = mt.matID
'        matName = mt.matName
''        Set matStd = mt.matStd
'    End If
    
    
    matID = ID
    
'    matName = POS_MAT.matName
    
    
    
    
    Exit Function
    
setMatParams_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setMatParams - Error"
    
End Function


'/******************************************************************************
Public Function getStandardID() As Long
'/******************************************************************************

    On Error GoTo getStandardID_ERR

    
    
    getStandardID = 0
    
    If POS_STDPD.stdpdID > 0 Then
        If POS_STDPD.SP_STD.stdID > 0 Then
            getStandardID = POS_STDPD.SP_STD.stdID
            Exit Function
        End If
    End If
    
    
    
    
    Exit Function
    
    
Exit Function

getStandardID_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getStandardID - Error"

End Function

'/******************************************************************************
Public Property Get POS_MASS_SRTM() As Double
'/******************************************************************************

    On Error GoTo POS_MASS_SRTM_ERR
    
    Dim dmas As Double
    Dim matcor As Double
    
    If POS_MAT.matID > 0 Then
        matcor = POS_MAT.matMassCorrect
    Else
        matcor = -1#
    End If

    If Len(POS_MCALC.mcTable) = 0 Then
        dmas = 0#
    Else
        If pos_props.existsProperty(POS_MCALC.mcTable) Then
            dmas = pos_props(POS_MCALC.mcTable).propValue
        Else
            dmas = 0#
        End If
    End If

    If pos_props.existsProperty("dopmass") And bUseDopMass Then
        If pos_props("dopmass").hasValue Then
            dmas = dmas + pos_props("dopmass").propValue
        End If
    End If

    If matcor > 0# Then
        POS_MASS_SRTM = dmas * matcor
    Else
        POS_MASS_SRTM = dmas
    End If

Exit Property

POS_MASS_SRTM_ERR:
    POS_MASS_SRTM = 0#
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "POS_MASS_SRTM - Error"

End Property



'/******************************************************************************
Public Function setSrtm(ID As Long, Optional bSave As Boolean = True, Optional bReloadSrtm As Boolean = False) As Boolean
'/******************************************************************************
    
    On Error GoTo setSrtm_ERR
    
    
    Dim bExit As Boolean
    
    If srtmID = ID Then bExit = True
    
    srtmID = ID
    
'    If ID > 0 Then
'        If std Is Nothing Then Set std = globStds(CStr(POS_STDPD.std.stdID))
'        If std.stdID = 0 Then Set std = globStds(CStr(POS_STDPD.std.stdID))
'    End If
    
    If bExit Then
        setSrtm = True
        Exit Function
    End If
    
'    If bReloadSrtm Then getSrtmProps ' вместо reloadSrtmProps
    If bReloadSrtm And srtmID > 0 Then
        reloadSrtmProps
    ElseIf srtmID > 0 Then
        getSrtmProps
    End If
    
    Dim strSQL As String

    
    posUMass = getDbl(Me.POS_UMASS)
    posCMass = getDbl(Me.POS_CMASS)
    
    If bSave And ID <> 0 Then
        
        '====================================================
        
        Dim strColumns As String
        Dim strValues As String

        If posID = 0 Then
        
            If getPartID = 0 Then Exit Function
            
            posID = insertDataInBase(cn_data, POS_SRC_TABLE, "partID", getPartID, "srtmID", srtmID, "posQuantity", Me.posQty, "numDigits", Me.numDigits)
            
            If posID > 0 Then
                partID = parentPart.partID
                
                If F2.curPosIndex = 0 Then
                    parentPart.ps.AddPos Me, CStr(posID)
                Else
                    parentPart.ps.AddPos Me, CStr(posID), , F2.curPosIndex
                End If
                parentPart.updatePosNumbersInBase True
    
                fgp.TextMatrix(Me.fgRowToEdit, 4) = posID
    
                Call writeOperationS(operCreate, POS_SRC_TABLE, posID)
            End If
            
        Else
            
            Call updateTableInBase(cn_data, POS_SRC_TABLE, "srtmID", srtmID, "posID", posID)
            Call updateTableInBase(cn_data, POS_SRC_TABLE, "mcID", mcIDover, "posID", posID)
            
            Call writeOperationS(operModify, POS_SRC_TABLE, posID, "изменена поз. сортамента")
            
        End If

        
        '====================================================
        
    End If
    
    
    '        ' свойства по сортаменту:
    '        ' ...........
    '
    '        RaiseEvent srtmChanged(srtmID)
    
    setSrtm = True
    
    Exit Function
    
    
setSrtm_ERR:
    srtmID = 0
    
    '    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setSrtm - Error"
    
End Function




'/******************************************************************************
Public Property Get POS_SRTM() As clsSrtm
'/******************************************************************************

    On Error GoTo POS_SRTM_ERR
    
    If srtmID <= 0 Then
        Dim s As New clsSrtm
        s.srtmID = srtmID
        Set POS_SRTM = s
    Else
        Set POS_SRTM = globSrtm(CStr(srtmID))
    End If



Exit Property

POS_SRTM_ERR:
    Set POS_SRTM = New clsSrtm

End Property


'
''/******************************************************************************
'Public Function getMatName() As String
''/******************************************************************************
'
'    On Error GoTo getMatID_ERR
'
''    getMatName = ""
''
''    If Me.mt Is Nothing Then
''        Exit Function
''    End If
'
'    getMatName = Me.POS_MAT.matName
'
'
'    Exit Function
'
'getMatID_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getMatID - Error"
'
'End Function


'/******************************************************************************
Public Function getMatID() As Long
'/******************************************************************************
    
    On Error GoTo getMatID_ERR
    
'    getMatID = 0
'
'    If Me.mt Is Nothing Then
'        If matID > 0 Then Set mt = globMats(CStr(matID)) Else Exit Function
'    End If
    
    getMatID = Me.POS_MAT.matID
    
    
    Exit Function
    
getMatID_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getMatID - Error"
    
End Function


'/******************************************************************************
Public Function setMaterial(ByVal ID As Long, Optional bSave As Boolean = True) As Boolean
'/******************************************************************************
    
    On Error GoTo mat_ERR
    
    Dim bOk As Boolean
'    Dim sMatName As String
    
    If getMatID = ID Then Exit Function
    
    If bSave And posID = 0 Then Exit Function ' не сохраняем материал если позиция не определена
    
    
    If bSave And posID > 0 Then
        bOk = updateTableInBase(cn_data, POS_SRC_TABLE, "matID", ID, "posID", posID)
        
        If bOk Then setMatParams ID
        
'        If mt Is Nothing Then
'            sMatName = ""
'        Else
'            sMatName = POS_MAT.matName
'        End If
        
        If bOk Then
'            If Not F1.curPos Is Nothing Then F1.curPos.setMaterial ID, False
            Call writeOperationS(operModify, POS_SRC_TABLE, posID, "материал " & POS_MAT.matName)
        End If
        
        Exit Function
        
    End If
    
    setMatParams ID
    
    
    setMaterial = True
    
    Exit Function
    
mat_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "mat - Error"
    
End Function


'/******************************************************************************
Public Property Let POS_UMASS_REAL(ByVal v As Double)
'/******************************************************************************

    On Error GoTo POS_UMASS_REAL_ERR


    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from " & POS_SRC_TABLE & " where posID = " & posID, cn_data, adOpenForwardOnly, adLockOptimistic
    
    If RS.EOF Then Exit Property

    RS.MoveFirst
    
    

    If v > 0 Then
        bUMCalc = False
        posUMass = v
        RS.fields("posUnitMass").Value = v
    Else
        bUMCalc = True
'        posUMass = Me.POS_UMASS_REAL
'        RS.Fields("posUnitMass").Value = posUMass
    End If
    
    RS.fields("posUMCalc").Value = bUMCalc
    
    RS.Update
    
    RS.Close
    Set RS = Nothing
    
    Call writeOperationS(operModify, POS_SRC_TABLE, posID, "единичная масса " & v)
    
    
Exit Property

POS_UMASS_REAL_ERR:

End Property




'/******************************************************************************
Public Property Get POS_UMASS() As String
'/******************************************************************************

    POS_UMASS = FormatNumber(POS_UMASS_REAL, numDigits, , , vbFalse)


End Property
'/******************************************************************************
Public Property Get POS_UMASS_REAL() As Double
'/******************************************************************************
    
    Dim k As Double
    Dim r1 As Double
    Dim r2 As Double
    Dim th As Double
    Dim p As clsProp
    Dim ar As Double
    Dim bLap As Boolean
    
    Dim umass As Double
    
    If POS_SRTM.srtmID < 0 Then
        If bUMCalc Then
            If Me.posPrtMass = 0 Then
                umass = roundShaman(getPartMass(-POS_SRTM.srtmID), numDigits)
            Else
                umass = Me.posPrtMass '  Round(getPartMass(-POS_SRTM.srtmID), numDigits)
            End If
        End If
        POS_UMASS_REAL = umass
        Exit Property
    End If
    
    
    If POS_MCALC.mcID = -1 Then
        POS_UMASS_REAL = 0#
        Exit Property
    End If

    If POS_PD.pdID = 0 Then
        POS_UMASS_REAL = 0#
        Exit Property
    End If
    
    
'    posUMass = 0# ' здесь нельзя иначе обнуляется введенная вручную масса
    
    
    
    If bUMCalc Then
        
        
        If POS_MCALC.mcID = -1 Then
        
            umass = 0#
        
        ElseIf POS_MCALC.mcID = 5 Then
            
            If parentPart Is Nothing Then
                umass = 0#
            Else
            
                If cattypes(parentPart.PART_CAT.catTypeID).ctEnum = ctRein Then ' арматурный
                    umass = Round(getCatMass2(parentPart.PART_CAT.catID, Me.POS_PD.pdID, 5, Me.POS_PD.pdIDtoCalc), numDigits)
                Else
                    umass = parentPart.getPartMassPM(0)
                End If
                
            End If
            
            
        Else
            k = 1# ' то что будем умножать на POS_MASS_SRTM
            
            If POS_MCALC.mcID = 1 Then
                
                k = 1#
                
            ElseIf POS_MCALC.mcID = 2 Then
                
                k = Me.getPosLength(bCalcLap, bLap, True) ' SI!!!
                
'                k = pos_props.getPropSiValue("length")
                
            ElseIf POS_MCALC.mcID = 3 Then
            
                k = pos_props.getPropSiValue("area")
            
            ElseIf POS_MCALC.mcID = 4 Then
            
                k = pos_props.getPropSiValue("volume")
            
            ElseIf POS_MCALC.mcID = 6 Then
                
                ar = pos_props.getPropSiValue("area")
                th = pos_props.getPropSiValue("thickness")
                
                k = ar * th
                
            ElseIf POS_MCALC.mcID = 7 Then
                
                r1 = pos_props.getPropSiValue("length")
                r2 = pos_props.getPropSiValue("width")
                th = pos_props.getPropSiValue("thickness")
                
                k = r1 * r2 * th
                
            ElseIf POS_MCALC.mcID = 8 Then ' радиус на толщину
                
                ar = pos_props.getPropSiValue("segment")
                r1 = pos_props.getPropSiValue("radiusout")
                r2 = pos_props.getPropSiValue("radiusinn")
                th = pos_props.getPropSiValue("thickness")
                
                k = th * pi * (r1 ^ 2 - r2 ^ 2) * ar
                
            ElseIf POS_MCALC.mcID = 11 Then ' диаметр на толщину
                
                ar = pos_props.getPropSiValue("segment")
                r1 = pos_props.getPropSiValue("diamout") / 2#
                r2 = pos_props.getPropSiValue("diaminn") / 2#
                th = pos_props.getPropSiValue("thickness")
                
                k = th * pi * (r1 ^ 2 - r2 ^ 2) * ar
                
            ElseIf POS_MCALC.mcID = 9 Then
                
                r1 = pos_props.getPropSiValue("length")
                r2 = pos_props.getPropSiValue("width")
                
                k = r1 * r2
                
            ElseIf POS_MCALC.mcID = 10 Then
            
                k = 0#
            
            ElseIf POS_MCALC.mcID = 12 Then ' бетон
            
                POS_UMASS_REAL = 1#
                Exit Property
            
            ElseIf POS_MCALC.mcID = 14 Then ' плашка, ширина одинаковая
            
                r2 = pos_props.getPropSiValue("width")
                th = pos_props.getPropSiValue("thickness")
                
                k = r2 * r2 * th
            
            ElseIf POS_MCALC.mcID = 15 Then ' кольцо по радиусу
                
                ar = pos_props.getPropSiValue("length")
                r1 = pos_props.getPropSiValue("radiusout")
                r2 = pos_props.getPropSiValue("radiusinn")
                th = pos_props.getPropSiValue("thickness")
                
                k = ar * (r1 - r2) * th
            
            ' look for parent masscalc
            '==========================
            ElseIf POS_MCALC.calcID = 2 Then
                
                k = Me.getPosLength(bCalcLap, bLap, True)
                
            ElseIf POS_MCALC.calcID = 4 Then
            
                If pos_props.existsProperty("volume") Then
                
                    k = pos_props.getPropSiValue("volume")
                
                ElseIf pos_props.existsProperty("length") And pos_props.existsProperty("width") And pos_props.existsProperty("thickness") Then
                
                    r1 = pos_props.getPropSiValue("length")
                    r2 = pos_props.getPropSiValue("width")
                    th = pos_props.getPropSiValue("thickness")
                    
                    k = r1 * r2 * th
                    
                End If
            
            '==========================
            Else
                
                k = 0#
                
            End If
            
            
            
            If Me.parentPart Is Nothing Then
            
                umass = roundShaman(POS_MASS_SRTM * k, numDigits, , rndGlobal.iPosMass)
                
            Else
            
                If Me.parentPart.bRoundDefined Then
                    umass = roundShaman(POS_MASS_SRTM * k, numDigits, , Me.parentPart.iRoundLocalShift)
                Else
                    umass = roundShaman(POS_MASS_SRTM * k, numDigits, , rndGlobal.iPosMass)
                End If
                
            End If
            
            '            Dim A, b, c As Double
            '            A = POS_MASS_SRTM * k * 10
            '            b = Int(A)
            '            c = A - b
            '            If numDigits = 1 And c > 0.3 And c < 0.5 Then A = A + 0.2
            '            posumass = A / 10
            
            
'            umass = umass * POS_MAT.matMassCorrect
            
            
        End If
        
        
        If posUMass = 0# Then posUMass = umass
        
        POS_UMASS_REAL = umass
        
        
    Else
        POS_UMASS_REAL = posUMass
    
    End If
    
    
    
    
    
End Property



'/******************************************************************************
Public Property Let POS_CMASS_REAL(ByVal v As Double)
'/******************************************************************************

    On Error GoTo POS_CMASS_REAL_ERR


    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from " & POS_SRC_TABLE & " where posID = " & posID, cn_data, adOpenForwardOnly, adLockOptimistic
    
    If RS.EOF Then Exit Property

    RS.MoveFirst
    

    If v > 0 Then
        bCMCalc = False
        posCMass = v
        RS.fields("posCommonMass").Value = v
    Else
        bCMCalc = True
'        posCMass = Me.POS_CMASS_REAL
'        RS.Fields("posCommontMass").Value = posCMass
    End If
    
    RS.fields("posCMCalc").Value = bCMCalc
    
    RS.Update
    
    RS.Close
    Set RS = Nothing
    
    
    Call writeOperationS(operModify, POS_SRC_TABLE, posID, "общая масса " & v)
    
    
Exit Property

POS_CMASS_REAL_ERR:

End Property

''/******************************************************************************
'Public Property Get POS_CMASS_REAL() As Double
''/******************************************************************************
'
'    If POS_MCALC.mcID = 0 Then
'        posCMass = 0#
'    Else
'        If bCMCalc Then
'            If Len(POS_MCALC.mcTable) = 0 Then
'                posCMass = Round(POS_UMASS_REAL * posQty * 0.01, numDigits) ' проценты
'            Else
'                posCMass = POS_UMASS_REAL * posQty
'            End If
'        Else
'            posCMass = posCMass
'        End If
'    End If
'
'    POS_CMASS_REAL = posCMass
'
'End Property

'/******************************************************************************
Public Property Get POS_CMASS() As String
'/******************************************************************************

    Dim v As Double

    If bCMCalc Then
        If POS_MCALC.mcID = 5 Then
            v = Round(getDbl(POS_UMASS) * posQty * 0.01, numDigits)
        Else
            v = getDbl(POS_UMASS) * posQty
        End If
    Else
        v = posCMass
    End If

    If posCMass = 0# Then posCMass = v
    POS_CMASS = FormatNumber(v, numDigits, , , vbFalse)
    

'    If numDigits <= 0 Then
'        POS_CMASS = Format(posCMass, "0")
'    Else
'        POS_CMASS = Format(posCMass, "0." & Strings.String(numDigits, "0"))
'    End If
    
    

End Property


'/******************************************************************************
Public Function setQuantity(ByVal v As Double, Optional bSave As Boolean = True)
'/******************************************************************************
    
    On Error GoTo qty_ERR
    
    
    If bSave Then
        
        Dim RS As New ADODB.Recordset
        RS.Open "select * from " & POS_SRC_TABLE & " where posID = " & posID, cn_data, adOpenForwardOnly, adLockOptimistic
        If RS.EOF Then Exit Function
        RS.MoveFirst
        RS.fields("posQuantity").Value = v
        RS.Update
        RS.Close
        Set RS = Nothing
        Call writeOperationS(operModify, POS_SRC_TABLE, posID, "количество " & v)
        
    End If
    
    posQty = v
    
    
    
    
    Exit Function
    
qty_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "qty - Error"
    
End Function

'/******************************************************************************
Public Function loadDefalts()
'/******************************************************************************
    
    On Error GoTo loadDefalts_ERR
    
    
    
    Dim posdefID As Long
    Dim stdID As Long
    Dim stdpdID As Long
    Dim matID As Long
    Dim srtmID As Long
    Dim mass As Double
    
    Class_Initialize
    
    Dim RS As New ADODB.Recordset
    
    ' получаем данные по умолчанию для заполнения новой строчки
    
    If bUseCursorClient Then RS.CursorLocation = adUseClient
    
    RS.Open "select * from r_usr_rein where usrID = " & usrCurrent.usrID, cn_data, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        
        RS.MoveFirst
        
        If Not IsNull(RS.fields("posdefID").Value) Then
            Me.setPosdefID RS.fields("posdefID").Value
        Else
            Me.setPosdefID 0
        End If
        
        If Not IsNull(RS.fields("stdID").Value) Then
            Me.setStandard RS.fields("stdID").Value
        Else
            Me.setStandard 0
        End If
        
        If Not IsNull(RS.fields("srtmID").Value) Then
            Me.setSrtm RS.fields("srtmID").Value, False, True
        Else
            Me.setSrtm 0, False
        End If
        
        If Not IsNull(RS.fields("matID").Value) Then
            Me.setMaterial RS.fields("matID").Value, False
        Else
            Me.setMaterial 0, False
        End If
        
        RS.Close
        
    Else
        
        Me.setPosdefID 1
        
    End If
    
    
    Set RS = Nothing
    
    
    
    Exit Function
    
loadDefalts_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "loadDefalts - Error"
    
End Function


'/******************************************************************************
Public Property Let POS_MCALC(ByVal v As Variant)
'/******************************************************************************

    On Error GoTo POS_MCALC_ERR
    
    Dim mc As clsMC
    
    If typeName(v) = "clsMC" Then
        If v Is Nothing Then
            mcIDover = 0
        Else
            Set mc = v
            mcIDover = mc.mcID
        End If
    Else
        mcIDover = Val(v)
    End If



Exit Property

POS_MCALC_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "POS_MCALC - Error"

End Property

Public Property Get POS_MAT_STD_FULLNUMBER() As String
    On Error GoTo POS_STD_FULLNUMBER_ERR

    If Me.bTranslateStdType Then
        POS_MAT_STD_FULLNUMBER = POS_MAT.MAT_STD.FULLNUMBER_TRANSLATED
    Else
        POS_MAT_STD_FULLNUMBER = POS_MAT.MAT_STD.FULLNUMBER
    End If
    
    Exit Property

POS_STD_FULLNUMBER_ERR:
    POS_MAT_STD_FULLNUMBER = "ERROR_1012"

End Property


'/******************************************************************************
Public Property Get POS_STD_FULLNUMBER() As String
'/******************************************************************************

    On Error GoTo POS_STD_FULLNUMBER_ERR


    Dim strStd As String
    
    strStd = ""
    
    If Me.pos_props.existsProperty("number") Then
        If Me.pos_props("number").hasValue Then
            If Me.pos_props("number").PVAL > 0 Then strStd = Format(Me.pos_props("number").PVAL, "00") & " "
        End If
    End If

    If Me.bTranslateStdType Then
        POS_STD_FULLNUMBER = strStd & POS_STD.FULLNUMBER_TRANSLATED
    Else
        POS_STD_FULLNUMBER = strStd & POS_STD.FULLNUMBER
    End If

Exit Property

POS_STD_FULLNUMBER_ERR:
    POS_STD_FULLNUMBER = "ERROR_1011"
    
End Property



'/******************************************************************************
Public Property Get POS_STD() As clsStd
'/******************************************************************************

    On Error GoTo POS_STD_ERR
    
    If POS_STDPD.stdpdID > 0 Then
        If POS_STDPD.SP_STD.stdID > 0 Then
            Set POS_STD = globStds(CStr(POS_STDPD.SP_STD.stdID))
            Exit Property
        End If
    End If
    

'Exit Property

POS_STD_ERR:
    Set POS_STD = New clsStd

End Property


'/******************************************************************************
Public Property Get POS_STDPD() As clsStdPd
'/******************************************************************************

    On Error GoTo POS_STDPD_ERR



    If Not Me.POS_SRTM.srtmID = 0 Then
        If Not Me.POS_SRTM.stdpdID = 0 Then
            Set POS_STDPD = globStdPosdefs(CStr(Me.POS_SRTM.stdpdID))
            Exit Property
        End If
    End If
    
    
    If stdpdID > 0 Then
        Set POS_STDPD = globStdPosdefs(CStr(stdpdID))
        Exit Property
    End If




'Exit Property

POS_STDPD_ERR:
    Set POS_STDPD = New clsStdPd
    

End Property




'/******************************************************************************
Public Property Get POS_MCALC() As clsMC
'/******************************************************************************
    
    On Error GoTo POS_MCALC_ERR
    
    
'    If Me.POS_SRTM.srtmID < 0 Then
'        Set POS_MCALC = globMassCalcs(CStr(1)) ' масса единицы
'        Exit Property
'    End If
    
    
    If POS_PD.PD_MCALC.MC_PRNT Is Nothing Then
        mcIDover = 0
    ElseIf mcIDover <> 0 Then
        If POS_PD.PD_MCALC.existChildMC(mcIDover) Then
            Set POS_MCALC = globMassCalcs(CStr(mcIDover))
            Exit Property
        Else
            mcIDover = 0
        End If
    End If

    
    If mcIDover <> 0 Then
        Set POS_MCALC = globMassCalcs(CStr(mcIDover))
        Exit Property
    End If
    
    
    
    If Me.POS_SRTM.srtmID > 0 Then
        If Me.POS_SRTM.stdpdID > 0 Then
            
            If Me.POS_SRTM.SRTM_STDPD.mcID <> 0 Then
                Set POS_MCALC = globMassCalcs(CStr(Me.POS_SRTM.SRTM_STDPD.mcID))
            Else
                Set POS_MCALC = globMassCalcs(CStr(Me.POS_SRTM.SRTM_STDPD.SP_PD.mcID))
            End If
            
            Exit Property
        End If
    End If
    
    
    If Me.POS_STDPD.stdpdID > 0 Then
        
        If Me.POS_STDPD.mcID <> 0 Then
            Set POS_MCALC = globMassCalcs(CStr(Me.POS_STDPD.mcID))
        Else
            Set POS_MCALC = globMassCalcs(CStr(Me.POS_STDPD.SP_PD.mcID))
        End If
        
        Exit Property
    End If
    
    
    If Me.POS_PD.pdID > 0 Then
        Set POS_MCALC = globMassCalcs(CStr(Me.POS_PD.mcID))
        Exit Property
    End If
    
    
    Set POS_MCALC = globMassCalcs(CStr(-1)) ' не считать
    
    
    Exit Property
    
POS_MCALC_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "POS_MCALC - Error"
    
End Property



'/******************************************************************************
Private Sub updateValues()
'/******************************************************************************

    On Error GoTo updateValues_ERR

    '    flds(0) = "posIDold"
    '    flds(1) = "partID"
    '    flds(2) = "srtmID"
    '    flds(3) = "muID"
    '    flds(4) = "posQuantity"
    '    flds(5) = "matID"
    '    flds(6) = "posUnitMass"
    '    flds(7) = "posCommonMass"
    '    flds(8) = "mcID"
    '    flds(9) = "numDigits"
    '    flds(10) = "posNumber"
    '    flds(11) = "posUMCalc"
    '    flds(12) = "posCMCalc"
    '    flds(13) = "posSketch"
    '    flds(14) = "posBarLength"
    '    flds(15) = "objID"
    '    flds(16) = "posName"

    vls(0) = posIDold
    vls(1) = getPartID
    vls(2) = POS_SRTM.srtmID
    vls(3) = 1 ' later
    vls(4) = Round(posQty, 2)
    vls(5) = getMatID
    vls(6) = posUMass
    vls(7) = posCMass
    vls(8) = mcIDover
    vls(9) = numDigits
    vls(10) = posNumber ' номер позиции
    vls(11) = Abs(CLng(bUMCalc))
    vls(12) = Abs(CLng(bCMCalc))
    vls(13) = Abs(CLng(bSketch))
    vls(14) = Abs(CLng(bCalcLap))
    vls(15) = POS_OBJ
    vls(16) = posNote
    
Exit Sub

updateValues_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "updateValues - Error"

End Sub

Public Function loadDataFromRSrecord(ByRef RS As ADODB.Recordset, Optional strPref As String = "") As Boolean
    
    Dim r As Long
    
    loadDataFromRSrecord = False
    
    
    If RS.EOF Then
        posID = 0
        Exit Function
    End If
    
    If IsNull(RS.fields("posID").Value) Then Exit Function
    If IsNull(RS.fields(strPref & "srtmID").Value) Then Exit Function
    
    If parentPart Is Nothing Then
        partID = RS.fields("partID").Value
    Else
        If parentPart.bIsCat Then
            partID = RS.fields("catID").Value
        Else
            partID = RS.fields("partID").Value
        End If
    End If

    
    
    
    posID = RS.fields("posID").Value
    
    srtmID = RS.fields(strPref & "srtmID").Value
    
    If srtmID = 0 Then
        MsgBox "В функции loadDataFromRSrecord() srtmID = 0 для posID = " & posID, vbCritical, "Ошибка"
        Exit Function
    End If
    
    If RS.fields("posUnitMass").Value = 0# Or RS.fields("posCommonMass").Value = 0# Then
        bMustUpdate = True
    Else
        bMustUpdate = False
    End If
    
'    posPrtName = RS.Fields("partName").Value & ""
    
    posNote = getFieldStringValue(RS, "posName", "")
    
    'If Not IsNull(RS.fields("posName").Value) Then ' posNote
    '    posNote = Trim(RS.fields("posName").Value)
    'End If
    
    
    posUMass = RS.fields("posUnitMass").Value
    posCMass = RS.fields("posCommonMass").Value
    
    bUMCalc = CBool(RS.fields("posUMCalc").Value)
    bCMCalc = CBool(RS.fields("posCMCalc").Value)
    bSketch = CBool(RS.fields("posSketch").Value)
    bCalcLap = CBool(RS.fields("posBarLength").Value)
    
    ' === masscalc ===
    If RS.fields("mcID").Value <> POS_PD.mcID Then ' override (или ошибка?)
        mcIDover = RS.fields("mcID").Value
        If Not POS_PD.PD_MCALC.existChildMC(mcIDover) Then mcIDover = 0
    End If
    ' ================
    
    
    posNumber = RS.fields("posNumber").Value
    
    If Not POS_PD.bPosNum Then
        posNumber = 0
    End If
    
'    If Len(POS_MCALC.mcTable) > 0 Then
'        posUMassSrtm = sm.srtm_props(POS_MCALC.mcTable).PVAL
'    End If
    
    
    posQty = RS.fields("posQuantity").Value
    
    
    If IsNull(RS.fields("numDigits").Value) Then
        numDigits = getNumDigitsDefault(iNumDigitsDefault)
    Else
        numDigits = RS.fields("numDigits").Value
    End If
    
    
'    Set std = POS_SRTM.stdpd.std
    
    If Not IsNull(RS.fields("matID").Value) Then
        setMatParams RS.fields("matID").Value
    Else
        setMatParams 0
    End If
    
    
    pos_objID = POS_OBJ
    
    
    updateValues
    
    
    loadDataFromRSrecord = True
    
End Function

'/******************************************************************************
' NOT USING
Private Function getSrtmDblPropertyFromRS(ByRef propValue As Double, ByRef RS As ADODB.Recordset, propName As String) As Boolean
'/******************************************************************************

    On Error GoTo getSrtmMass_ERR

    propValue = RS.fields("srtm_" & propName).Value

    getSrtmDblPropertyFromRS = True
Exit Function

getSrtmMass_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "getSrtmMass - Error"

End Function


'/******************************************************************************
' NOT USING
Private Function getPosDblPropertyFromRS(ByRef propValue As Double, ByRef RS As ADODB.Recordset, propName As String) As Boolean
'/******************************************************************************

    On Error GoTo getPosPropertyFromRS_ERR

    propValue = RS.fields("pos_" & propName).Value

    getPosDblPropertyFromRS = True
Exit Function

getPosPropertyFromRS_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "getPosPropertyFromRS - Error"

End Function



'/******************************************************************************
Public Function import(ByRef RS As ADODB.Recordset) As Boolean
'/******************************************************************************
    
    Dim posdefID As Long
    Dim posdefName As String
    Dim prop As clsProp
    
    On Error GoTo import_ERR
    
    
    Dim dval As Double
    
    import = False
    
    posIDold = RS.fields("Счетчик").Value ' присвоение для того чтобы был уникальный ключ в коллекции
    
    If Not IsNull(RS.fields("Номер позиции").Value) Then
        posNumber = CDbl(RS.fields("Номер позиции").Value)
    Else
        posNumber = 0#
    End If
        
    
    ' характеристика позиции
    '================
    posdefName = RS.fields("Характеристика позиции").Value & "" ' предварительное присвоение
    
    
    ' узнаем, есть ли такая хар-ка среди синонимов
    posdefID = selectLongFromBase(cn_srtm, "view_posdef_synonims", "posdefID", "posdefSyn", posdefName)
    
    
    If posdefID > 0 Then ' есть, возвращаем настоящее именование
        posdefName = selectStringFromBase(cn_srtm, "view_posdef_synonims", "posdefName", "posdefID", posdefID)
    Else
        ' среди синонимов нет, берем ID по именованию хар-ки
        posdefID = selectLongFromBase(cn_srtm, "posdef", "posdefID", "posdefName", posdefName)
    End If
    
    
    
    If posdefID = 0 Then ' вообще не нашел такой хар-ки
        ' ERROR!!!
        FLog.addLog "pos", posIDold, "не определить posdef", True, True
        Exit Function
    End If
    
    Me.setPosdefID posdefID, , True ' определяем свойства posdef
    '================
    
    Dim srmp As String
    srmp = RS.fields("Способ расчета массы позиции").Value & ""
    If srmp = "кольцо" Then
        Me.POS_MCALC = 8
    End If
    
    
    ' стандарт
    ' ====================================================
    Dim stdFullNumber As String
    Dim ar() As String
    
    stdFullNumber = RS.fields("ГОСТ на профиль позиции").Value & ""
    
    stdFullNumber = Replace(stdFullNumber, "ГОСТ 103-76", "ГОСТ 103-2006")
    
    If Len(stdFullNumber) = 0 And posdefName = "Электроды" Then ' электроды
        stdFullNumber = RS.fields("Материал позиции").Value & ""
    End If
    
    If Len(stdFullNumber) > 0 Then
        If InStr(1, stdFullNumber, "ОСТ") > 0 Then
            ar = Split(stdFullNumber, " ")
            If UBound(ar) = 1 Then
                Dim std As New clsStd
                If std.setByNumber(ar(0), ar(1)) Then
                    Me.setStandard std.stdID
                Else
                    FLog.addLog "pos", posIDold, "не определить стандарт " & stdFullNumber, True, True
                    Exit Function
                End If
            Else
                FLog.addLog "pos", posIDold, "не определить имя стандарта " & stdFullNumber, True, True
                Exit Function
            End If
        ElseIf left(stdFullNumber, 2) = "ТУ" Then
            ar = Split(stdFullNumber, " ")
            If UBound(ar) = 1 Then
                Set std = New clsStd
                If std.setByNumber(ar(0), ar(1)) Then
                Else
                    FLog.addLog "pos", posIDold, "не определить стандарт " & stdFullNumber, True, True
                    Exit Function
                End If
            Else
                Set std = New clsStd
                If std.setByNumber("ТУ", right(stdFullNumber, Len(stdFullNumber) - 3)) Then
                Else
                    FLog.addLog "pos", posIDold, "не определить имя стандарта " & stdFullNumber, True, True
                    Exit Function
                End If
            
            End If
        Else
            FLog.addLog "pos", posIDold, "стандарт не является ГОСТом или ОСТом - " & stdFullNumber, True, True
            Exit Function
        End If
    Else
        FLog.addLog "pos", posIDold, "имя стандарта не определено", True, True
        Exit Function
    End If
    
    
    Dim stdposdefID As Long
    
    
    stdposdefID = selectLongFromBase(cn_srtm, "r_standard_posdef", "relID", "stdID", std.stdID, "posdefID", POS_PD.pdID)
    
    
    If stdposdefID = 0 Then
        FLog.addLog "pos", posIDold, "не найдено отношение " & posdefName & " и стандарта " & stdFullNumber, True, True
        Exit Function
    End If
    
    Dim stdpd As clsStdPd
    Set stdpd = globStdPosdefs(CStr(stdposdefID))
    
    ' сортамент
    '====================================================
    
    posPrtName = RS.fields("Наименование позиции").Value & "" ' предварительное присвоение
    
    If left(posPrtName, 1) = "d" Then posPrtName = right(posPrtName, Len(posPrtName) - 1)
    posPrtName = Replace(posPrtName, ",", ".")

    
    If StrComp(posdefName, "Электроды") = 0 Then
        srtmID = selectLongFromBase(cn_srtm, "sortament", "srtmID", "srtmName", posPrtName)
        
        If srtmID = 0 Then
            posPrtName = Replace(posPrtName, "-", "")
            srtmID = selectLongFromBase(cn_srtm, "sortament", "srtmID", "srtmName", posPrtName)
        End If
        
        stdposdefID = selectLongFromBase(cn_srtm, "sortament", "stdposdefID", "srtmID", srtmID)
        Call std.setStdID(selectLongFromBase(cn_srtm, "r_standard_posdef", "stdID", "posdefID", POS_PD.pdID, "relID", stdposdefID))
    Else
        
        srtmID = selectLongFromBase(cn_srtm, "sortament", "srtmID", "stdposdefID", stdposdefID, "srtmName", posPrtName)
        
        If srtmID = 0 Then
            posPrtName = Replace(posPrtName, "-", "")
            srtmID = selectLongFromBase(cn_srtm, "sortament", "srtmID", "stdposdefID", stdposdefID, "srtmName", posPrtName)
        End If
    End If
    
    
    
    If srtmID = 0 Then
        FLog.addLog "pos", posIDold, "не найдена позиция сортамента " & posdefName & " " & posPrtName & " " & stdFullNumber, True, True
        Exit Function
    End If
        
    
    
'    posUMassSrtm = selectDoubleFromBase(cn_srtm, "r_sortament_property", POS_MCALC.mcTable, "srtmID", srtmID)
    
    
'    getSrtmProps ' вместо reloadSrtmProps
    reloadSrtmProps
    
    '================
    
    
  
    
    
    If Not IsNull(RS.fields("Количество позиций").Value) Then
        posQty = CDbl(RS.fields("Количество позиций").Value)
    Else
        posQty = 0
    End If
    
    
    
    If Not IsNull(RS.fields("Единичная масса позиции").Value) Then
        posUMass = CDbl(RS.fields("Единичная масса позиции").Value)
        bUMCalc = False
    Else
        posUMass = 0#
        bUMCalc = True
    End If
    
    If Not IsNull(RS.fields("Общая масса позиции").Value) Then
        posCMass = CDbl(RS.fields("Общая масса позиции").Value)
        bCMCalc = False
    Else
        posCMass = 0#
        bCMCalc = True
    End If
    
'    If Not IsNull(RS.Fields("Обозначение позиции").Value) Then
'        Set prop = prop.fromExisting("description")
'        prop.propValue = RS.Fields("Обозначение позиции").Value
'        pos_props.AddNewProp prop
'    End If
    
    
'    класс арматуры
    Dim strArmClass As String
    If Not IsNull(RS.fields("Класс арматуры позиции").Value) Then
        strArmClass = RS.fields("Класс арматуры позиции").Value
        If strArmClass = "A-III" Then
            strArmClass = "А400 "
        ElseIf strArmClass = "A-I" Then
            strArmClass = "A240 "
        Else
            strArmClass = ""
        End If
    End If
    
    ' материал
    ' =====================================================
    Dim strNew(2) As String
    Dim strOld As String
    Dim bFound As Boolean
    bFound = False
    
    If Not StrComp(posdefName, "Электроды") = 0 Then
        Dim RSM As New ADODB.Recordset
        
        If bUseCursorClient Then RSM.CursorLocation = adUseClient
        
        RSM.Open "select * from view_r_posdef_material where posdefID = " & POS_PD.pdID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RSM.EOF Then
            If Not IsNull(RS.fields("Материал позиции").Value) Then
            
                strOld = strArmClass & RS.fields("Материал позиции").Value
                strOld = makeStringRussian(strOld)
                strOld = Replace(strOld, "Ст3 кп", "Ст3кп")
                strOld = Replace(strOld, "380-94", "380-2005")
                strOld = Replace(strOld, "535-88", "535-2005")
                If strOld = "25Г2С" Then strOld = "A240 25Г2С"
                
                RSM.MoveFirst
                Do
                
                    
                    strNew(0) = RSM.fields("matName").Value
                    strNew(1) = RSM.fields("stdTypeName").Value
                    strNew(2) = RSM.fields("stdNumber").Value
                    
                    strNew(0) = makeStringRussian(strNew(0))
                    strNew(1) = makeStringRussian(strNew(1))
                    strNew(2) = makeStringRussian(strNew(2))
                    strNew(2) = Replace(strNew(2), "*", "")
                    
                    If InStr(strOld, strNew(0)) > 0 And InStr(strOld, strNew(1)) > 0 And InStr(strOld, strNew(2)) > 0 Then
                        matID = RSM.fields("matID").Value
                        bFound = True
                        Exit Do
                    End If
                
                    RSM.MoveNext
                Loop Until RSM.EOF
            
            
            
            Else ' материал для позиции не определен
            
                FLog.addLog "pos", posIDold, "не определен материал для позиции", True, True
'                Exit Function
            
            End If
        Else ' в базе нет такого posdefID
        
            FLog.addLog "pos", posIDold, "не найден материал " & strOld & " для " & posdefName, True, True
            Exit Function
        
        End If
        
'        If bFound Then
'            matName = RSM.Fields("matName").Value
''            Set matStd = globStds(CStr(RSM.Fields("stdID").Value))
'        Else
'
'            FLog.addLog "pos", posIDold, "не найден материал " & strOld & " для " & posdefName, True, True
''            Exit Function
'
'            matID = 0
'            matName = ""
'        End If
        
        RSM.Close
        Set RSM = Nothing
    
    End If
    

    
    ' ======= геометрические параметры ================
    ' =====================================================
    
    
    If Not (RS.fields("Длина позиции").Value = 1000) Then addd RS, "Длина позиции", "length"
    addd RS, "Сегмент кольца позиции", "segment"
    addd RS, "Диаметр позиции", "diameter"
    addd RS, "Радиус позиции", "radiusout"
    addd RS, "Внешний радиус позиции", "radiusout"
    addd RS, "Внутренний радиус позиции", "radiusinn"
    addd RS, "Толщина позиции", "thickness"
    addd RS, "Ширина позиции", "width"
    addd RS, "Высота позиции", "height"
    addd RS, "Шаг позиций", "spacing"
    

'    Debug.Print Me.posNumber
    
    import = True
    
    
    
    Exit Function
    
import_ERR:
    import = False
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "import - Error"
    
End Function

'/******************************************************************************
Public Function getEmptyPropsQty() As Integer
'/******************************************************************************

    On Error GoTo getEmptyProps_ERR

    Dim prop As clsProp
    Dim iEmptyProps As Integer


    iEmptyProps = 0
    For Each prop In pos_props
        If prop.bMassCalc And IsEmpty(prop.propValue) Then
            iEmptyProps = iEmptyProps + 1
        End If
    Next prop
    
    getEmptyPropsQty = iEmptyProps

Exit Function

getEmptyProps_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getEmptyProps - Error"

End Function


'/******************************************************************************
Private Sub addd(ByRef RS As ADODB.Recordset, strFrom As String, strIn As String)
'/******************************************************************************
    
    On Error GoTo addd_ERR
    
    Dim v As Variant
    
    v = RS.fields(strFrom).Value
    
    If IsNull(v) Or IsEmpty(v) Or v = "" Or v = 0 Then
        Exit Sub
    End If
    
    Dim prop As New clsProp
    Set prop = prop.fromExisting(strIn)
    Set prop = pos_props.AddNewProp(prop)
    prop.propValue = v
    
    
    
    Exit Sub
    
addd_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "addd - Error"
    
End Sub


Public Sub fgAddEmptyRow(Optional Row As Long = 0, Optional bUpdateMasses As Boolean = True)
    
    Dim r As Long
    
    If Row = 0 Then
        fgp.AddItem "" & vbTab & vbTab & vbTab & vbTab & Me.posID
        r = fgp.Rows - 1
        If bUpdateMasses Then F1.curPart.updateMasses False
    Else
        fgp.AddItem "" & vbTab & vbTab & vbTab & vbTab & Me.posID, Row
        r = Row
    End If
    
    
    
    
    fgp.RowHeight(r) = 480
    fgp.Cell(flexcpFontBold, r, 1, , 3) = True
    fgp.IsSubtotal(r) = True
    '    fgp.Cell(flexcpData, r, 0) = RS![posID]
    
    '    fgp.Cell(flexcpPicture, r, 0) = ImageList4.ListImages(ImIndex).ExtractIcon
    
    
    
    
    
    
    
End Sub

Private Function getNumDigitsDefault(iDef As Integer, Optional bUsePDS As Boolean = True) As Integer

    On Error GoTo err
    
    If bUsePDS Then
        If usrCurrent.pdsID = 0 Then
            getNumDigitsDefault = iDef
        Else
            Dim pds As clsPDSet
            Set pds = getColItem(globPDSets, CStr(usrCurrent.pdsID))
            If Not pds Is Nothing Then
                getNumDigitsDefault = pds.iMassRoundNumDigits
            End If
        End If
    Else
        getNumDigitsDefault = iDef
    End If
    
    
    Exit Function
err:
    getNumDigitsDefault = iDef


End Function


'/******************************************************************************
Private Sub Class_Initialize()
'/******************************************************************************

    On Error GoTo Class_Initialize_ERR

'

    Set pos_props = New colProp

    bCalcLap = F1.mnuPrefLap.Checked
    
    bUMCalc = True
    bCMCalc = True
    
    Set fgp = F1.fgPositions
    
    posQty = 1#
    
    posMassKoef = 1#
    
    numDigits = getNumDigitsDefault(iNumDigitsDefault)
    

    ReDim flds(0 To 16)
    ReDim vls(0 To 16)
    ReDim vls_new(0 To 16)
    
    flds(0) = "posIDold"
    flds(1) = "partID"
    flds(2) = "srtmID"
    flds(3) = "muID"
    flds(4) = "posQuantity"
    flds(5) = "matID"
    flds(6) = "posUnitMass"
    flds(7) = "posCommonMass"
    flds(8) = "mcID"
    flds(9) = "numDigits"
    flds(10) = "posNumber"
    flds(11) = "posUMCalc"
    flds(12) = "posCMCalc"
    flds(13) = "posSketch"
    flds(14) = "posBarLength" ' флаг расчета нахлеста
    flds(15) = "objID"
    flds(16) = "posName"

    Set pointsSkch = New Collection

    Set pointsDraw = New Collection
    
    Set pointsComp = New Collection
    Set pointsCompAlt = New Collection
    
    pos_objID = objs("part") ' по умолчанию

Exit Sub

Class_Initialize_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "Class_Initialize - Error"

End Sub

'/******************************************************************************
Private Sub Class_Terminate()
'/******************************************************************************

    On Error GoTo Class_Terminate_ERR

'

    Set pos_props = Nothing

    Set pointsSkch = Nothing

    Set pointsDraw = Nothing

    Set pointsComp = Nothing
    Set pointsCompAlt = Nothing

Exit Sub

Class_Terminate_ERR:

End Sub

'/******************************************************************************
Public Function reloadSrtmPropsFromRS(ByRef RS As ADODB.Recordset, Optional bReloadMassCalc As Boolean = True) As Boolean
'/******************************************************************************
    
    On Error GoTo reloadSrtmPropsFromRS_ERR
    
    Dim i As Integer
    
    
    Dim cp As New colProp ' копия массива свойств для сохранения значений при его перезагрузке
    
    
    
    Dim s As String
    
    
    ' удаляем неиспользуемые свойства сортамента
    Dim prop As clsProp
    For Each prop In pos_props
        If prop.hasValue Then
            cp.AddSimple prop, prop.propName
        End If
        If prop.bMassCalc Or prop.bEditable = False Then pos_props.Remove prop.propName
    Next prop
    
    
    If RS.EOF Then Exit Function
    
    
    If Not IsNull(RS.fields("srtmID").Value) And POS_SRTM.srtmID = RS.fields("srtmID").Value Then
        
        For i = 0 To RS.fields.Count - 1
            
            s = RS.fields(i).Name
            
            If globProps.existsProperty(s) Then ' если в поле свойство
                
                If Not IsNull(RS.fields(i).Value) Then
                    If Not pos_props.existsProperty(s) Then
                        Set prop = pos_props.AddByPropName(s, Me, True)
                    Else
                        Set prop = pos_props(s)
                    End If
                    Set prop.pos = Me
                    prop.setValue RS.fields(i).Value
                End If
                
            End If
            
        Next i
        
    End If
    
    
    If bReloadMassCalc And getPosdefID > 0 Then
        
        
        
        Dim mc As clsMC
        Dim pr As clsProp
        
        
        For Each pr In POS_MCALC.mc_props
            
            s = pr.propName
            
            If globProps.existsProperty(s) Then ' если в поле свойство
                
                If Not pos_props.existsProperty(s) Then
                    Set prop = pos_props.AddByPropName(s, Me)
                Else
                    Set prop = pos_props(s)
                End If
                
                
                If cp.existsProperty(s) Then
                    If cp(s).bEditable Then prop.setValue cp(s).propValue ' оставляем только если было введено вручную
                End If
                
                Set prop.pos = Me
                prop.bMassCalc = True
                
            End If
            
        Next pr
        
    End If
    
    Set cp = Nothing
    
    ' удаляем дублирующуюся массу если есть
    For Each pr In pos_props
        If pr.bMassCalc = False And left(pr.propName, 4) = "mass" Then
            pos_props.Remove pr.propName
        End If
    Next pr
    
    
    reloadSrtmPropsFromRS = True
    
    Exit Function
    
reloadSrtmPropsFromRS_ERR:
    '    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "reloadSrtmPropsFromRS - Error"
    
End Function


'/******************************************************************************
Public Function reloadPosPropsFromRS(ByRef RS As ADODB.Recordset, Optional strPref As String = "") As Boolean
'/******************************************************************************
    
    On Error GoTo reloadPosPropsFromRS_ERR
    
    Dim s As String
    Dim i As Integer
    Dim bOno As Boolean
    
    Dim prop As clsProp
    
    For Each prop In pos_props
        If Not (prop.bMassCalc Or prop.bEditable = False) Then pos_props.Remove prop.propName
    Next prop
    
    For i = 0 To RS.fields.Count - 1
        
        s = RS.fields(i).Name
        
        If Len(strPref) > 0 Then
            bOno = CBool(left(s, Len(strPref)) = strPref)
            s = Replace(s, strPref, "")
        Else
            bOno = True
        End If
        
        If bOno And Not IsNull(RS.fields(i).Value) Then
            
            If globProps.existsProperty(s) Then ' если в поле свойство
                
                If Not pos_props.existsProperty(s) Then
                    
                    Set prop = pos_props.AddByPropName(s, Me)
                    
                Else
                    Set prop = pos_props(s)
                    
                End If
                
                Set prop.pos = Me
                If prop.bEditable Then prop.setValue RS.fields(i).Value ' не заменяем значение из сортамента
                
            End If
            
        End If
        
    Next i
    
    
    
    reloadPosPropsFromRS = True
    Exit Function
    
reloadPosPropsFromRS_ERR:
    '    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "reloadPosPropsFromRS - Error"
    
End Function




'/******************************************************************************
Public Function reloadPosProps() As Boolean
'/******************************************************************************
    
    On Error GoTo reloadPosProps_ERR
    
    Dim RSM As New ADODB.Recordset
    Dim s As String
    Dim i As Integer
    
    Dim prop As clsProp
    
    For Each prop In pos_props
        If Not (prop.bMassCalc Or prop.bEditable = False) Then pos_props.Remove prop.propName
    Next prop
    
    If bUseCursorClient Then RSM.CursorLocation = adUseClient
    
    RSM.Open "select * from r_" & POS_SRC_TABLE & "_property where posID = " & posID, cn_data, adOpenForwardOnly, adLockReadOnly
    
    If Not RSM.EOF Then
        RSM.MoveFirst
        
        For i = 2 To RSM.fields.Count - 1
                
                s = RSM.fields(i).Name
                
                If Not IsNull(RSM.fields(i).Value) Then
                    
                    If Not pos_props.existsProperty(s) Then
                        
                        Set prop = pos_props.AddByPropName(s, Me)
                        
                    Else
                        Set prop = pos_props(s)
                        
                    End If
                    
                    Set prop.pos = Me
                    If prop.bEditable Then prop.setValue RSM.fields(i).Value ' не заменяем значение из сортамента
                    
                End If
                
        Next i
        
    End If
    
    RSM.Close
    Set RSM = Nothing
    
    
    Exit Function
    
reloadPosProps_ERR:
    Set RSM = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "reloadPosProps - Error"
    
End Function


'/******************************************************************************
' сделана для замены reloadSrtmProps для перехода на сортамент в памяти
Public Function getSrtmProps() As Boolean
'/******************************************************************************

    On Error GoTo getSrtmProps_ERR

    
    Dim pos_prop As clsProp
    Dim srtm_prop As clsProp
    Dim mc_prop As clsProp
    
'    If srtmID = 0 Then ' posdef может быть определен
'        Set pos_props = New colProp
'        getSrtmProps = True
'        Exit Function
'    End If
    
    Dim cp As New colProp ' для запоминания
    
    For Each pos_prop In pos_props
        If pos_prop.hasValue Then
            cp.AddSimple pos_prop, pos_prop.propName
        End If
        If pos_prop.bMassCalc Or pos_prop.bEditable = False Then pos_props.Remove pos_prop.propName
    Next pos_prop
    
    If POS_SRTM.srtmID > 0 Then
        For Each srtm_prop In POS_SRTM.srtm_props
            
            If Not pos_props.existsProperty(srtm_prop.propName) Then
                Set pos_prop = pos_props.AddByPropName(srtm_prop.propName, Me, True)
            Else
                Set pos_prop = pos_props(srtm_prop.propName)
            End If
            
            Set pos_prop.pos = Me
            pos_prop.propValue = srtm_prop.propValue
            
        Next srtm_prop
    End If
    
    If getPosdefID > 0 Then
    
        If Not POS_MCALC.mc_props Is Nothing Then
        
            For Each mc_prop In POS_MCALC.mc_props
            
                If Not pos_props.existsProperty(mc_prop.propName) Then
                    Set pos_prop = pos_props.AddByPropName(mc_prop.propName, Me, False)
                Else
                    Set pos_prop = pos_props(mc_prop.propName)
                End If
                
                If cp.existsProperty(mc_prop.propName) Then
                    If cp(mc_prop.propName).bEditable Then pos_prop.setValue cp(mc_prop.propName).propValue ' оставляем только если было введено вручную
                End If
                
                Set pos_prop.pos = Me
                pos_prop.bMassCalc = True
            
            Next mc_prop
        
        End If

    End If
    
    getSrtmProps = True
    
    
    
    
Exit Function

getSrtmProps_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "getSrtmProps - Error"

End Function




'/******************************************************************************
' должна быть заменена на getSrtmProps ??? (сортамент - в память)
Public Function reloadSrtmProps() As Boolean
'/******************************************************************************
    
    On Error GoTo reloadSrtmProps_ERR
    
    Dim RSM As ADODB.Recordset
    Dim i As Integer
    Dim s As String
    
    Dim cp As New colProp
    
    
    Dim prop As clsProp
    Dim propTA As clsProp
    
    For Each prop In pos_props
        If prop.hasValue Then
            cp.AddSimple prop, prop.propName
        End If
        If prop.bMassCalc Or prop.bEditable = False Then pos_props.Remove prop.propName
    Next prop
    
    If POS_SRTM.srtmID > 0 Then
        
        Set RSM = New ADODB.Recordset
        
        If bUseCursorClient Then RSM.CursorLocation = adUseClient
        
        RSM.Open "select * from view_r_sortament_property_3 where srtmID = " & srtmID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        
        
        If Not RSM.EOF Then
            RSM.MoveFirst
            
            For i = 0 To RSM.fields.Count - 1
                
                s = RSM.fields(i).Name
                
                If Not (LCase(left(s, 4)) = "srtm" Or LCase(right(s, 2)) = "id") Then
                
                    If Not IsNull(RSM.fields(i).Value) Then
                        If Not pos_props.existsProperty(s) Then
                            Set prop = pos_props.AddByPropName(s, Me, True)
                        Else
                            Set prop = pos_props(s)
                        End If
                        Set prop.pos = Me
                        prop.setValue RSM.fields(i).Value
                    End If
                
                End If
                
            Next i
            
        End If
        
        RSM.Close
        
        Set RSM = Nothing
        
    End If
    
    
    If getPosdefID > 0 Then
    
        
        
        Dim pr As clsProp
        
        
        If Not POS_MCALC.mc_props Is Nothing Then
        
            For Each pr In POS_MCALC.mc_props
            
                s = pr.propName
                
                If Not pos_props.existsProperty(s) Then
                    Set prop = pos_props.AddByPropName(s, Me)
                Else
                    Set prop = pos_props(s)
                End If
                
                If cp.existsProperty(s) Then
                    If cp(s).bEditable Then prop.setValue cp(s).propValue ' оставляем только если было введено вручную
                End If
                
                Set prop.pos = Me
                prop.bMassCalc = True
            
            Next pr
        
        End If

    End If
    
    Set RSM = Nothing
    Set cp = Nothing
    
    
    Exit Function
    
reloadSrtmProps_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "reloadSrtmProps - Error"
    
End Function





'/******************************************************************************
Public Sub updatePosRow(Row As Long, ByRef bUpdated As Boolean, Optional bReloadProps As Boolean = False, Optional bRecalcPartRows As Boolean = True, Optional bReloadsPropsFromBase As Boolean = True, Optional bForceMassUpdate As Boolean = False)
'/******************************************************************************
    
    On Error GoTo updatePosRow_ERR
    
    Dim sID As String
    Dim iID As String
    sID = fgp.TextMatrix(Row, 4)
    iID = Val(fgp.TextMatrix(Row, 4))
    If Len(sID) = 0 Then Exit Sub
    If iID = 0 Then Exit Sub
    Dim p As clsProp
    Dim strUMassDop As String
    Dim strCMassDop As String
    
    'gotick True
    Dim r As Long
    r = Row + 1
    
    Dim bCh As Boolean
    Dim qty As Double
    qty = getPosQty(bCh)
    
    
    If bReloadProps Then
    'If bReloadProps Or bCh Then
        
        If bReloadsPropsFromBase Then
'            getSrtmProps ' вместо reloadSrtmProps
            reloadSrtmProps
            reloadPosProps
        End If
        
        ' ========== properties ==================
        
        
        If r < fgp.Rows Then
            Do While Val(fgp.TextMatrix(r, 4)) = posID
                fgp.RemoveItem r
            Loop
        End If
        
        For Each p In pos_props
            If p.bMassCalc And p.bEditable Then
                p.addFgRow r
                r = r + 1
            End If
        Next p
        
        For Each p In pos_props
            If p.bMassCalc And Not p.bEditable Then
                p.addFgRow r
                r = r + 1
            End If
        Next p
        
        For Each p In pos_props
            If Not p.bMassCalc Then
                p.addFgRow r
                r = r + 1
            End If
        Next p
        
    End If
    
    'gotick False, "bReloadProps"
    
    
    If Me.POS_SRTM.srtmID < 0 And bReloadProps Then
        Dim strPath As String
        strPath = cCats(CStr(Me.posPrtCatID)).getCatPath(True)

        If Len(strPath) > 0 Then
            Me.fgp.AddItem strPath & vbTab & strPath & vbTab & strPath & vbTab & strPath & vbTab & Me.posID, r

            Me.fgp.MergeRow(r) = True
            Me.fgp.IsSubtotal(r) = True
            Me.fgp.RowOutlineLevel(r) = 1
        End If

    End If
    
    
    'gotick False, "selectStringFromBase"
    'gotick True
    
    If Me.parentPart.partStatusID = pst.pstRazrabotka And Not bCatIsBlocked And bForceMassUpdate Then
    
        If updateTableInBase(cn_data, POS_SRC_TABLE, "posUnitMass", getDbl(POS_UMASS), "posID", posID) Then bUpdated = True
        'gotick False, "posUnitMass"
        If updateTableInBase(cn_data, POS_SRC_TABLE, "posCommonMass", getDbl(POS_CMASS), "posID", posID) Then bUpdated = True
        'gotick False, "posCommonMass"
        updateTableInBase cn_data, POS_SRC_TABLE, "posBarLength", Abs(CBool(Me.bCalcLap)), "posID", posID
        'gotick False, "posBarLength"

        If Me.getIndex = 1 Then
'            updateTableInBase cn_data, "part", "partMainPosEP", isInRunMet, "partID", Me.parentPart.partID
            'gotick False, "partMainPosEP"
            F1.checkListParts Me.partID, isInRunMet
            'gotick False, "checkListParts"
        End If
        
        If bUpdated Then writeOperationS operModify, POS_SRC_TABLE, Me.posID, "обновление массы позиции"

    ElseIf bForceMassUpdate Then
        If Me.bUMCalc And Me.posUMass > 0 Then
            If Abs((Me.posUMass - getDbl(Me.POS_UMASS)) / Me.posUMass) > 0.01 Then
                strUMassDop = vbNewLine & "db: " & FormatNumber(Me.posUMass, Me.numDigits)
            End If
        End If
        If Me.bCMCalc And Me.posCMass > 0 Then
            If Abs((Me.posCMass - getDbl(Me.POS_CMASS)) / Me.posCMass) > 0.01 Then
                strCMassDop = vbNewLine & "db: " & FormatNumber(Me.posCMass, Me.numDigits)
            End If
        End If
    End If
    
    'gotick False, "updateTableInBase"
    
    
    fgp.TextMatrix(Row, 0) = getDescr
    '==============================================
    If Me.POS_MCALC.mcID <> 10 Then
        fgp.TextMatrix(Row, 1) = Round(posQty, 4)
        'fgp.TextMatrix(Row, 1) = Round(qty, 4)
    Else
        fgp.TextMatrix(Row, 1) = ""
    End If
    '==============================================
    
    fgp.TextMatrix(Row, 2) = ""
    fgp.TextMatrix(Row, 3) = ""
    
    'gotick False, "getDescr"
    
    If Me.POS_MCALC.mcID > 0 Then
        If Me.POS_MCALC.mcID <> 10 Then
            fgp.TextMatrix(Row, 2) = POS_UMASS & strUMassDop
            If bUMCalc = False Then
                fgp.Cell(flexcpBackColor, Row, 2) = lngGrey
            Else
                fgp.Cell(flexcpBackColor, Row, 2) = lngRowWinColor
            End If
            If POS_MCALC.mcID = 5 Then
                fgp.Cell(flexcpForeColor, Row, 2) = &H80000011
                fgp.Cell(flexcpFontBold, Row, 2) = False
            Else
                fgp.Cell(flexcpForeColor, Row, 2) = lngTextColor
                fgp.Cell(flexcpFontBold, Row, 2) = True
            End If
        End If
        '==============================================
        fgp.TextMatrix(Row, 3) = POS_CMASS & strCMassDop
        If bCMCalc = False Then
            fgp.Cell(flexcpBackColor, Row, 3) = lngGrey
        Else
            fgp.Cell(flexcpBackColor, Row, 3) = lngRowWinColor
        End If
    End If
    
    'gotick False, "POS_UMASS"
    
    
    '==============================================
    fgp.TextMatrix(Row, 4) = posID
    '==============================================
    
    
    If bRecalcPartRows Then
        parentPart.updateMasses
    End If
    
    'gotick False, "updateMasses"
    
    Exit Sub
    
updatePosRow_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "updatePosRow - Error"
    
End Sub

'/******************************************************************************
Private Sub getChange(Index As Integer, strDesc As String)
'/******************************************************************************

    On Error GoTo getChange_ERR

    Dim strDelim As String

    If vls(Index) <> vls_new(Index) Or posID = 0 Then ' обновление или создание
    
        If Len(strColumns) > 0 Then strDelim = "," Else strDelim = ""
        If Len(strChanged) > 0 Then strChanged = strChanged & ", "
        
        If Len(strDesc) > 0 Then strChanged = strChanged & strDesc
        
        If posID = 0 Then ' insert
            strColumns = strColumns & strDelim & CStr(flds(Index))
            strValues = strValues & strDelim & getString(vls_new(Index))
        Else ' update
            strColumns = strColumns & strDelim & CStr(flds(Index)) & "=" & getString(vls_new(Index))
        End If
        
        If Index = 6 Or Index = 7 Then bMustUpdate = True ' umass, cmass
        
        
    End If



Exit Sub

getChange_ERR:

End Sub


'/******************************************************************************
Public Function savePos(Optional bCopy As Boolean = False) As Boolean
'/******************************************************************************
    
    On Error GoTo savePos_ERR
    
    If Me.parentPart Is Nothing Then Exit Function
    If Me.parentPart.bIsCat = False And Me.parentPart.catID = 0 Then Exit Function
    If Len(Me.parentPart.partName) = 0 Then Exit Function
    If Me.POS_SRTM.srtmID = 0 Then Exit Function
    
    If Me.parentPart.partID = 0 Then
        Me.parentPart.partdefID = lngCurDefReinPartdefID 'Детали
        Me.parentPart.typeID = 1 'Тип не определен
        Me.parentPart.savePart False, bCopy ' не сохранять позиции
        partID = Me.parentPart.partID
    End If
    
'    saveUndo
    
    
    Dim strSQL As String
    
    
    
    '    flds(0) = "posIDold"
    '    flds(1) = "partID"
    '    flds(2) = "srtmID"
    '    flds(3) = "muID"
    '    flds(4) = "posQuantity"
    '    flds(5) = "matID"
    '    flds(6) = "posUnitMass"
    '    flds(7) = "posCommonMass"
    '    flds(8) = "mcID"
    '    flds(9) = "numDigits"
    '    flds(10) = "posNumber"
    '    flds(11) = "posUMCalc"
    '    flds(12) = "posCMCalc"
    '    flds(13) = "posSketch"
    '    flds(14) = "posBarLength" ' флаг расчета нахлеста
    '    flds(15) = "objID"
    '    flds(16) = "posName" ' for posNote
    
    
    vls_new(0) = posIDold
    vls_new(1) = partID
    vls_new(2) = POS_SRTM.srtmID
    vls_new(3) = 1 ' muID? later
    vls_new(4) = Round(posQty, 2)
    vls_new(5) = getMatID
    If bCopy And Me.posUMass > 0# And posCMass > 0# Then
        vls_new(6) = posUMass
        vls_new(7) = posCMass
    Else
        vls_new(6) = getDbl(POS_UMASS)
        vls_new(7) = getDbl(POS_CMASS)
    End If
    vls_new(8) = mcIDover
    vls_new(9) = numDigits
    vls_new(10) = posNumber ' номер позиции
    vls_new(11) = Abs(CLng(bUMCalc))
    vls_new(12) = Abs(CLng(bCMCalc))
    vls_new(13) = Abs(CLng(bSketch))
    vls_new(14) = Abs(CLng(bCalcLap))
    vls_new(15) = POS_OBJ
    vls_new(16) = posNote
    
    strChanged = ""
    strColumns = ""
    strValues = ""
    
    getChange 2, "позиция сортамента " & POS_SRTM.srtmName
    getChange 4, "количество " & getString(vls_new(4))
    getChange 5, "материал " & POS_MAT.matName
    getChange 6, ""
    getChange 7, ""
    getChange 8, "изм. способ расчета массы"
    getChange 9, "кол-во дес. знаков " & numDigits
    getChange 10, ""
    If bUMCalc Then getChange 11, "ед.масса автоматически" Else getChange 11, "ед.масса вручную"
    If bCMCalc Then getChange 12, "общ.масса автоматически" Else getChange 12, "общ.масса вручную"
    If bSketch Then getChange 13, "вкл. эскиз " Else getChange 13, "выкл. эскиз "
    If bCalcLap Then getChange 14, "вкл. нахлест " Else getChange 14, "выкл. нахлест "
    getChange 16, "примечание " & posNote
    
    
    If Len(strColumns) > 0 Then
        If posID = 0 Then
            strColumns = strColumns & ",partID"
            strValues = strValues & "," & partID
            strSQL = "SET NOCOUNT ON;INSERT INTO [" & POS_SRC_TABLE & "] (" & strColumns & ") VALUES (" & strValues & ");SELECT SCOPE_IDENTITY() AS [IDENT];"
        Else
            strSQL = "UPDATE [" & POS_SRC_TABLE & "] SET " & strColumns & " WHERE posID = " & posID
        End If
        
        Dim iRecAf As Integer
        Dim RS As ADODB.Recordset
        Dim cmd As New ADODB.Command
        cmd.ActiveConnection = cn_data
        cmd.CommandText = strSQL
        Set RS = cmd.Execute(iRecAf)
        If posID = 0 Then
            posID = RS.fields(0).Value
            strChanged = "создание позиции"
        End If
        If RS.State = adStateOpen Then RS.Close
        Set RS = Nothing
        
        cmd.CommandText = "SET NOCOUNT OFF"
        cmd.Execute
        
        If bMustUpdate Then
            updateMassInBase
        End If
        
        updateValues
        
    End If
    
    
    If Len(strChanged) > 0 Then writeOperationS operModify, POS_SRC_TABLE, posID, strChanged
    
    
    Dim i As Integer
    
    Dim prop As clsProp
    
    For i = 1 To pos_props.Count
        Set prop = pos_props(i)
        Set prop.parentPos = Me
        prop.save
    Next i
    
    
    savePos = True
    
    Exit Function
    
savePos_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "savePos - Error"
    
End Function




'/******************************************************************************
Public Function saveArmPoints(Optional bCalcPoints As Boolean = True) As Boolean
'/******************************************************************************

    On Error GoTo saveArmPoints_ERR

    Dim bCompOk As Boolean
    Dim bSkchOk As Boolean
    

    If partID = 0 Then Exit Function
    If pointsDraw Is Nothing Then Exit Function
    If pointsDraw.Count = 0 Then Exit Function
    
    bSkchOk = True
    If pointsSkch Is Nothing Then
        bSkchOk = False
    Else
        If pointsSkch.Count <> pointsDraw.Count Then bSkchOk = False
    End If

    
    Dim i As Integer
    
    If bCalcPoints Then
        bCompOk = armCalcPointsFromDraw(Me, False)
        If bCompOk Then bCompOk = armCalcPointsFromDraw(Me, True)
    Else
        If pointsDraw.Count = pointsComp.Count And pointsDraw.Count = pointsCompAlt.Count Then bCompOk = True
    End If
    
    
    Dim iRecordsAffected As Integer
    Dim cmd As New ADODB.Command
    cmd.ActiveConnection = cn_data
    cmd.CommandText = "delete from [r_part_reinpoints] where partID = " & partID
    cmd.Execute iRecordsAffected
    Set cmd = Nothing
    
    
    
    
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from r_part_reinpoints", cn_data, adOpenStatic, adLockOptimistic
    
    For i = 1 To pointsDraw.Count
    
        RS.AddNew
        
        RS.fields("partID").Value = partID
        
        RS.fields("xd").Value = Round(pointsDraw(i).X, 5)
        RS.fields("yd").Value = Round(pointsDraw(i).Y, 5)
        
        If bSkchOk Then
            RS.fields("xs").Value = Round(pointsSkch(i).X, 5)
            RS.fields("ys").Value = Round(pointsSkch(i).Y, 5)
        Else
            RS.fields("xs").Value = Round(pointsDraw(i).X, 5)
            RS.fields("ys").Value = Round(pointsDraw(i).Y, 5)
        End If
        
        
        If iMainLine = i - 1 Then
            RS.fields("isMain").Value = True
            RS.fields("isCont").Value = Me.bCont
        End If
        
        
        RS.fields("isSketchOk").Value = True
        
        If bCompOk Then
            RS.fields("x").Value = Round(pointsComp(i).X, 0)
            RS.fields("y").Value = Round(pointsComp(i).Y, 0)
            RS.fields("xa").Value = Round(pointsCompAlt(i).X, 0)
            RS.fields("ya").Value = Round(pointsCompAlt(i).Y, 0)
            RS.fields("isOk").Value = True
        End If
        
        RS.Update
    
    Next i
    
    
    RS.NextRecordset
    
    RS.Open "select * from r_part_reinsketch where partID = " & partID, cn_data, adOpenStatic, adLockOptimistic
    If RS.EOF Then
        RS.AddNew
    Else
        RS.MoveFirst
    End If
    
    RS.fields("partID").Value = partID
    RS.fields("sketchStartType").Value = termBegType
    RS.fields("sketchStartAngle").Value = termBegAngle
    RS.fields("sketchStartLength").Value = termBegLength
    RS.fields("sketchEndType").Value = termEndType
    RS.fields("sketchEndAngle").Value = termEndAngle
    RS.fields("sketchEndLength").Value = termEndLength
    
    RS.Update
    
    
    
    RS.Close
    Set RS = Nothing
    
    
    saveArmPoints = True




Exit Function

saveArmPoints_ERR:
    Set RS = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "saveArmPoints - Error"

End Function




'/******************************************************************************
Public Function isInRunMet() As Integer
'/******************************************************************************
    
    On Error GoTo isInRunMet_ERR
    
    
    Dim prop As clsProp
    
    isInRunMet = 0
    
    If pos_props.existsProperty("length") Then
        Set prop = pos_props("length")
        If prop.bMassCalc And Not prop.hasValue And getEmptyPropsQty = 1 Then isInRunMet = 1
    End If
    
    Exit Function
    
isInRunMet_ERR:
    '    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "isInRunMet - Error"
    
End Function



'/******************************************************************************
Public Function reloadPosData(Optional bReloadProps As Boolean = True) As Boolean
'/******************************************************************************
    
    On Error GoTo reloadPosData_ERR
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from " & POS_SRC_VIEW & " where posID = " & posID, cn_data, adOpenForwardOnly, adLockOptimistic
    
    
    If Not RS.EOF Then
        
        RS.MoveFirst
        
        If Me.loadDataFromRSrecord(RS) Then
            
            If bReloadProps Then
'                Me.getSrtmProps ' вместо me.reloadSrtmProps
                Me.reloadSrtmProps
                Me.reloadPosPropsFromRS RS ' вместо me.reloadPosProps
            End If
            
        End If
        
    End If
    
    RS.Close
    Set RS = Nothing
    
    
    
    Exit Function
    
reloadPosData_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "reloadPosData - Error"
    
End Function


'/******************************************************************************
Public Property Get POS_LAP() As Offtmisc.clsArmLap
'/******************************************************************************

    On Error GoTo getLap_ERR

    Dim lap As New Offtmisc.clsArmLap
    Dim lap2 As Offtmisc.clsArmLap
    
    lap.projectID = lngCurProjectID
    lap.betonID = lngCurBuildingID ' lngCurBetonID
    lap.classID = Me.POS_MAT.ARM_CLASS.armClassID
    lap.diameter = pos_props("diameter").propValue
    
    Set lap2 = globLapsSet(lap.KEY)
    
    If lap2.projectID = 0 And lap2.betonID = 0 And lap2.classID = 0 And lap2.diameter = 0 Then ' building not found
        lap.betonID = 0
        lap.projectID = lngCurProjectID
        Set POS_LAP = globLaps(lap.KEY)
    Else
        Set POS_LAP = globLapsSet(lap.KEY)
    End If
    
    
    Set lap = Nothing
    Set lap2 = Nothing

Exit Property

getLap_ERR:
    Set POS_LAP = New Offtmisc.clsArmLap

End Property


'/******************************************************************************
Public Function getPosLength(bWithLap As Boolean, ByRef bGotLap As Boolean, Optional bSI As Boolean = False) As Double
'/******************************************************************************

    On Error GoTo getPosLengthWithLap_ERR
    
    Dim prop As clsProp
    Dim koef As Double
    
    bGotLap = False

    If Not pos_props.existsProperty("length") Then
        If bSI Then
            getPosLength = pos_props.getPropSiValue("length")
        Else
            getPosLength = 0#
        End If
        Exit Function
    End If
    
    Set prop = pos_props("length")
    
    If prop.propValue = 0 Then
        If bSI Then
            getPosLength = pos_props.getPropSiValue("length")
        Else
            getPosLength = 0#
        End If
        Exit Function
    End If
    
    If bSI Then
        koef = pos_props.getPropSiValue("length") / prop.propValue
    Else
        koef = 1#
    End If
    
    
    If POS_LAP.lapValue = 0 Then
        getPosLength = prop.propValue * koef
        Exit Function
    End If
    
    
    bGotLap = False
    
    If bWithLap Then
        bGotLap = CBool(prop.propValue > POS_LAP.maxlen)
'        getPosLength = (prop.propValue + Ceil((prop.propValue - POS_LAP.maxlen) / (POS_LAP.maxlen - POS_LAP.lapValue)) * POS_LAP.lapValue) * koef
        getPosLength = POS_LAP.getLength(prop.propValue) * koef
    Else
        getPosLength = prop.propValue * koef
    End If

    

Exit Function

getPosLengthWithLap_ERR:
    getPosLength = 0#

End Function


'/******************************************************************************
Public Function saveUndo() As Boolean ' NU
'/******************************************************************************

    On Error GoTo saveUndo_ERR
    
    If Me.posID = 0 Then Exit Function
    
    Dim strSQL As String
    
    Dim tb As clsTable
    Dim cmd As New ADODB.Command
    cmd.ActiveConnection = cn_data
    
    cmd.CommandText = "SET IDENTITY_INSERT #position ON"
    cmd.Execute
    
    cmd.CommandText = "SET IDENTITY_INSERT #r_position_property ON"
    cmd.Execute
    
    Set tb = globTables("position")
    strSQL = "INSERT INTO #position SELECT " & Replace(tb.getFields(True), "[posIDold]", CStr(Me.posID)) & " FROM position WHERE posID = " & Me.posID
'    strSQL = "INSERT INTO ##position SELECT " & Replace(tb.getFields(True, , , "posID"), "[posIDold]", CStr(Me.posID)) & " FROM position WHERE posID = " & Me.posID
    cmd.CommandText = strSQL
    cmd.Execute
    
    Set tb = globTables("r_position_property")
    strSQL = "INSERT INTO #r_position_property SELECT " & tb.getFields(True) & " FROM r_position_property WHERE posID = " & Me.posID
    cmd.CommandText = strSQL
    cmd.Execute
    
    saveUndo = True

Exit Function

saveUndo_ERR:

End Function


'/******************************************************************************
Public Sub updateMassInBase(Optional bIgnoreFlags As Boolean = False)
'/******************************************************************************

    On Error GoTo updateMassInBase_ERR

    If bUMCalc Or bIgnoreFlags Then
        If updateTableInBase(cn_data, POS_SRC_TABLE, "posUnitMass", getDbl(Me.POS_UMASS), "posID", Me.posID) Then posUMass = getDbl(Me.POS_UMASS)
    End If
    
    If bCMCalc Or bIgnoreFlags Then
        If updateTableInBase(cn_data, POS_SRC_TABLE, "posCommonMass", getDbl(Me.POS_CMASS), "posID", Me.posID) Then posCMass = getDbl(Me.POS_CMASS)
    End If

    bMustUpdate = False

Exit Sub

updateMassInBase_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "updateMassInBase - Error"

End Sub

'/******************************************************************************
Public Function getMassLevel(Optional bUseGlob As Boolean = False) As Integer
'/******************************************************************************

    On Error GoTo getMassLevel_ERR
    
    If Me.POS_STDPD.iStdPdMassLevel >= 0 Then
        getMassLevel = Me.POS_STDPD.iStdPdMassLevel
    ElseIf bUseGlob Then
        Dim pd As clsPD
        Set pd = globPosdefs(Trim(CStr(Me.POS_PD.pdID)))
'        If Me.POS_PD.pdID = 12 Then
'            Debug.Print ""
'        End If
        getMassLevel = pd.iMassLevel
    Else
        getMassLevel = Me.POS_PD.iMassLevel
    End If

Exit Function

getMassLevel_ERR:
    getMassLevel = 0

End Function

'/******************************************************************************
Public Property Get POS_SRC_TABLE() As String
'/******************************************************************************

    On Error GoTo POS_SRC_TABLE_ERR

    
    If POS_OBJ = objs("part") Then
        POS_SRC_TABLE = "position"
    ElseIf POS_OBJ = objs("catalog") Then
        POS_SRC_TABLE = "catpos"
    Else
        POS_SRC_TABLE = "position"
    End If


Exit Property

POS_SRC_TABLE_ERR:
    POS_SRC_TABLE = "position"

End Property



'/******************************************************************************
Public Property Get POS_SRC_VIEW() As String
'/******************************************************************************

    On Error GoTo POS_SRC_VIEW_ERR
    
    If POS_OBJ = objs("part") Then
        POS_SRC_VIEW = "view_position"
    ElseIf POS_OBJ = objs("catalog") Then
        POS_SRC_VIEW = "view_r_cat_position"
    Else
        POS_SRC_VIEW = "view_position"
    End If

Exit Property

POS_SRC_VIEW_ERR:
    POS_SRC_VIEW = "view_position"

End Property


'/******************************************************************************
Public Property Get POS_OBJ() As Long
'/******************************************************************************

    On Error GoTo POS_OBJ_ERR
    
    If Me.parentPart.bIsCat Then
        POS_OBJ = objs("catalog")
    Else
        POS_OBJ = objs("part")
    End If
    

Exit Property

POS_OBJ_ERR:
    POS_OBJ = pos_objID

End Property




'/******************************************************************************
Public Function getPosQty(Optional ByRef bChanged As Boolean = False) As Double
'/******************************************************************************

    On Error GoTo getPosQty_ERR
    
    If Me.POS_MCALC.mcID = 13 And posQty = 0# Then ' анкер (шаг, отступ)
    
        Dim ln As Double
        Dim wd As Double
        Dim chx As String
        Dim chy As String
        Dim arx() As String
        Dim ary() As String
        Dim qx As Integer
        Dim qy As Integer
        
        Dim mainpos As clsPos
        Set mainpos = Me.parentPart.ps.pm(1) ' first position, 1 based index!
        
        ln = CDbl(mainpos.pos_props("length").propValue)
        wd = CDbl(mainpos.pos_props("width").propValue)
        chx = CStr(pos_props("chainx").propValue)
        chy = CStr(pos_props("chainy").propValue)
    
        arx = Split(chx, "+")
        ary = Split(chy, "+")
    
    
        If ln > 0# And UBound(arx) >= 0 Then
        
            ' подсчитать количество рядов x y
            
            Dim lnn As Double
            Dim lnnn As Double
            
            qx = 1
            lnn = ln - Val(arx(0)) * 2 ' длина между крайними анкерами (без отступов)
        
            If lnn > 0# Then
            
                If UBound(arx) > 1 Then ' переменный шах (100+150+200)
                    
                    qx = qx + Int(lnn / Val(arx(1)))
                    
                    lnnn = lnn - Val(arx(1)) * 2 ' длина между крайними анкерами внутреннего шага
                    
                    If lnnn > 0# Then
                    
                        qx = qx + Int(lnnn / Val(arx(2)))
                    
                    End If
                    
                Else
                    qx = qx + 1
                
                End If
                
                
            End If
        
            Dim p As clsProp
            If pos_props.existsProperty("ancqx") Then
                Set p = pos_props("ancqx")
                p.propValue = qx
            Else
                Set p = pos_props.AddByPropName("ancqx", Me, True)
                p.bMassCalc = True
                p.propValue = qx
            End If
            
            bChanged = True
    
    
        Else
            err.Raise 100
        End If
        
        
        If wd > 0# And UBound(ary) >= 0 Then
        
            Dim wdd As Double
            Dim wddd As Double
            
            wdd = wd - Val(ary(0)) * 2 ' ширина между крайними анкерами (без отступов)
        
            If wdd > 0# And UBound(ary) > 1 Then ' переменный шах (100+150+200)
                wddd = wdd - Val(ary(1)) * 2 ' ширина между крайними анкерами внутреннего шага
            End If
    
    
    
    
        Else
            err.Raise 100
        End If
        
        
    
    Else
        getPosQty = posQty
    End If


Exit Function

getPosQty_ERR:
    getPosQty = posQty

End Function

