Attribute VB_Name = "Module1"
Option Explicit

Public userID As Long
Public cn As New ADODB.Connection
Public strFIO(1 To 3) As String


Sub main()

    Dim strLogin As String
    strLogin = GetThreadUserName
    
    
    If Not tryToConnectDB Then
        MsgBox "   Нет возможности подключиться к базе данных   ", vbCritical, "Ошибка"
        Exit Sub
    End If
    
    userID = selectLongFromBase(cn, "user", "userID", "userLogin", strLogin)
    
    If userID = 0 Then
        MsgBox "   В базе данных не найден пользователь " & strLogin & "   "
        Exit Sub
    End If
    
'    groupID = selectLongFromBase(cn, "ns_user", "groupID", "userID", userID)
'    strGroupName = selectStringFromBase(cn, "ns_group", "groupName", "groupID", groupID)
    
    
'    If Not (groupID = 2 Or groupID = 1) Then
'        MsgBox "   Группа '" & strGroupName & "' пользователя '" & strLogin & "' не соответствует запускаемому приложению   ", vbCritical, "Ошибка"
'        Exit Sub
'    End If
    
    strFIO(1) = selectStringFromBase(cn, "user", "userFName", "userID", userID)
    strFIO(2) = selectStringFromBase(cn, "user", "userName", "userID", userID)
    strFIO(3) = selectStringFromBase(cn, "user", "userOName", "userID", userID)
    
    Load F1
    F1.Caption = "Oftake II - " & strFIO(1) & " " & strFIO(2) & " " & strFIO(3) & " "
    F1.Show


End Sub



'/******************************************************************************
Public Function tryToConnectDB() As Boolean
'/******************************************************************************

    tryToConnectDB = False
    
    On Error GoTo m2
    
    Dim strCn As String
    Dim strPath As String
    
    Dim shlShell As Shell32.Shell
    Dim shlFolder As Shell32.Folder
    Const BIF_RETURNONLYFSDIRS = &H1
    
    strPath = GetSetting("PartsBase", "Common", "Path", "")
    
    If strPath = "" Then
        Set shlShell = New Shell32.Shell
        Set shlFolder = shlShell.BrowseForFolder(0, "Select a Folder", BIF_RETURNONLYFSDIRS)
        If shlFolder Is Nothing Then
            tryToConnectDB = False
            Exit Function
        End If
        strPath = shlFolder.Self.Path
       
        
    End If
    
    
    strCn = "Provider=Microsoft.Jet.OLEDB.4.0" & ";"
    strCn = strCn & "Data Source=" & strPath & "\main2003.so2" & ";"
    strCn = strCn & "Persist Security Info=True" & ";"
    strCn = strCn & "Jet OLEDB:System database=" & strPath & "\main2003.mdw"
    
    
'    cn.Open "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=so2user;Initial Catalog=parts;Data Source=aep-10.spbaep.ru;Net=dbmssocn", "so2user", "so2user"
    cn.Open strCn, "Admin", ""
    
    SaveSetting "PartsBase", "Common", "Path", strPath
    tryToConnectDB = True
    
    Exit Function

m2:
    If Err.Number = 3705 Then ' уже открыто
        tryToConnectDB = True
    End If

End Function



'/******************************************************************************
Public Function selectStringFromBase(conn As ADODB.Connection, strTable As String, strFieldToReturn As String, strWhereField As String, whereFieldValue As Variant) As String
'/******************************************************************************

    On Error GoTo m100

    Dim RS As New ADODB.Recordset
    
    Dim strSQL As String
    
    strSQL = "select " & strFieldToReturn & " from [" & strTable & "] where [" & strWhereField & "] = "

    If TypeName(whereFieldValue) = "String" Then
        strSQL = strSQL & "'" & Trim(whereFieldValue) & "'"
    ElseIf TypeName(whereFieldValue) = "Integer" Or TypeName(whereFieldValue) = "Long" Or TypeName(whereFieldValue) = "Double" Then
        strSQL = strSQL & Trim(Str(whereFieldValue))
    Else
        GoTo m100
    End If
    
    RS.Open strSQL, conn, adOpenStatic, adLockReadOnly
    
    If RS.RecordCount = 0 Then GoTo m100
    
    RS.MoveFirst
    
    selectStringFromBase = RS.Fields(strFieldToReturn).Value & ""



    Exit Function
m100:
    selectStringFromBase = ""


End Function

'/******************************************************************************
Public Function selectLongFromBase(conn As ADODB.Connection, strTable As String, strFieldToReturn As String, strWhereField As String, whereFieldValue As Variant) As Long
'/******************************************************************************
    
    On Error GoTo m100
    
    Dim RS As New ADODB.Recordset
    
    Dim strSQL As String
    
    strSQL = "select " & strFieldToReturn & " from [" & strTable & "] where [" & strWhereField & "] = "
    
    If TypeName(whereFieldValue) = "String" Then
        strSQL = strSQL & "'" & Trim(whereFieldValue) & "'"
    ElseIf TypeName(whereFieldValue) = "Integer" Or TypeName(whereFieldValue) = "Long" Or TypeName(whereFieldValue) = "Double" Then
        strSQL = strSQL & Trim(Str(whereFieldValue))
    Else
        GoTo m100
    End If
    
    RS.Open strSQL, conn, adOpenStatic, adLockReadOnly
    
    If RS.RecordCount = 0 Then GoTo m100
    
    RS.MoveFirst
    
    selectLongFromBase = RS.Fields(strFieldToReturn).Value
    
    
    
    Exit Function
m100:
    selectLongFromBase = 0
    
    
End Function
