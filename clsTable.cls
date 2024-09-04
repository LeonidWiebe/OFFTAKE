VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public cols As Collection
Public sTableName As String
Public sKeyFieldName As String
Public KEY As Long

Public bCopyExist As Boolean


'/******************************************************************************
Public Sub loadFields()
'/******************************************************************************
    
    On Error GoTo loadFields_ERR
    
    Set cols = New Collection
    
    
    Dim strSQL As String
    
    
    
    strSQL = "SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" & sTableName & "'"
    
    Dim RS As New ADODB.Recordset
    
    RS.Open strSQL, cn_data, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        
        RS.MoveFirst
        Do
            
            
            cols.Add RS.fields("COLUMN_NAME").Value ' первый - ID
            
            RS.MoveNext
        Loop Until RS.EOF
    End If
    
    RS.Close
    Set RS = Nothing
    
    
    
    
    
    Exit Sub
    
loadFields_ERR:
    MsgBox "[" & err.Number & "] " & err.Description, vbInformation, "loadFields - Error"
    
End Sub

Private Sub Class_Initialize()
    
    Set cols = New Collection
    
End Sub

Private Sub Class_Terminate()

    Set cols = Nothing

End Sub


'/******************************************************************************
Public Function getFields(bAddBrackets As Boolean, _
                            Optional sFieldPrefix As String = "", _
                            Optional bInclTable As Boolean = False, _
                            Optional sExcField1 As String = "", _
                            Optional sExcField2 As String = "", _
                            Optional sExcField3 As String = "") As String
'/******************************************************************************
    
    On Error GoTo getFields_ERR
    
    
    Dim i As Integer
    Dim s As String
    Dim ss As String
    Dim sret As String
    
    
    
    If cols Is Nothing Then Exit Function
    
    For i = 1 To cols.Count
        s = cols(i)
        
        If Len(Trim(sExcField1)) > 0 And LCase(Trim(s)) = LCase(Trim(sExcField1)) Then GoTo cont
        If Len(Trim(sExcField2)) > 0 And LCase(Trim(s)) = LCase(Trim(sExcField2)) Then GoTo cont
        If Len(Trim(sExcField3)) > 0 And LCase(Trim(s)) = LCase(Trim(sExcField3)) Then GoTo cont
        If bInclTable Then s = Me.sTableName & "." & s
        If Len(Trim(sFieldPrefix)) > 0 Then s = sFieldPrefix & s
        
        If bAddBrackets Then s = "[" & s & "]"
        If bAddBrackets Then ss = "[" & sKeyFieldName & "]"
        
        
        If Len(sKeyFieldName) = 0 Then
            If i = 1 Then GoTo cont ' по умолчанию считаем что ID на первом месте
        Else
            If s = ss Then GoTo cont
        End If
        
        If Len(sret) > 0 Then sret = sret & ","
        sret = sret & s
        
cont:
        
    Next i
    
    getFields = sret
    
    Exit Function
    
    
getFields_ERR:
    getFields = ""
    
End Function


'/******************************************************************************
Public Function createUndoTable() As Boolean
'/******************************************************************************

    On Error GoTo createUndoTable_ERR

    Dim strSQL As String

    strSQL = "SELECT TOP 0 * INTO #" & sTableName & " FROM " & sTableName
    
    Dim cmd As New ADODB.Command
    cmd.ActiveConnection = cn_data
    cmd.CommandText = strSQL
    cmd.Execute
    
    bCopyExist = True


Exit Function

createUndoTable_ERR:

End Function
