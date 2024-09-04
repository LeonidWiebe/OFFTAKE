VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSCfg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public rowTop As clsSpecRow
Public rowOrd As clsSpecRow
Public rowBot As clsSpecRow

Public spcfgID As Long
Public spcfgName As String
Public spcfgListName As String
Public spcfgCapCell As String
Public spcfgUseDots As Boolean
Public spcfgHeadHeight As Double
Public spcfgLevVar As String

Public spcfg_prntID As Long

Public spcfgColWidths As String
Public spcfgRowHeights As String ' для выборки
Public spcfgRowHeight As Double

Public bNewAC As Boolean
Public bOldAC As Boolean
Public bUseMatScnd As Boolean

Public iTrans As Integer

Public sRunMetOver As String
Public offtMatMask As String

Public iColCnt As Integer

Public bNewRowPartName As Boolean
Public bNewRowPartDef As Boolean
Public bNewRowMatStd As Boolean
Public bNewRowMat As Boolean

Public bPosdefIsText As Boolean
Public bPosSignStd As Boolean

Public dTextScale As Double
Public dTextHgt As Double
Public dTextWdt As Double
Public iTextFont As Long


Public spec_v_line_wdt As Integer
Public spec_h_line_wdt As Integer
Public spec_v_line_clr As Integer
Public spec_h_line_clr As Integer
Public spec_text_clr As Integer
Public spec_table_scale As Integer
Public spec_col_cmass As Integer

Public spec_text_diam As String

Public spec_text_dscr As String
Public spec_text_dscr_replace_from As String
Public spec_text_dscr_replace_to As String

Public o_spec_text_name As New colAts ' section <spcfg/> included in <spec_text_name/>

Public spec_sheet_num_fmt As String ' sheet num format
Public spec_sheet_num_pfx As String ' sheet num prefix

Public spec_row_numbers As Integer ' -1, 0, 1
Public spec_skip_bar As Integer


Public spec_xls_template As String
Public spec_xls_startrow As Integer
Public spec_xls_startcol As Integer
Public spec_xls_rows As Integer
Public spec_xls_jump As Integer

'------------------------------------------------
'Kulakov - add for Room To SPF
Public space_xls_template As String
Public space_xls_startrow As Integer
Public space_xls_startcol As Integer
Public space_xls_rows As Integer
Public space_xls_jump As Integer

'------------------------------------------------

Public bUnderLineHeader As Boolean

Public sPartSheetFormat As String

Private Sub Class_Initialize()
    
    bNewRowPartName = True
    bNewRowPartDef = True
    bNewRowMatStd = True
    bNewRowMat = True
    bPosdefIsText = False
    bPosSignStd = False
    
    
    spec_v_line_wdt = scfgCmn.spec_v_line_wdt
    spec_h_line_wdt = scfgCmn.spec_h_line_wdt
    spec_row_numbers = scfgCmn.spec_row_numbers
    spec_v_line_clr = scfgCmn.spec_v_line_clr
    spec_h_line_clr = scfgCmn.spec_h_line_clr
    spec_text_clr = scfgCmn.spec_text_clr
    spec_text_diam = scfgCmn.spec_text_diam
    spec_skip_bar = scfgCmn.spec_skip_bar
    spec_table_scale = scfgCmn.spec_table_scale
    spec_col_cmass = scfgCmn.spec_col_cmass
    spec_text_dscr = scfgCmn.spec_text_dscr
    
    spec_xls_template = scfgCmn.spec_xls_template
    spec_xls_startrow = scfgCmn.spec_xls_startrow
    spec_xls_startcol = scfgCmn.spec_xls_startcol
    spec_xls_rows = scfgCmn.spec_xls_rows
    spec_xls_jump = scfgCmn.spec_xls_jump
    
    '------------------------------------------------
'Kulakov - add for Room To SPF
    space_xls_template = scfgCmn.space_xls_template
    space_xls_startrow = scfgCmn.space_xls_startrow
    space_xls_startcol = scfgCmn.space_xls_startcol
    space_xls_rows = scfgCmn.space_xls_rows
    space_xls_jump = scfgCmn.space_xls_jump
    
'    ------------------------------------------------------------

    offtMatMask = ""
    
End Sub

Public Function get_spec_col_cmass() As Integer

    get_spec_col_cmass = Me.spec_col_cmass

    Dim o As clsSCfg
    
    Set o = getColItem(colSpecTextOver, CStr(spcfgID))

    If Not o Is Nothing Then
    
        get_spec_col_cmass = o.spec_col_cmass

    End If

End Function



'/******************************************************************************
Public Function get_spec_row_numbers() As Integer
'/******************************************************************************

    On Error GoTo get_spec_row_numbers_ERR

    get_spec_row_numbers = 1

    Dim o As clsSCfg
    
    Set o = getColItem(colSpecTextOver, CStr(spcfgID))

    If Not o Is Nothing Then
    
        get_spec_row_numbers = o.spec_row_numbers

    End If

Exit Function

get_spec_row_numbers_ERR:
    get_spec_row_numbers = 1

End Function



'/******************************************************************************
Public Function getPartDescr(Optional sDefaultDescr As String = "")
'/******************************************************************************

    On Error GoTo getPartDescr_ERR
    
    Dim sPrtDsc As String
    
    sPrtDsc = spec_text_dscr
    
    Dim o As clsSCfg
    
    Set o = getColItem(colSpecTextOver, CStr(spcfgID))

    If Not o Is Nothing Then
    
        sPrtDsc = o.spec_text_dscr
        
        If Len(sDefaultDescr) > 0 Then sPrtDsc = Replace(sPrtDsc, "[dscr]", sDefaultDescr)
        
        If Len(o.spec_text_dscr_replace_from) > 0 Then
            sPrtDsc = Replace(sPrtDsc, o.spec_text_dscr_replace_from, o.spec_text_dscr_replace_to)
        End If
        
        
    Else
    
        If Len(sDefaultDescr) > 0 Then sPrtDsc = Replace(sPrtDsc, "[dscr]", sDefaultDescr)
    
    End If
    
    
    sPrtDsc = Replace(sPrtDsc, "[dscr]", "")
    
    getPartDescr = sPrtDsc
    

Exit Function

getPartDescr_ERR:

    getPartDescr = "ERROR"

End Function
