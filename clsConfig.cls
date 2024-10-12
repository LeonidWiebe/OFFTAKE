VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsConfig"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Wrksp As New Collection
Public SimViews As New Collection
Public SysVariables As New Dictionary
Public TempViewTabs As New Collection

Public fgTabViews As New Dictionary
Public fgTabs As New Dictionary

Private path As String
Private lmDate As Date

Public LastTabIndex As Integer
Public LastNodeKey As String

Public Nodes As Dictionary

Private fso As FileSystemObject

Public errMessage As String

'Конструктор
'/******************************************************************************
Private Sub Class_Initialize()
'/******************************************************************************
On Error GoTo Class_Initialize_ERR

    Set fso = New FileSystemObject
    
    path = ReadPath(strCurSimConfig)
        
    If fso.FileExists(path) Then
        Call UpdateConfig
    Else: MsgBox "Не найден конфигурационный файл, некоторые функции будут не доступны", vbOKOnly + vbExclamation
    End If
    
Exit Sub

Class_Initialize_ERR:
    errMessage = "Class_Initialize" & "() - " & err.Description
End Sub


'/******************************************************************************
Private Sub ReadData()
'/******************************************************************************
On Error GoTo ReadData_ERR
    
    Dim i As Integer
    Set SimViews = New Collection
    Set SysVariables = New Dictionary
    Set TempViewTabs = New Collection
    
    Dim oXMLDoc As MSXML2.DOMDocument
    Dim oNode As MSXML2.IXMLDOMElement
    Dim oChildNode As MSXML2.IXMLDOMElement
    Dim oChildNode2 As MSXML2.IXMLDOMElement
    Dim oChildNode3 As MSXML2.IXMLDOMElement
    Dim oChildNode4 As MSXML2.IXMLDOMElement
    Dim oChildNode5 As MSXML2.IXMLDOMElement
    Dim SysVar As String
    
    Set oXMLDoc = New MSXML2.DOMDocument
    Call oXMLDoc.Load(path) 'чтение файла конфигурации
    

    'Читаем набор системных переменных окружения:
'    Set oNode = oXMLDoc.documentElement.getElementsByTagName("SysVariables")(0)
'    For Each oChildNode In oNode.getElementsByTagName("Item")
'        With oChildNode
'            SysVar = Environ$(.getAttribute("Name"))
'            If Len(SysVar) > 0 Then
'                Call SysVariables.Add(.getAttribute("Name"), SysVar)
'            Else:  Call SysVariables.Add(.getAttribute("Name"), .getAttribute("Default"))
'            End If
'        End With
'    Next
    
'    Set oNode = oXMLDoc.documentElement.getElementsByTagName("Navisworks")(0)
'    If Not oNode Is Nothing Then
'        If Not oNode.getAttributeNode("path") Is Nothing Then strNavisPath = oNode.getAttribute("path") _
'            Else strNavisPath = "//10.24.2.5/ftp$/"
'        If Not oNode.getAttributeNode("localpath") Is Nothing Then strNavisLocPath = oNode.getAttribute("localpath") _
'            Else strNavisLocPath = "c:/Offtake/nwd/"
'        If Not oNode.getAttributeNode("ftpserver") Is Nothing Then strNavisFTPserv = oNode.getAttribute("ftpserver") _
'            Else strNavisFTPserv = "10.24.2.5"
'        If Not oNode.getAttributeNode("ftpport") Is Nothing Then strNavisFTPport = oNode.getAttribute("ftpport") _
'            Else strNavisFTPport = "21"
'        If Not oNode.getAttributeNode("ftpuser") Is Nothing Then strNavisFTPuser = oNode.getAttribute("ftpuser") _
'            Else strNavisFTPuser = "anonymous"
'        If Not oNode.getAttributeNode("ftppass") Is Nothing Then strNavisFTPpass = oNode.getAttribute("ftppass") _
'            Else strNavisFTPpass = "anonymous"
'        If Not oNode.getAttributeNode("ftpblddir") Is Nothing Then strNavisFTPbld = oNode.getAttribute("ftpblddir") _
'            Else strNavisFTPbld = "Navisworks"
'        If Not oNode.getAttributeNode("ftptechdir") Is Nothing Then strNavisFTPtech = oNode.getAttribute("ftptechdir") _
'            Else strNavisFTPtech = "NavisworksFull"
'    End If

    Dim X As colAts
    Dim locID As Long
    Dim o As clsSCfg


    Dim bForce As Boolean

    Set oNode = oXMLDoc.documentElement.getElementsByTagName("Workspace")(0)
    
    'Set oNode = oXMLDoc.selectSingleNode("//Tab[@name='Rein']") ' RAHMAT
    'Set oNode = oXMLDoc.selectSingleNode("//Tab[@name='Wise']/Connect/Filters/Standard") ' RAHMAT
    'Set oNode = oXMLDoc.selectSingleNode("//Tab")
    
    speccfg.readXmlNodeByPath oXMLDoc, "Settings/Workspace/Specification"
    
    offtcfg.readXmlNodeByPath oXMLDoc, "Settings/Workspace/Offtake"
    
    listcfg.readXmlNodeByPath oXMLDoc, "Settings/Workspace/List"
    
    reincfg.readXmlNodeByPath oXMLDoc, "Settings/Workspace/Reinforcement/Round"
    
    intfcfg.readXmlNodeByPath oXMLDoc, "Settings/Workspace/Interface/Common"
    
    'Dim p As New clsPart
    'Call p.genSortNumber("MD-25-25", 91)
    
    ' ===== interface settings =====
    
    If Len(intfcfg("Grids").attval("redraw")) > 0 Then
        bFormGridsRedraw = CBool(intfcfg("Grids").attval("redraw"))
    Else
        bFormGridsRedraw = False
    End If
    
    If Len(intfcfg("Grids").attval("icons")) > 0 Then
        bFormGridsIcons = CBool(intfcfg("Grids").attval("icons"))
    Else
        bFormGridsIcons = GetSetting("Offtake2", "Size", "mnuPrefShowGridIcons.Checked", True)
    End If
    
    If Len(intfcfg("Tabs").attval("hide")) > 0 Then
        bFormTabsHide = CBool(intfcfg("Tabs").attval("hide"))
    Else
        bFormTabsHide = True
    End If
    
    ' ===== offtake settings =====
    
    If Len(offtcfg("Function" & 1).attval("name")) > 0 Then
        strFuncNameOfftake1 = offtcfg("Function" & 1).attval("name")
    End If
    
    If Len(offtcfg("Function" & 2).attval("name")) > 0 Then
        strFuncNameOfftake2 = offtcfg("Function" & 2).attval("name")
    End If
    
    'Debug.Print offtcfg("Function" & 2)("Section2").attval("id")
    
    ' ===== specification settings =====
    
    If Len(speccfg("Lines")("vertical").attval("width")) > 0 Then scfgCmn.spec_v_line_wdt = Val(speccfg("Lines")("vertical").attval("width"))
    If Len(speccfg("Lines")("vertical").attval("color")) > 0 Then scfgCmn.spec_v_line_clr = Val(speccfg("Lines")("vertical").attval("color"))
    If Len(speccfg("Lines")("horizontal").attval("width")) > 0 Then scfgCmn.spec_h_line_wdt = Val(speccfg("Lines")("horizontal").attval("width"))
    If Len(speccfg("Lines")("horizontal").attval("color")) > 0 Then scfgCmn.spec_h_line_clr = Val(speccfg("Lines")("horizontal").attval("color"))
    
    If Len(speccfg("Text").attval("color")) > 0 Then scfgCmn.spec_text_clr = Val(speccfg("Text").attval("color"))
    
    If Len(speccfg("Text")("Diameter").attval("value")) > 0 Then scfgCmn.spec_text_diam = speccfg("Text")("Diameter").attval("value")
    
    If Len(speccfg("Text")("Skip").attval("value")) > 0 Then scfgCmn.spec_skip_bar = speccfg("Text")("Skip").attval("value")
    
    If Len(speccfg("Scale").attval("value")) > 0 Then scfgCmn.spec_table_scale = speccfg("Scale").attval("value")
    
    
    
    If Len(speccfg("Excel").attval("template")) > 0 Then scfgCmn.spec_xls_template = speccfg("Excel").attval("template")
    
    If Len(speccfg("Excel")("Rows").attval("start")) > 0 Then scfgCmn.spec_xls_startrow = Val(speccfg("Excel")("Rows").attval("start"))
    If Len(speccfg("Excel")("Rows").attval("quantity")) > 0 Then scfgCmn.spec_xls_rows = Val(speccfg("Excel")("Rows").attval("quantity"))
    If Len(speccfg("Excel")("Rows").attval("jump")) > 0 Then scfgCmn.spec_xls_jump = Val(speccfg("Excel")("Rows").attval("jump"))
    If Len(speccfg("Excel")("Columns").attval("start")) > 0 Then scfgCmn.spec_xls_startcol = Val(speccfg("Excel")("Columns").attval("start"))
    
    
    If Len(reincfg("arc").attval("shift")) > 0 Then rndGlobal.iArmArc = Val(reincfg("arc").attval("shift"))
    If Len(reincfg("arc").attval("snap")) > 0 Then rndGlobal.iArmArcSnap = Val(reincfg("arc").attval("snap"))
    If Len(reincfg("line").attval("shift")) > 0 Then rndGlobal.iArmSegm = Val(reincfg("line").attval("shift"))
    If Len(reincfg("line").attval("snap")) > 0 Then rndGlobal.iArmSegmSnap = Val(reincfg("line").attval("snap"))

                        
    
    
    For Each X In speccfg("Text")("Underline")
        If X.atname = "Default" And Len(X.attval("value")) > 0 Then
            blnSpecHeaderUnderLine = CBool(X.attval("value"))
        ElseIf left(X.atname, 7) = "spcfgid" And Len(X.attval("value")) > 0 Then ' legacy
            locID = Val(right(X.atname, Len(X.atname) - 7))
            Set o = getOrAddColItem(colSpecTextOver, CStr(locID), "clsSCfg")
            o.bUnderLineHeader = CBool(X.attval("value"))
        End If
    Next
    
    For Each X In speccfg("Part")("spec_col_cmass")
        If X.atname = "Default" And Len(X.attval("value")) > 0 Then
            scfgCmn.spec_col_cmass = Val(X.attval("value"))
        ElseIf left(X.atname, 7) = "spcfgid" And Len(X.attval("value")) > 0 Then ' legacy
            locID = Val(right(X.atname, Len(X.atname) - 7))
            Set o = getOrAddColItem(colSpecTextOver, CStr(locID), "clsSCfg")
            o.spec_col_cmass = Val(X.attval("value"))
        End If
    Next
    
    For Each X In speccfg("Part")("spec_row_numbers")
        If X.atname = "Default" And Len(X.attval("value")) > 0 Then
            scfgCmn.spec_row_numbers = Val(X.attval("value"))
        ElseIf left(X.atname, 7) = "spcfgid" And Len(X.attval("value")) > 0 Then ' legacy
            locID = Val(right(X.atname, Len(X.atname) - 7))
            Set o = getOrAddColItem(colSpecTextOver, CStr(locID), "clsSCfg")
            o.spec_row_numbers = Val(X.attval("value"))
        End If
    Next
    
    For Each X In speccfg("Part")("spec_text_dscr")
        If X.atname = "Default" And Len(X.attval("value")) > 0 Then
            scfgCmn.spec_text_dscr = X.attval("value")
        ElseIf left(X.atname, 7) = "spcfgid" And Len(X.attval("value")) > 0 Then ' legacy
            locID = Val(right(X.atname, Len(X.atname) - 7))
            Set o = getOrAddColItem(colSpecTextOver, CStr(locID), "clsSCfg")
            o.spec_text_dscr = X.attval("value")
            o.spec_text_dscr_replace_from = X.attval("replace_from")
            o.spec_text_dscr_replace_to = X.attval("replace_to")
            'Set o = Nothing
        End If
    Next
    
    For Each X In speccfg("Part")("spec_sheet_num")
        If X.atname = "Default" And Len(X.attval("format")) > 0 Then
            scfgCmn.spec_sheet_num_fmt = X.attval("format")
            scfgCmn.spec_sheet_num_pfx = X.attval("prefix")
        ElseIf left(X.atname, 7) = "spcfgid" And Len(X.attval("format")) > 0 Then ' legacy
            locID = Val(right(X.atname, Len(X.atname) - 7))
            Set o = getOrAddColItem(colSpecTextOver, CStr(locID), "clsSCfg")
            o.spec_sheet_num_fmt = X.attval("format")
            o.spec_sheet_num_pfx = X.attval("prefix")
            'Set o = Nothing
        End If
    Next
    
    
    
    
    'speccfg.readXmlNodeByPath oXMLDoc, "Settings/Workspace/Specification/Part/spec_text_name"
    Dim osp As colAts ' секция <spcfg/>
    For Each osp In speccfg("Part")("spec_text_name")
        'Set o = getColItem(scfgs, CStr(osp.objID))
        Set o = getOrAddColItem(scfgs, CStr(osp.atID), "clsSCfg")
        If Not o Is Nothing Then Set o.o_spec_text_name = osp
    Next
    
    
    
    
    
    If Not oNode Is Nothing Then
    
        Set oChildNode = oNode.getElementsByTagName(strHelpXml)(0)
        If Not oChildNode Is Nothing Then
            If Not oChildNode.getAttributeNode("path") Is Nothing Then
                strHelpPath = oChildNode.getAttribute("path")
            End If
        End If
    
        Set oChildNode = oNode.getElementsByTagName("Specification")(0)
        If Not oChildNode Is Nothing Then
            If Not oChildNode.getAttributeNode("libpath") Is Nothing Then
                strDrawingsLibraryFileName = oChildNode.getAttribute("libpath")
            End If
            
            Dim cn As MSXML2.IXMLDOMNode
            
            
            ' ======= настройки сбора модели ======
    
            If oXMLDoc.selectNodes("Settings/Workspace/Specification/Model/Formular").length > 0 Then
                For Each oChildNode2 In oXMLDoc.selectNodes("Settings/Workspace/Specification/Model/Formular")
                    
                    'intSpecFormulaQty = 3 ' default
                    'intSpecSplitterQty = 4
                    
                    Dim frml As New clsObj
                    
                    If Not oChildNode2.Attributes Is Nothing Then
                    
                        For i = 0 To oChildNode2.Attributes.length - 1
                            frml.props.AddProp oChildNode2.Attributes(i).nodeName, oChildNode2.Attributes(i).nodeValue
                        Next i
                        
                        If frml.props.existsProperty("name") Then frml.objname = frml.props("name").propValue
                        
                        'If oChildNode2.Attributes.length > 0 Then
                        '    If oChildNode2.Attributes(0).nodeName = "name" Then
                        '        frml.objname = oChildNode2.Attributes(0).nodeValue
                        '    End If
                        'End If
                    
                        'If oChildNode2.Attributes.length > 1 Then
                        '    If oChildNode2.Attributes(1).nodeName Like "params*" Then
                        '        frml.props.AddProp "intSpecFormulaQty", CInt(Val(oChildNode2.Attributes(1).nodeValue))
                        '    End If
                        'End If
                        
                        'If oChildNode2.Attributes.length > 2 Then
                        '    If oChildNode2.Attributes(2).nodeName Like "splitter*" Then
                        '        frml.props.AddProp "intSpecSplitterQty", CInt(Val(oChildNode2.Attributes(2).nodeValue))
                        '    End If
                        'End If
                        
                    End If
                    
                    For Each cn In oChildNode2.ChildNodes
                        
                        If Not cn.Attributes Is Nothing Then
                        
                            Dim frml_pos As New clsObj
                            
                            Dim strf As String
                            
                            
                            If cn.Attributes.length > 0 Then
                                If cn.Attributes(0).nodeName = "expr" Then
                                    
                                    strf = cn.Attributes(0).nodeValue
                                    frml_pos.props.AddProp "expr", strf ' strSpecFormula
                                    
                                End If
                            End If
    
    
                            If cn.Attributes.length > 1 Then
                                If cn.Attributes(1).nodeName = "criteria" Then
                                    
                                    strf = cn.Attributes(1).nodeValue
                                    frml_pos.props.AddProp "criteria", strf ' criteria for sql
                                    
                                End If
                            End If
                            
                            frml.kinder.Add frml_pos
                            
                            Set frml_pos = Nothing
                        
                        End If
                        
                    Next
                    
                    frml.KEY = frml.objname
                    
                    colFrml.Add frml, frml.objname
                    
                    Set frml = Nothing
                    
                Next
            End If
            
            
            
        End If
    
        Set oChildNode = oNode.getElementsByTagName("Interface")(0)
        If Not oChildNode Is Nothing Then
        
            If oChildNode.getElementsByTagName("Tab").length > 0 Then
            
                For Each oChildNode2 In oChildNode.getElementsByTagName("Tab")
                    
                    If Not oChildNode2.getAttributeNode("name") Is Nothing Then
                        If oChildNode2.getAttribute("name") = "Wise" Then
                        
                            If oChildNode2.getElementsByTagName("Connect").length > 0 Then
                            
                                Set pwsets = New Collection
                        
                                For Each oChildNode3 In oChildNode2.getElementsByTagName("Connect")
                                
                                    Dim pws As New clsDBCon
                                
                                    If Not oChildNode3.getAttributeNode("name") Is Nothing Then
                                        pws.text = oChildNode3.getAttribute("name")
                                    End If
                                
                                    If Not oChildNode3.getAttributeNode("server") Is Nothing Then
                                        pws.server = oChildNode3.getAttribute("server")
                                    End If
                                
                                    If Not oChildNode3.getAttributeNode("base") Is Nothing Then
                                        pws.database = oChildNode3.getAttribute("base")
                                    End If
                                
                                    If Not oChildNode3.getAttributeNode("login") Is Nothing Then
                                        pws.login = oChildNode3.getAttribute("login")
                                    End If
                                
                                    If Not oChildNode3.getAttributeNode("root") Is Nothing Then
                                        pws.root = Val(oChildNode3.getAttribute("root"))
                                        pws.ispwdb = True
                                    Else
                                        pws.ispwdb = False
                                    End If
                                
                                    If Not oChildNode3.getAttributeNode("glev") Is Nothing Then
                                        pws.glev = Val(oChildNode3.getAttribute("glev"))
                                    End If
                                    
    'Set oChildNode4 = oChildNode3.selectSingleNode("//Tab[@name='Wise']/Connect/Filters/Standard") ' RAHMAT
    Dim xmlnd As MSXML2.IXMLDOMNode
    
    Set xmlnd = oChildNode3.selectSingleNode("Filters/Standard")
    If Not xmlnd Is Nothing Then
        pws.sql_filter = xmlnd.text
    End If
                                                
'    Set xmlnd = oChildNode3.selectSingleNode("Filters/Regex")
'    If Not xmlnd Is Nothing Then
'        Set xmlnd = xmlnd.firstChild
'        Do Until xmlnd Is Nothing
'            If xmlnd.nodeType <> NODE_COMMENT Then
'                Dim str As String
'                str = xmlnd.text
'                pws.regexps.Add str, xmlnd.nodeName
'            End If
'            Set xmlnd = xmlnd.nextSibling
'        Loop
'    End If
                                                
                                    If Len(pws.text) > 0 And Len(pws.server) > 0 And Len(pws.database) > 0 And Len(pws.login) > 0 Then
                                                
                                        Set oChildNode4 = oChildNode3.getElementsByTagName("Department")(0)
                                        If oChildNode4 Is Nothing Then
                                        
                                            pwsets.Add pws, pws.text
                                        
                                        Else ' ограничение видимости по отделам
                                            For Each oChildNode4 In oChildNode3.getElementsByTagName("Department")
                                                If usrCurrent.depID = Val(oChildNode4.getAttribute("ID")) Then
                                                
                                                    If Not oChildNode4.getAttributeNode("edit_grid") Is Nothing Then pws.canedit_grid = CBool(oChildNode4.getAttribute("edit_grid"))
                                                    If Not oChildNode4.getAttributeNode("edit_tree") Is Nothing Then pws.canedit_tree = CBool(oChildNode4.getAttribute("edit_tree"))
                                                
                                                    pwsets.Add pws, pws.text
                    
                                                End If
                                            Next
                                        End If
                                    
                                    End If
                                    
                                    Set pws = Nothing
                                
                                Next
                                
                                If pwsets.Count > 0 Then
                            
                                    Dim ind As Integer
                                    ind = GetSetting("Offtake2", "pw", "connection index", 0) + 1
                            
                                    If ind < 1 Then ind = 1
                                    If ind > pwsets.Count Then ind = pwsets.Count
                            
                                    Set pwset = pwsets(ind)
                                Else
                                    Set pwset = New clsDBCon
                                End If
                                
                            
                            End If
                        
                        ElseIf oChildNode2.getAttribute("name") = "Rein" Then
                        
                            If oChildNode2.getElementsByTagName("Import").length > 0 Then
                            
                                For Each oChildNode3 In oChildNode2.getElementsByTagName("Import")
                        
                                    If Not oChildNode3 Is Nothing Then
                                    
                                        If Not oChildNode3.getAttributeNode("key") Is Nothing Then
                                        
                                            Dim im As New clsObj
                                            
                                            im.objname = "Import"
                                            im.KEY = oChildNode3.getAttribute("key")
                                            
                                            im.props.AddProp "key", im.KEY
                                            
                                            If Not oChildNode3.getAttributeNode("app") Is Nothing Then
                                                im.props.AddProp "app", oChildNode3.getAttribute("app")
                                            Else
                                                im.props.AddProp "app", "Excel"
                                            End If
                                            
                                            If Not oChildNode3.getAttributeNode("name") Is Nothing Then
                                                im.props.AddProp "name", oChildNode3.getAttribute("name")
                                            Else
                                                im.props.AddProp "name", "Import " & im.KEY
                                            End If
                                            
                                            If im.props("app").propValue = "Excel" Then
                                                If Not oChildNode3.getAttributeNode("startrow") Is Nothing Then
                                                    im.props.AddProp "startrow", CLng(oChildNode3.getAttribute("startrow"))
                                                Else
                                                    im.props.AddProp "startrow", CLng(1)
                                                End If
                                            End If
                                            
                                            ' атрибут - можно ли обновлять (true) или каталог перед заполнением должен быть пустым (false)
                                            If Not oChildNode3.getAttributeNode("update") Is Nothing Then
                                                im.props.AddProp "update", oChildNode3.getAttribute("update")
                                            Else
                                                im.props.AddProp "update", "false"
                                            End If
        
        
                                            i = 0 ' column index
                                            
        '                                    <Column index="0" key="posnum" required="true"/>
        '                                    <Column index="1" key="diameter" required="false"/>
        '                                    <Column index="2" key="quantity" required="false"/>
        '                                    <Column index="3" key="length" required="false"/>
        '                                    <Column index="4" key="srtmID" required="true"/>
        '                                    <Column index="5" key="sketch" required="false"/>
                                            For Each oChildNode4 In oChildNode3.getElementsByTagName("Column")
                                            
                                                Dim Clmn As New clsObj
                                                
                                                If Not oChildNode4.getAttributeNode("key") Is Nothing Then
                                                
                                                    Clmn.objname = "Column"
                                                    Clmn.KEY = oChildNode4.getAttribute("key")
                                                
                                                    Clmn.props.AddProp "key", Clmn.KEY
                                                    
                                                    If Not oChildNode4.getAttributeNode("index") Is Nothing Then
                                                        i = CLng(Val(oChildNode4.getAttribute("index")))
                                                    End If
                                                    Clmn.props.AddProp "index", i
                                                    i = i + 1
                                                    
                                                    If Not oChildNode4.getAttributeNode("required") Is Nothing Then
                                                        Clmn.props.AddProp "required", CBool(oChildNode4.getAttribute("required"))
                                                    Else
                                                        Clmn.props.AddProp "required", False
                                                    End If
                                                    
                                                    addColObj im.kinder, Clmn, Clmn.KEY
                                                    Set Clmn = Nothing
                                                    
                                                End If
                                            
                                            Next
                                            
                                            Set oChildNode4 = oChildNode3.getElementsByTagName("Material")(0)
                                            If Not oChildNode4 Is Nothing Then
                                                If Not oChildNode4.getAttributeNode("ID") Is Nothing Then
                                                    im.props.AddProp "matID", CLng(Val(oChildNode4.getAttribute("ID")))
                                                End If
                                                Set oChildNode4 = Nothing
                                            End If
                                            
                                            'imps.Add im, im.KEY
                                            addColObj imps, im, im.KEY
                                            Set im = Nothing
                                            
                                        End If
                                    
                                    End If ' oChildNode3
                        
                        
                                Next
                                
                            End If
                        
                        
                        ElseIf oChildNode2.getAttribute("name") = "Part" Then
                        
        
                            Set oChildNode3 = oChildNode2.getElementsByTagName("Sketches")(0)
                            If Not oChildNode3 Is Nothing Then
                                If Not oChildNode3.getAttributeNode("path") Is Nothing Then
                                    globPartTypes_sketch_path = oChildNode3.getAttribute("path")
                                End If
                                If Not oChildNode3.getAttributeNode("ext") Is Nothing Then
                                    globPartTypes_sketch_ext = oChildNode3.getAttribute("ext")
                                End If
                                Set oChildNode3 = Nothing
                            End If
        
                        End If
                        
                    End If
                
                Next
                
            End If

        End If
    
        
        Dim prjID As Long
        Dim bldID As Long
        Dim pr As clsPrp
        Dim prj As clsObj
        
        Set globLapsSet = New Offtmisc.colArmLap
    
        Set oChildNode = oNode.getElementsByTagName("Reinforcement")(0)
        If Not oChildNode Is Nothing Then
    
            If oChildNode.getElementsByTagName("Project").length > 0 Then
            
                For Each oChildNode2 In oChildNode.getElementsByTagName("Project")
                    
                    If Not oChildNode2.getAttributeNode("ID") Is Nothing Then
                        prjID = Val(oChildNode2.getAttribute("ID"))
                        
                        If prjID > 0 Then
                        
                            Set prj = New clsObj
                        
                            If oChildNode2.getElementsByTagName("Building").length > 0 Then
                            
                                For Each oChildNode3 In oChildNode2.getElementsByTagName("Building")
                                    
                                    If Not oChildNode3.getAttributeNode("ID") Is Nothing Then
                                        bldID = Val(oChildNode3.getAttribute("ID"))
                                        
                                        If bldID > 0 Then
                                        
                                            Set pr = New clsPrp
                                            pr.propValue = bldID
                                            prj.props.AddSimple pr
                                            Set pr = Nothing
                                        
                                        End If
                                    End If
                                Next
                            End If
                            
                            If oChildNode2.getElementsByTagName("Lap").length > 0 Then
                            
                                For Each oChildNode3 In oChildNode2.getElementsByTagName("Lap")
                                    
                                    For Each pr In prj.props
                                    
                                        Dim lap As New Offtmisc.clsArmLap
                                        
                                        lap.projectID = prjID
                                        lap.betonID = pr.propValue
                                        If Not oChildNode3.getAttributeNode("lapID") Is Nothing Then lap.lapID = Val(oChildNode3.getAttribute("lapID"))
                                        If Not oChildNode3.getAttributeNode("lapValue") Is Nothing Then lap.lapValue = Val(oChildNode3.getAttribute("lapValue"))
                                        'If Not oChildNode3.getAttributeNode("projectID") Is Nothing Then lap.projectID = Val(oChildNode3.getAttribute("projectID"))
                                        'If Not oChildNode3.getAttributeNode("buildingID") Is Nothing Then lap.betonID = Val(oChildNode3.getAttribute("buildingID"))
                                        If Not oChildNode3.getAttributeNode("armclassID") Is Nothing Then lap.classID = Val(oChildNode3.getAttribute("armclassID"))
                                        If Not oChildNode3.getAttributeNode("diameter") Is Nothing Then lap.diameter = Val(oChildNode3.getAttribute("diameter"))
                                        'If Not oChildNode3.getAttributeNode("direction") Is Nothing Then lap.Direction = Val(oChildNode3.getAttribute("direction"))
                                        If Not oChildNode3.getAttributeNode("maxlen") Is Nothing Then lap.maxlen = Val(oChildNode3.getAttribute("maxlen"))
                                        If Not oChildNode3.getAttributeNode("bend_work") Is Nothing Then lap.bend_work = Val(oChildNode3.getAttribute("bend_work"))
                                        If Not oChildNode3.getAttributeNode("bend_free") Is Nothing Then lap.bend_free = Val(oChildNode3.getAttribute("bend_free"))
                                        If Not oChildNode3.getAttributeNode("muft") Is Nothing Then lap.bMuft = CBool(oChildNode3.getAttribute("muft"))
                                        'If Not oChildNode3.getAttributeNode("srtmID") Is Nothing Then lap.srtmID = Val(oChildNode3.getAttribute("srtmID"))
                                        'If Not oChildNode3.getAttributeNode("matID") Is Nothing Then lap.matID = Val(oChildNode3.getAttribute("matID"))
                                        'If Not oChildNode3.getAttributeNode("bendrad") Is Nothing Then lap.bendrad = Val(oChildNode3.getAttribute("bendrad"))
                                        
                                        globLapsSet.addLap lap
                                        
                                        Set lap = Nothing
                                        
                                    Next
                                Next
                            End If
                        End If
                    End If
                Next
            End If

            
            
            
        End If
    
        If oNode.getElementsByTagName("Database").length > 0 Then
        
            For Each oChildNode In oNode.getElementsByTagName("Database")
                
                If Not oChildNode.getAttributeNode("name") Is Nothing And oChildNode.getElementsByTagName("User").length > 0 Then
                
                    Dim clst As New clsTable
                    clst.sTableName = oChildNode.getAttribute("name")
                    
                    For Each oChildNode2 In oChildNode.getElementsByTagName("User")
                    
                        If LCase(usrCurrent.strLogin) = LCase(Trim(oChildNode2.text)) Then
                            Wrksp.Add clst, clst.sTableName
                            
                            If Not oChildNode2.getAttributeNode("force") Is Nothing Then
                                bForce = CBool(oChildNode2.getAttribute("force"))
                                bAskSource = Not bForce
                            Else
                                bForce = False
                            End If
                            
                            
                            If bForce Then
                                ReDim arBases(0)
                                arBases(0) = clst.sTableName
                                strCurDataBase = clst.sTableName
                            Else
                                For i = 0 To UBound(arBases)
                                    If StrComp(arBases(i), clst.sTableName, vbTextCompare) = 0 Then
                                        i = -1 ' уже есть такой
                                        Exit For
                                    End If
                                Next i
                                If i > -1 Then
                                    ReDim Preserve arBases(UBound(arBases) + 1)
                                    arBases(UBound(arBases)) = clst.sTableName
                                End If
                            End If
                            
                            Set clst = Nothing
                            
                        End If
                    Next
                Else
                End If
            
            Next
            
        End If
    End If
    


    
    Set oNode = oXMLDoc.documentElement.getElementsByTagName("SimViews")(0)
    'Читаем настройки всех указанных View:
    For Each oChildNode In oNode.getElementsByTagName("View")
        'чтение запроса и подстановка системных переменных:
        Dim oQueryEl As MSXML2.IXMLDOMElement: Set oQueryEl = oChildNode.getElementsByTagName("SQLQuery")(0)
        
        Dim SqlQuery$: SqlQuery = oQueryEl.text
        Dim SysVarKey
        For Each SysVarKey In SysVariables.Keys
            Dim RegExp As New RegExp
            RegExp.Pattern = "%" & SysVarKey & "%"
            SqlQuery = RegExp.Replace(SqlQuery, SysVariables(SysVarKey))
        Next

        Dim SimView As clsConfigSimView: Set SimView = New clsConfigSimView
          
        With oChildNode
            Call SimView.Initialize(.getAttribute("Name"), .getAttribute("Title"), .getAttribute("Keys"), SqlQuery)
            
            If Not .getAttributeNode("Proj") Is Nothing Then
                SimView.Proj = .getAttributeNode("Proj").Value
            End If
            
            With oQueryEl
                SimView.HiddenColumns = .getAttribute("HiddenColumns")
                SimView.MergeColumns = .getAttribute("MergeColumns")
                SimView.MergeRef = .getAttribute("MergeRef")
                SimView.LevelFilterColumn = .getAttribute("LevelFilterColumn")
                SimView.AutoIndexColumn = .getAttribute("AutoIndexColumn")
                
                If Not .getAttributeNode("SubTotalColumns") Is Nothing Then
                    SimView.SubTotalColumns = .getAttribute("SubTotalColumns")
                End If
                
            End With
            
            Set oNode = .getElementsByTagName("Errors")(0)
            If oNode.hasChildNodes Then
                Dim ErrNode As MSXML2.IXMLDOMElement, vErr As clsConfigViewErr
                For Each ErrNode In oNode.getElementsByTagName("Item")
                    Set vErr = New clsConfigViewErr
                    With ErrNode
                         Call vErr.Initialize(.getAttribute("Column"), .getAttribute("ErrorExpression"), .getAttribute("Trigger"), .getAttribute("Message"))
                    End With
                    SimView.Errors.Add vErr 'запоминаем характеристики ошибки
                Next
            End If
            
            Dim vField As clsObjVec
            Dim EdNode  As MSXML2.IXMLDOMElement
            Dim n1  As MSXML2.IXMLDOMElement
            Dim n2   As MSXML2.IXMLDOMElement
            Dim n3   As MSXML2.IXMLDOMElement
            Dim atr As MSXML2.IXMLDOMAttribute
            Set oNode = .getElementsByTagName("EditFields")(0)
            If Not oNode Is Nothing Then
                If oNode.hasChildNodes Then
                    For Each EdNode In oNode.getElementsByTagName("Item")
                        For Each n3 In EdNode.getElementsByTagName("Department")
                            If usrCurrent.depID = Val(n3.getAttribute("ID")) Then
                            
                                Set vField = New clsObjVec
                                For Each atr In EdNode.Attributes
                                    vField.props.AddProp atr.Name, atr.Value
                                Next
                                Set n1 = EdNode.getElementsByTagName("Auto")(0)
                                Set n2 = EdNode.getElementsByTagName("Manual")(0)
                                
                                If n1 Is Nothing Or n2 Is Nothing Then Exit For
                                For Each atr In n1.Attributes
                                    vField.src.props.AddProp atr.Name, atr.Value
                                Next
                                For Each atr In n2.Attributes
                                    vField.trg.props.AddProp atr.Name, atr.Value
                                Next
                        
                                SimView.cEditFields.Add vField
                            End If
                        Next
                        
                        Set vField = Nothing
                    Next
                End If
            End If
            
            Dim nd As MSXML2.IXMLDOMElement
            Dim ndd As MSXML2.IXMLDOMNode
            Dim nda As MSXML2.IXMLDOMAttribute
            
            ' MS
            If .getElementsByTagName("MicroStationExport").length > 0 Then
                Set oNode = .getElementsByTagName("MicroStationExport")(0)
                With oNode
                    SimView.MS_TemplatePath = ReadPath(.getAttribute("TemplatePath"))
                    
                    Dim scfg As clsSCfg
                    
                    Set SimView.MS_SpecConfig = New clsSCfg
                    
                    Set scfg = SimView.MS_SpecConfig
                    
                    If Not .getAttributeNode("ID") Is Nothing Then scfg.spcfgID = .getAttribute("ID")
                    If Not .getAttributeNode("Name") Is Nothing Then scfg.spcfgName = .getAttribute("Name")
                    If Not .getAttributeNode("TemplateModel") Is Nothing Then scfg.spcfgCapCell = .getAttribute("TemplateModel")
                    If Not .getAttributeNode("UseDots") Is Nothing Then scfg.spcfgUseDots = CBool(.getAttribute("UseDots"))
                    If Not .getAttributeNode("ListName") Is Nothing Then scfg.spcfgListName = .getAttribute("ListName")
                    If Not .getAttributeNode("txtHeight") Is Nothing Then scfg.dTextHgt = getDbl(.getAttribute("txtHeight"))
                    If Not .getAttributeNode("txtWidth") Is Nothing Then scfg.dTextWdt = getDbl(.getAttribute("txtWidth"))
                    If Not .getAttributeNode("txtScale") Is Nothing Then scfg.dTextScale = getDbl(.getAttribute("txtScale"))
                    If Not .getAttributeNode("useTranslation") Is Nothing Then scfg.iTrans = Val(.getAttribute("useTranslation"))
                    If Not .getAttributeNode("RunMet") Is Nothing Then scfg.sRunMetOver = .getAttribute("RunMet")
                    If Not .getAttributeNode("LineWgtVert") Is Nothing Then
                        If CInt(.getAttribute("LineWgtVert")) >= 0 Then
                            scfgCmn.spec_v_line_wdt = CInt(.getAttribute("LineWgtVert"))
                        End If
                    End If
                    If Not .getAttributeNode("lineWgtHor") Is Nothing Then
                        If CInt(.getAttribute("lineWgtHor")) >= 0 Then
                            scfgCmn.spec_h_line_wdt = CInt(.getAttribute("lineWgtHor"))
                        End If
                    End If
                    If Not .getAttributeNode("txtFont") Is Nothing Then scfg.iTextFont = .getAttribute("txtFont") Else scfg.iTextFont = 226
                    

                    
'                    scfg.spcfgHeadHeight from dgn file
'                    scfg.spcfgColWidths from dgn file
'                    scfg.spcfgRowHeight from dgn file
'                    scfg.iColCnt from dgn file
                        
                    
                    
                    
'                    If Not IsNull(RS.fields("rowHeights").Value) Then scfg.spcfgRowHeights = RS.fields("rowHeights").Value
'                    scfg.bNewAC = RS.fields("useNewArmClass").Value
'                    scfg.bOldAC = RS.fields("useOldArmClass").Value
'                    scfg.bUseMatScnd = RS.fields("useMatScnd").Value
'                    scfg.bNewRowPartName = getFieldBoolValue(RS, "newRowPartName", scfg.bNewRowPartName)
'                    scfg.bNewRowPartDef = getFieldBoolValue(RS, "newRowPartDef", scfg.bNewRowPartDef)
'                    scfg.bNewRowMatStd = getFieldBoolValue(RS, "newRowMatStd", scfg.bNewRowMatStd)
'                    scfg.bPosdefIsText = getFieldBoolValue(RS, "posdefIsText", scfg.bPosdefIsText)
'                    scfg.bPosSignStd = getFieldBoolValue(RS, "posSignStd", scfg.bPosSignStd)
'                    scfg.spcfgLevVar = RS.fields("strLenVar").Value & ""
'

                    
                    
                End With
                
                ' columns
'                If oNode.getElementsByTagName("Columns").length > 0 Then
'                    For Each nd In oNode.getElementsByTagName("Columns")(0).ChildNodes
'                        If Not nd.getAttributeNode("name") Is Nothing Then
'                            SimView.MS_SpecConfig.iColCnt = SimView.MS_SpecConfig.iColCnt + 1
'                        End If
'                        If Not nd.getAttributeNode("width") Is Nothing Then
'                            arSpecCol(SimView.MS_SpecConfig.iColCnt) = Val(nd.getAttribute("width"))
'                        End If
'                    Next
'                End If

'                ' rows
                If oNode.getElementsByTagName("Rows").length > 0 Then
                    For Each nd In oNode.getElementsByTagName("Rows")(0).ChildNodes
                        If Not nd.getAttributeNode("Row") Is Nothing Then
'                             = getDbl(.getAttribute("TextLines"))
'                             = getDbl(.getAttribute("RowHeight"))
'                             = getDbl(.getAttribute("TextShift"))
                        End If
                    Next
                End If
                
            End If
            
            ' EXCEL
            If .getElementsByTagName("ExcelExport").length > 0 Then
                Set oNode = .getElementsByTagName("ExcelExport")(0)
                With oNode
                    SimView.Excel_TemplatePath = ReadPath(.getAttribute("TemplatePath"))
                    SimView.Excel_StartRow = Abs(.getAttribute("StartRow"))
                    SimView.Excel_StrartColumn = Abs(.getAttribute("StartColumn"))
                    SimView.Excel_EndPageRow = .getAttribute("EndPageRow")
                    SimView.Excel_Jump = Abs(.getAttribute("Jump"))
                    SimView.Excel_SavePath = ReadPath(.getAttribute("SavePath"))
                    SimView.Excel_GroupBy = .getAttribute("GroupBy")
                End With
            End If
            
            ' WORD
            If .getElementsByTagName("WordExport").length > 0 Then
                Set oNode = .getElementsByTagName("WordExport")(0)
                
                With oNode
                    SimView.Word_TemplatePath = ReadPath(.getAttribute("TemplatePath"))
                    SimView.Word_TableIndex = Abs(.getAttribute("TableIndex"))
                    
                    If Not .getAttributeNode("NewRowKey") Is Nothing Then
                        SimView.Word_NewRowKey = .getAttribute("NewRowKey")
                    End If
                    If Not .getAttributeNode("TableStartRow") Is Nothing Then
                        SimView.Word_TableStartRow = .getAttribute("TableStartRow")
                    End If
                End With
                
                If oNode.getElementsByTagName("GroupColumns").length > 0 Then
                    Dim ClmnNode As MSXML2.IXMLDOMElement, GroupClmn As clsConfigWordGrClmn
                    For Each ClmnNode In oNode.getElementsByTagName("GroupColumns")(0).ChildNodes
                        Set GroupClmn = New clsConfigWordGrClmn
                        With ClmnNode
                            Call GroupClmn.Initialize(.getAttribute("Column"), .getAttribute("GroupExpression"), .getAttribute("TitleRowsCount"), .getAttribute("TitleText"), .getAttribute("Hidden"))
                        End With
                        SimView.Word_GroupColumnsColl.Add GroupClmn
                    Next
                End If
            End If
            
        End With
        
        Call SimViews.Add(SimView)
    Next

'    Set oNode = oXMLDoc.documentElement.getElementsByTagName("RootNode")(0)
'    Set Nodes = GetChildNodesData(oNode, 0)


    
Exit Sub

ReadData_ERR:
    If Not oXMLDoc Is Nothing Then
        errMessage = "error parsing xml in Offtake.cfg:" & vbNewLine & oXMLDoc.parseError.reason & vbNewLine & "line: " & oXMLDoc.parseError.Line & ", symbol: " & oXMLDoc.parseError.linepos
    Else
        errMessage = "error reading xml - " & err.Description
    End If
    'Resume Next
End Sub

Public Function GetChildNodesData(ByVal Node As MSXML2.IXMLDOMElement, ByVal ID As Integer) As Dictionary
    Dim Coll As Dictionary: Set Coll = New Dictionary
    Dim ChildNodes As MSXML2.IXMLDOMNodeList: Set ChildNodes = Node.getElementsByTagName("ChildNodes")
    
    Dim ChildNode As MSXML2.IXMLDOMElement
    
    Dim iName$, i%
    i = 0
    
'    If ChildNodes.length > 0 Then
'        For Each ChildNode In ChildNodes(0).ChildNodes
'            If ChildNode.tagName = "Node" Then
'                iName = ChildNode.getAttribute("Name")
'                If Not Coll.exists(iName) Then
'                    I = I + 1
'                    Dim ViewNode As UDTViewNode
'                    With ViewNode
'                        .ID = CInt(ID & I)
'                        .Name = iName
'                        Set .Nodes = GetChildNodesData(ChildNode, ViewNode.ID)
'                    End With
'                    Dim v As Object
'                    Set v = ViewMode
'                    Coll.Add iName, v
'                End If
'            End If
'        Next
'    End If

    Set GetChildNodesData = Coll
End Function


'/******************************************************************************
Public Function RequiresUpdate() As Boolean
'/******************************************************************************
On Error GoTo RequiresUpdate_ERR
    
    RequiresUpdate = (lmDate <> fso.GetFile(path).DateLastModified)
    
Exit Function
RequiresUpdate_ERR:
    errMessage = "RequiresUpdate" & "() - " & err.Description
End Function

'/******************************************************************************
Public Sub UpdateConfig()
'/******************************************************************************
On Error GoTo Update_ERR

    If RequiresUpdate Then
        Call ReadData
        lmDate = fso.GetFile(path).DateLastModified
    End If
     
Exit Sub
Update_ERR:
    errMessage = "Update" & "() - " & err.Description
End Sub

'Проверка на ошибки для указанной вкладки
Public Sub checkTabViewErrors(TabIndex As Integer)
    If Not fgTabViews.exists(TabIndex) Then Exit Sub
    
    Dim oView As clsConfigSimView: Set oView = fgTabViews(TabIndex)
    Dim fgDyn As VSFlexGrid: Set fgDyn = fgTabs(TabIndex)
    
    Dim ErrClmns As String: ErrClmns = vbNullString 'для записи заголовков столбцов с ошибками
    
    Dim i%, j%, errcnt%
    Dim RegExp As RegExp: Set RegExp = New RegExp
    
'    Dim rrr As New RegExp
'    rrr.Pattern = "^(~Name)$"
'    Dim blnAAA As Boolean
'    blnAAA = rrr.Test("~Name")
    
    'предварительная разблокировка кнопки экспорта
    F1.tbWise.Buttons("Excel").Enabled = True
    F1.tbSimData.TabColor(TabIndex) = F1.tbSimData.BackColor 'сброс подсветки
    
    Dim vErr As clsConfigViewErr, HasErrors As Boolean
    HasErrors = False
    For Each vErr In oView.Errors
        errcnt = 0
        
        With fgDyn
            For j = 0 To .cols - 1
                If .ColHidden(j) Then GoTo LNextCol
                
                RegExp.Pattern = vErr.Column
                If RegExp.Test(.ColKey(j)) Then
                    
                    If vErr.ErrorExpression = "%Unique%" Then
                        'Проверка на уникальность
                        Dim UniqColl As Dictionary: Set UniqColl = New Dictionary
                        For i = 1 To .Rows - 1
                            If .RowHidden(i) Or .IsSubtotal(i) Then GoTo LNextRow1
                            If Not vErr.Trigger And Not UniqColl.exists(.TextMatrix(i, j)) Then
                                Call UniqColl.Add(.TextMatrix(i, j), Empty)
                            Else
                                If Not InStr(ErrClmns, .ColKey(j)) > 0 Then
                                    If Len(ErrClmns) > 0 Then ErrClmns = ErrClmns & ", "
                                    ErrClmns = ErrClmns & "'" & .ColKey(j) & "'"
                                End If
                                .Cell(flexcpBackColor, i, j, i, j) = lngRed
                                errcnt = errcnt + 1
                            End If
LNextRow1:
                        Next
                        Set UniqColl = Nothing
                    Else
                        RegExp.Pattern = vErr.ErrorExpression
                        For i = 1 To .Rows - 1
                            If .RowHidden(i) Or .IsSubtotal(i) Then GoTo LNextRow2
                            If RegExp.Test(.TextMatrix(i, j)) = CBool(vErr.Trigger) Then
                                If Not InStr(ErrClmns, .ColKey(j)) > 0 Then
                                    If Len(ErrClmns) > 0 Then ErrClmns = ErrClmns & ", "
                                    ErrClmns = ErrClmns & "'" & .ColKey(j) & "'"
                                End If
                            
                                .Cell(flexcpBackColor, i, j, i, j) = lngRed
                                errcnt = errcnt + 1
                            End If
LNextRow2:
                        Next
                    End If
                End If
LNextCol:
            Next
            If errcnt > 0 Then 'были найдены ошибки
                HasErrors = True
                F1.tbSimData.TabColor(TabIndex) = vbRed 'выделение вкладки с ошибками
                If Len(vErr.Message) > 0 Then
                    MsgBox "В " & ErrClmns & vErr.Message & vbLf & "Количество некорректных полей: " & errcnt, vbOKOnly + vbExclamation, F1.tbSimData.TabCaption(TabIndex)
                End If
            End If

        End With
    Next
    
    'блокируем кнопку экспорта для активной вкладки
    If bMainFormLoaded Then
        If F1.tbSimData.CurrTab = TabIndex Then
            With F1.tbWise
'                .Buttons("Excel").Enabled = Not HasErrors
                .Buttons("Word").Enabled = Len(oView.Word_TemplatePath) > 0 And Not HasErrors
                .Buttons("Micro").Enabled = Len(oView.MS_TemplatePath) > 0 And Not HasErrors
            End With
        End If
    End If
    
End Sub

Public Function ReadPath(ByVal path As String) As String
    If InStr(path, ".\") = 1 Then
        Dim fso As FileSystemObject: Set fso = New FileSystemObject
        ReadPath = fso.BuildPath(App.path, right(path, Len(path) - 2))
    Else
        ReadPath = path
    End If
End Function
