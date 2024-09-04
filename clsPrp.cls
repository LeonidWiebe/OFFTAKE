VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsPrp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'аналог clsProp, идущий на замену


Public propID As Long
Public propName As String
Public propDescr As String
Public propvalName As String
Public propK As Double

Public muID As Long
Public muIDover As Long

Public propValue As Variant
Public propDefValue As Variant

Public colValues As Collection

Public parentObj As IUnknown

Public OK As Boolean

Public bEditable As Boolean
Public bMassCalc As Boolean


Public sTableName As String


Public iSortOrder As Integer ' исп. только в pd_props для редактирования сортировки в frmPosdef


Public bAddedByUser As Boolean

'Public Property Let u(ByVal v As Double)
'End Property

Public propObjID As Long

'/*****************************************************
Public Function makeClone() As clsPrp
'/*****************************************************

    On Error GoTo fromExisting_ERR

    Dim pNew As New clsPrp

    If Not Me.muID = 0 Then pNew.muID = Me.muID
    pNew.muIDover = Me.muIDover

    Set pNew.parentObj = Me.parentObj

    pNew.bEditable = Me.bEditable
    pNew.bMassCalc = Me.bMassCalc
    pNew.OK = Me.OK
    pNew.propDefValue = Me.propDefValue
    pNew.propDescr = Me.propDescr
    pNew.propID = Me.propID
    pNew.propK = Me.propK
    pNew.propName = Me.propName
    pNew.propvalName = Me.propvalName
    pNew.propValue = Me.propValue
    pNew.sTableName = Me.sTableName
    pNew.propObjID = Me.propObjID

    Set makeClone = pNew

    Set pNew = Nothing


Exit Function

fromExisting_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "fromExisting - Error"

End Function


'/******************************************************************************
Public Function setPrpValue(v As Variant, Optional secID As Long = 0) As Boolean
'/******************************************************************************
    
    On Error GoTo setValue_ERR


    On Error GoTo setValue_ERR
    
    Dim vv As Variant
    Dim s As Variant
    
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
        ElseIf propvalName = "secid" Then
            For Each s In colValues
                If s = CStr(secID) Then
                    If secID > 0 Then colValues.Remove (CStr(secID))
                    Exit For
                End If
            Next s
        Else
            propValue = v
        End If
        
    Else
        If propvalName = "secid" Then
            For Each s In colValues ' проверяем есть ли уже такой
                If s = CStr(secID) Then
                    s = "0"
                    Exit For
                End If
            Next s
            If s <> "0" Then
                If secID > 0 Then colValues.Add CStr(secID), CStr(secID)
            End If
        Else
            propValue = v
        End If
    
    End If
    
    
    
    
    setPrpValue = True
    
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
        PVAL_SI = propValue
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
    ElseIf propvalName = "secid" Then
        PVAL_SI = PVAL
    Else
        PVAL_SI = Empty
    End If



Exit Property

PVAL_SI_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "PVAL_SI - Error"

End Property

'/******************************************************************************
Public Function hasListValue(prlistID As Long) As Boolean
'/******************************************************************************

    On Error GoTo hasListValue_ERR

    If propvalName = "secid" Then
        Dim s As String
        s = colValues(CStr(prlistID))
        hasListValue = True
        Exit Function
    End If

    hasListValue = False

Exit Function

hasListValue_ERR:
    hasListValue = False

End Function


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
    ElseIf propvalName = "secid" Then
        hasValue = (colValues.Count > 0)
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
    
    Dim secID As Long
    Dim I As Integer
    Dim s As Variant
    Dim ss As String
    
    If propvalName = "double" Or propvalName = "long" Then
        If IsEmpty(propValue) Or propValue = 0# Then
            PVAL = propDefValue
        Else
            PVAL = propValue
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
        
        Else
        
            secID = 0
            For I = 0 To UBound(prplisttypes)
                If prplisttypes(I).plID = propValue Then
                    s = prplisttypes(I).plValue
                    secID = -1
                    Exit For
                End If
            Next I
            If secID = -1 Then ' found
                PVAL = s
            Else
                PVAL = ""
            End If
        
        End If
    
    ElseIf propvalName = "secid" Then
        
        For Each s In colValues
            secID = CLng(s)
            For I = 0 To UBound(prplisttypes)
                If prplisttypes(I).plID = secID Then
                    s = prplisttypes(I).plValue
                    secID = -1
                    Exit For
                End If
            Next I
            If secID = -1 Then ' found
                If Len(ss) > 0 Then ss = ss & vbNewLine
                ss = ss & s
            End If
        Next s
        PVAL = ss
    Else
        PVAL = Empty
    End If
    
    
    
    
    
    
    Exit Property
    
PVAL_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "PVAL - Error"
    
End Property




'/******************************************************************************
Public Function saveValue() As Boolean
'/******************************************************************************

    On Error GoTo saveValue_ERR

    Dim sFieldName As String
    sFieldName = propName

    Dim rm As clsRoom
    Dim objname As String
    Dim sIDname As String
    Dim ID  As Long
    
    If typeName(Me.parentObj) = "clsRoom" Then
        Set rm = Me.parentObj
        objname = "room"
        sIDname = "roomID"
        ID = rm.simID
    Else
        Exit Function
    End If




    Dim RS As New ADODB.Recordset

    RS.Open "select * from " & Me.sTableName & " where " & sIDname & " = " & ID, cn_data, adOpenForwardOnly, adLockOptimistic

    If RS.EOF Then
        ' insert value

        If Me.hasValue() Then

            RS.AddNew
            RS.Fields(sIDname).Value = ID
            RS.Fields(sFieldName).Value = propValue
            RS.Update
            Call writeOperationS(operModify, objname, ID, propDescr & " = " & PVAL)

        End If
    Else
        ' update value

        If Me.bEditable Then

            If Not Me.hasValue() Then ' обнуление

                RS.MoveFirst
                If IsNull(RS.Fields(sFieldName).Value) Then
                Else
                    RS.Fields(sFieldName).Value = Null
                    RS.Update
                    Call writeOperationS(operModify, objname, ID, "обнуление " & propDescr)
                End If
                
            Else

                RS.MoveFirst
                
                Dim bUpdate As Boolean
                
                bUpdate = False
                
                If IsNull(RS.Fields(sFieldName).Value) Then
                    bUpdate = True
                Else
                    If RS.Fields(sFieldName).Value <> propValue Then ' занчение идентично, не сохраняем
                        bUpdate = True
                    End If
                End If
                
                If bUpdate Then
                    RS.Fields(sFieldName).Value = propValue
                    RS.Update
                    Call writeOperationS(operModify, objname, ID, propDescr & " = " & PVAL)
                End If

            End If

        End If

    End If


    RS.Close
    Set RS = Nothing
    
    
    saveValue = True



Exit Function

saveValue_ERR:
    If bMainFormLoaded Then F1.SB.Panels("status").text = "saveValue" & "() - " & err.Description

End Function
''/******************************************************************************
'
'    On Error GoTo VALUE_ERR
'
'    Dim sFieldName As String
'    sFieldName = propName
'
'    If typeName(v) = "String" Then
'        If Len(v) = 0 Then v = Empty
'    Else
'        If v <= 0 Then v = Empty
'    End If
'
''    Dim strPosTable As String
''
''    If Me.parentPos Is Nothing Then
''        strPosTable = "position"
''    Else
''        strPosTable = Me.parentPos.POS_SRC_TABLE
''    End If
''
''
''    Dim RS As New ADODB.Recordset
''
''    RS.Open "select * from r_" & strPosTable & "_property where posID = " & parentPos.posID, cn_data, adOpenForwardOnly, adLockOptimistic
''
''    If RS.EOF Then
''        ' insert value
''
''        If Not IsEmpty(v) Then
''
''
''            RS.AddNew
''            RS.Fields("posID").Value = parentPos.posID
''            RS.Fields(sFieldName).Value = v
''            RS.Update
''            Call writeOperationS(operModify, strPosTable, parentPos.posID, propName & " = " & CStr(v))
''
''        End If
''    Else
''        ' update value
''
''        If Me.bEditable Then
''
''            If IsEmpty(v) Then
''
''
''                RS.MoveFirst
''                If IsNull(RS.Fields(sFieldName).Value) Then
''                Else
''                    RS.Fields(sFieldName).Value = Null
''                    RS.Update
''                    Call writeOperationS(operModify, strPosTable, parentPos.posID, "обнуление " & propName)
''                End If
''
''
''
''            Else
''
''                RS.MoveFirst
''                If Val(RS.Fields(sFieldName).Value & "") = v Then
''                Else
''                    RS.Fields(sFieldName).Value = v
''                    RS.Update
''                    Call writeOperationS(operModify, strPosTable, parentPos.posID, propName & " = " & CStr(v))
''                End If
''
''            End If
''
''        End If
''
''    End If
''
''
''    RS.Close
''    Set RS = Nothing
'
'    propValue = v
'
'
'    Exit Property
'
'VALUE_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "VALUE - Error"
'
'End Property

'/******************************************************************************
Public Property Set parent(ByVal vData As IUnknown)
'/******************************************************************************

    On Error GoTo POS_ERR
    
    Set parentObj = vData
    
    
    Exit Property
    
POS_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, " - Error"
    
End Property



'/******************************************************************************
Public Function loadByPropID(ByVal ID As Long, Optional ByRef RSin As ADODB.Recordset = Nothing) As Boolean
'/******************************************************************************

On Error GoTo ID_ERR

    Dim RS As ADODB.Recordset

    If RSin Is Nothing Then
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        RS.Open "select * from view_property where propID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RS.EOF Then RS.MoveFirst
    Else
        Set RS = RSin
    End If

    propID = 0
    propName = ""
    OK = False
    
    
    If Not RS.EOF Then
    
        propID = RS.Fields("propID").Value
        propName = RS.Fields("propName").Value
        propDescr = RS.Fields("propDescr").Value
        propvalName = RS.Fields("propvalName").Value
        propDefValue = Val(RS.Fields("propDefValue").Value & "")
        sTableName = RS.Fields("tableName").Value & ""
        propObjID = getFieldLongValue(RS, "objID", 2)
    
        If IsNull(RS.Fields("muID").Value) Then
            muID = 0
        Else
            muID = RS.Fields("muID").Value
        End If
    
        If IsNull(RS.Fields("muIDsrtm").Value) Then
            muIDover = 0
        Else
            muIDover = RS.Fields("muIDsrtm").Value
        End If
        
    End If
    
    
    If RSin Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If

    loadByPropID = True


Exit Function

ID_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "prop.loadByPropID - Error"

End Function



''/******************************************************************************
'Public Sub save()
''/******************************************************************************
'
'    On Error GoTo save_ERR
'
'    If Not bEditable Then Exit Sub ' from sortament
'
'    PVAL = propValue
'
'
'    Exit Sub
'
'save_ERR:
'    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "save - Error"
'
'End Sub

''/******************************************************************************
'Public Function getReinStringValue() As String
''/******************************************************************************
'
'    On Error GoTo getReinValue_ERR
'
'    If propvalName = "double" Then
'        If IsEmpty(propValue) Or propValue = 0# Then
'            getReinStringValue = ""
'        Else
'            getReinStringValue = propValue
'        End If
'    ElseIf propvalName = "string" Then
'        If Len(Trim(propValue)) = 0 Then
'            getReinStringValue = ""
'        Else
'            getReinStringValue = propValue
'        End If
'    ElseIf propvalName = "id" Then
'        If IsEmpty(propValue) Or propValue = 0 Then
'            getReinStringValue = ""
'        Else
'            getReinStringValue = propValue
'        End If
'    Else
'        If CBool(propValue) Then
'            getReinStringValue = propValue
'        Else
'            getReinStringValue = ""
'        End If
'    End If
'
'Exit Function
'
'getReinValue_ERR:
'getReinStringValue = ""
'
'End Function



Public Property Get PROP_MU() As clsMU

    On Error GoTo PROP_MU_ERR
    
    If muIDover > 0 Then
        Set PROP_MU = globMUnits(CStr(muIDover))
    ElseIf muID > 0 Then
        Set PROP_MU = globMUnits(CStr(muID))
    Else
        GoTo PROP_MU_ERR
    End If

Exit Property

PROP_MU_ERR:
    Set PROP_MU = New clsMU


End Property

Private Sub Class_Initialize()

    Set colValues = New Collection
    
    bEditable = True

End Sub

Private Sub Class_Terminate()
    Set colValues = Nothing
End Sub
