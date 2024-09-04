Attribute VB_Name = "MM"
Option Explicit

Public Const pi = 3.14159265358979

Public cCats As colCats

Public cn_data As ADODB.Connection
Public cn_srtm As ADODB.Connection
Public cn_mdb As New ADODB.Connection

Public cn_cmd(0 To 1) As ADODB.Connection

Public usrCurrent As usr

Public arSpecCol(1 To 100) As Double
Public arOfftRow(1 To 10) As Double
Public strSpecCapCellName As String
Public iSpecAlign As Integer

'Public strNavisPath As String
'Public strNavisLocPath As String
'Public strNavisFTPserv As String
'Public strNavisFTPport As String
'Public strNavisFTPuser As String
'Public strNavisFTPpass As String
'Public strNavisFTPbld As String
'Public strNavisFTPtech As String

Public iSpecImportRowHeight As Integer

Public frmSps As frmSplash

Public misc As Offtmisc.misc
Public conn As Offtmisc.Connection

Public sRememberedDB As String
Public sRememberedSRV As String

Public ouGlobSum As clsOU
Public strOfftMarks As String

Public iSketchRadiusOpt As Long
Public iSketchRadiusVal As Long
Public iSketchScaleLft As Long
Public iSketchScaleRgt As Long
Public iSketchShowDialog As Long
Public iSketchScaleHor As Long
Public iSketchScaleVer As Long
Public iSketchCellHeight As Long
Public iSketchCellWidth As Long
Public iSketchMaxHeight As Long

Public sCommonMessage As String

Public lngCurProjectID As Long
Public lngCurBlockID As Long
Public lngCurBuildingID As Long
Public lngCurPartID As Long
Public lngCurCatID As Long
Public lngCurPartCatID As Long
Public lngCurReinCatID As Long
Public lngCurCatListID As Long
Public lngCurCatListCatID As Long
Public lngCurCatListBlockID As Long
Public lngCurCatListProjID As Long
Public lngCurDefaultPartdefID As Long
Public lngCurDefReinPartdefID As Long
Public lngCurCatListDefaultID As Long
Public lngCurBetonID As Long ' для выбора нахлёста (= 0)

Public lngCurSpecID As Long

Public lngLeftCatID As Long
Public lngRightCatID As Long

Public lngCurCatTreeObjID As Long
Public lngCurCatTreeSelectedID As Long

Public dOfftHeadWidth As Double
Public dOfftGlobalSumWidth As Double


Public dSpecCmnScale As Double
Public dSpecTextScale As Double
Public dSpecTextHeight As Double
Public dSpecTextWidth As Double
Public Const dSpecNextRowParam As Double = 1.5

Public lngCurCatListIDtoCopy As Long
Public lngCurCatalogIDtoCopy As Long

Public strReinSpec As String

Public bFormOk As Boolean

Public arTreeLev(20) As String

Public colParts As New Collection

Public iVersDB As Long
Public iVersApp As Long

Public bSkipLoadData As Boolean

Public sFireCompFileName As String

Public Type copytype
    sNewCatName As String
    sOldCatName As String
    bLinks As Boolean
    bLists As Boolean
    bListContent As Boolean
    bListRedirect As Boolean
    bReinChilds As Boolean
    bOk As Boolean
    sBaseNameSrc As String
    sBaseNameDst As String
    cn_src As ADODB.Connection
    cn_dst As ADODB.Connection
    catTypeID As Long ' постфактум
    bSrcDstEqual As Boolean ' постфактум
End Type


Public Type cattype
    ctEnum As ctype
    partdefID As Long
    ctName As String
    tnNum As String
End Type

Public Enum pwbldsub
    pwbldsubNon = 0
    pwbldsubCat = 1
    pwbldsubSet = 2
    pwbldsubMod = 3
End Enum

'Public Type partdef
'    partdefID As Long
'    partdefName As String
'    partdefNameMulti As String
'    bUsePositions As Boolean
'    parentID As Long
'    partdefSort As Integer
'    partdefKksDiv As String
'    pdpdsID As Long
'End Type

'Public Type PARTTYPE
'    ptID As Long
'    ptName As String
'    specID As Long
'    sortKey As String
'End Type

Public Type docsetType
    dstID As Long
    dstName As String
End Type

Public Type prplistType
    plID As Long
    prpID As Long
    plValue As String
End Type



Public Type usr
    usrID As Long
    groupID As Long
    depID As Long
    depName As String
    objID As Long ' ID строки usr в таблице типов объектов
    strFIO(1 To 3) As String
    strGroupName As String
    strLogin As String
    specID As Long
    trusted As Boolean
    pdsID As Long ' posdef set
    partdefDefaultID As Long ' приоритетнее чем lngCurDefaultPartdefID
    strDomain As String
End Type

'Public Type perm
'    bCreate As Boolean
'    bDelete As Boolean
'    bModify As Boolean
'    bMove As Boolean
'End Type

'Public Type obj
'    ID As Long
'    NAME As String
'End Type

Public Type rndShift
    iPosMass As Integer
    iArmSegm As Integer
    iArmSegmSnap As Integer
    iArmArc As Integer
    iArmArcSnap As Integer
End Type

Public Type reinSketch
    iType As Integer
    iAngle As Integer
    iLength As Integer
End Type

Public Type pwSettings
    text As String
    server As String
    database As String
    login As String
    root As Long
    connected As Boolean
    constring As String
    userno As Long
    canedit As Boolean
End Type

Public pwset As New clsDBCon ' current
Public pwsets As New Collection
Public imps As New Collection ' import settings
'Public pwsetscnt As Integer

Public rndGlobal As rndShift

Public Enum TextJustification
    lt = 0
    lc = 1
    LB = 2
    ct = 6
    cc = 7
    cb = 8
    rt = 12
    rc = 13
    rb = 14
End Enum

Public Enum oper
    operUnknown
    operCreate
    operModify
    operOverStatus
    operDelete
    operRestore
    operErase
End Enum

Public Enum pst ' part/cat status
    pstRazrabotka
    pstProvereno
    pstArchive
    pstUstar
End Enum

Public Enum ctype ' catalog type
    ctNone
    ctEmb
    ctRein
End Enum

Public Enum spectype ' specification type
    stPart
    stList
    stRein
    stRooms
End Enum

Public Enum dstype ' docset type
    dsNone
    dsPartList
    dsDrawings
End Enum

Public Enum treelevel ' docset type
    tlSimple
    tlType
    tlUser
    tlSign
    tlSignSheet
    tlStatus
    tlPartList
    tlDrawings
    tlKKS
End Enum

Public Enum datatype ' see table "propertyvalue"
    dtUnknown
    dtDouble
    dtID
    dtString
    dtLong
End Enum



Public copyInfo As copytype

Public strCurServer As String
Public strCurDataBase As String
Public strCurSimBase As String
Public strCurSimConfig As String
Public strNavisMsg As String


Public bMainFormLoaded As Boolean
Public bBaseConnected As Boolean

Public Const appID As Long = 15973 ' для привязки файла DGN к каталогу через ApplicationElement


Public dSpecHeadHeight As Double
Public dSpecRowHeight As Double


Public Const iTextLevel As Integer = 51
Public Const iLineLevel As Integer = 52

Public iNumDigitsDefault As Integer
Public iPosMassRoundDefault As Integer

'Public strBaseName As String
'Public strSrtmName As String
'Public strServerName As String
Public strUser As String
Public strPass As String
    
Public iUseReinFilletByProject As Integer ' -1 no, 0 by setting, 1 yes
Public bUseReinFilletBySettings As Boolean
Public bDontUseSplash As Integer
Public bUseCursorClient As Boolean
Public bUseNewCatsLoad As Boolean
Public bUsePartPdfColor As Boolean
Public iSetDepID As Integer
Public bReadOnly As Boolean
Public bAskSource As Boolean

'Public bAdminMode As Boolean

'Public bCoreLines As Boolean
'Public bCoreText As Boolean
'Public bUseCoreLines As Boolean
'Public bUseCoreText As Boolean
'Public bUpdateRein As Boolean
'Public bCatsInList As Boolean ' возможно использовать каталоги в списках (только для каталогжных списков)
Public bOfftNew As Boolean ' новый расчет выборки
'Public bUseOnlyProgramFilesDir As Boolean ' нельзя запускать из другой папки кроме Program files

Public iCreate As Long
Public iModify As Long
Public iMove As Long
Public iDelete As Long
Public iRestore As Long

Public objs As New Collection
Public cattypes(0 To 10) As cattype
'Public partdefs(0 To 100) As partdef
'Public parttypes(0 To 200) As parttype
Public docsettypes(0 To 50) As docsetType
Public prplisttypes() As prplistType

Public globPartTypes_sketch_path As String
Public globPartTypes_sketch_ext As String

Public globPartTypes As colPartType
Public globPartDefs As colPartDef
Public globPDSets As Collection
Public globDSNum As Collection ' docsetnumber
Public globDSSgn As Collection ' docsetsign
Public globDocSets As colDocSets
Public globArmClasses As Collection
Public globMassCalcs As Collection
Public globMUnits As Collection
Public globObjs As Collection
Public globTables As Collection
Public globRules As Collection
Public globCatDefs As Collection
Public globUserSpecs As Collection

Public globPosdefs As New colPD
Public globStds As colStd
Public globMats As colMat
Public globSrtm As colSrtm
Public globStdPosdefs As colStdPd
Public globProps As colProp
Public globPrps As colPrp
Public globLaps As Offtmisc.colArmLap
Public globLapsSet As Offtmisc.colArmLap

Public trans As Collection
Public scfgs As New Collection
'Public arSpecConfigKeys(1000) As String

Public colRein2 As Collection

'Public msapp As MicroStationDGN.Application
'Public tec1 As TransientElementContainer

'Public ng As NamedGroupElement

Public mspoint As OfftPoint3D

Public dSpecWidth As Double


'Public Const cstNewPartName As String = "MC-"
Public strNewPartName As String

Public Const cstMaxBarLength As Double = 11700#

Public lngMarkRowColor As Long
Public lngNewRowColor As Long
Public lngRowColor As Long
Public lngTextColor As Long
Public lngRed As Long
Public lngRowWinColor As Long
Public lngGreen As Long
Public lngGrey As Long
Public lngDarkGrey As Long
Public lngFiolet As Long
Public lngBlue As Long
Public lngLightRed As Long

Public lngSpecDefaultRows As Long
Public lngSpecFirstRows As Long
Public lngSpecLastRows As Long
Public blnSpecLastRows As Boolean
Public blnDrawSpecCap As Boolean
Public blnSortDiam As Boolean
Public blnSkipEmpty As Boolean
Public blnSpecCmnMass As Boolean
Public blnSpecHeaderUnderLine As Boolean
Public colSpecTextOver As New Collection
'Public colSpecPartOver As New Collection
Public speccfg As New colAts ' spec config
Public offtcfg As New colAts ' offtake config
Public listcfg As New colAts ' parts list config
Public reincfg As New colAts ' reinf. config


Public colFrml As New Collection
'Public strSpecFormula As String
'Public intSpecFormulaQty As Integer
'Public intSpecSplitterQty As Integer

Public sFilterPartVersion As String
Public sFilterPartName As String

Public sFilterPartSheet As String
Public sPartSheetFormat As String

Public iPartTreeLevel As treelevel

Public strDrawingsLibraryFileName As String
Public strHelpPath As String
Public strHelpXml As String

Public strTechViewName As String

Public Const strFireCompTable As String = "o_fireComp"
Public Const strFireRes As String = "fc res"
Public Const strFireResMan As String = "fc res man"
Public Const strFireArea As String = "area"
Public Const strFireAreaMan As String = "area man"
Public Const strFireAreaField As String = "fcFloorArea"
Public Const strFireLoads As String = "f loads"
Public Const strFireRooms As String = "rooms"
Public Const strFireCode As String = "fc code"
Public Const strRoomCode As String = "room code"
Public Const strFireCompID As String = "fcID"
Public Const strFireResField As String = "fcFireRes"
Public Const strKeySimID As String = "simID"

Public Const strFuncNameListMass As String = "getPosCmnMass2" ' sc func, общая масса для списка
Public Const strFuncNameSpec As String = "view_spec_catlist_4" ' view, spec
Public Const strFuncNameSpecRein As String = "view_spec_rein_catlist" ' view, spec of reinforcement

Public strFuncNameOfftake1 As String  ' = "goofftall4_3" ' table func, строители
Public strFuncNameOfftake2 As String  ' = "goofftall5_3" ' table func, подопорные

Public stts(3) As String ' part status

Public BRYS As Boolean

Public bCatIsBlocked As Boolean
Public bCatListIsBlocked As Boolean
Public bUseDopMass As Boolean
Public bUseStdNumberAlt As Boolean

Public strCurProvider As String

Public curSpecCfg As clsSCfg

'===========================================================
' execute program
Public Declare Function ShellExecute Lib "shell32.dll" Alias _
                                     "ShellExecuteA" (ByVal hwnd As Long, _
                                     ByVal lpOperation As String, _
                                     ByVal lpFile As String, _
                                     ByVal lpParameters As String, _
                                     ByVal lpDirectory As String, _
                                     ByVal nShowCmd As Long) As Long
'===========================================================
' переменные для определения - существует ли файл
Public Declare Function OpenFile Lib "kernel32" (ByVal lpFileName As String, lpReOpenBuff As OFSTRUCT, ByVal wStyle As Long) As Long
Public Const OFS_MAXPATHNAME = 128
Type OFSTRUCT
       cBytes As Byte
       fFixedDisk As Byte
       nErrCode As Integer
       Reserved1 As Integer
       Reserved2 As Integer
       szPathName(OFS_MAXPATHNAME) As Byte
End Type
'===========================================================



Declare Function apiCopyFile Lib "kernel32" Alias "CopyFileA" _
(ByVal lpExistingFileName As String, _
ByVal lpNewFileName As String, _
ByVal bFailIfExists As Long) As Long

Public strErr As String

Public colCatTreeSet As Collection
Public colWiseTreeSet As Collection

Public tics As Long

Public Const sFmt0 As String = "###0.0"
Public Const sFmt1 As String = "#,##0.0"
Public Const sFmt2 As String = "#,##0.00"
Public Const sFmt3 As String = "#,##0.000"
Public Const sFmt4 As String = "#,##0.0000"
Public Const sFmt5 As String = "#,##0.00000"
Public Const sFmt6 As String = "#,##0.000000"
Public Const sFmt7 As String = "#,##0.0000000"
Public Const sFmtFree As String = "#,###.####"


Public scfgCmn As New clsSCfg


Public arServers() As String
Public arBases() As String


'ez 2017-07-07 ссылка на файл конфигурации (для формирования таблиц SymView)
Private prConfig As clsConfig

Public Function getPwBldSub(i As pwbldsub)
    If i = pwbldsubNon Then getPwBldSub = ""
    If i = pwbldsubCat Then getPwBldSub = "pwcat"
    If i = pwbldsubSet Then getPwBldSub = "pwset"
    If i = pwbldsubMod Then getPwBldSub = "pwmod"
End Function


Public Sub makeDir(path)
    On Error Resume Next
    MkDir path
    
End Sub


'/******************************************************************************
Public Property Get Config() As clsConfig
'/******************************************************************************
On Error GoTo cnf_ERR

    prConfig.UpdateConfig
    Set Config = prConfig

Exit Property

cnf_ERR:
    F1.SB.Panels("status").text = "cnf" & "() - " & err.Description

End Property


'/******************************************************************************
Public Function connectOldBases() As Boolean
'/******************************************************************************

    On Error GoTo connectOldBases_ERR
    connectOldBases = False

'    If usrCurrent.depID = 3 Then
'        cn_mdb.Open "PROVIDER=Microsoft.Jet.OLEDB.4.0;Data Source=d:\Storage\Base\main.so3"
'        connectOldBases = True
'    ElseIf usrCurrent.depID = 2 Then
        cn_mdb.Open "PROVIDER=Microsoft.Jet.OLEDB.4.0;Data Source=z:\DATABASE\main.so2"
        connectOldBases = True
'    Else
'    End If



Exit Function

connectOldBases_ERR:
    connectOldBases = False
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "connectOldBases - Error"

End Function



Sub Main()
    

    
'    Call UserInfo("l_vibe")
    
'    Dim arstr() As String
'    Call rebuildString("Что значит: может быть применимо? В принципе, можно и закон ассоциативности приплести и говорить, что (A*B)*C не равно A*(B*C). Такие системы исчисления тоже существуют. Но арифметика, т.е. алгебра действительных чисел, коммутативна и ассоциативна. И писать 5*2 не равно 2*5  - это чистой воды кретинизм. А когда это делает преподаватель, то еще и вредительство.", arstr)
'
'    End

    
    Dim bSaveSettings As Boolean
    
    If App.PrevInstance Then
        ' taskkill /f /im offtake2.exe
        If MsgBox("   Offtake уже работает, запустить его заново?   ", vbYesNo, "") = vbNo Then Exit Sub
    End If
    
    strUser = "so2user"
    strPass = "so2user"


    ' по умолчанию
    rndGlobal.iArmArc = -2
    rndGlobal.iArmArcSnap = 10
    rndGlobal.iArmSegm = 0
    rndGlobal.iArmSegmSnap = 5
    
    strFuncNameOfftake1 = "goofftall4_3"    ' default table func, строители
    strFuncNameOfftake2 = "goofftall5_3"    ' default table func, подопорные
    
    Set misc = New Offtmisc.misc
    Set conn = New Offtmisc.Connection
    
    conn.strUser = strUser
    conn.strPass = strPass

    Dim strCmd As String
    strCmd = Replace(Command$, "#", "")
    
    If Not left(Command$, 1) = "#" Then
        'MsgBox (GetThreadUserName)
        If GetThreadUserName = "l_vibe" Or GetThreadUserName = "Администратор" Then
        Else
            MsgBox "   Запуск Offtake блокирован, так как требуется запуск с сетевого ресурса   " & vbNewLine & _
            "   Для локального запуска можно использовать соотвествующий параметр #   "
            Exit Sub
        End If
'        "   Это нужно для того чтобы у Вас всегда запускалась актуальная версия   " & vbNewLine & _
'        "   Ярлык Offtake2.exe, как правило, расположен на рабочем столе"
    End If
    
'    bAdminMode = False
    
    usrCurrent.strLogin = GetThreadUserName
'    usrCurrent.strLogin = "l_vibe"
    
    
    If Len(strCmd) > 0 Then
        If Trim(LCase(strCmd)) = "-adm" Then
'            bAdminMode = True
        Else
            usrCurrent.strLogin = Trim(LCase(strCmd))
        End If
    Else
    End If
    
    usrCurrent.strDomain = Environ$("USERDOMAIN")
    
    strReinSpec = "reinsp11"
    
    iNumDigitsDefault = 1
    
    'чтение настроек:
    If getServerSettings Then
'        If usrCurrent.strLogin <> "l_vibe" Then bSaveSettings = True
        bSaveSettings = True
    Else
        bSaveSettings = False
    End If
    
    getUsrDescr
    
    'ez 2017-07-14 ссылка на файл конфигурации (для формирования таблиц SymView)
    'Set prConfig = New clsConfig

    If bReadOnly Then
        strUser = "so2read"
        strPass = "so2read"
        conn.strUser = strUser
        conn.strPass = strPass
    End If
    
    
'    If bUseOnlyProgramFilesDir And left(LCase(App.Path), Len("c:\progra")) <> "c:\progra" Then
'        MsgBox "   Просьба запускать Offtake стандартным способом:   " & vbNewLine & "   С сервера - файл Offtake2.exe   "
'        Exit Sub
'    End If

    
    Set frmSps = New frmSplash
    

    If Not frmSps Is Nothing And bDontUseSplash <> 2 Then frmSps.Show
    If bDontUseSplash = 1 Then
        frmSps.Move 0, 0
    End If
    If Not frmSps Is Nothing Then frmSps.Refresh
    
    
    If Not frmSps Is Nothing Then frmSps.setStatus "Чтение настроек..."
    
    getCatTreeSettings
    getWiseTreeSettings
    

    
    
    
'    conn.strServerName = ""
'    conn.strBaseName = ""
'    conn.strSrtmName = ""
    
dbconnect:
    If Not frmSps Is Nothing Then frmSps.setStatus "Подключение к базе данных..."
    
    
    
    
    If Not bAskSource And Len(strCurServer) > 0 And Len(strCurDataBase) > 0 Then
    
        conn.strServerName = strCurServer
        conn.strBaseName = strCurDataBase
        conn.strSrtmName = strCurDataBase
    
        Call conn.tryToConnectDB(bSaveSettings)
        
    End If
    
    
    If Not conn.isConnected Then
    
        conn.cloasAll
    
        Load frmDB
        frmDB.bFromStart = True
        frmDB.Show 1
        
        bAskSource = False
    
        If bBaseConnected Then
            
            GoTo dbconnect
            
'            conn.strServerName = strCurServer
'            conn.strBaseName = strCurDataBase
'            conn.strSrtmName = strCurDataBase

'            If Not frmSps Is Nothing Then frmSps.setStatus "Подключение к базе данных..."
'            Call conn.tryToConnectDB(bSaveSettings)

        Else
            Set frmSps = Nothing
            Exit Sub
        End If
        
    End If
    
    
    If Not frmSps Is Nothing Then frmSps.Visible = True
    
    
    Set cn_data = conn.con_data
    Set cn_srtm = conn.con_srtm
    
    Dim RS As New ADODB.Recordset
    
    
    
    usrCurrent.usrID = selectLongFromBase(cn_srtm, "usr", "usrID", "usrLogin", usrCurrent.strLogin)
    
    'usrCurrent.usrID = 681 ' Ириней
    'usrCurrent.usrID = 485 ' Мицкевич
    'usrCurrent.usrID = 500 '
    
    
    If usrCurrent.usrID = 0 Then
    
        If Not frmSps Is Nothing Then frmSps.Visible = False
        
        Dim iTrusted As Integer
        
        '        MsgBox "   В базе данных не найден пользователь " & usrCurrent.strLogin & ", работа с программой невозможна   ", vbCritical, ""
        '        Unload frmSplash
        '        Exit Sub
        
        '        Dim str As String
        '        str=inputbox("Введите Ваши фамилию, имя и отчество","Ваши персональные данные","Иванов Иван Иванович",
        
        Dim usrcnt As Long
        usrcnt = selectLongFromBase(cn_srtm, "usr", "count(*)", "", Empty)
        
    If usrcnt = 0 Then ' no user records
        
            Dim res As VbMsgBoxResult
            
            res = MsgBox("Пользователей в базе данных нет." & vbNewLine & "Создать запись для логина " _
                        & usrCurrent.strLogin & " с правами администратора?", vbYesNoCancel, "")
            
            If res = vbCancel Then
                If Not frmSps Is Nothing Then Unload frmSps: Set frmSps = Nothing
            End If
            
            If res = vbYes Then
                usrCurrent.groupID = 1
                iTrusted = 1
            Else
                usrCurrent.groupID = 2
                iTrusted = 0
            End If
            
            
        Else
            iTrusted = 0
        
        End If
        Load frmUser
        
        If Len(usrCurrent.strFIO(1)) > 0 Then frmUser.txtF.text = usrCurrent.strFIO(1)
        If Len(usrCurrent.strFIO(3)) > 0 Then frmUser.txtI.text = usrCurrent.strFIO(2)
        If Len(usrCurrent.strFIO(3)) > 0 Then frmUser.txtO.text = usrCurrent.strFIO(3)
        
        frmUser.Show 1
        
        If frmUser.bOk And usrCurrent.depID > 0 Then
            
            
            If frmUser.userID > 0 Then
                usrCurrent.usrID = frmUser.userID
                
                If Not updateTableInBase(cn_srtm, "usr", "usrLogin", usrCurrent.strLogin, "usrID", usrCurrent.usrID) Then
                    usrCurrent.usrID = 0
                End If
                
            Else
                usrCurrent.usrID = insertDataInBase(cn_srtm, "usr", _
                                    "usrLogin", usrCurrent.strLogin, _
                                    "usrFName", usrCurrent.strFIO(1), _
                                    "usrName", usrCurrent.strFIO(2), _
                                    "usrOName", usrCurrent.strFIO(3), _
                                    "groupID", usrCurrent.groupID, _
                                    "depID", usrCurrent.depID, _
                                    "usrTrusted", iTrusted)
            End If
            

            If usrCurrent.usrID = 0 Then
                MsgBox "Не сохранить пользователя", vbCritical
                Exit Sub
            End If
            
            If bDontUseSplash <> 2 Then
            If Not frmSps Is Nothing Then frmSps.Show
            If Not frmSps Is Nothing Then frmSps.Refresh
            End If
            
        Else
            Exit Sub
        End If
        
        
    End If
    
    If Not frmSps Is Nothing Then frmSps.Visible = True
    
'    If getBool(GetSetting("Offtake2", "Size", "mnuPrefRound03.Checked", True)) Then
'        rndGlobal.iPosMass = GetSetting("Offtake2", "RndShift", "iPosMass", -2)
'    Else
        rndGlobal.iPosMass = GetSetting("Offtake2", "RndShift", "iPosMass", iPosMassRoundDefault)
'    End If
    
    iSpecImportRowHeight = GetSetting("Offtake2", "SpecDgnImport", "iSpecImportRowHeight", 800)

    
    lngRowColor = &HFFFFFF
    lngTextColor = &H80000008
    lngRed = &HFF&
    lngRowWinColor = &H80000005
    lngGreen = &HC0FFC0
    lngGrey = &HE0E0E0
    lngDarkGrey = &H808080
    lngFiolet = &HFFC0C0
    lngBlue = &HFFFFC0
    lngNewRowColor = lngBlue
    lngMarkRowColor = lngGrey
    lngLightRed = &HC0C0FF
    
    sFilterPartVersion = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    sFilterPartSheet = "0123456789"
    sFilterPartName = selectStringFromBase(cn_srtm, "usr", "usrPartFilter", "usrID", usrCurrent.usrID)
    
    iPartTreeLevel = GetSetting("Offtake2", "Size", "iPartTreeLevel", 0)
    
    stts(0) = "Разработка"
    stts(1) = "Проверено"
    stts(2) = "Выпущено"
    stts(3) = "Не используется"
    
    strDrawingsLibraryFileName = App.path & "\drawings.dgn"
    
    RS.Open "select * from usr where usrID = " & usrCurrent.usrID, cn_srtm, adOpenForwardOnly, adLockOptimistic
    If Not RS.EOF Then
        
        
        usrCurrent.depID = RS.fields("depID").Value
        usrCurrent.strFIO(1) = RS.fields("usrFName").Value & ""
        usrCurrent.strFIO(2) = RS.fields("usrName").Value & ""
        usrCurrent.strFIO(3) = RS.fields("usrOName").Value & ""
        usrCurrent.groupID = RS.fields("groupID").Value
        usrCurrent.trusted = getBool(RS.fields("usrTrusted").Value & "")
        
        RS.fields("compName").Value = curCompName
        RS.fields("usedNative").Value = conn.bUsedNative
        If Not bReadOnly Then RS.Update
        
        usrCurrent.pdsID = selectLongFromBase(cn_srtm, "usr", "pdsID", "usrID", usrCurrent.usrID)
        If usrCurrent.pdsID = 0 Then
            usrCurrent.pdsID = selectLongFromBase(cn_srtm, "department", "pdsID", "depID", usrCurrent.depID)
        End If
        
        If usrCurrent.pdsID > 0 Then
            usrCurrent.partdefDefaultID = selectLongFromBase(cn_srtm, "pdset", "partdefID", "pdsID", usrCurrent.pdsID)
        End If
        
        
    End If
    
    If Not bReadOnly Then RS.Close
    Set RS = Nothing
    
    
    usrCurrent.specID = selectLongFromBase(cn_srtm, "department", "specID", "depID", usrCurrent.depID)
    usrCurrent.depName = selectStringFromBase(cn_srtm, "department", "depName", "depID", usrCurrent.depID)
    
    connectOldBases
    
    Dim strDifDepName As String

    
    If usrCurrent.groupID = 0 Then
'        MsgBox "   Пользователь '" & usrCurrent.strLogin & "' не принадлежит ни одной из групп   ", vbCritical, ""
'        Unload frmSplash
'        Exit Sub
        usrCurrent.groupID = 2
    End If
    
    usrCurrent.strGroupName = selectStringFromBase(cn_srtm, "i_group", "groupName", "groupID", usrCurrent.groupID)
    
    If iSetDepID > 0 And iSetDepID <> usrCurrent.depID Then
        strDifDepName = "<" & usrCurrent.depName & "/" & selectStringFromBase(cn_srtm, "department", "depName", "depID", iSetDepID) & ">"
    Else
        strDifDepName = "(" & usrCurrent.depName & ")"
    End If
    
    '==========================================
    '==========================================
    '==========================================
    Set prConfig = New clsConfig ' загрузка XML
    '==========================================
    '==========================================
    '==========================================

    If Len(prConfig.errMessage) > 0 Then
        If Not frmSps Is Nothing Then Unload frmSps: Set frmSps = Nothing
        If MsgBox(prConfig.errMessage & vbNewLine & "Продолжать работу?", vbYesNo) = vbNo Then Exit Sub
    End If
    
    ' =========================================
    ' ======== LOAD SORTAMENT =================
    If frmSps Is Nothing Then
        loadBaseData Nothing
    Else
        loadBaseData frmSps.lblStatus
    End If
    ' =========================================
    ' =========================================
    
    
    usrCurrent.objID = objs("usr")
    
    '===================================================================
    
    If Not frmSps Is Nothing Then frmSps.setStatus "Подключение к ProjectWise..."
    
    '===================================================================
    
    Dim i As Integer
    Dim pws As clsDBCon
    For i = 1 To pwsets.Count
        Set pws = pwsets(i)
        pws.constring = "Provider=" & conn.strProvider & ".1;Persist Security Info=False;Timeout=5;"
        pws.constring = pws.constring & "User ID=" & pws.login & ";"
        pws.constring = pws.constring & "Initial Catalog=" & pws.database & ";"
        pws.constring = pws.constring & "Data Source=" & pws.server & ";"
    Next i
    
    pwset.connected = connectPW(conn.strProvider, False)
                
    
    If Not frmSps Is Nothing Then frmSps.setStatus "Загрузка интерфейса"
    
    
    Load F1
    F1.Caption = "Offtake Explorer v" & App.Major & "." & App.Minor & "." & App.Revision & " --- " & usrCurrent.strGroupName & _
                ": " & usrCurrent.strFIO(1) & " " & usrCurrent.strFIO(2) & " " & usrCurrent.strFIO(3) & " " & strDifDepName
                
    If pwset.canedit Then F1.Caption = F1.Caption & " (PW login OK)"
                
                
'    F1.Caption = F1.Caption & " --- помощь по тел.: 54295"
    
    F1.Show
    Set frmSps = Nothing
    F1.Refresh
    
    bMainFormLoaded = True
    
End Sub

'/******************************************************************************
Public Function connectPW(strProvider As String, Optional bCheckUser As Boolean = True) As Boolean
'/******************************************************************************

    On Error GoTo connectPW_ERR
    
'    constring = "Provider=" & strProvider & ".1;Persist Security Info=False;Timeout=5;"
'    constring = constring & "User ID=" & login & ";"
'    constring = constring & "Initial Catalog=" & database & ";"
'    constring = constring & "Data Source=" & server & ";"
    
    
    Dim cnpw As New ADODB.Connection
    cnpw.Open pwset.constring, pwset.login, pwset.login
    
    If bCheckUser Then
        Dim RS As New ADODB.Recordset
        RS.Open "select * from dms_user where o_username = '" & usrCurrent.strLogin & "' and o_secprovider = '" & usrCurrent.strDomain & "'", _
                    cnpw, adOpenForwardOnly, adLockReadOnly
        
    '    If Not RS.EOF Then
    '        pwset.userno = RS.Fields("o_userno").Value
    '    Else
    '        Exit Function
    '    End If
        
        RS.Close
    End If
    
    
'    Set RS = New ADODB.Recordset
'
'    RS.Open "select * from view_r_user_group where o_userno = " & pwset.userno, _
'                cnpw, adOpenForwardOnly, adLockReadOnly
'
'    If Not RS.EOF Then
'        RS.MoveFirst
'        Do
'            If InStr(1, RS.Fields("o_groupname").Value & "", "offtake", vbTextCompare) > 0 Then
                pwset.canedit = True
'            End If
'            RS.MoveNext
'        Loop Until RS.EOF
'
'    End If
'
'    RS.Close
    Set RS = Nothing
    
    cnpw.Close
    Set cnpw = Nothing
    
    connectPW = True

Exit Function

connectPW_ERR:

    If Not frmSps Is Nothing Then Unload frmSps: Set frmSps = Nothing

    MsgBox err.Description & vbNewLine & pwset.constring & vbNewLine & pwset.login

'    Dim fn As Integer
'    fn = FreeFile
'    Open App.Path & "\pwconerr.txt" For Output As fn
'
'    Print #fn, "strStep = "; strStep
'    Print #fn, "pwset.constring = "; pwset.constring
'    Print #fn, "pwset.login = "; pwset.login
'    Print #fn, "strSQL = "; strSQL
'    Print #fn, err.Number, err.Description
'
'    Close fn


    Set cnpw = Nothing
    connectPW = False

End Function



'/******************************************************************************
Public Function getServerSettings() As Boolean
'/******************************************************************************

    On Error GoTo getServerSettings_ERR ' ec
    
    Dim i As Integer
    Dim strFileName As String
    Dim fn As Integer
    Dim ar() As String
    Dim Arr() As String
    
    Dim str(1 To 30) As String
    Dim strLine As String
    Dim strArg As String
   
    strCurDataBase = ""
    
    strTechViewName = "view_tech"
    
    scfgCmn.spec_v_line_wdt = 1
    scfgCmn.spec_h_line_wdt = 0
    scfgCmn.spec_v_line_clr = 2
    scfgCmn.spec_h_line_clr = 2
    scfgCmn.spec_text_clr = 4
    scfgCmn.spec_table_scale = 100
    scfgCmn.spec_col_cmass = 6
    
    scfgCmn.spec_xls_template = "\\vibe2.sp.spbaep.ru\ms\set\seed\FH1_emb_template.xls"
    scfgCmn.spec_xls_startrow = 5
    scfgCmn.spec_xls_startcol = 5
    scfgCmn.spec_xls_rows = 21
    scfgCmn.spec_xls_jump = 27
'    ------------------------------------
'Kulakov - add for Rooom to SPF (24/06/2017)
    scfgCmn.space_xls_template = "\\vibe2.sp.spbaep.ru\ms\set\seed\FH1_Room_to_SPF_Template.xls"
    scfgCmn.space_xls_startrow = 11
    scfgCmn.space_xls_startcol = 3
    scfgCmn.space_xls_rows = 500
    scfgCmn.space_xls_jump = 0
    
'    -----------------------------------
    
    scfgCmn.spec_text_diam = "¶"
    scfgCmn.spec_text_dscr = "[dscr]|лист [sht]"
    
    scfgCmn.spec_row_numbers = 0
    scfgCmn.spec_skip_bar = 0
    
    strNewPartName = "MC-"
    
    strHelpXml = "Help"
    
    '    If StrComp(Right(App.EXEName, 4), ".exe", vbTextCompare) = 0 Then
    '        strFileName = App.Path & "\" & Replace(App.EXEName, ".exe", ".ini", , , vbTextCompare)
    '    Else
    strFileName = App.path & "\Offtake2.ini"
    '    End If
    
    fn = FreeFile
    
    Open strFileName For Input As fn
    
    Do
        
        Line Input #fn, strLine
        
        Arr = Split(Trim(strLine), "#", , vbTextCompare) ' comment
        
        If UBound(Arr) > -1 Then ' not empty row
            
            ar = Split(Arr(0), "=", , vbTextCompare)
            
            If UBound(ar) = 1 Then
                
                strLine = Replace(LCase(ar(0)), " ", "")
                strLine = Replace(strLine, vbTab, "")
                
                strArg = Replace(ar(1), " ", "")
                strArg = Replace(strArg, vbTab, "")
                
                Select Case strLine
                    Case "server"
                        str(1) = strArg
                        
                    Case "database"
                        str(2) = strArg
                        
                    Case "usefillet" ' использовать загиб стержня по радиусу из базы fillet_radius, если нет - (5d + 0.5d)
                        str(3) = strArg
                        
                        '                Case "corelines"
                        '                    str(4) = Trim(UCase(ar(1)))
                        
                        '                Case "coretext"
                        '                    str(5) = Trim(UCase(ar(1)))
                        
                        '                Case "updrein"
                        '                    str(6) = Trim(UCase(ar(1)))
                        
                    Case "srtm"
                        str(7) = strArg
                        
                    Case "catsinlist"
                        str(8) = strArg
                        
                    Case "offtnew"
                        str(9) = strArg
                        
                    Case "helpxml"
                        strHelpXml = Trim(strArg)
                        
                    Case "skipdata"
                        bSkipLoadData = CBool(Trim(strArg))
                        
                    Case "techview"
                        strTechViewName = Trim(strArg)
                        
                    Case "numdigits"
                        str(11) = strArg
                        
                    Case "nosplash"
                        str(12) = strArg
                        
                    Case "massround"
                        str(13) = strArg
                        
                    Case "clientcursor"
                        str(14) = strArg
                        
                    Case "catsnewload"
                        str(15) = strArg
                        
                    Case "pdfcolor"
                        str(16) = strArg
                        
                    Case "departid"
                        str(17) = strArg
                        
                    Case "readonly"
                        str(18) = strArg
                        
                    Case "askalways"
                        str(19) = strArg
                        
                        ' spec config
'                    Case "spec_v_line_wdt"
'                        scfgCmn.spec_v_line_wdt = Val(strArg)
'                    Case "spec_h_line_wdt"
'                        scfgCmn.spec_h_line_wdt = Val(strArg)
'                    Case "spec_row_numbers"
'                        scfgCmn.spec_row_numbers = Val(strArg)
'                    Case "spec_v_line_clr"
'                        scfgCmn.spec_v_line_clr = Val(strArg)
'                    Case "spec_h_line_clr"
'                        scfgCmn.spec_h_line_clr = Val(strArg)
'                    Case "spec_text_clr"
'                        scfgCmn.spec_text_clr = Val(strArg)
'                    Case "spec_text_diam"
'                        scfgCmn.spec_text_diam = strArg
'                    Case "spec_skip_bar"
'                        scfgCmn.spec_skip_bar = Val(strArg)
'                    Case "spec_table_scale"
'                        scfgCmn.spec_table_scale = Val(strArg)
'                    Case "spec_col_cmass"
'                        scfgCmn.spec_col_cmass = Val(strArg)
'                    Case "spec_text_dscr"
'                        scfgCmn.spec_text_dscr = Trim(ar(1))
                        
'                    Case "spec_xls_template"
'                        scfgCmn.spec_xls_template = Trim(ar(1))
'                    Case "spec_xls_startrow"
'                        scfgCmn.spec_xls_startrow = Val(strArg)
'                    Case "spec_xls_startcol"
'                        scfgCmn.spec_xls_startcol = Val(strArg)
'                    Case "spec_xls_rows"
'                        scfgCmn.spec_xls_rows = Val(strArg)
'                    Case "spec_xls_jump"
'                        scfgCmn.spec_xls_jump = Val(strArg)
'                        ------------------------------------------------------
'Kulakov - add for Rooom to SPF (24/06/2017)
                     Case "space_xls_template"
                        scfgCmn.space_xls_template = Trim(ar(1))
                    Case "space_xls_startrow"
                        scfgCmn.space_xls_startrow = Val(strArg)
                    Case "space_xls_startcol"
                        scfgCmn.space_xls_startcol = Val(strArg)
                    Case "space_xls_rows"
                        scfgCmn.space_xls_rows = Val(strArg)
                    Case "space_xls_jump"
                        scfgCmn.space_xls_jump = Val(strArg)
'                  --------------------------------------------------------------
                    Case "part_new_name"
                        strNewPartName = Trim(ar(1))
                        
'                    Case "rein_arc_round_shift"
'                        rndGlobal.iArmArc = Val(strArg)
'                    Case "rein_arc_round_snap"
'                        rndGlobal.iArmArcSnap = Val(strArg)
'                    Case "rein_line_round_shift"
'                        rndGlobal.iArmSegm = Val(strArg)
'                    Case "rein_line_round_snap"
'                        rndGlobal.iArmSegmSnap = Val(strArg)
                        
'                    Case "pw_menu"
'                        ar = Split(strArg, ";")
'                        'pwsetscnt = 0
'                        For i = 0 To UBound(ar)
'                            Dim a As New clsDBCon
'                            a.text = ar(i)
'                            pwsets.Add a, a.text
'                            Set a = Nothing
'                        Next i
'                    Case "pw_srv"
'                        ar = Split(strArg, ";")
'                        For i = 0 To UBound(ar)
'                            pwsets(i + 1).server = ar(i)
'                        Next i
'                    Case "pw_db"
'                        ar = Split(strArg, ";")
'                        For i = 0 To UBound(ar)
'                            pwsets(i + 1).database = ar(i)
'                        Next i
'                    Case "pw_login"
'                        For i = 1 To pwsets.Count
'                            pwsets(i).login = ar(0)
'                        Next i
'                        ar = Split(strArg, ";")
'                        For i = 0 To UBound(ar)
'                            pwsets(i + 1).login = ar(i)
'                        Next i
'                    Case "pw_root"
'                        For i = 1 To pwsets.Count
'                            pwsets(i).root = Val(strArg)
'                        Next i
                    Case "simdbase"
                        str(20) = strArg
                    Case "simconfig"
                        str(21) = strArg
                    Case "navismsg" ' navismsg        = \\vibe2\Install\Navis\Navisworks.msg
                        str(22) = strArg
                        
                        
                End Select
                
            End If
            
        End If
        
    Loop Until EOF(fn)
    
    
    
'    If pwsets.Count > 0 Then
'
'        Dim ind As Integer
'        ind = GetSetting("Offtake2", "pw", "connection index", 0) + 1
'
'        If ind < 1 Then ind = 1
'        If ind > pwsets.Count Then ind = pwsets.Count
'
'        Set pwset = pwsets(ind)
'    End If
    
    
    'Dim I As Integer
    
    ar = Split(str(1), ",", , vbTextCompare)
    ReDim arServers(UBound(ar))
    For i = 0 To UBound(ar)
        arServers(i) = ar(i)
    Next i
    
    ar = Split(str(2), ",", , vbTextCompare)
    ReDim arBases(UBound(ar))
    For i = 0 To UBound(ar)
        arBases(i) = ar(i)
    Next i
    
    sRememberedDB = GetSetting("Offtake2", "Source", "DB_rem", "")
    sRememberedSRV = GetSetting("Offtake2", "Source", "SRV_rem", "")
    
    If UBound(arServers) >= 0 And Len(sRememberedSRV) = 0 Then
        strCurServer = arServers(0)
    ElseIf Len(sRememberedSRV) > 0 Then
        strCurServer = sRememberedSRV
    End If
    
    
    If UBound(arBases) >= 0 And Len(sRememberedDB) = 0 Then
        strCurDataBase = arBases(0)
    ElseIf Len(sRememberedDB) > 0 Then
        strCurDataBase = sRememberedDB
    End If
    
    If Len(str(20)) > 0 Then
        strCurSimBase = str(20)
    Else
        strCurSimBase = "aecosim"
    End If
    
    
    If Len(str(21)) > 0 Then
        strCurSimConfig = str(21)
    Else
        strCurSimConfig = App.path & "\Offtake2.cfg"
    End If
    
    If Len(str(22)) > 0 Then
        strNavisMsg = str(22)
    Else
        strNavisMsg = "\\vibe2\Install\Navis\Navisworks.msg"
    End If
    
   
        
'        If Len(str(7)) > 0 Then
'            conn.strSrtmName = str(7)
'        Else
'            conn.strSrtmName = conn.strBaseName
'        End If
        
    bUseReinFilletBySettings = CBool(Val(str(3)))
    bOfftNew = CBool(Val(str(9)))
    If Len(str(11)) > 0 Then iNumDigitsDefault = Val(str(11))
    bDontUseSplash = Val(str(12))
    If Len(str(13)) > 0 Then iPosMassRoundDefault = Val(str(13))
    bUseCursorClient = CBool(Val(str(14)))
    bUseNewCatsLoad = True ' CBool(Val(str(15)))
    bUsePartPdfColor = CBool(Val(str(16)))
    iSetDepID = Val(str(17))
    bReadOnly = CBool(Val(str(18)))
    bAskSource = CBool(Val(str(19)))
    
    getServerSettings = True
    
    Close fn
    
    
    
    
    
    Exit Function
    
getServerSettings_ERR:
    '    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "getServerSettings - Error"
    
End Function

''/******************************************************************************
'Public Function tryToConnectDB(bSaveSettings As Boolean) As Boolean
''/******************************************************************************
'
'
'    tryToConnectDB = False
'    bBaseConnected = False
'
'    On Error GoTo m2
'
'
'    If bUseNativeProvider Then
'        strCurProvider = "SQLNCLI10"
'    Else
'        strCurProvider = "SQLOLEDB"
'    End If
'
''    Dim strCn As String
''    Dim strPath As String
'
''    Dim shlShell As Shell32.Shell
''    Dim shlFolder As Shell32.Folder
''    Const BIF_RETURNONLYFSDIRS = &H1
'
''    strPath = GetSetting("PartsBase", "Common", "Path", "")
'
''    If strPath = "" Then
''        Set shlShell = New Shell32.Shell
''        Set shlFolder = shlShell.BrowseForFolder(0, "Select a Folder", BIF_RETURNONLYFSDIRS)
''        If shlFolder Is Nothing Then
''            tryToConnectDB = False
''            Exit Function
''        End If
''        strPath = shlFolder.Self.Path
''    End If
'
'
'
''    strBaseName = "parts"
''    strServerName = "SRVPARTS\PRT"
''    strServerName = "10.22.64.101\PRT"
'
'
'
'
''    strCn = "Provider=Microsoft.Jet.OLEDB.4.0" & ";"
''    strCn = strCn & "Data Source=" & strPath & "\main2003.so2" & ";"
''    strCn = strCn & "Persist Security Info=True" & ";"
''    strCn = strCn & "Jet OLEDB:System database=" & strPath & "\main2003.mdw"
'
'    Set cn_data = New ADODB.Connection
'    cn_data.Open "Provider=" & strCurProvider & ".1;Persist Security Info=False;Timeout=15;User ID=" & strUser & ";Initial Catalog=" & strBaseName & ";Data Source=" & strServerName, strUser, strPass
'
'    If StrComp(strBaseName, strSrtmName, vbTextCompare) = 0 Then
'        Set cn_srtm = cn_data
'    Else
'        Set cn_srtm = New ADODB.Connection
'        cn_srtm.Open "Provider=" & strCurProvider & ".1;Persist Security Info=False;Timeout=15;User ID=" & strUser & ";Initial Catalog=" & strSrtmName & ";Data Source=" & strServerName, strUser, strPass
'    End If
'
'
'
'
''    Provider=SQLNCLI10.1;
''    User ID=so2user;
''    Initial Catalog=parts;
''    Data Source=10.22.66.190;
'
'    If bSaveSettings Then
'
'        SaveSetting "Offtake2", "Source", "Server", strServerName
'        SaveSetting "Offtake2", "Source", "Database", strBaseName
'        SaveSetting "Offtake2", "Source", "Srtm", strSrtmName
'
'
'        Dim str As String
'
'        str = "[oledb]" & vbNewLine
'        str = str & "; Everything after this line is an OLE DB initstring" & vbNewLine
'
'        str = str & "Provider=" & strCurProvider & ".1;Persist Security Info=True" & _
'            ";User ID=" & strUser & _
'            ";Password=" & strPass & _
'            ";Initial Catalog=" & strBaseName & _
'            ";Data Source=" & strServerName & _
'            ";Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Use Encryption for Data=False;Tag with column collation when possible=False" & vbNewLine
'
'        writeUnicodeTextFile Environ$("WINDIR") & "\so2.udl", str
'
'    End If
'
'
'
'
'
'
'    bBaseConnected = True
'    tryToConnectDB = True
'
'    strErr = ""
'
'    Exit Function
'
'm2:
'    If err.Number = 3705 Then ' уже открыто
'        tryToConnectDB = True
'        bBaseConnected = True
'        Exit Function
'    End If
'
'    strErr = err.Description
'
'End Function

' NOT USING
Sub writeUnicodeTextFile(ByRef path As String, ByRef Value As String)

    Dim buffer() As Byte
    Dim Buffer2() As Byte
    Dim FileNum As Integer
    
    ' Convert string to an array of bytes, preserving unicode (2bytes per character)
    ReDim buffer(0 To Len(Value) * 2)
    
    buffer = Value

    ReDim Buffer2(0 To UBound(buffer) + 2)

    Buffer2(0) = &HFF
    Buffer2(1) = &HFE

    Dim i As Integer

    For i = 0 To UBound(buffer)
        Buffer2(i + 2) = buffer(i)
    Next i
    
    ' clear
    FileNum = FreeFile
    Open path For Output As FileNum
    Close FileNum
    
    ' write
    FileNum = FreeFile
    Open path For Binary As FileNum
    Put FileNum, , Buffer2
    Close FileNum

End Sub


'/******************************************************************************
Public Function copyFile(strSrc As String, strDst As String, Optional bRewrite As Boolean = True) As Boolean
'/******************************************************************************

    On Error GoTo copyFile2_ERR
    
    copyFile = False

    Dim ret As Long

    ret = apiCopyFile(strSrc, strDst, Not bRewrite)

    If ret = 0 Then copyFile = False Else copyFile = True

   
Exit Function

copyFile2_ERR:


End Function



'/******************************************************************************
Public Function loadMaterials() As Boolean
'/******************************************************************************

    On Error GoTo loadMaterials_ERR


    Set globMats = New colMat
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from material", cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    RS.MoveFirst
    Do
        
        Dim m As New clsMat
        If m.loadMat(RS, RS.fields("matID").Value) Then
            m.loadMatPosDefs
            globMats.AddMat m, CStr(m.matID)
        End If
        
        Set m = Nothing
        
        RS.MoveNext
    Loop Until RS.EOF
    
    loadMaterials = True


Exit Function

loadMaterials_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "loadMaterials - Error"

End Function

'/******************************************************************************
Public Function loadProperties2() As Boolean
'/******************************************************************************
    
    On Error GoTo loadProperties_ERR
    
    loadProperties2 = False
    
    Set globPrps = New colPrp
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from view_property where [using] = 1", cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    RS.MoveFirst
    Do
    
        Dim pr As New clsPrp
        If pr.loadByPropID(RS.fields("propID").Value, RS) Then
            globPrps.AddSimple pr, pr.propName
        Else
            Exit Function
        End If
        Set pr = Nothing
        
        RS.MoveNext
    Loop Until RS.EOF
    
    RS.Close
    Set RS = Nothing
    
    loadProperties2 = True
    
    
    
    Exit Function
    
loadProperties_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "loadProperties - Error"
    
End Function



'/******************************************************************************
Public Function loadProperties() As Boolean
'/******************************************************************************
    
    On Error GoTo loadProperties_ERR
    
    loadProperties = False
    
    Set globProps = New colProp
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from view_property where [using] = 1", cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    RS.MoveFirst
    Do
    
        Dim pr As New clsProp
        If pr.loadByPropID(RS.fields("propID").Value, RS) Then
            globProps.AddSimple pr, pr.propName
        Else
            Exit Function
        End If
        Set pr = Nothing
        
        RS.MoveNext
    Loop Until RS.EOF
    
    
    RS.Close
    Set RS = Nothing
    
    loadProperties = True
    
    
    
    Exit Function
    
loadProperties_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "loadProperties - Error"
    
End Function


'/******************************************************************************
Public Function loadPosdefs() As Boolean ' NU
'/******************************************************************************

    On Error GoTo loadPosdefs_ERR

    Set globPosdefs = New colPD

    Dim RS As New ADODB.Recordset


    RS.Open "select * from posdef", cn_srtm, adOpenForwardOnly, adLockReadOnly

    RS.MoveFirst
    Do

        Dim pd As New clsPD
        pd.loadPosdef RS.fields("posdefID").Value
        globPosdefs.AddPosdef pd, CStr(pd.pdID)
        Set pd = Nothing

        RS.MoveNext
    Loop Until RS.EOF


    loadPosdefs = True

Exit Function

loadPosdefs_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "loadPosdefs - Error"

End Function



'/******************************************************************************
Public Function loadDocSets() As Boolean
'/******************************************************************************
    
    On Error GoTo loadDocSets_ERR
    
    
    Dim RS As New ADODB.Recordset
    
    
    
    Set globDSSgn = New Collection
    
'    RS.Open "select * from docsetsign", cn_srtm, adOpenForwardOnly, adLockReadOnly
'
'    RS.MoveFirst
'    Do
'
'        Dim dss As New clsDocSetSign
'
'        If dss.loadDSS(RS, RS.fields("dssID").Value) Then globDSSgn.Add dss, dss.dssSymbol
'
'        Set dss = Nothing
'
'        RS.MoveNext
'    Loop Until RS.EOF
'
'    RS.Close
    
    '===========================================
    
    Set globDSNum = New Collection
    
    RS.Open "select * from docsetnumber", cn_srtm, adOpenForwardOnly, adLockReadOnly

    RS.MoveFirst
    Do

        Dim dsn As New clsDocSetNum

        If dsn.loadDSNum(RS, RS.fields("nmbID").Value) Then globDSNum.Add dsn, CStr(dsn.dsnID)

        Set dsn = Nothing

        RS.MoveNext
    Loop Until RS.EOF

    RS.Close
    
    '===========================================
    
    
    
'    Set globDocSets = New colDocSets
    
'    RS.Open "select * from docset", cn_srtm, adOpenForwardOnly, adLockReadOnly
'
'    If Not RS.EOF Then
'
'        RS.MoveFirst
'        Do
'
'            Dim ds As New clsDocSet
'
'            ds.loadDocSet RS, RS.fields("dsID").Value
'
'            globDocSets.Add ds, CStr(ds.docsetID)
'
'            Set ds = Nothing
'
'            RS.MoveNext
'        Loop Until RS.EOF
'
'    End If
'
'    RS.Close
'    Set RS = Nothing
    
    loadDocSets = True
    
    
    
    Exit Function
    
loadDocSets_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadDocSets - Error"
    
End Function

'/******************************************************************************
Public Function loadArmClasses() As Boolean
'/******************************************************************************

    On Error GoTo loadArmClasses_ERR

    Dim RS As New ADODB.Recordset
    
    Set globArmClasses = New Collection
    
    RS.Open "select * from armclass", cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    RS.MoveFirst
    Do
        
        Dim AC As New clsArmClass
        
        AC.armClassID = RS.fields("armclassID").Value
        AC.armClassName = RS.fields("armclassName").Value & ""
        AC.armClassOldName = RS.fields("oldName").Value & ""
'        ac.bUseWire = CBool(RS.Fields("useWire").Value)
        
        globArmClasses.Add AC, CStr(AC.armClassID)
        
        Set AC = Nothing
        
        RS.MoveNext
    Loop Until RS.EOF
    
    RS.Close
    Set RS = Nothing
    
    loadArmClasses = True


Exit Function

loadArmClasses_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadArmClasses - Error"

End Function


'/******************************************************************************
Public Function loadMassCalcs() As Boolean
'/******************************************************************************
    
    On Error GoTo loadMassCalcs_ERR
    
    Dim mc As clsMC
    
    Set globMassCalcs = New Collection
    
    loadMassCalcs = False
    
    ' массу не считать
    Set mc = New clsMC
    mc.mcID = -1
    mc.mcName = "массу не считать"
    mc.mcDescr = mc.mcName
    mc.bSpecQty = True
    mc.bSpecUMass = False
    mc.bSpecCMass = False
    Set mc.mc_props = New colProp
    globMassCalcs.Add mc, "-1"
    Set mc = Nothing
    
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from masscalc", cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    RS.MoveFirst
    Do
        
        Set mc = New clsMC
        
        If mc.loadMassCalc(RS, RS.fields("mcID").Value) Then
            mc.loadMassCalcProps
            globMassCalcs.Add mc, CStr(mc.mcID)
        End If
        
        Set mc = Nothing
        
        RS.MoveNext
    Loop Until RS.EOF
    
    
    
    
    
    Dim i As Integer
    
    
    For i = 1 To globMassCalcs.Count
        Set mc = globMassCalcs(i)
        mc.loadChildren
    Next i
    
    RS.Close
    Set RS = Nothing
    
    loadMassCalcs = True
    
    Exit Function
    
loadMassCalcs_ERR:
    loadMassCalcs = False
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "loadMassCalcs - Error"
    
End Function


'/******************************************************************************
Public Function loadMeasureUnits() As Boolean
'/******************************************************************************

    On Error GoTo loadMeasureUnits_ERR

    
    
    Set globMUnits = New Collection
    
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from measureunit", cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    RS.MoveFirst
    Do
        
        Dim mu As New clsMU
        mu.loadMUnits RS, RS.fields("muID").Value
        globMUnits.Add mu, CStr(mu.muID)
        Set mu = Nothing
        
        RS.MoveNext
    Loop Until RS.EOF
    
    
    Dim i As Integer
    
    
    For i = 1 To globMUnits.Count
        
        Set mu = globMUnits(i)
        mu.loadChildren
        
    Next i
    
    RS.Close
    Set RS = Nothing
    
    loadMeasureUnits = True

Exit Function

loadMeasureUnits_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "loadMeasureUnits - Error"

End Function



'/******************************************************************************
Public Function loadStandards() As Boolean
'/******************************************************************************
    
    On Error GoTo loadStandards_ERR
    
    Set globStds = New colStd
    
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from view_standard", cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    RS.MoveFirst
    Do
        
'        MsgBox RS.Fields("stdID").Value
'
        Dim std As New clsStd
        std.setStdID RS.fields("stdID").Value, RS
        globStds.AddStd std, CStr(std.stdID)
        Set std = Nothing
        
        RS.MoveNext
    Loop Until RS.EOF
    
'    MsgBox "ok"
    
    loadStandards = True
    
    
    Exit Function
    
loadStandards_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "loadStandards - Error"
    
End Function


'/******************************************************************************
Public Function loadPosdefStd() As Boolean
'/******************************************************************************

    On Error GoTo loadPosdefStd_ERR



    Set globStdPosdefs = New colStdPd

    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from r_standard_posdef where [using] = 1", cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    RS.MoveFirst
    Do
        
        Dim sp As New clsStdPd
        
        sp.loadByID RS.fields("relID").Value, RS
        
        globStdPosdefs.AddStdPd sp, CStr(sp.stdpdID)
        Set sp = Nothing
        
        RS.MoveNext
    Loop Until RS.EOF
    
    RS.Close
    Set RS = Nothing

    loadPosdefStd = True

Exit Function

loadPosdefStd_ERR:
    Set RS = Nothing
    Set frmSps = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "loadPosdefStd - Error"

End Function


'/******************************************************************************
Public Function loadSortament() As Boolean
'/******************************************************************************
    
    On Error GoTo loadSortament_ERR
    
    Dim i As Integer
    Dim s As String
    
    Set globSrtm = New colSrtm
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from view_r_sortament_property_3", cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    RS.MoveFirst
    Do
        
        Dim srtm As New clsSrtm
        
        If srtm.loadSrtm(RS, RS.fields("srtmID").Value) Then
            srtm.loadSrtmProps RS
        End If
        
        globSrtm.AddSimple srtm, CStr(srtm.srtmID)
        Set srtm = Nothing
        
        RS.MoveNext
    Loop Until RS.EOF
    
    RS.Close
    Set RS = Nothing
    
    
    ' добавить для clsPD коллекцию сортамента и загрузить с использованием strSort, забирая мемберы из colSrtm по srtmID
    
    
    
    
    
    
    
    
    loadSortament = True
    
    
    Exit Function
    
loadSortament_ERR:
    Set RS = Nothing
    Set frmSps = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "loadSortament - Error"
    
End Function


'/******************************************************************************
Public Function selectStringFromBase(conn As ADODB.Connection, strTable As String, strFieldToReturn As String, strWhereField As String, whereFieldValue As Variant) As String
'/******************************************************************************

    On Error GoTo m100

    Dim RS As New ADODB.Recordset
    
    Dim strSQL As String
    
    strSQL = "select " & strFieldToReturn & " from [" & strTable & "] where [" & strWhereField & "] = "

    If typeName(whereFieldValue) = "String" Then
        strSQL = strSQL & "'" & Trim(whereFieldValue) & "'"
    Else
        strSQL = strSQL & Val(CStr(whereFieldValue))
    End If
    
    If bUseCursorClient Then RS.CursorLocation = adUseClient
    
    RS.Open strSQL, conn, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        RS.MoveFirst
        selectStringFromBase = RS.fields(0).Value & ""
    End If
    
    RS.Close
    Set RS = Nothing

    Exit Function
m100:
    Set RS = Nothing
    selectStringFromBase = "ssfb error"


End Function

'/******************************************************************************
Public Function selectLongFromBase(conn As ADODB.Connection, strTable As String, strFieldToReturn As String, _
                                   strWhereField As String, whereFieldValue As Variant, _
                                   Optional strWhereField2 As String = "", Optional whereFieldValue2 As Variant = Empty, _
                                   Optional strWhereField3 As String = "", Optional whereFieldValue3 As Variant = Empty, _
                                   Optional strWhereField4 As String = "", Optional whereFieldValue4 As Variant = Empty _
                                   ) As Long
'/******************************************************************************
    
    On Error GoTo m100
    
    Dim RS As New ADODB.Recordset
    
    Dim strSQL As String
    
    strSQL = "select " & strFieldToReturn & " from [" & strTable & "]"
    
    If Len(strWhereField) > 0 And Not IsEmpty(whereFieldValue) Then
    
        strSQL = strSQL & " where [" & strWhereField & "] = "
        
        If typeName(whereFieldValue) = "String" Then
            strSQL = strSQL & "'" & Trim(whereFieldValue) & "'"
        Else
            strSQL = strSQL & whereFieldValue
        End If
        
    End If
    
    If Not IsEmpty(whereFieldValue2) Then
    
        strSQL = strSQL & " and [" & strWhereField2 & "] = "
        
        If typeName(whereFieldValue2) = "String" Then
            strSQL = strSQL & "'" & Trim(whereFieldValue2) & "'"
        Else
            strSQL = strSQL & whereFieldValue2
        End If
    End If
    
    
    If Not IsEmpty(whereFieldValue3) Then
    
        strSQL = strSQL & " and [" & strWhereField3 & "] = "
        
        If typeName(whereFieldValue3) = "String" Then
            strSQL = strSQL & "'" & Trim(whereFieldValue3) & "'"
        Else
            strSQL = strSQL & whereFieldValue3
        End If
    End If
    
    
    If Not IsEmpty(whereFieldValue4) Then
    
        strSQL = strSQL & " and [" & strWhereField4 & "] = "
        
        If typeName(whereFieldValue4) = "String" Then
            strSQL = strSQL & "'" & Trim(whereFieldValue4) & "'"
        Else
            strSQL = strSQL & whereFieldValue4
        End If
    End If
    
    If bUseCursorClient Then RS.CursorLocation = adUseClient
    
    RS.Open strSQL, conn, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
    
        RS.MoveFirst
        
        selectLongFromBase = RS.fields(0).Value
    
    End If
    
    RS.Close
    Set RS = Nothing
    
    
    
    Exit Function
m100:
    Set RS = Nothing
    selectLongFromBase = 0
    
    
End Function

'/******************************************************************************
Public Function selectDoubleFromBase(conn As ADODB.Connection, strTable As String, strFieldToReturn As String, strWhereField As String, whereFieldValue As Variant) As Double
'/******************************************************************************
    
    On Error GoTo m100
    
    Dim RS As New ADODB.Recordset
    
    Dim strSQL As String
    
    strSQL = "select " & strFieldToReturn & " from " & strTable & " where " & strWhereField & " = "
    
    If typeName(whereFieldValue) = "String" Then
        strSQL = strSQL & "'" & Trim(whereFieldValue) & "'"
    ElseIf typeName(whereFieldValue) = "Integer" Or typeName(whereFieldValue) = "Long" Or typeName(whereFieldValue) = "Double" Or _
                typeName(whereFieldValue) = "Decimal" Then
        strSQL = strSQL & Trim(str(whereFieldValue))
    Else
        GoTo m100
    End If
    
    If bUseCursorClient Then RS.CursorLocation = adUseClient
    
    RS.Open strSQL, conn, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
    
        RS.MoveFirst
        
        If IsNull(RS.fields(strFieldToReturn).Value) Then
            selectDoubleFromBase = 0#
        Else
            selectDoubleFromBase = RS.fields(strFieldToReturn).Value
        End If
    
    End If
    
    RS.Close
    Set RS = Nothing
    
    
    Exit Function
m100:
    Set RS = Nothing
    selectDoubleFromBase = 0#
    
    
End Function

'/******************************************************************************
Public Function selectFromBase(con As ADODB.Connection, ByRef valueToReturn As Variant, strTable As String, strFieldToReturn As String, _
                strWhereField1 As String, whereFieldValue1 As Variant, _
                Optional strWhereField2 As String = "", Optional whereFieldValue2 As Variant = 0 _
                ) As Boolean
    
    On Error GoTo m100
    
    selectFromBase = False
    
    Dim RS As New ADODB.Recordset
    
    Dim strSQL As String
    
    strSQL = "select " & strFieldToReturn & " from [" & strTable & "] where [" & strWhereField1 & "] = "
    
    If typeName(whereFieldValue1) = "String" Then
        strSQL = strSQL & "'" & Trim(whereFieldValue1) & "'"
    Else
        strSQL = strSQL & Trim(CStr(whereFieldValue1))
    End If
    
    If Len(Trim(strWhereField2)) > 0 Then
    
        strSQL = strSQL & " and [" & strWhereField2 & "] = "
    
        If typeName(whereFieldValue2) = "String" Then
            strSQL = strSQL & "'" & Trim(whereFieldValue2) & "'"
        Else
            strSQL = strSQL & Trim(CStr(whereFieldValue2))
        End If
    End If
    
    If bUseCursorClient Then RS.CursorLocation = adUseClient
    
    RS.Open strSQL, con, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
    
        RS.MoveFirst
        
        valueToReturn = RS.fields(strFieldToReturn).Value
    
        selectFromBase = True
        
    End If
    
    RS.Close
    Set RS = Nothing
    
    
    Exit Function
m100:
    Set RS = Nothing
    selectFromBase = False
    
    
End Function

'/******************************************************************************
Public Function checkCatPerm(catID As Long, Optional op As oper = operUnknown) As Boolean
'/******************************************************************************

    On Error GoTo checkCatPerm_ERR

    Dim projID As Long
    
    Dim bCatOpen As Boolean
    Dim iCatStatus As pst
    Dim objID As Long
    Dim objectID As Long
    Dim catdefID As Long
    
    Dim strErr As String
    
    checkCatPerm = False
    
    If catID = 0 Then Exit Function
    
    If op = operUnknown Then
        If Not checkGroupPerm(0, "part", operModify) Then Exit Function
    Else
        If Not checkGroupPerm(0, "catalog", op) Then Exit Function
    End If
    
    
    projID = cCats(CStr(catID)).getProjectIDfromDB(True)
'    projID = F1.getProjID(Nothing, catID)
    If projID > 0 And CBool(selectLongFromBase(cn_data, "r_department_project", "readOnly", "projectID", projID, "depID", usrCurrent.depID)) Then
        Exit Function
    End If
    
    ' администраторы тоже не могут менять заблокированный
'    If checkGroupPerm(usrCurrent.groupID, "catalog", operModify) Then
'        checkCatPerm = True
'        Exit Function
'    End If
    
    
    Dim RS As ADODB.Recordset
    
    Set RS = New ADODB.Recordset
    
    RS.Open "select * from view_object_catalog where catID = " & catID, cn_data, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
    
        RS.MoveFirst
        
        bCatOpen = CBool(RS.fields("catOpen").Value)
        iCatStatus = RS.fields("catStatus").Value
        objID = RS.fields("objID").Value
        objectID = RS.fields("objectID").Value
        catdefID = RS.fields("catdefID").Value
        
    End If
    
    RS.Close
    
    ' блокирован если не определна конструкция
'    If catdefID = 0 Then
'        Exit Function
'    End If
    
    ' блокирован если не разработка
    If iCatStatus <> pstRazrabotka Then
        Exit Function
    End If
    
    ' если родит. каталог блокирован, то этот тоже
    If objID = objs("catalog") Then
        If checkCatPerm(objectID) = False Then Exit Function
    End If
    
    
    If bCatOpen Then
        checkCatPerm = True
        Exit Function
    End If
    
    
    RS.Open "select * from r_usr_catalog where catID = " & catID & " and usrID = " & usrCurrent.usrID, cn_data, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then checkCatPerm = True
    
    RS.Close
    Set RS = Nothing
    
    
    
Exit Function

checkCatPerm_ERR:
    Set RS = Nothing
    checkCatPerm = False
    F1.SB.Panels("status").text = "checkCatPerm() - " & err.Description
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "checkCatPerm - Error"

End Function




Public Function checkPartPerm(partID As Long, op As oper) As Boolean
    
    Dim usrID As Long
    Dim partStatusID As Long
    
    checkPartPerm = False
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from part where partID = " & partID, cn_data, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        
        usrID = RS.fields("usrID").Value
        partStatusID = RS.fields("partStatusID").Value
        
        If op = operModify Then
            
            If partStatusID = pst.pstRazrabotka Then
                checkPartPerm = True
            End If
            
        ElseIf op = operOverStatus Then
            
            ' изменение статуса делаем более простым 03/2024 Вибе Л.
            
            'If partStatusID = pst.pstRazrabotka Then
                checkPartPerm = True
            'ElseIf partStatusID = pst.pstProvereno Then
            '    If usrCurrent.usrID = usrID Then checkPartPerm = True
            '    If usrCurrent.groupID = 1 Then checkPartPerm = True
            'ElseIf partStatusID = pst.pstArchive Then
            '    If usrCurrent.groupID = 1 Then checkPartPerm = True
            'ElseIf partStatusID = pst.pstUstar Then
            '    If usrCurrent.groupID = 1 Then checkPartPerm = True
            'End If
            
        End If
    End If
    
    
    
End Function

'/////////////////////////////////////////////////////////////////
'/******************************************************************************
Public Function checkGroupPerm(grID_notused As Long, objname As String, op As oper) As Boolean
'/******************************************************************************

    On Error GoTo checkGroupPerm2_ERR


    Dim objID As Long
    Dim strOper As String
    
    objID = objs(objname)
    
    Dim rl As clsRule
    
    Set rl = globRules(objID & "-" & usrCurrent.groupID)
    
    If op = operCreate Then checkGroupPerm = rl.bCreate
    If op = operDelete Then checkGroupPerm = rl.bDelete
    If op = operErase Then checkGroupPerm = rl.bDelete
    If op = operModify Then checkGroupPerm = rl.bModify
    If op = operOverStatus Then checkGroupPerm = rl.bModify
    If op = operRestore Then checkGroupPerm = rl.bDelete
    If op = operUnknown Then checkGroupPerm = rl.bModify


Exit Function

checkGroupPerm2_ERR:
    checkGroupPerm = False

End Function




'/////////////////////////////////////////////////////////////////////////////////
Public Function checkGroupPerm_old(groupID As Long, objname As Variant, op As oper) As Boolean
    
    Dim objID As Long
    Dim strOper As String
    Dim RS As ADODB.Recordset
    
    On Error GoTo checkUserPerm_ERR
    
    checkGroupPerm_old = False
    
    If typeName(objname) = "String" Then
        objID = objs(objname)
    ElseIf typeName(objname) = "Integer" Or typeName(objname) = "Long" Then
        objID = CLng(objname)
    End If
    
    
    If objID = 0 Then
        GoTo checkUserPerm_ERR
    End If
    If groupID = 0 Then
        GoTo checkUserPerm_ERR
    End If
    
    
    If op = operCreate Then
        strOper = "ruleCreate"
    ElseIf op = operDelete Then
        strOper = "ruleDelete"
    ElseIf op = operErase Then
        strOper = "ruleDelete"
    ElseIf op = operOverStatus Then
        strOper = "ruleModify"
    ElseIf op = operModify Then
        strOper = "ruleModify"
    ElseIf op = operRestore Then ' unused
        strOper = "ruleDelete"
    ElseIf op = operUnknown Then ' unused
        strOper = "ruleModify"
    End If
    
    
    Set RS = New ADODB.Recordset
    
    RS.Open "select * from i_rule where groupID = " & groupID & " and objID = " & objID, cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        RS.MoveFirst
        checkGroupPerm_old = CBool(RS.fields(strOper).Value)
    Else
        GoTo checkUserPerm_ERR
    End If
    
    
    RS.Close
    
    Set RS = Nothing
    
    Exit Function
    
checkUserPerm_ERR:
    Set RS = Nothing
    checkGroupPerm_old = False
End Function

''/******************************************************************************
'Public Function roundShamanOld(v As Double, numDigits As Integer) As Double
''/******************************************************************************
'
'    On Error GoTo roundShaman_ERR
'
'
'
'    ' шаманское округление
'    Dim A, b, c As Double
'    Dim s As String
'
'    A = Round(v * 10#, 3)
'
'    b = Int(A)
'
'    c = Round(A - b, 3)
'
'    If numDigits = 1 And F1.mnuPrefRound03.Checked And c >= 0.3 And c <= 0.5 Then A = A + 0.2
'
'    s = FormatNumber(A / 10#, numDigits)
'
'    roundShamanOld = getDbl(s)
''    roundShamanOld = Round(A / 10#, numDigits)
'
'
'
'
'
'    Exit Function
'
'roundShaman_ERR:
'    roundShamanOld = -11111111#
'    '    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "roundShaman - Error"
'
'End Function


'/******************************************************************************
' ШАМАНСКОЕ ОКРУГЛЕНИЕ, дублирует содержимое misc.roundExt на случай ошибки
Private Function roundSh(v As Double, numDigits As Integer, Optional dSnap As Double = 10#, Optional iShift As Integer = 0) As Double
'/******************************************************************************

    On Error GoTo roundS_ERR


    Dim dv As Double

    dv = v * (dSnap ^ numDigits)

    dv = Int(dv + 0.55555555555555 - (0.111111111111111 * iShift))

    dv = dv / (dSnap ^ numDigits)

    roundSh = dv



Exit Function

roundS_ERR:
    roundSh = getDbl(FormatNumber(v, numDigits, , , vbFalse))

End Function


'/******************************************************************************
Public Function roundShaman(v As Double, numDigits As Integer, Optional dSnap As Double = 10#, Optional iShift As Integer = 0) As Double
'/******************************************************************************

    On Error GoTo roundShaman_ERR

    
    roundShaman = misc.roundExt(v, numDigits, dSnap, iShift)
    



Exit Function

roundShaman_ERR:
    roundShaman = roundSh(v, numDigits, dSnap, iShift)

End Function




'/******************************************************************************
Public Function FormatNum(v As Double, nd As Integer, Optional ndMin = 0) As String
'/******************************************************************************

    On Error GoTo FormatNum_ERR
    
    Dim sF As String
    
    If nd < ndMin Then nd = ndMin
    
    sF = "0." & String(nd, "0")
    
    If sF = "0." Then sF = "0"

    FormatNum = Format(v, sF)


Exit Function

FormatNum_ERR:
    FormatNum = FormatNumber(v, nd, , , vbFalse)

End Function




'/////////////////////////////////////////////////////////////////////////////////
Public Function writeOperationS(operID As oper, strObjName As String, objectID As Long, Optional sWhat As String = "", Optional ByRef cn As ADODB.Connection = Nothing) As Long


    On Error GoTo writeOperationS_ERR

    If cn Is Nothing Then Set cn = cn_data


    Dim objID As Long
    
    objID = objs(strObjName)
    
    If objID > 0 Then
        writeOperationS = writeOperationL(operID, objID, objectID, sWhat, cn)
    Else
        writeOperationS = 0
    End If

Exit Function

writeOperationS_ERR:
    writeOperationS = 0

End Function

'/////////////////////////////////////////////////////////////////////////////////
Public Function writeOperationL(operID As Long, objID As Long, objectID As Long, Optional sWhat As String = "", Optional ByRef cn As ADODB.Connection = Nothing) As Long


    On Error GoTo writeOperationL_ERR

    If cn Is Nothing Then Set cn = cn_data


    Dim RS As New ADODB.Recordset
    
    Dim arFields(5) As Variant
    Dim arValues(5) As Variant
    Dim dat As Date
    
    RS.Open "select top 1 *, getdate() as tm from operationslog order by operID desc", cn, adOpenForwardOnly, adLockOptimistic
    
    If Not RS.EOF Then
        RS.MoveFirst
        dat = RS.fields("tm").Value
    Else
        dat = Now
    End If
    
    arFields(0) = "oplogDate"
    arFields(1) = "operID"
    arFields(2) = "objID"
    arFields(3) = "objectID"
    arFields(4) = "usrID"
    arFields(5) = "what"
    
    arValues(0) = dat
    arValues(1) = operID
    arValues(2) = objID
    arValues(3) = objectID
    arValues(4) = usrCurrent.usrID
    arValues(5) = sWhat
    
    
    RS.AddNew arFields, arValues
    
    RS.Update
    
'    RS.Requery
'
'    RS.MoveFirst
'
'    writeOperationL = RS.Fields("operID").Value
    
    RS.Close
    Set RS = Nothing
    

Exit Function

writeOperationL_ERR:

    writeOperationL = 0

End Function


'/******************************************************************************
Public Function getBool(s As String)
'/******************************************************************************

    On Error GoTo getBool_ERR
    
    getBool = CBool(s)

Exit Function

getBool_ERR:
    getBool = CBool(Val(s))
End Function


Public Function getDbl(s As String) As Double
    On Error GoTo err
    Dim d As Double
    Dim ss As String
    
    ss = Replace(Trim(s), " ", "")
    
    d = ss
    GoTo noerr
err:
    d = Val(ss)
noerr:
    getDbl = d
End Function



''/******************************************************************************
'Private Function getString(iValue As Variant) As String
''/******************************************************************************
'
'    On Error GoTo getString_ERR
'
'        If typeName(iValue) = "String" Then
'            getString = "'" & Trim(iValue) & "'"
'        ElseIf typeName(iValue) = "Integer" Or typeName(iValue) = "Long" Or typeName(iValue) = "Double" Then
'            getString = Trim(str(iValue))
'        Else
'            getString = iValue
'        End If
'
'
'
'Exit Function
'
'getString_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getString - Error"
'
'End Function

'Public Function updateOrInsertTableInBase(conn As ADODB.Connection, _
'                                          strTable As String, _
'                                          strField As String, _
'                                          fieldValue As Variant, _
'                                          strWhere As String, _
'                                          whereValue As Variant) As Boolean
'
'
'
'    Dim RS As New ADODB.Recordset
'
'    RS.Open "select " & strWhere & "," & strField & " from " & strTable & " where " & strWhere & " = " & getString(whereValue), conn, adOpenForwardOnly, adLockOptimistic
'
'    If RS.EOF Then
'        RS.AddNew
'        RS.Fields(strWhere).Value = whereValue
'    Else
'        RS.MoveFirst
'    End If
'
'    RS.Fields(strField).Value = fieldValue
'
'    RS.Update
'
'    RS.Close
'    Set RS = Nothing
'
'
'End Function




'/******************************************************************************
Public Function updateTableInBase(conn As ADODB.Connection, _
                                                strTable As String, _
                                                strField As String, _
                                                fieldValue As Variant, _
                                                Optional strWhere As String = "", _
                                                Optional whereValue As Variant = "") As Boolean
'/******************************************************************************

    
    
    On Error GoTo updateComplexData_ERR
    
    Dim recaf As Integer
    
    Dim strSQL As String
    
    Dim strFieldValue As String
    Dim strWhereValue As String
    
    
    strFieldValue = getString(fieldValue)
    
    If strWhere <> "" Then
        strWhereValue = getString(whereValue)
        strWhereValue = " WHERE " & strWhere & " = " & strWhereValue
    Else
        strWhereValue = ""
    End If
    
    strSQL = "UPDATE " & strTable & " SET " & strField & " = " & strFieldValue & strWhereValue & ";"
    
    Call conn.Execute(strSQL, recaf)
    
    If recaf > 0 Then updateTableInBase = True Else updateTableInBase = False
    
    
    Exit Function
    
updateComplexData_ERR:
    updateTableInBase = False
    

End Function



'/******************************************************************************
Public Function updateTableInBase2(conn As ADODB.Connection, _
                                    ByRef strSQL As String, _
                                    strTable As String, _
                                    strField As String, _
                                    fieldValue As Variant, _
                                    Optional strWhere As String = "", _
                                    Optional whereValue As Variant = "") As Boolean
'/******************************************************************************

    
    
    On Error GoTo updateComplexData_ERR
    
    Dim recaf As Integer
    
    strSQL = ""
    
    Dim strFieldValue As String
    Dim strWhereValue As String
    
    
    strFieldValue = getString(fieldValue)
    
    If strWhere <> "" Then
        strWhereValue = getString(whereValue)
        strWhereValue = " WHERE " & strWhere & " = " & strWhereValue
    Else
        strWhereValue = ""
    End If
    
    strSQL = "UPDATE " & strTable & " SET " & strField & " = " & strFieldValue & strWhereValue & ";"
    
    Call conn.Execute(strSQL, recaf)
    
    If recaf > 0 Then updateTableInBase2 = True Else updateTableInBase2 = False
    
    
    Exit Function
    
updateComplexData_ERR:
    updateTableInBase2 = False
    

End Function


''/******************************************************************************
'Public Sub importPart(catIDfrom As Long, partName As String, catID As Long, Optional bRein As Boolean = False)
''/******************************************************************************
'
'    On Error GoTo importPart_ERR
'
'
'    Dim part As New clsPart
'
'    part.setCat catID
'
'    If part.import(catIDfrom, partName, Not bRein) Then
'        part.setCat catID
'        part.savePart bRein, False
'        FLog.addLog "part", part.partName, "Ипорт изделия завершен", False
'    Else
'        FLog.addLog "part", part.partName, "Ипорт изделия не выполнен", True
'    End If
'
'    FLog.fgLog.ShowCell FLog.fgLog.Rows - 1, 0
'    FLog.fgLog.Refresh
'
'
'
'
'
'Exit Sub
'
'importPart_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "importPart - Error"
'
'End Sub

'/******************************************************************************
Public Function makeStringRussian(ByVal str As String) As String
'/******************************************************************************
    
    On Error GoTo makeStringRussian_ERR
    
    str = Replace(str, "A", "А", , , vbTextCompare)
    str = Replace(str, "B", "В", , , vbTextCompare)
    str = Replace(str, "C", "С", , , vbTextCompare)
    str = Replace(str, "E", "Е", , , vbTextCompare)
    str = Replace(str, "H", "Н", , , vbTextCompare)
    str = Replace(str, "K", "К", , , vbTextCompare)
    str = Replace(str, "M", "М", , , vbTextCompare)
    str = Replace(str, "O", "О", , , vbTextCompare)
    str = Replace(str, "P", "Р", , , vbTextCompare)
    str = Replace(str, "T", "Т", , , vbTextCompare)
    str = Replace(str, "X", "Х", , , vbTextCompare)
    
    makeStringRussian = str
    
    
    Exit Function
    
    
makeStringRussian_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "makeStringRussian - Error"
    
End Function

'/******************************************************************************
 Public Function getLevelByNumber(ByRef ms As Object, levnum As Long) As Boolean
'/******************************************************************************

    On Error GoTo getLevel_ERR
    
    If ms Is Nothing Then Exit Function
    
    Dim lvl As Level
    
    Set lvl = ms.ActiveModelReference.Levels.FindByNumber(levnum)
    
    getLevelByNumber = True

Exit Function

getLevel_ERR:

End Function


Public Function setLevel(ByRef el As Element, levnum As Variant, msapp As Object) As Boolean

    On Error GoTo m1
    
    If msapp Is Nothing Then Exit Function
    
    If typeName(levnum) = "Integer" Then
        If Not setLevel(el, "Level " & levnum, msapp) Then setLevel = setLevel(el, "Слой " & levnum, msapp)
    Else
        Set el.Level = msapp.ActiveDesignFile.Levels(levnum)
        setLevel = True
    End If


    Exit Function
m1:
setLevel = False

End Function



'/******************************************************************************
Public Function drawLineXY(msapp As Object, x1 As Double, y1 As Double, x2 As Double, y2 As Double, Optional lw As Long = -1) As Boolean
'/******************************************************************************

    On Error GoTo drawLine_ERR
    
    If msapp Is Nothing Then Exit Function
    
    If lw = -1 Then
        If x1 = x2 And y1 <> y2 Then ' vert
            lw = curSpecCfg.spec_v_line_wdt ' scfgCmn.spec_v_line_wdt
        ElseIf x1 <> x2 And y1 = y2 Then ' hor
            lw = curSpecCfg.spec_h_line_wdt ' scfgCmn.spec_h_line_wdt
        Else
            lw = 0
        End If
    End If
    

'    If bUseCoreLines Then
        msapp.CadInputQueue.SendMessageToApplication strReinSpec, Replace("dl" _
            & ";" & x1 _
            & ";" & y1 _
            & ";" & x2 _
            & ";" & y2 _
            & ";" & curSpecCfg.spec_h_line_clr _
            & ";" & lw _
            & ";" & 0 _
            & ";" & iLineLevel _
            & ";" & msapp.CurrentGraphicGroup, ",", ".")
'    Else
'
''        Dim p(0 To 1) As Point3d
''
''        p(0) = Point3dFromXYZ(x1, y1, 0#)
''        p(1) = Point3dFromXYZ(x2, y2, 0#)
''
''        Dim ln As LineElement
''        Set ln = CreateLineElement1(Nothing, p)
''        ln.LineWeight = lw
''        ln.Color = scfgCmn.spec_h_line_clr
''        ln.LineStyle = ActiveDesignFile.LineStyles("0")
''
''        setLevel ln, iLineLevel
''
''        ln.GraphicGroup = msapp.CurrentGraphicGroup
''        msapp.ActiveModelReference.AddElement ln
''        ln.redraw msdDrawingModeNormal
'
'    End If



    drawLineXY = True


Exit Function

drawLine_ERR:

End Function

'/******************************************************************************
Public Function drawLinePP(msapp As Object, p1 As Point3d, p2 As Point3d, lw As Long) As Boolean
'/******************************************************************************

    On Error GoTo drawLine_ERR
    
    If msapp Is Nothing Then Exit Function


'    If bUseCoreLines Then
        msapp.CadInputQueue.SendMessageToApplication strReinSpec, Replace("dl" _
            & ";" & p1.X _
            & ";" & p1.Y _
            & ";" & p2.X _
            & ";" & p2.Y _
            & ";" & curSpecCfg.spec_h_line_clr _
            & ";" & lw _
            & ";" & 0 _
            & ";" & iLineLevel _
            & ";" & msapp.CurrentGraphicGroup, ",", ".")
'    Else
'
''        Dim p(0 To 1) As Point3d
''
''        p(0) = Point3dFromXYZ(p1.X, p1.Y, p1.Z)
''        p(1) = Point3dFromXYZ(p2.X, p2.Y, p2.Z)
''
''        Dim ln As LineElement
''        Set ln = CreateLineElement1(Nothing, p)
''
''        ln.LineWeight = lw
''        ln.Color = scfgCmn.spec_h_line_clr
''        ln.LineStyle = ActiveDesignFile.LineStyles("0")
''        ln.GraphicGroup = msapp.CurrentGraphicGroup
''        msapp.ActiveModelReference.AddElement ln
''        ln.redraw msdDrawingModeNormal
'
'    End If





    drawLinePP = True

Exit Function

drawLine_ERR:

End Function

''/******************************************************************************
'Public Function drawLineP(msapp As Object, p() As Point3d, Optional lw As Long = 0) As Boolean ' NU
''/******************************************************************************
'
'    On Error GoTo drawLine_ERR
'
'
''    If bUseCoreLines Then
'        msapp.CadInputQueue.SendMessageToApplication strReinSpec, Replace("dl" _
'            & ";" & p(0).X _
'            & ";" & p(0).Y _
'            & ";" & p(1).X _
'            & ";" & p(1).Y _
'            & ";" & scfgCmn.spec_h_line_clr _
'            & ";" & lw _
'            & ";" & 0 _
'            & ";" & iLineLevel _
'            & ";" & msapp.CurrentGraphicGroup, ",", ".")
''    Else
''
'''        Dim ln As LineElement
'''        Set ln = CreateLineElement1(Nothing, p)
'''
'''        ln.LineWeight = lw
'''        ln.Color = scfgCmn.spec_h_line_clr
'''        ln.LineStyle = ActiveDesignFile.LineStyles("0")
'''        ln.GraphicGroup = msapp.CurrentGraphicGroup
'''        msapp.ActiveModelReference.AddElement ln
'''        ln.redraw msdDrawingModeNormal
''
''    End If
'
'
'
'
'    drawLineP = True
'
'Exit Function
'
'drawLine_ERR:
'    drawLineP = False
'
'End Function


'/******************************************************************************
Public Function correctPartName(strPartName As String) As String
'/******************************************************************************

    On Error GoTo correctPartName_ERR

    Dim strName As String
    
    strName = strPartName

    Dim alpE As String
    Dim alpR As String
    Dim i As Integer
    
    alpE = "ABCEHKMOPTXaceopx" ' english
    alpR = "АВСЕНКМОРТХасеорх" ' russian
    
    For i = 1 To Len(alpE)
        strName = Replace(strName, Mid(alpR, i, 1), Mid(alpE, i, 1), , , vbBinaryCompare)
    Next i
    
    strName = Replace(strName, Chr(10), "")
    strName = Replace(strName, Chr(13), "")
    
    correctPartName = Trim(strName)




Exit Function

correctPartName_ERR:
    correctPartName = strPartName


End Function


'/******************************************************************************
Public Function insertDataInBase(conn As ADODB.Connection, strTable As String, strField1 As String, iValue1 As Variant, _
                             Optional strField2 As String = "", Optional iValue2 As Variant = 0, _
                             Optional strField3 As String = "", Optional iValue3 As Variant = 0, _
                             Optional strField4 As String = "", Optional iValue4 As Variant = 0, _
                             Optional strField5 As String = "", Optional iValue5 As Variant = 0, _
                             Optional strField6 As String = "", Optional iValue6 As Variant = 0, _
                             Optional strField7 As String = "", Optional iValue7 As Variant = 0, _
                             Optional strField8 As String = "", Optional iValue8 As Variant = 0, _
                             Optional strField9 As String = "", Optional iValue9 As Variant = 0) As Long
'/******************************************************************************
    
    
    On Error GoTo insertDataInBase_ERR
    
    Dim strFields As String
    Dim strValues As String
    Dim iRecordsAffected As Long
    Dim ID As Long
    
    Dim RS As ADODB.Recordset
    
    Dim cmd As New ADODB.Command
    Set cmd.ActiveConnection = conn
    cmd.CommandType = adCmdText
    
    ' поля
    strFields = " (" & strField1
    strValues = " VALUES ("
    
    strValues = strValues & getString(iValue1)
    
    If strField2 <> "" Then
        strFields = strFields & "," & strField2
        strValues = strValues & "," & getString(iValue2)
    End If
    
    If strField3 <> "" Then
        strFields = strFields & "," & strField3
        strValues = strValues & "," & getString(iValue3)
    End If
    
    If strField4 <> "" Then
        strFields = strFields & "," & strField4
        strValues = strValues & "," & getString(iValue4)
    End If
    
    If strField5 <> "" Then
        strFields = strFields & "," & strField5
        strValues = strValues & "," & getString(iValue5)
    End If
    
    If strField6 <> "" Then
        strFields = strFields & "," & strField6
        strValues = strValues & "," & getString(iValue6)
    End If
    
    If strField7 <> "" Then
        strFields = strFields & "," & strField7
        strValues = strValues & "," & getString(iValue7)
    End If
    
    If strField8 <> "" Then
        strFields = strFields & "," & strField8
        strValues = strValues & "," & getString(iValue8)
    End If
    
    If strField9 <> "" Then
        strFields = strFields & "," & strField9
        strValues = strValues & "," & getString(iValue9)
    End If
    
    strFields = strFields & ")"
    strValues = strValues & ")"
    
    cmd.CommandText = "INSERT INTO " & strTable
    cmd.CommandText = cmd.CommandText & strFields
    cmd.CommandText = cmd.CommandText & strValues
    
    cmd.CommandText = "SET NOCOUNT ON;" & cmd.CommandText & ";SELECT SCOPE_IDENTITY() AS [IDENT];"
    
    Set RS = cmd.Execute(iRecordsAffected)
    
    If Not RS.EOF Then
        ID = RS.fields(0).Value
    End If
    
    If RS.State = adStateOpen Then RS.Close
    Set RS = Nothing
    
    
    cmd.CommandText = "SET NOCOUNT OFF"
    cmd.Execute
    
    insertDataInBase = ID
    
    Exit Function
    
insertDataInBase_ERR:
    insertDataInBase = 0
    Set RS = Nothing
    
End Function

'/******************************************************************************
Public Function getString(iValue As Variant) As String
'/******************************************************************************

    On Error GoTo getString_ERR


        If typeName(iValue) = "String" Then
            If left(iValue, 1) = "'" And right(iValue, 1) = "'" Then
                getString = Trim(iValue)
            ElseIf LCase(Trim(iValue)) = "null" Then
                getString = "null"
            Else
                getString = "'" & Trim(iValue) & "'"
            End If
        ElseIf typeName(iValue) = "Integer" Or typeName(iValue) = "Long" Or typeName(iValue) = "Double" Or typeName(iValue) = "Decimal" Then
            getString = Replace(Trim(str(iValue)), ",", ".")
        ElseIf typeName(iValue) = "Boolean" Then
            getString = str(CInt(iValue))
        ElseIf typeName(iValue) = "Null" Then
            getString = "NULL"
        Else
            getString = iValue
        End If



Exit Function

getString_ERR:
    getString = iValue
'    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getString - Error"

End Function





'/******************************************************************************
Public Function getCatMass2(catID As Long, pdID As Long, Optional mcIDtoExclude As Long = 0, Optional pdIDonly As Long = 0) As Double
'/******************************************************************************
    
        On Error GoTo getCatMass_ERR
    
    
    If catID = 0 Then Exit Function
    
    
    Dim strSQL As String
    
'    strSQL = "select sum(posCommonMass) as sm from view_position where catID = " & catID & " and isnull(mcTable,0) > 0 and deleted = 0"
    strSQL = "select sum(posCommonMass) as sm from view_position where catID = " & catID & " and deleted = 0"
    
    If pdIDonly > 0 Then
        strSQL = strSQL & " and posdefID = " & pdIDonly
    ElseIf mcIDtoExclude > 0 Then
        strSQL = strSQL & " and mcIDpd != " & mcIDtoExclude
    Else
        strSQL = strSQL & " and posdefID != " & pdID
    End If
    
    strSQL = strSQL & " group by catID"
    
    Dim RS As New ADODB.Recordset
    
    If bUseCursorClient Then RS.CursorLocation = adUseClient
    
    RS.Open strSQL, cn_data, adOpenStatic, adLockReadOnly
    
    If Not RS.EOF Then
        
        RS.MoveFirst
        
        getCatMass2 = RS.fields("sm").Value
        
    End If
    
    RS.Close
    Set RS = Nothing
    
    Exit Function
    
getCatMass_ERR:
    getCatMass2 = 0#
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getCatMass2 - Error"
    
End Function

' не катит
Public Function addColItem(Col As Collection, Item As IUnknown, Optional KEY As String = "")
    On Error GoTo err
    
    If Len(KEY) = 0 Then
        Col.Add Item
    Else
        Col.Add Item, KEY
    End If
    
err:
End Function

Public Function addColObj(ByRef Col As Collection, ByRef o As clsObj, Optional KEY As String = "", Optional bSetNothing As Boolean = False)
    On Error GoTo err
    
    If Len(KEY) = 0 Then
        Col.Add o
    Else
        Col.Add o, KEY
    End If
    
    If bSetNothing Then Set o = Nothing
    
err:
End Function



Public Function getColItem(Col As Collection, strKey As String) As IUnknown

On Error GoTo err

    Set getColItem = Col(strKey)

    Exit Function
err:
    Set getColItem = Nothing

End Function



Public Function getOrAddColItem(Col As Collection, strKey As String, cls As String) As IUnknown

On Error GoTo err

    Set getOrAddColItem = Col(strKey)

    Exit Function
err:

    If err.Number = 5 Then
        If cls = "clsSCfg" Then
            Dim o As New clsSCfg
            o.spcfgID = Val(strKey)
            Col.Add o, strKey
            Set o = Nothing
        Else
            Dim oo As New clsObj
            Col.Add oo, strKey
            Set oo = Nothing
        End If
        
    Else
    
        Set getOrAddColItem = Nothing
        
        Exit Function
    
    End If

    Set getOrAddColItem = Col(strKey)

End Function



'/******************************************************************************
Public Function getTrans(strKey As String, Optional strDelim As String = vbNewLine, Optional iTransType As Integer = 1) As String
'/******************************************************************************
    
    On Error GoTo getTrans_ERR
    
    
    If iTransType = 0 Then ' no translation
        getTrans = strKey
    ElseIf iTransType = 1 Then
        getTrans = strKey & strDelim & trans(strKey)
    ElseIf iTransType = 2 Then
        getTrans = trans(strKey)
    Else
        getTrans = strDelim & trans(strKey)
    End If
    
    
    Exit Function
    
getTrans_ERR:

    If iTransType = 0 Then
        getTrans = strKey
    ElseIf iTransType = 1 Then
        getTrans = strKey
    ElseIf iTransType = 2 Then
        getTrans = strKey
    Else
        getTrans = strDelim & strKey
    End If
    
    
    
End Function



'/******************************************************************************
Private Function addTrans(strItem As String, strKey As String) As Boolean
'/******************************************************************************

    On Error GoTo addTrans_ERR
    
    trans.Add strItem, strKey

Exit Function

addTrans_ERR:

End Function


'/******************************************************************************
Public Function getFieldBoolValue(ByRef RS As ADODB.Recordset, strFieldName As String, bDefault As Boolean) As Boolean
'/******************************************************************************

    On Error GoTo getFieldBoolValue_ERR
    
    getFieldBoolValue = CBool(RS.fields(strFieldName))
    

Exit Function

getFieldBoolValue_ERR:
    getFieldBoolValue = bDefault

End Function


'/******************************************************************************
Public Function getFieldStringValue(ByRef RS As ADODB.Recordset, strFieldName As String, sDefault As String) As String
'/******************************************************************************

    On Error GoTo getFieldStringValue_ERR
    
    getFieldStringValue = RS.fields(strFieldName) & ""

Exit Function

getFieldStringValue_ERR:
    getFieldStringValue = sDefault

End Function


'/******************************************************************************
Public Function getFieldLongValue(ByRef RS As ADODB.Recordset, strFieldName As String, iDefault As Long) As Long
'/******************************************************************************

    On Error GoTo getFieldLongValue_ERR

    getFieldLongValue = CLng(Val(RS.fields(strFieldName) & ""))

Exit Function

getFieldLongValue_ERR:
    getFieldLongValue = iDefault

End Function

Public Function getFieldDoubleValue(ByRef RS As ADODB.Recordset, strFieldName As String, dDefault As Double) As Double

    getFieldDoubleValue = getDbl(RS.fields(strFieldName) & "")

Exit Function

getFieldLongValue_ERR:
    getFieldDoubleValue = dDefault

End Function



'/******************************************************************************
Public Function loadBaseData(lbl As Label)
'/******************************************************************************

    On Error GoTo loadBaseData_ERR
    
    Dim RS As New ADODB.Recordset
    
    
    If Not lbl Is Nothing Then lbl.Caption = "Загрузка объектов"
    If Not lbl Is Nothing Then lbl.Refresh
    
    
    Set globTables = New Collection
    
    Dim tt As clsTable
    
    Set tt = New clsTable
    tt.sTableName = "part"
    tt.sKeyFieldName = "partID"
    tt.loadFields
    globTables.Add tt, tt.sTableName
    Set tt = Nothing
    
    Set tt = New clsTable
    tt.sTableName = "position"
    tt.sKeyFieldName = "posID"
    tt.loadFields
'    tt.createUndoTable ' ====>>> UNDO
    globTables.Add tt, tt.sTableName
    Set tt = Nothing
    
    Set tt = New clsTable
    tt.sTableName = "r_position_property"
    tt.sKeyFieldName = "relID"
    tt.loadFields
'    tt.createUndoTable ' ====>>> UNDO
    globTables.Add tt, tt.sTableName
    Set tt = Nothing
    
    Set tt = New clsTable
    tt.sTableName = "catpos"
    tt.sKeyFieldName = "posID"
    tt.loadFields
'    tt.createUndoTable ' ====>>> UNDO
    globTables.Add tt, tt.sTableName
    Set tt = Nothing
    
    Set tt = New clsTable
    tt.sTableName = "r_catpos_property"
    tt.sKeyFieldName = "relID"
    tt.loadFields
'    tt.createUndoTable ' ====>>> UNDO
    globTables.Add tt, tt.sTableName
    Set tt = Nothing
    
    Set tt = New clsTable
    tt.sTableName = "r_catalog_part"
    tt.sKeyFieldName = "relID"
    tt.loadFields
    globTables.Add tt, tt.sTableName
    Set tt = Nothing
    
    Set tt = New clsTable
    tt.sTableName = "r_catlist_part"
    tt.sKeyFieldName = "relID"
    tt.loadFields
    globTables.Add tt, tt.sTableName
    Set tt = Nothing
    
    Set tt = New clsTable
    tt.sTableName = "catlist"
    tt.sKeyFieldName = "catlistID"
    tt.loadFields
    globTables.Add tt, tt.sTableName
    Set tt = Nothing
    
    Set tt = New clsTable
    tt.sTableName = "r_part_reinpoints"
    tt.sKeyFieldName = "rpID"
    tt.loadFields
    globTables.Add tt, tt.sTableName
    Set tt = Nothing
    
    Set tt = New clsTable
    tt.sTableName = "r_part_reinsketch"
    tt.sKeyFieldName = "sketchID"
    tt.loadFields
    globTables.Add tt, tt.sTableName
    Set tt = Nothing
    

    Set globRules = New Collection
    
    RS.Open "select * from i_rule", cn_srtm, adOpenForwardOnly, adLockReadOnly
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            
            
            Dim rl As New clsRule
            
            rl.ruleID = RS.fields("ruleID").Value
            rl.objID = RS.fields("objID").Value
            rl.groupID = RS.fields("groupID").Value
            
            rl.bCreate = CBool(RS.fields("ruleCreate").Value)
            rl.bDelete = CBool(RS.fields("ruleDelete").Value)
            rl.bModify = CBool(RS.fields("ruleModify").Value)
            rl.bMove = CBool(RS.fields("ruleMove").Value)
            
            globRules.Add rl, CStr(rl.objID & "-" & rl.groupID)
            
            Set rl = Nothing
            
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    
    RS.NextRecordset
    
    
    Set objs = New Collection
    Set globObjs = New Collection
    
    RS.Open "select * from object", cn_srtm, adOpenForwardOnly, adLockReadOnly
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            
            Dim objID As Long
            objID = RS.fields("objID").Value
            objs.Add objID, Trim(RS.fields("objName").Value & "")
            
            Dim obj As New clsObj
            obj.objID = objID
            obj.objname = Trim(RS.fields("objName").Value & "")
            obj.objDescr = Trim(RS.fields("objDescription").Value & "")
            
            obj.itable = Trim(RS.fields("itable").Value & "")
            obj.ctable = Trim(RS.fields("ctable").Value & "")
            obj.idName = Trim(RS.fields("idName").Value & "")
            
            globObjs.Add obj, CStr(objID)
            
            Set obj = Nothing
            
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    
    RS.NextRecordset
    
    Set globLaps = New Offtmisc.colArmLap

    RS.Open "select * from rein_laps", cn_srtm, adOpenForwardOnly, adLockReadOnly
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            
            Dim lap As New Offtmisc.clsArmLap
            
            If lap.loadLap(Nothing, RS) Then
                globLaps.addLap lap
            End If
            
            Set lap = Nothing
            
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    
    RS.NextRecordset


    RS.Open "select * from cattype", cn_srtm, adOpenForwardOnly, adLockReadOnly
    If Not RS.EOF Then
        RS.MoveFirst
        Do
        
            If RS.fields("treeNodeNum").Value = "catalog" Then
                cattypes(RS.fields("catTypeID").Value).ctEnum = ctEmb
                cattypes(RS.fields("catTypeID").Value).ctName = RS.fields("catTypeName").Value
                cattypes(RS.fields("catTypeID").Value).partdefID = RS.fields("partdefID").Value
                cattypes(RS.fields("catTypeID").Value).tnNum = "catalog"
                lngCurDefaultPartdefID = RS.fields("partdefID").Value
            ElseIf RS.fields("treeNodeNum").Value = "reincat" Then
                cattypes(RS.fields("catTypeID").Value).ctEnum = ctRein
                cattypes(RS.fields("catTypeID").Value).ctName = RS.fields("catTypeName").Value
                cattypes(RS.fields("catTypeID").Value).partdefID = RS.fields("partdefID").Value
                cattypes(RS.fields("catTypeID").Value).tnNum = "reincat"
                lngCurDefReinPartdefID = RS.fields("partdefID").Value
            Else
            End If
        
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    
    RS.NextRecordset

    Set globCatDefs = New Collection
    
    Dim cd As New clsCatDef
    cd.cdName = "Не определено"
    globCatDefs.Add cd, CStr("0")
    Set cd = Nothing

    RS.Open "select * from catdef", cn_srtm, adOpenForwardOnly, adLockReadOnly
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            Set cd = New clsCatDef
            
            cd.cdID = RS.fields("catdefID").Value
            cd.cdName = RS.fields("catdefName").Value
            cd.bIsDocSet = RS.fields("isDocSet").Value
            cd.iUpLevel = RS.fields("upLevel").Value
            cd.partdefID = RS.fields("partdefID").Value
            cd.speedKey = RS.fields("speedKey").Value & ""
            cd.simKey = RS.fields("simKey").Value & ""
            
            globCatDefs.Add cd, CStr(cd.cdID)
            
            Set cd = Nothing
        
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    
    RS.NextRecordset
    
    
    Set globUserSpecs = New Collection
    
    Dim uspec As New clsUserSpec
    uspec.uspecName = "Не определено"
    globUserSpecs.Add uspec, CStr("0")
    Set uspec = Nothing

    RS.Open "select * from specialty", cn_srtm, adOpenForwardOnly, adLockReadOnly
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            Set uspec = New clsUserSpec
            
            uspec.uspecID = RS.fields("specID").Value
            uspec.uspecName = RS.fields("specName").Value
            uspec.num1 = RS.fields("num1").Value & ""
            uspec.num2 = RS.fields("num2").Value & ""
            uspec.num3 = RS.fields("num3").Value & ""
            
            globUserSpecs.Add uspec, CStr(uspec.uspecID)
            
            Set uspec = Nothing
        
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    
    RS.NextRecordset
    
    Set globPartDefs = New colPartDef
    
    RS.Open "select * from partdef", cn_srtm, adOpenForwardOnly, adLockReadOnly
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            
            Dim pd As New clsPartDef
            
            If pd.loadPartDef(0, RS) Then
                globPartDefs.AddPartDef pd, CStr(pd.partdefID)
            End If
            
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    
    RS.NextRecordset
    
    Set globPartTypes = New colPartType
    
    RS.Open "select * from parttype order by sortID", cn_srtm, adOpenForwardOnly, adLockReadOnly
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            
            Dim pt As New clsPartType
            
            If pt.loadPartType(0, RS) Then
                globPartTypes.AddPartType pt, CStr(pt.ptID)
            End If
            
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    
    RS.NextRecordset
    
    
    RS.Open "select * from docsettype", cn_srtm, adOpenForwardOnly, adLockReadOnly
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            
            Dim dst As docsetType
            dst.dstID = RS.fields("dstID").Value
            dst.dstName = RS.fields("dstName").Value & ""
            
            docsettypes(dst.dstID) = dst
            
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    
    RS.NextRecordset
    
    
    RS.Open "select * from propertylist", cn_srtm, adOpenStatic, adLockReadOnly
    
    ReDim prplisttypes(0 To RS.RecordCount)
    
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            
            Dim pl As prplistType
            pl.plID = RS.fields("plID").Value
            pl.prpID = RS.fields("propID").Value
            pl.plValue = RS.fields("plValue").Value & ""
            
            prplisttypes(RS.AbsolutePosition) = pl
            
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    
'    Dim p As New clsPrp
'    p.propvalName = "secid"
'    p.setValue 1, 2 ' add, id
'    p.setValue 1, 7
'    p.setValue 1, 7
'
'    Debug.Print p.PVAL
'
'    p.setValue 0, 2 ' remove, id
'    p.setValue 0, 7
'    p.setValue 0, 7
    
    
    RS.NextRecordset
    
    Set globPDSets = New Collection
    
    RS.Open "select * from pdset", cn_srtm, adOpenForwardOnly, adLockReadOnly
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            
            Dim pds As New clsPDSet
            pds.pdID = RS.fields("pdsID").Value
            pds.pdsNameAlt = RS.fields("pdsName").Value & ""
            pds.relID = RS.fields("partdefID").Value
            pds.iMassRoundNumDigits = getFieldLongValue(RS, "massRoundNumDigits", 0)
            
            globPDSets.Add pds, CStr(pds.pdID)
            
            Set pds = Nothing
            
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    
    
    RS.NextRecordset
    
    Set trans = New Collection
    
    RS.Open "select * from dictionary", cn_srtm, adOpenForwardOnly, adLockReadOnly
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            addTrans RS.fields("dicEng").Value, RS.fields("dicRus").Value
            
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    
    
    RS.NextRecordset
    
    Dim scfg As clsSCfg
    Dim scfgtmp As clsSCfg
    'Set scfgs = New Collection
    
    RS.Open "select * from spec_config", cn_srtm, adOpenForwardOnly, adLockReadOnly
    If Not RS.EOF Then
        RS.MoveFirst
        Do
        
            Set scfg = getOrAddColItem(scfgs, CStr(RS.fields("scID").Value), "clsSCfg") ' New clsSCfg
        
            scfg.spcfgID = RS.fields("scID").Value
            scfg.spcfgName = RS.fields("scName").Value
            scfg.spcfgListName = RS.fields("scListName").Value
            scfg.spcfgCapCell = RS.fields("scCapCell").Value
            scfg.spcfgUseDots = RS.fields("useDots").Value
            scfg.spcfgHeadHeight = RS.fields("headHeight").Value
            scfg.spcfgColWidths = RS.fields("colWidths").Value
            If Not IsNull(RS.fields("rowHeights").Value) Then scfg.spcfgRowHeights = RS.fields("rowHeights").Value
            
            scfg.sRunMetOver = RS.fields("scRunMet").Value & ""
            
            If RS.fields("useTranslation").Value Then
                scfg.iTrans = 1
                
                If right(scfg.spcfgName, 4) = "_eng" Then
                    scfg.iTrans = 2 ' only english text
                End If
                
            Else
                scfg.iTrans = 0
            End If
            
            scfg.dTextScale = RS.fields("txtScale").Value
            scfg.dTextHgt = RS.fields("txtHeight").Value
            scfg.dTextWdt = RS.fields("txtWidth").Value
            scfg.iTextFont = getFieldLongValue(RS, "txtFont", 226)
            
            If RS.fields("lineWgtVert").Value >= 0 Then
                scfg.spec_v_line_wdt = RS.fields("lineWgtVert").Value
            End If
            
            If RS.fields("lineWgtHor").Value >= 0 Then
                scfg.spec_h_line_wdt = RS.fields("lineWgtHor").Value
            End If
            
            scfg.bNewAC = RS.fields("useNewArmClass").Value
            scfg.bOldAC = RS.fields("useOldArmClass").Value
            scfg.bUseMatScnd = RS.fields("useMatScnd").Value
            
            scfg.bNewRowPartName = getFieldBoolValue(RS, "newRowPartName", scfg.bNewRowPartName)
            scfg.bNewRowPartDef = getFieldBoolValue(RS, "newRowPartDef", scfg.bNewRowPartDef)
            scfg.bNewRowMatStd = getFieldBoolValue(RS, "newRowMatStd", scfg.bNewRowMatStd)
            scfg.bNewRowMat = getFieldBoolValue(RS, "newRowMat", scfg.bNewRowMat)
            scfg.bPosdefIsText = getFieldBoolValue(RS, "posdefIsText", scfg.bPosdefIsText)
            scfg.bPosSignStd = getFieldBoolValue(RS, "posSignStd", scfg.bPosSignStd)

            scfg.spcfgLevVar = RS.fields("strLenVar").Value & ""
            
            scfg.offtMatMask = getFieldStringValue(RS, "offtMatMask", "")
            
            scfg.spcfg_prntID = getFieldLongValue(RS, "prntID", 0)
            
            scfg.bUnderLineHeader = blnSpecHeaderUnderLine
            Set scfgtmp = getColItem(colSpecTextOver, CStr(scfg.spcfgID))
            If Not scfgtmp Is Nothing Then
                scfg.bUnderLineHeader = scfgtmp.bUnderLineHeader
            End If
            
            'scfgs.Add scfg, CStr(scfg.spcfgID)
            
            Set scfg = Nothing
            
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    
    RS.NextRecordset
    
    iVersApp = CLng(App.Major) * 100000000 + CLng(App.Minor) * 100000 + CLng(App.Revision)
    
    RS.Open "select top 1 * from whatsnew order by wnID desc", cn_srtm, adOpenForwardOnly, adLockReadOnly
    If Not RS.EOF Then
        RS.MoveFirst
        iVersDB = getFieldLongValue(RS, "wnMajor", 2) * 100000000 + _
                getFieldLongValue(RS, "wnMinor", 1) * 100000 + _
                getFieldLongValue(RS, "wnRev", 1)
        
    Else
        iVersDB = 200000000 + 100000 + 1
    End If
    
    
    
    RS.Close
    Set RS = Nothing
    
    '================
     If bSkipLoadData Then Exit Function ' loaddata
    '================
    

    If Not lbl Is Nothing Then lbl.Caption = "Загрузка единиц измерения"
    If Not lbl Is Nothing Then lbl.Refresh

    loadMeasureUnits
    loadArmClasses
    
    If Not lbl Is Nothing Then lbl.Caption = "Загрузка стандартов"
    If Not lbl Is Nothing Then lbl.Refresh
    
    loadStandards
    
    If Not lbl Is Nothing Then lbl.Caption = "Загрузка определений позиций"
    If Not lbl Is Nothing Then lbl.Refresh
    
    loadMassCalcs
    loadPosdefs2
    
    If Not lbl Is Nothing Then lbl.Caption = "Загрузка материалов"
    If Not lbl Is Nothing Then lbl.Refresh
    
    loadMaterials
    
    If Not lbl Is Nothing Then lbl.Caption = "Загрузка свойств"
    If Not lbl Is Nothing Then lbl.Refresh
    
    loadProperties
    loadProperties2
    
    If Not lbl Is Nothing Then lbl.Caption = "Загрузка сортамента"
    If Not lbl Is Nothing Then lbl.Refresh
    
    loadPosdefStd
    loadSortament
    
    If Not lbl Is Nothing Then lbl.Caption = "Загрузка документов"
    If Not lbl Is Nothing Then lbl.Refresh
    
    loadDocSets
    
    
    
    


Exit Function

loadBaseData_ERR:
    Set RS = Nothing
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadBaseData - Error"

End Function


' This routine uses the "heap sort" algorithm to sort a VB collection.
' It returns the sorted collection.
' Author: Christian d'Heureuse (www.source-code.biz)
Public Function sortCollection(ByVal c As Collection) As Collection
    
    Dim n As Long
    n = c.Count
    
    If n = 0 Then Set sortCollection = New Collection: Exit Function
    
    ReDim Index(0 To n - 1) As Long                    ' allocate index array
    
    Dim i As Long, m As Long
    
    For i = 0 To n - 1
        Index(i) = i + 1
    Next         ' fill index array
    
    For i = n \ 2 - 1 To 0 Step -1                     ' generate ordered heap
        Heapify c, Index, i, n
    Next
    
    For m = n To 2 Step -1                             ' sort the index array
        Exchange Index, 0, m - 1                        ' move highest element to top
        Heapify c, Index, 0, m - 1
    Next
    
    Dim c2 As New Collection
    
    For i = 0 To n - 1
    
'        If typeName(c.Item(Index(i)).KEY) = "String" Then
'            c2.Add c.Item(Index(i)), c.Item(Index(i)).KEY
''        ElseIf typeName(c.Item(Index(i)).KEY) = "Integer" Or typeName(c.Item(Index(i)).KEY) = "Long" Or typeName(c.Item(Index(i)).KEY) = "Double" Then
''            c2.Add c.Item(Index(i)), CStr(c.Item(Index(i)).KEY)
'        Else
            c2.Add c.Item(Index(i)), CStr(c.Item(Index(i)).KEY)
'        End If
    
        'c2.Add c.Item(Index(i)), c.Item(Index(i)).KEY
        
    Next  ' fill output collection
    
    Set sortCollection = c2
    
End Function

Private Sub Heapify(ByVal c As Collection, Index() As Long, ByVal i1 As Long, ByVal n As Long)
    ' Heap order rule: a[i] >= a[2*i+1] and a[i] >= a[2*i+2]
    
    Dim nDiv2 As Long
    nDiv2 = n \ 2
    
    Dim i As Long: i = i1
    
    Do While i < nDiv2
        
        Dim k As Long: k = 2 * i + 1
        
        If k + 1 < n Then
            If c.Item(Index(k)).KEY < c.Item(Index(k + 1)).KEY Then k = k + 1
        End If
        
        If c.Item(Index(i)).KEY >= c.Item(Index(k)).KEY Then Exit Do
        
        Exchange Index, i, k
        
        i = k
        
    Loop
    
End Sub

Private Sub Exchange(Index() As Long, ByVal i As Long, ByVal j As Long)
    
    Dim temp As Long
    temp = Index(i)
    
    Index(i) = Index(j)
    
    Index(j) = temp
    
End Sub


'/******************************************************************************
Public Function getTagElement(ts As TagSet, elem As Element, strTElName As String) As TagElement
'/******************************************************************************

    On Error GoTo getTagElement_ERR
    
    Set getTagElement = elem.GetTag(ts, strTElName)


Exit Function

getTagElement_ERR:
    Set getTagElement = Nothing

End Function


'/******************************************************************************
Public Function getTagElementValue(ts As TagSet, elem As Element, strTElName As String) As String
'/******************************************************************************

    On Error GoTo getTagElement_ERR
    
    Dim tel As TagElement
    
    Set tel = elem.GetTag(ts, strTElName)
    
    getTagElementValue = CStr(tel.Value)


Exit Function

getTagElement_ERR:
    getTagElementValue = ""

End Function


'/******************************************************************************
Public Function getTagDef(ts As TagSet, strTDName As String) As TagDefinition
'/******************************************************************************

    On Error GoTo getTagElement_ERR
    
    Set getTagDef = ts.TagDefinitions(strTDName)


Exit Function

getTagElement_ERR:
    Set getTagDef = Nothing

End Function

'/******************************************************************************
Public Function getTagSet(desfile As DesignFile, strTSName As String) As TagSet
'/******************************************************************************

    On Error GoTo getTagSet_ERR

    Set getTagSet = desfile.TagSets(strTSName)

Exit Function

getTagSet_ERR:
    Set getTagSet = Nothing

End Function


'/******************************************************************************
Public Function getPartByName(prts As Collection, strName As String) As clsPart
'/******************************************************************************

    On Error GoTo getPartByName_ERR

    Set getPartByName = prts(strName)
    
Exit Function

getPartByName_ERR:
    Set getPartByName = Nothing
    
End Function
    
'/******************************************************************************
Public Sub setSpecConfig(scID As Long)
'/******************************************************************************

    On Error GoTo setSpecConfig_ERR

    If scID = 0 Then scID = 2 ' default
    
    Dim bFromXML As Boolean

    Dim sv As clsConfigSimView
    For Each sv In Config.SimViews
        If Not sv.MS_SpecConfig Is Nothing Then
            If sv.MS_SpecConfig.spcfgID = scID Then
                Set curSpecCfg = sv.MS_SpecConfig
                bFromXML = True
            End If
        End If
    Next

    If Not bFromXML Then Set curSpecCfg = scfgs(CStr(scID))
    
    dOfftHeadWidth = 40# * dSpecCmnScale
    dOfftGlobalSumWidth = 25# * dSpecCmnScale

    strSpecCapCellName = curSpecCfg.spcfgCapCell
    dSpecHeadHeight = curSpecCfg.spcfgHeadHeight * dSpecCmnScale
    
    If curSpecCfg.spcfgRowHeight <= 0.001 Then
        dSpecRowHeight = 8 * dSpecCmnScale
    Else
        dSpecRowHeight = curSpecCfg.spcfgRowHeight * dSpecCmnScale
    End If
    
    
    If bFromXML Then
'        arSpecCol()
'        dSpecWidth
   
    Else
        Dim ar() As String
        ar = Split(curSpecCfg.spcfgColWidths, "-")
        
        dSpecWidth = 0#
        
        Dim i As Integer
        For i = 0 To UBound(ar)
            arSpecCol(i + 1) = getDbl(ar(i)) * dSpecCmnScale
            dSpecWidth = dSpecWidth + arSpecCol(i + 1)
        Next i
        
        curSpecCfg.iColCnt = UBound(ar) + 1
        
        
        ar = Split(curSpecCfg.spcfgRowHeights, "-")
        
        
        arOfftRow(1) = Val(ar(0)) * dSpecCmnScale
        arOfftRow(2) = Val(ar(1)) * dSpecCmnScale
        arOfftRow(3) = Val(ar(2)) * dSpecCmnScale
        arOfftRow(4) = Val(ar(3)) * dSpecCmnScale
        arOfftRow(5) = Val(ar(4)) * dSpecCmnScale
        arOfftRow(6) = Val(ar(5)) * dSpecCmnScale
        
    End If
    


Exit Sub

setSpecConfig_ERR:
    Set curSpecCfg = scfgCmn ' scfgs(CStr(2))

End Sub


'/******************************************************************************
Public Sub writeToLogFile(strWhat As String, Optional bNew As Boolean = False)
'/******************************************************************************

    On Error GoTo writeToLogFile_ERR


    Dim fn As Integer
    fn = FreeFile
    
    If bNew Then
        Open App.path & "\log.txt" For Output As fn
    Else
        Open App.path & "\log.txt" For Append As fn
    End If
    
    Print #fn, strWhat
    
    Close fn

Exit Sub

writeToLogFile_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "writeToLogFile - Error"

End Sub


Public Function getSepText(sText As String, dval As Double) As String

    Dim str As String
    
    str = sText

    If Len(sText) > 0 Then str = str & "!"

    If dval = 0# Then str = str & "-" Else str = str & Format(dval, "0.0")
    
    getSepText = str

End Function

'/******************************************************************************
Public Function isWiseNodeExpanded(strKey As String) As Boolean
'/******************************************************************************

    On Error GoTo isWiseNodeExpanded_ERR

    isWiseNodeExpanded = colWiseTreeSet(strKey)

Exit Function

isWiseNodeExpanded_ERR:
    isWiseNodeExpanded = False

End Function

'/******************************************************************************
Public Function isCatNodeExpanded(strKey As String) As Boolean
'/******************************************************************************

    On Error GoTo isNodeExpanded_ERR
    
    isCatNodeExpanded = colCatTreeSet(strKey)

Exit Function

isNodeExpanded_ERR:
    isCatNodeExpanded = False

End Function


'/******************************************************************************
Public Sub getWiseTreeSettings()
'/******************************************************************************

    On Error GoTo getWiseTreeSettings_ERR

    Dim str As String
    
    Set colWiseTreeSet = New Collection
    
    str = GetSetting("Offtake2", "WiseTree2", "all", "")
    
    If Len(str) = 0 Then Exit Sub
    
    Dim ar() As String
    Dim ar2() As String
    
    ar = Split(str, "|")
    
    Dim i As Long
    
    For i = 0 To UBound(ar)
    
        ar2 = Split(ar(i), ":")
        
        colWiseTreeSet.Add CBool(ar2(1)), ar2(0)
    
    Next i



Exit Sub

getWiseTreeSettings_ERR:

End Sub


'/******************************************************************************
Public Sub getCatTreeSettings()
'/******************************************************************************

    On Error GoTo getCatTreeSettings_ERR
    
    Dim str As String
    
    Set colCatTreeSet = New Collection
    
    str = GetSetting("Offtake2", "CatsTree2", "all", "")
    
    If Len(str) = 0 Then Exit Sub
    
    Dim ar() As String
    Dim ar2() As String
    
    ar = Split(str, "|")
    
    Dim i As Long
    
    For i = 0 To UBound(ar)
    
        ar2 = Split(ar(i), ":")
        
        colCatTreeSet.Add CBool(ar2(1)), ar2(0)
    
    Next i
    

Exit Sub

getCatTreeSettings_ERR:

End Sub



'/******************************************************************************
'Public Function getPartMass(partID As Long, pdID As Long, Optional mcIDtoExclude As Long = 0, Optional pdIDonly As Long = 0) As Double
Public Function getPartMass(partID As Long) As Double
'/******************************************************************************
    
        On Error GoTo getCatMass_ERR
    
    
    If partID = 0 Then Exit Function
    
    
    Dim strSQL As String
    
    strSQL = "select sum(posCommonMass) as sm from position where partID = " & partID
    
    strSQL = strSQL & " group by partID"
    
    Dim RS As New ADODB.Recordset
    
    If bUseCursorClient Then RS.CursorLocation = adUseClient
    
    RS.Open strSQL, cn_data, adOpenStatic, adLockReadOnly
    
    If Not RS.EOF Then
        
        RS.MoveFirst
        
        getPartMass = RS.fields("sm").Value
        
    End If
    
    RS.Close
    Set RS = Nothing
    
    Exit Function
    
getCatMass_ERR:
    getPartMass = 0#
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getPartMass - Error"
    
End Function


'/******************************************************************************
Public Sub gotick(bStart As Boolean, Optional str As String = "")
'/******************************************************************************

    On Error GoTo gotick_ERR

    Dim t As Long

    t = tics
    tics = GetTickCount

    If Not bStart Then
        Debug.Print CStr(tics - t) & " - " & str
    Else
        Debug.Print "==============================="
    End If

Exit Sub

gotick_ERR:

End Sub

Public Function FileExists(FileName As String) As Integer
       
       Dim RetCode As Integer
       Dim OpenFileStructure As OFSTRUCT
       Const OF_EXIST = &H4000
       Const FILE_NOT_FOUND = 2
       RetCode = OpenFile(FileName$, OpenFileStructure, OF_EXIST)
       
       If Len(Trim(FileName$)) = 0 Then FileExists = False: Exit Function
       
       If OpenFileStructure.nErrCode = FILE_NOT_FOUND Then
              FileExists = False
       Else
              FileExists = True
       End If

End Function


'/******************************************************************************
Public Function stringSplit(str As String) As String
'/******************************************************************************
    
    On Error GoTo stringSplit_ERR
    
    Dim i As Integer
    
    Dim sss As String
    
    Dim ar() As String
    ar = Split(str, " ")
    If UBound(ar) > 0 Then
        sss = ar(0) & vbNewLine
        For i = 1 To UBound(ar)
            sss = sss & ar(i) & " "
        Next i
    Else
        sss = str
    End If
    
    stringSplit = sss
    
    Exit Function
    
stringSplit_ERR:
    stringSplit = str
    
End Function


'/******************************************************************************
Public Function tvGetTreeNode(tv As TreeView, nkey As String) As Node
'/******************************************************************************
    
    On Error GoTo tvPartsSelectItem_ERR
    
    Set tvGetTreeNode = Nothing
    
    If tv Is Nothing Then Exit Function
    
    If Len(nkey) > 0 And tv.Nodes.Count >= 1 Then
        
        Set tvGetTreeNode = tv.Nodes(nkey)
        
    End If
    
    
    Exit Function
    
tvPartsSelectItem_ERR:

    Set tvGetTreeNode = Nothing
    
End Function


'/******************************************************************************
Public Function tvGetParentNode(tv As TreeView, nd As Node, objID As Long, objectID As Long, Optional iLev As Integer = 1) As Integer
'/******************************************************************************

    On Error GoTo err
    
    
    Dim strKey As String
    
'    Dim cmd As New ADODB.Command
'    cmd.ActiveConnection = cn_data
'    cmd.CommandType = adCmdStoredProc
'    cmd.CommandText = "getParKey"
'    cmd.Parameters.Append cmd.CreateParameter("ret", adBSTR, adParamReturnValue)
'    cmd.Parameters.Append cmd.CreateParameter("objID", adBigInt, adParamInput, , objID)
'    cmd.Parameters.Append cmd.CreateParameter("objectID", adBigInt, adParamInput, , objectID)
'    cmd.Parameters.Append cmd.CreateParameter("lev", adInteger, adParamInput, , iLev)
'    cmd.Execute
    strKey = srvGetParentKey(objID, objectID, iLev)
    
    If Len(strKey) = 0 Then Exit Function
    
    arTreeLev(iLev) = strKey
    
    
    If Len(strKey) = 0 Then
        tvGetParentNode = -1
        Exit Function
    Else
        Set nd = tvGetTreeNode(tv, strKey)
        If nd Is Nothing Then
            iLev = tvGetParentNode(tv, nd, objID, objectID, iLev + 1)
        End If
        
        tvGetParentNode = iLev
    End If
    


Exit Function

err:

End Function


'/******************************************************************************
Public Function loadPosdefs2() As Boolean
'/******************************************************************************

    On Error GoTo loadPosdefs_ERR

    Set globPosdefs = New colPD
    
    Dim RS As New ADODB.Recordset
    Dim posdefID As Long
    
    Dim strSQL As String
    
'    strSQL = "select * from posdef"
    
    
    strSQL = "SELECT "
    
'    strSQL = strSQL & conn.strSrtmName & ".dbo.posdef.* "
'    strSQL = strSQL & "," & conn.strSrtmName & ".dbo.view_r_posdef_property.* "
    strSQL = strSQL & conn.strSrtmName & ".dbo.view_r_posdef_property.* "
    strSQL = strSQL & "," & conn.strSrtmName & ".dbo.posdef.* " ' должна быть такая последовательность, иначе поля view_r_posdef_property переопределяют posdef, и pdID может стать NULL
    
    strSQL = strSQL & "FROM "
    strSQL = strSQL & conn.strSrtmName & ".dbo.posdef "
    
    strSQL = strSQL & "LEFT OUTER JOIN "
    strSQL = strSQL & conn.strSrtmName & ".dbo.view_r_posdef_property "
    strSQL = strSQL & "ON "
    strSQL = strSQL & conn.strSrtmName & ".dbo.posdef.posdefID "
    strSQL = strSQL & "= "
    strSQL = strSQL & conn.strSrtmName & ".dbo.view_r_posdef_property.posdefID "
    
    strSQL = strSQL & " order by " & conn.strSrtmName & ".dbo.posdef.posdefID"
    
    
    Dim pd As clsPD
    Dim bAdd As Boolean
    
    
    RS.Open strSQL, cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    RS.MoveFirst
    Do
    
        bAdd = False
        
'        If (RS.Fields("posdefID").Value = 12) Then
'        Debug.Print ""
'        End If
    
        If pd Is Nothing Then
            Set pd = New clsPD
            pd.loadPosdefFromRS RS
        End If
    
        pd.loadPosdefPropsFromRS RS
        
        
        RS.MoveNext
        
        
        If RS.EOF Then
            bAdd = True
        Else
            If pd.pdID <> RS.fields("posdefID").Value Then bAdd = True
        End If
        
        If bAdd Then
        
            pd.loadPDSets
        
            globPosdefs.AddPosdef pd, CStr(pd.pdID)
            Set pd = Nothing
        End If
        
    Loop Until RS.EOF
    
    
    loadPosdefs2 = True

Exit Function

loadPosdefs_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "loadPosdefs2 - Error"

End Function


'/******************************************************************************
Public Function srvGetParentKey(objID As Long, objectID As Long, Optional iLev As Integer = 1) As String
'/******************************************************************************

    On Error GoTo srvGetParentKey_ERR

    Dim cmd As New ADODB.Command
    cmd.ActiveConnection = cn_data
    cmd.CommandType = adCmdStoredProc
    cmd.CommandText = "getParKey"
    cmd.Parameters.Append cmd.CreateParameter("ret", adBSTR, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("objID", adBigInt, adParamInput, , objID)
    cmd.Parameters.Append cmd.CreateParameter("objectID", adBigInt, adParamInput, , objectID)
    cmd.Parameters.Append cmd.CreateParameter("lev", adInteger, adParamInput, , iLev)
    cmd.Execute
    srvGetParentKey = cmd.Parameters("ret") & ""

Exit Function

srvGetParentKey_ERR:
    srvGetParentKey = ""
    
    If bMainFormLoaded Then F1.SB.Panels("status").text = "srvGetParentKey" & "() - " & err.Description

End Function

'/******************************************************************************
Public Function srvIsCatBlocked(catID As Long, usrID As Long) As Boolean
'/******************************************************************************

    On Error GoTo srvIsCatBlocked_ERR


    Dim cmd As New ADODB.Command
    cmd.ActiveConnection = cn_data
    cmd.CommandType = adCmdStoredProc
    cmd.CommandText = "isCatBlocked"
    cmd.Parameters.Append cmd.CreateParameter("ret", adBSTR, adParamReturnValue)
    cmd.Parameters.Append cmd.CreateParameter("catID", adBigInt, adParamInput, , catID)
    cmd.Parameters.Append cmd.CreateParameter("usrID", adBigInt, adParamInput, , usrID)
    cmd.Execute
    srvIsCatBlocked = CBool(cmd.Parameters("ret"))


Exit Function

srvIsCatBlocked_ERR:
    If bMainFormLoaded Then F1.SB.Panels("status").text = "srvIsCatBlocked" & "() - " & err.Description

End Function


'/******************************************************************************
Public Function getLevSign(iLev As Integer, Optional sNoDef As String = "-") As String
'/******************************************************************************

    On Error GoTo getLevSign_ERR
    
    If iLev = 0 Then
        getLevSign = sNoDef
    ElseIf iLev = 1 Then
        getLevSign = "Надземная часть"
    ElseIf iLev = -1 Then
        getLevSign = "Подземная часть"
    ElseIf iLev = 2 Then ' для выпадающих списков
        getLevSign = "Подземная часть"
    Else
        getLevSign = "getLevSign error"
    End If

Exit Function

getLevSign_ERR:
    getLevSign = "getLevSign error"

End Function


Public Function getTaskFiles(ByRef arExcelFiles() As String, f As frmBeton) As Integer ' count

On Error GoTo m1


'Public Enum OFN_FLAGS
'    OFN_READONLY = &H1
'    OFN_OVERWRITEPROMPT = &H2
'    OFN_HIDEREADONLY = &H4
'    OFN_NOCHANGEDIR = &H8
'    OFN_SHOWHELP = &H10
'    OFN_ENABLEHOOK = &H20
'    OFN_ENABLETEMPLATE = &H40
'    OFN_ENABLETEMPLATEHANDLE = &H80
'    OFN_NOVALIDATE = &H100
'    OFN_ALLOWMULTISELECT = &H200
'    OFN_EXTENSIONDIFFERENT = &H400
'    OFN_PATHMUSTEXIST = &H800
'    OFN_FILEMUSTEXIST = &H1000
'    OFN_CREATEPROMPT = &H2000
'    OFN_SHAREAWARE = &H4000
'    OFN_NOREADONLYRETURN = &H8000
'    OFN_NOTESTFILECREATE = &H10000
'    OFN_NONETWORKBUTTON = &H20000
'    OFN_NOLONGNAMES = &H40000
'    OFN_EXPLORER = &H80000
'    OFN_NODEREFERENCELINKS = &H100000
'    OFN_LONGNAMES = &H200000
'End Enum


    Dim OFN As OPENFILENAME
    OFN.lStructSize = Len(OFN)
    OFN.hWndOwner = f.hwnd
    OFN.lpstrFilter = "CSV Files (*.csv)" + Chr$(0) + "*.csv" + Chr$(0) + "All Files (*.*)" + Chr$(0) + "*.*" + Chr$(0)
    OFN.lpstrFile = Space$(2054)
    OFN.nMaxFile = 2055
    OFN.lpstrFileTitle = Space$(2054)
    OFN.nMaxFileTitle = 2055
    OFN.lpstrInitialDir = GetSetting("Offtake2", "Size", "BetonReport", CurDir)
    OFN.lpstrTitle = "Открываем файлы отчета"
    OFN.flags = OFN_EXPLORER Or OFN_ALLOWMULTISELECT
    Dim a As Long
    
    a = GetOpenFileName(OFN)
        
    
    
    Dim strPath As String
    
        
        
    If a > 0 Then
        arExcelFiles = Split(OFN.lpstrFile, Chr(0), , vbBinaryCompare)
        
        strPath = arExcelFiles(0)
        
        Dim i As Integer
        For i = 0 To UBound(arExcelFiles)
            If Len(Trim(arExcelFiles(i))) = 0 Then
                
                ReDim Preserve arExcelFiles(i - 1)
                Exit For
            
            
            End If
        
        Next i
        
        If UBound(arExcelFiles) = 0 Then ' one file selected
            getTaskFiles = -1
            Dim artmp() As String
            artmp = Split(arExcelFiles(0), "\")
            SaveSetting "Offtake2", "Size", "BetonReport", _
                        left(arExcelFiles(0), Len(arExcelFiles(0)) - 1 - Len(artmp(UBound(artmp))))
        Else
            getTaskFiles = i - 1
            SaveSetting "Offtake2", "Size", "BetonReport", strPath
        End If
        
    Else
        getTaskFiles = 0
    End If
    

Exit Function

m1:
    getTaskFiles = 0
    MsgBox err.Description, vbCritical, err.Number

End Function


Private Function getUsrDescr() As Boolean

    On Error GoTo err
    Dim oRoot As IADs
'    Dim oDomain As IADs
    Dim sDomain As String
    Dim usr As IADsUser
    Dim str As String
    Dim ar() As String
    
    If Environ("AEP_SAVRD_SERVER") <> strCurServer Then Exit Function ' чтобы дома не ломился определять данные пользователя в домене
    
    Set oRoot = GetObject("LDAP://rootDSE")
    
    sDomain = oRoot.get("defaultNamingContext")
    
'    Set oDomain = GetObject("LDAP://" & sDomain)
    
    ' Bind to a user object.
    Set usr = GetObject("LDAP://CN=" & usrCurrent.strLogin & ",CN=users," & sDomain)
    
    
    
    
    str = usr.Description
    
    If Len(str) > 0 Then
    
        ar = Split(str, " ")
        
        If UBound(ar) = 2 Then
            usrCurrent.strFIO(1) = ar(0)
            usrCurrent.strFIO(2) = ar(1)
            usrCurrent.strFIO(3) = ar(2)
        
            getUsrDescr = True
        End If
    
    
    End If
    
    
    
    Exit Function
err:
    

End Function


Public Function getMS() As Object

On Error GoTo err

    Dim msapp As Object
        
    Set msapp = GetObject(, "MicroStationDGN.Application")
    
    If msapp Is Nothing Then
        sCommonMessage = "Не получить доступ к приложению MicroStation, возможно оно не запущено"
        Set getMS = Nothing
        Exit Function
    ElseIf Not msapp.HasActiveDesignFile Then
        sCommonMessage = "Не получить доступ к приложению MicroStation, перезапуститте его"
        msapp.Quit
        Set getMS = Nothing
        Exit Function
    End If
    
    Set getMS = msapp
    
    Exit Function

err:
    sCommonMessage = "Не запустить MicroStation, ошибка: " & err.Description

    Set getMS = Nothing


End Function


Public Function rebuildString(str As String, ByRef arstr() As String, Optional iMaxLen As Integer = 55)

    On Error GoTo err
    
    Dim ar() As String
    Dim i As Integer
    ReDim arstr(0)
    
    ar = Split(str, " ")
    
    If UBound(ar) < 1 Then GoTo err
    
    
    Dim iCop As Integer
    Dim iInd As Integer
    Dim strCop As String
    
    For i = 0 To UBound(ar)
    
        If iCop = 0 Then
            iCop = Len(ar(i)) ' probel
        Else
            iCop = iCop + 1 + Len(ar(i))
        End If
        
        If iCop > iMaxLen Then
            ReDim Preserve arstr(iInd)
            arstr(iInd) = strCop
            iInd = iInd + 1
            iCop = 0
            strCop = ""
        Else
        End If
        
        If Len(strCop) = 0 Then
            strCop = ar(i)
        Else
            strCop = strCop & " " & ar(i)
        End If
    
    Next i
    
    
    If iCop > 0 Then
        ReDim Preserve arstr(iInd)
        arstr(iInd) = strCop
    End If
    
    
    
    
    Exit Function
err:
    ReDim arstr(0)
    arstr(0) = str
    
End Function


'/******************************************************************************
Public Function getAncKoefByLen(lng_plate_length_mm As Long, lng_space_mm As Long, lng_gap_mm As Long) As Double
'/******************************************************************************

    On Error GoTo getAncKoefByLen_ERR
    
    Dim a As Double
    Dim b As Double
    
    a = getAncQtyByLen(lng_plate_length_mm, lng_space_mm, lng_gap_mm)
    b = getAncQtyByLen(1000, lng_space_mm, lng_gap_mm)
    
    getAncKoefByLen = a / b


Exit Function

getAncKoefByLen_ERR:
    getAncKoefByLen = 1#

End Function


'/******************************************************************************
Public Function getAncQtyByLen(lng_plate_length_mm As Long, lng_space_mm As Long, lng_gap_mm As Long) As Integer
'/******************************************************************************

    On Error GoTo getAncQtyByLen_ERR
    
    Dim lng_len As Long
    Dim lng_qty As Long
    
    lng_qty = 1 ' один ряд по идее есть всегда
    
    
    lng_len = lng_plate_length_mm - lng_gap_mm * 2
    
    If lng_len > 0 Then lng_qty = lng_qty + 1 ' уже два ряда
    
    While (lng_len > lng_space_mm)
        lng_len = lng_len - lng_space_mm
        lng_qty = lng_qty + 1
    
    
    Wend
    
    getAncQtyByLen = lng_qty
    

Exit Function

getAncQtyByLen_ERR:
    getAncQtyByLen = 0

End Function
