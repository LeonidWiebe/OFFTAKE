VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsMat"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public matID As Long
Public matStdID As Long
Public matName As String
Public armClassID As Long
Public matScndID As Long ' вторичный

Public matMassCorrect As Double


'Public matStd As clsStd
Public pdc As Collection

Public sortNum As Integer


Public bChanged As Boolean
Public bUsing As Boolean


'/******************************************************************************
Public Function getClass(Optional bNew As Boolean = True, Optional bOld As Boolean = False) As String
'/******************************************************************************
    
    On Error GoTo getClass_ERR
    
    Dim str As String
    
'    If usrCurrent.depID = 3 Then
'
'        getClass = ARM_CLASS.armClassOldName
'
'    Else
    
        If bNew And Not bOld Then
            getClass = ARM_CLASS.armClassName
        ElseIf Not bNew And bOld Then
            getClass = ARM_CLASS.armClassOldName
        ElseIf bNew And bOld Then
        
            If Len(ARM_CLASS.armClassName) > 0 And Len(ARM_CLASS.armClassOldName) > 0 Then
                getClass = ARM_CLASS.armClassName & "(" & ARM_CLASS.armClassOldName & ")"
            ElseIf Len(ARM_CLASS.armClassName) > 0 Then
                getClass = ARM_CLASS.armClassName
            ElseIf Len(ARM_CLASS.armClassName) > 0 Then
                getClass = ARM_CLASS.armClassOldName
            Else
                getClass = ""
            End If
            
        Else
            getClass = ""
        End If
    
        
'    End If
    
    
    
    
    
    Exit Function
    
getClass_ERR:
    getClass = ""
    '    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, " - Error"
    
End Function


'/******************************************************************************
Public Function getReinMatName(Optional bTranslate As Boolean = False) As String
'/******************************************************************************
    
    
    On Error GoTo getReinMatName_ERR
    
    Dim str As String
    
    
    If bTranslate Then
        getReinMatName = getTrans(matName, "", 2)
    Else
        getReinMatName = matName
    End If
    
    If Len(Trim(ARM_CLASS.armClassName)) = 0 Then Exit Function
    
    If Len(Trim(matName)) = 0 Then Exit Function
    

    
    str = Replace(matName, ARM_CLASS.armClassName, "")
    
    
    If bTranslate Then
        getReinMatName = getTrans(str, "", 2)
    Else
        getReinMatName = Trim(str)
    End If
    
    
    Exit Function
    
getReinMatName_ERR:
    getReinMatName = ""
    '    MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "getReinMatName - Error"
    
End Function

Private Sub Class_Initialize()

    Set pdc = New Collection
    
    matMassCorrect = -1#

End Sub

Private Sub Class_Terminate()
    Set pdc = Nothing
End Sub


'/******************************************************************************
Public Function save(ByRef bVarOutExist As Boolean) As Boolean
'/******************************************************************************
    
    On Error GoTo save_ERR
    
    save = False
    
'    If matStd Is Nothing Then Exit Function
'    If matStdID = 0 Then Exit Function
    If Len(Trim(Me.matName)) = 0 Then Exit Function
    
    Dim maxSort As Long
    
    
    Dim RS As New ADODB.Recordset
    Dim RSms As New ADODB.Recordset
    
    RSms.Open "select max(matSortNumber) as [msn] from material", cn_srtm, adOpenForwardOnly, adLockOptimistic
    
    If Not RSms.EOF Then
        RSms.MoveFirst
        maxSort = RSms.fields("msn").Value
    End If
    
    RSms.Close
    Set RSms = Nothing
    
    RS.Open "select * from material where matID = " & matID, cn_srtm, adOpenForwardOnly, adLockOptimistic
    
    If RS.EOF Then
        bVarOutExist = False
        RS.NextRecordset
        RS.Open "select top 1 * from material order by matID desc", cn_srtm, adOpenForwardOnly, adLockOptimistic
        RS.AddNew
        RS.fields("stdID").Value = matStdID
        RS.fields("matName").Value = Trim(matName)
        RS.fields("matSortNumber").Value = maxSort + 10
        RS.fields("armclassID").Value = ARM_CLASS.armClassID
        If matMassCorrect <= 0# Then RS.fields("matMassCorrect").Value = Null Else RS.fields("matMassCorrect").Value = matMassCorrect
        RS.Update
        RS.Requery
        RS.MoveFirst
        matID = RS.fields("matID").Value
        writeOperationS operCreate, "material", matID, "создание"
    Else
        bVarOutExist = True
        RS.MoveFirst
        RS.fields("stdID").Value = matStdID
        RS.fields("matName").Value = Trim(matName)
        RS.fields("armclassID").Value = ARM_CLASS.armClassID
        If matMassCorrect <= 0# Then RS.fields("matMassCorrect").Value = Null Else RS.fields("matMassCorrect").Value = matMassCorrect
        RS.Update
        writeOperationS operModify, "material", matID, "изменение"
    End If
    
    
    RS.Close
    Set RS = Nothing
    
    updateMatSortSequence
    
    bChanged = False
    save = True
    
    Exit Function
    
save_ERR:
    Set RS = Nothing
    save = False
    
End Function


Public Sub updateMatSortSequence()


    Dim usn As Long
    Dim RS As New ADODB.Recordset
    
    usn = 0


    RS.Open "select * from material order by matSortNumber", cn_srtm, adOpenKeyset, adLockBatchOptimistic
    If Not RS.EOF Then
        RS.MoveFirst
        Do
            usn = usn + 10
            RS.fields("matSortNumber").Value = usn
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    RS.UpdateBatch
    
    RS.Close
    Set RS = Nothing


End Sub


'/******************************************************************************
Public Property Get ARM_CLASS() As clsArmClass
'/******************************************************************************

    On Error GoTo ARM_CLASS_ERR
    
    Set ARM_CLASS = globArmClasses(CStr(armClassID))


Exit Property

ARM_CLASS_ERR:
    Set ARM_CLASS = New clsArmClass

End Property


'/******************************************************************************
Public Property Get MAT_STD() As clsStd
'/******************************************************************************

    On Error GoTo MAT_STD_ERR
    
    Set MAT_STD = globStds(CStr(matStdID))


Exit Property

MAT_STD_ERR:
    Set MAT_STD = New clsStd

End Property



'/******************************************************************************
Public Function loadMatPosDefs() As Boolean
'/******************************************************************************

    On Error GoTo loadMatPosDefs_ERR

    Dim RS As New ADODB.Recordset

    RS.Open "select * from r_posdef_material where matID = " & matID, cn_srtm, adOpenForwardOnly, adLockReadOnly
    
    Set pdc = New Collection
    
    If Not RS.EOF Then
        
        RS.MoveFirst
        Do
            pdc.Add globPosdefs(CStr(RS.fields("posdefID").Value))
            
            RS.MoveNext
        Loop Until RS.EOF
        
    End If
    
    RS.Close
    Set RS = Nothing



    loadMatPosDefs = True

Exit Function

loadMatPosDefs_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, " - Error"

End Function



'/******************************************************************************
Public Function loadMat(RSfrom As ADODB.Recordset, ID As Long) As Boolean
'/******************************************************************************

    On Error GoTo loadMat_ERR

    Dim RS As ADODB.Recordset

    If RSfrom Is Nothing Then
        Set RS = New ADODB.Recordset
        If bUseCursorClient Then RS.CursorLocation = adUseClient
        RS.Open "select * from material where matID = " & ID, cn_srtm, adOpenForwardOnly, adLockReadOnly
        If Not RS.EOF Then RS.MoveFirst
    Else
        Set RS = RSfrom
    End If
    
    If Not RS.EOF Then
        
        matID = RS.fields("matID").Value
        matName = RS.fields("matName").Value
        bUsing = CBool(RS.fields("matUsing").Value)
        sortNum = RS.fields("matSortNumber").Value
        matStdID = RS.fields("stdID").Value
        matScndID = RS.fields("matScndID").Value
        
        If Not IsNull(RS.fields("armclassID").Value) Then armClassID = RS.fields("armclassID").Value Else armClassID = 0
        
        If Not IsNull(RS.fields("matMassCorrect").Value) Then matMassCorrect = RS.fields("matMassCorrect").Value Else matMassCorrect = -1#
        
    End If
    
    
    If RSfrom Is Nothing Then
        RS.Close
        Set RS = Nothing
    End If

    loadMat = True


Exit Function

loadMat_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadMat - Error"

End Function


'/******************************************************************************
Public Property Get MAT_SCND() As clsMat
'/******************************************************************************

    On Error GoTo MAT_SCND_ERR
    
    If Me.matScndID > 0 Then
        Set MAT_SCND = globMats(CStr(matScndID))
    Else
        Set MAT_SCND = New clsMat
    End If

Exit Property

MAT_SCND_ERR:
    Set MAT_SCND = New clsMat

End Property
