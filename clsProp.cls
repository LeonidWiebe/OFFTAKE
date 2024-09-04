VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsProp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public propID As Long
Public propName As String
Public propDescr As String
Public propvalName As String
Public propK As Double

Public muID As Long
Public muSrtmID As Long
'Public mu As clsMU
'Public muSrtm As clsMU

Public propValue As Variant
Public propDefValue As Variant

Public parentPos As clsPos

Public pr As clsProp

Public OK As Boolean

Public bEditable As Boolean


Public sTableName As String

Public bMassCalc As Boolean

Public iSortOrder As Integer ' исп. только в pd_props для редактирования сортировки в frmPosdef

Public bPosProp As Boolean

Public bAddedByUser As Boolean

'Public Property Let u(ByVal v As Double)
'End Property

Public propObjID As Long

Dim matcor As Double ' material mass correction


'/******************************************************************************
Public Function fromExisting(sKey As String) As clsProp
'/******************************************************************************

    On Error GoTo fromExisting_ERR

    If Len(sKey) = 0 Then Exit Function

    Dim pNew As New clsProp
    
    Dim pEx As clsProp
    
    Set pEx = globProps(sKey)
    
    If Not pEx.muID = 0 Then pNew.muID = pEx.muID
    Set pNew.parentPos = pEx.parentPos
    Set pNew.pr = globProps(sKey)
    
    pNew.bEditable = pEx.bEditable
    pNew.bMassCalc = pEx.bMassCalc
    pNew.OK = pEx.OK
    pNew.propDefValue = pEx.propDefValue
    pNew.propDescr = pEx.propDescr
    pNew.propID = pEx.propID
    pNew.propK = pEx.propK
    pNew.propName = pEx.propName
    pNew.propvalName = pEx.propvalName
    pNew.propValue = pEx.propValue
    pNew.sTableName = pEx.sTableName
    pNew.propObjID = pEx.propObjID





    Set fromExisting = pNew
    
    Set pNew = Nothing
    

Exit Function

fromExisting_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "fromExisting - Error"

End Function


'/******************************************************************************
Public Function setValue(v As Variant) As Boolean
'/******************************************************************************
    
    On Error GoTo setValue_ERR


    On Error GoTo setValue_ERR
    
    Dim vv As Variant
    
    If IsNull(v) Then
        vv = Null
    ElseIf typeName(v) = "String" Then
        If Len(v) = 0 Then vv = Null
    Else
        If v = 0 Then vv = Null
    End If
    
    If IsNull(vv) Then
        
        If propvalName = "double" Then
            propValue = CDbl(0#)
        ElseIf propvalName = "string" Then
            propValue = CStr("")
        ElseIf propvalName = "id" Then
            propValue = CLng(0)
        Else
            propValue = v
        End If
        
    Else
        propValue = v
    End If
    
    
    
    
    setValue = True
    
    Exit Function
    


Exit Function

setValue_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "setValue - Error"

End Function


'/******************************************************************************
Public Property Get PVAL_SI() As Variant
'/******************************************************************************

    On Error GoTo PVAL_SI_ERR

    If muID = 0 Then
'        If propValue Is Empty Then
'            PVAL_SI = propDefValue
'        Else
            PVAL_SI = propValue
'        End If
        Exit Property
    End If

    If propvalName = "double" Then
        If IsEmpty(propValue) Or propValue = 0# Then
            PVAL_SI = propDefValue * PROP_MU.muSiK
        Else
            PVAL_SI = propValue * PROP_MU.muSiK
        End If
    ElseIf propvalName = "string" Then
        PVAL_SI = propValue
    ElseIf propvalName = "id" Then
        PVAL_SI = propValue
    Else
        PVAL_SI = Empty
    End If



Exit Property

PVAL_SI_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "PVAL_SI - Error"

End Property

Public Function hasValue() As Boolean

    If propvalName = "double" Then
        If IsEmpty(propValue) Or propValue = 0# Then
            hasValue = False
        Else
            hasValue = True
        End If
    ElseIf propvalName = "string" Then
        If Len(Trim(propValue)) = 0 Then
            hasValue = False
        Else
            hasValue = True
        End If
    ElseIf propvalName = "id" Then
        If IsEmpty(propValue) Or propValue = 0 Then
            hasValue = False
        Else
            hasValue = True
        End If
    Else
        If CBool(propValue) Then
            hasValue = True
        Else
            hasValue = False
        End If
    End If



End Function



'/******************************************************************************
Public Property Get PVAL() As Variant
'/******************************************************************************
    
    On Error GoTo PVAL_ERR
    
    
    If propvalName = "double" Or propvalName = "long" Then
        Dim locval As Variant
        If IsEmpty(propValue) Or propValue = 0# Then
            locval = propDefValue
        Else
            locval = propValue
        End If
        
        If matcor > 0# Then
            PVAL = Format(locval * matcor, "0.0")
        Else
            PVAL = locval
        End If
        
    ElseIf propvalName = "string" Then
        PVAL = propValue
    ElseIf propvalName = "id" Then
    
        If Me.propName = "catdef" Then
        
            If propValue = 0 Then
                PVAL = "-"
            Else
                Dim cd As clsCatDef
                Set cd = globCatDefs(CStr(propValue))
                PVAL = cd.cdName
            End If
        
        ElseIf Me.propName = "glevel" Then
        
            PVAL = getLevSign(Val(propValue))
        
'            If propValue = 0 Then
'                PVAL = "-"
'            Else
'                If propValue = 1 Then
'                    PVAL = "Надземная часть"
'                ElseIf propValue = -1 Then
'                    PVAL = "Подземная часть"
'                ElseIf propValue = 2 Then
'                    PVAL = "Подземная часть"
'                Else
'                    PVAL = "-"
'                End If
'            End If
        
        Else
            PVAL = propValue
        End If
    
    Else
        PVAL = Empty
    End If
    
    
    
    
    
    
    Exit Property
    
PVAL_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "PVAL - Error"
    
End Property




'/******************************************************************************
Public Property Let PVAL(ByVal v As Variant)
'/******************************************************************************
    
    On Error GoTo VALUE_ERR
    
    Dim sFieldName As String
    sFieldName = propName
    
    If typeName(v) = "String" Then
        If Len(v) = 0 Then v = Empty
    Else
        If v <= 0 Then v = Empty
    End If
    
    Dim strPosTable As String
    
    If Me.parentPos Is Nothing Then
        strPosTable = "position"
    Else
        strPosTable = Me.parentPos.POS_SRC_TABLE
    End If
    
    
    Dim RS As New ADODB.Recordset
    
    RS.Open "select * from r_" & strPosTable & "_property where posID = " & parentPos.posID, cn_data, adOpenForwardOnly, adLockOptimistic
    
    If RS.EOF Then
        ' insert value
        
        If Not IsEmpty(v) Then
            
            
            RS.AddNew
            RS.fields("posID").Value = parentPos.posID
            RS.fields(sFieldName).Value = v
            RS.Update
            Call writeOperationS(operModify, strPosTable, parentPos.posID, propName & " = " & CStr(v))
            
        End If
    Else
        ' update value
        
        If Me.bEditable Then
            
            If IsEmpty(v) Then
                
                
                RS.MoveFirst
                If IsNull(RS.fields(sFieldName).Value) Then
                Else
                    RS.fields(sFieldName).Value = Null
                    RS.Update
                    Call writeOperationS(operModify, strPosTable, parentPos.posID, "обнуление " & propName)
                End If
                
                
                
            Else
                
                RS.MoveFirst
                If Val(RS.fields(sFieldName).Value & "") = v Then
                Else
                    RS.fields(sFieldName).Value = v
                    RS.Update
                    Call writeOperationS(operModify, strPosTable, parentPos.posID, propName & " = " & CStr(v))
                End If
                
            End If
            
        End If
        
    End If
    
    
    RS.Close
    Set RS = Nothing
    
    propValue = v
    
    
    Exit Property
    
VALUE_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "VALUE - Error"
    
End Property

'/******************************************************************************
Public Property Set pos(ByVal vData As clsPos)
'/******************************************************************************

    On Error GoTo POS_ERR
    
    Set parentPos = vData
    
    
    Exit Property
    
POS_ERR:
    If err.Number = &H80040E37 Then
        Resume Next
    Else
        MsgBox "[" & err.Number & "] " & err.Description, vbCritical, " - Error"
    End If
    
End Property



'/******************************************************************************
Public Function loadByPropID(ByVal ID As Long, Optional ByRef RS As ADODB.Recordset = Nothing) As Boolean
'/******************************************************************************

On Error GoTo ID_ERR

    Dim bNew As Boolean

    If RS Is Nothing Then
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        RS.Open "select * from view_property where propID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        bNew = True
    Else
        bNew = False
    End If

    
    
    If RS.EOF Then
        propID = 0
        propName = ""
        OK = False
        Exit Function
    Else
        If bNew Then RS.MoveFirst
    End If
    
    
    
    propID = RS.fields("propID").Value
    propName = RS.fields("propName").Value
    propDescr = RS.fields("propDescr").Value
    propvalName = RS.fields("propvalName").Value
    propDefValue = Val(RS.fields("propDefValue").Value & "")
    sTableName = RS.fields("tableName").Value & ""
    propObjID = getFieldLongValue(RS, "objID", 2)

    If IsNull(RS.fields("muID").Value) Then
        muID = 0
    Else
        muID = RS.fields("muID").Value
    End If

    If IsNull(RS.fields("muIDsrtm").Value) Then
        muSrtmID = 0
    Else
        muSrtmID = RS.fields("muIDsrtm").Value
    End If
    
    
    Dim tbl As clsTable
    Set tbl = globTables("r_position_property")
    
    If InStr(tbl.getFields(False), propName) Then
        Me.bPosProp = True
    Else
        Me.bPosProp = False
    End If
    
    
    If bNew Then
        RS.Close
        Set RS = Nothing
    End If

    loadByPropID = True


Exit Function

ID_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "prop.loadByPropID - Error"

End Function


'/******************************************************************************
Public Sub addFgRow(Optional r As Long = 0)
'/******************************************************************************
    
    On Error GoTo fgpositionsRow_ERR
    
    Dim a As String
    Dim rr As Long
    
    Dim s As String
    
    Dim mutmp As clsMU
    
    If bEditable Then
        Set mutmp = pr.PROP_MU
    Else
        Set mutmp = pr.PROP_MU_SRTM
    End If
    
    
    If mutmp Is Nothing Then
        s = ""
    Else
        s = mutmp.muShortName
    End If
    
    
    If bMassCalc And left(propName, 4) = "mass" Then
        If parentPos.POS_MAT.matID > 0 Then
            matcor = parentPos.POS_MAT.matMassCorrect
        Else
            matcor = -1#
        End If
    Else
        matcor = -1#
    End If
    
    a = propDescr & vbTab & Me.PVAL & vbTab & s & vbTab & "" & vbTab & parentPos.posID
    'a = propDescr & vbTab & Me.PVAL & vbTab & s & vbTab & Format(matcor, "0") & vbTab & parentPos.posID
    
    
    
    If r = 0 Then
        parentPos.fgp.AddItem a
        rr = parentPos.fgp.Rows - 1
    Else
        parentPos.fgp.AddItem a, r
        rr = r
    End If
    
    If IsEmpty(propValue) Or propValue = 0# Then
        parentPos.fgp.Cell(flexcpFontItalic, rr, 1) = True
    End If
    
    parentPos.fgp.MergeRow(rr) = True
    parentPos.fgp.IsSubtotal(rr) = True
    parentPos.fgp.RowOutlineLevel(rr) = 1
    parentPos.fgp.RowData(rr) = propName
    
    If propName = "length" Then
        Dim bLap As Boolean
        Call parentPos.getPosLength(parentPos.bCalcLap, bLap)
        parentPos.fgp.Cell(flexcpFontUnderline, rr, 1) = bLap
    End If
    
    
    
    If bEditable Then
        parentPos.fgp.Cell(flexcpBackColor, rr, 0) = lngGrey
    Else
        parentPos.fgp.Cell(flexcpBackColor, rr, 0, rr, 1) = lngGrey
    End If
    
    If bMassCalc Then
    
        If matcor > 0# Then
            parentPos.fgp.Cell(flexcpBackColor, rr, 0, rr, 1) = lngFiolet
        Else
            parentPos.fgp.Cell(flexcpBackColor, rr, 0) = lngFiolet
        End If
    End If
    
    
    Exit Sub
    
fgpositionsRow_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "fgpositionsRow - Error"
    
End Sub


'/******************************************************************************
Public Sub save()
'/******************************************************************************
    
    On Error GoTo save_ERR
    
    If Not bEditable Then Exit Sub ' from sortament
    
    
    PVAL = propValue
    
    
    
    Exit Sub
    
save_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "save - Error"
    
End Sub

'/******************************************************************************
Public Function getReinStringValue() As String
'/******************************************************************************

    On Error GoTo getReinValue_ERR

    If propvalName = "double" Then
        If IsEmpty(propValue) Or propValue = 0# Then
            getReinStringValue = ""
        Else
            getReinStringValue = propValue
        End If
    ElseIf propvalName = "string" Then
        If Len(Trim(propValue)) = 0 Then
            getReinStringValue = ""
        Else
            getReinStringValue = propValue
        End If
    ElseIf propvalName = "id" Then
        If IsEmpty(propValue) Or propValue = 0 Then
            getReinStringValue = ""
        Else
            getReinStringValue = propValue
        End If
    Else
        If CBool(propValue) Then
            getReinStringValue = propValue
        Else
            getReinStringValue = ""
        End If
    End If

Exit Function

getReinValue_ERR:
getReinStringValue = ""

End Function


'/******************************************************************************
Public Property Get PROP_MU() As clsMU
'/******************************************************************************

    On Error GoTo PROP_MU_ERR
    
    If muID = 0 Then GoTo PROP_MU_ERR
    
    Set PROP_MU = globMUnits(CStr(muID))

Exit Property

PROP_MU_ERR:
    Set PROP_MU = New clsMU

End Property


Public Property Get PROP_MU_SRTM() As clsMU

    On Error GoTo PROP_MU_ERR
    
    If muSrtmID = 0 Then
        Set PROP_MU_SRTM = PROP_MU
    Else
        Set PROP_MU_SRTM = globMUnits(CStr(muSrtmID))
    End If

Exit Property

PROP_MU_ERR:
    Set PROP_MU_SRTM = New clsMU


End Property

Private Sub Class_Initialize()

    matcor = -1#

End Sub
