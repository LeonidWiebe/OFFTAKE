Attribute VB_Name = "API"
Option Explicit

Public Declare Sub mdlLocate_hiliteElement Lib "stdmdlbltin.dll" (ByVal elemRef As Long, ByVal modelRef As Long)
Public Declare Sub mdlLocate_clearHilited Lib "stdmdlbltin.dll" (ByVal redraw As Long)
Public Declare Function mdlModelRef_getElementRef Lib "stdmdlbltin.dll" (ByVal modelRef As Long, ByVal filePos As Long) As Long
Public Declare Function mdlModelRef_getCache Lib "stdmdlbltin.dll" (ByVal modelRef As Long) As Long
Public Declare Function dgnCache_findElemByID Lib "stdmdlbltin.dll" (ByVal cache As Long, ByVal elementID As Long) As Long

'   цитата из хелпа VBA
'  For design files loaded via OpenDesignFileForProgram it is sometimes necessary  to call UpdateElementDependencyState
Private Declare Function mdlDependency_processAffected Lib "stdmdlbltin.dll" () As Long



'Public Declare Function mdlParams_setActive Lib "stdmdlbltin.dll" (ByVal param As Long, ByVal paramName As Long) As Long

Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Public Declare Function SafeArrayGetDim Lib "oleaut32.dll" (ByRef saArray() As Any) As Long

'================================================================
Public Declare Function GetTickCount Lib "kernel32" () As Long
Public Declare Function GetLastInputInfo Lib "user32" (plii As Any) As Long
Public Type LASTINPUTINFO
    cbSize As Long
    dwTime As Long
End Type
'================================================================

'==========================================================================================================================
Private Declare Function GetUserName Lib "advapi32" Alias "GetUserNameA" (ByVal lpBuffer As String, nSize As Long) As Long
'==========================================================================================================================
'' переменные и функции для работы с реесторм
'Private Declare Function RegCloseKey Lib "advapi32" (ByVal hKey As Long) As Long
'Private Declare Function RegCreateKeyEx Lib "advapi32" Alias "RegCreateKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal Reserved As Long, ByVal lpClass As String, ByVal dwOptions As Long, ByVal samDesired As Long, ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES, ByRef phkResult As Long, ByRef lpdwDisposition As Long) As Long
'Private Declare Function RegOpenKeyEx Lib "advapi32" Alias "RegOpenKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal ulOptions As Long, ByVal samDesired As Long, ByRef phkResult As Long) As Long
'Private Declare Function RegQueryValueEx Lib "advapi32" Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, ByRef lpType As Long, ByVal lpData As Any, ByRef lpcbData As Long) As Long
'Private Declare Function RegSetValueEx Lib "advapi32" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, ByVal lpData As String, ByVal cbData As Long) As Long
'' Reg Data Types...
'Const REG_SZ = 1                         ' Unicode nul terminated string
'Const REG_EXPAND_SZ = 2                  ' Unicode nul terminated string
'Const REG_DWORD = 4                      ' 32-bit number
'' Reg Create Type Values...
'Const REG_OPTION_NON_VOLATILE = 0       ' Key is preserved when system is rebooted
'' Reg Key Security Options...
'Const READ_CONTROL = &H20000
'Const KEY_QUERY_VALUE = &H1
'Const KEY_SET_VALUE = &H2
'Const KEY_CREATE_SUB_KEY = &H4
'Const KEY_ENUMERATE_SUB_KEYS = &H8
'Const KEY_NOTIFY = &H10
'Const KEY_CREATE_LINK = &H20
'Const KEY_READ = KEY_QUERY_VALUE + KEY_ENUMERATE_SUB_KEYS + KEY_NOTIFY + READ_CONTROL
'Const KEY_WRITE = KEY_SET_VALUE + KEY_CREATE_SUB_KEY + READ_CONTROL
'Const KEY_EXECUTE = KEY_READ
'Const KEY_ALL_ACCESS = KEY_QUERY_VALUE + KEY_SET_VALUE + _
'KEY_CREATE_SUB_KEY + KEY_ENUMERATE_SUB_KEYS + _
'KEY_NOTIFY + KEY_CREATE_LINK + READ_CONTROL
'' Reg Key ROOT Types...
'Public Const HKEY_CLASSES_ROOT = &H80000000
'Public Const HKEY_CURRENT_USER = &H80000001
'Public Const HKEY_LOCAL_MACHINE = &H80000002
'Public Const HKEY_USERS = &H80000003
'Public Const HKEY_PERFORMANCE_DATA = &H80000004
'' Return Value...
'Const ERROR_NONE = 0
'Const ERROR_BADKEY = 2
'Const ERROR_ACCESS_DENIED = 8
'Const ERROR_SUCCESS = 0
'Private Type SECURITY_ATTRIBUTES
'       nLength As Long
'       lpSecurityDescriptor As Long
'       bInheritHandle As Boolean
'End Type
'==========================================================================================================================
Public Type POINTAPI
    X As Long
    Y As Long
End Type
Public Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Public Declare Function ScreenToClient Lib "user32" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long
Public Declare Function ClientToScreen Lib "user32" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long
'==========================================================================================================================

Public Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As Any, ByVal lpWindowName As Any) As Long
Public Declare Function SetForegroundWindow Lib "user32" (ByVal hwnd As Long) As Long


'===========================================================
' переменные для открытия файлов
Public Type OPENFILENAME
       lStructSize As Long
       hWndOwner As Long
       hInstance As Long
       lpstrFilter As String
       lpstrCustomFilter As String
       nMaxCustFilter As Long
       nFilterIndex As Long
       lpstrFile As String
       nMaxFile As Long
       lpstrFileTitle As String
       nMaxFileTitle As Long
       lpstrInitialDir As String
       lpstrTitle As String
       flags As Long
       nFileOffset As Integer
       nFileExtension As Integer
       lpstrDefExt As String
       lCustData As Long
       lpfnHook As Long
       lpTemplateName As String
End Type

Public Enum OFN_FLAGS
    OFN_READONLY = &H1
    OFN_OVERWRITEPROMPT = &H2
    OFN_HIDEREADONLY = &H4
    OFN_NOCHANGEDIR = &H8
    OFN_SHOWHELP = &H10
    OFN_ENABLEHOOK = &H20
    OFN_ENABLETEMPLATE = &H40
    OFN_ENABLETEMPLATEHANDLE = &H80
    OFN_NOVALIDATE = &H100
    OFN_ALLOWMULTISELECT = &H200
    OFN_EXTENSIONDIFFERENT = &H400
    OFN_PATHMUSTEXIST = &H800
    OFN_FILEMUSTEXIST = &H1000
    OFN_CREATEPROMPT = &H2000
    OFN_SHAREAWARE = &H4000
    OFN_NOREADONLYRETURN = &H8000
    OFN_NOTESTFILECREATE = &H10000
    OFN_NONETWORKBUTTON = &H20000
    OFN_NOLONGNAMES = &H40000
    OFN_EXPLORER = &H80000
    OFN_NODEREFERENCELINKS = &H100000
    OFN_LONGNAMES = &H200000
End Enum


'typedef struct tagOFN {
'  DWORD         lStructSize;
'  HWND          hwndOwner;
'  HINSTANCE     hInstance;
'  LPCTSTR       lpstrFilter;
'  LPTSTR        lpstrCustomFilter;
'  DWORD         nMaxCustFilter;
'  DWORD         nFilterIndex;
'  LPTSTR        lpstrFile;
'  DWORD         nMaxFile;
'  LPTSTR        lpstrFileTitle;
'  DWORD         nMaxFileTitle;
'  LPCTSTR       lpstrInitialDir;
'  LPCTSTR       lpstrTitle;
'  DWORD         Flags;
'  WORD          nFileOffset;
'  WORD          nFileExtension;
'  LPCTSTR       lpstrDefExt;
'  LPARAM        lCustData;
'  LPOFNHOOKPROC lpfnHook;
'  LPCTSTR       lpTemplateName;
'#if (_WIN32_WINNT >= 0x0500)
'  void *        pvReserved;
'  DWORD         dwReserved;
'  DWORD         FlagsEx;
'#endif // (_WIN32_WINNT >= 0x0500)
'} OPENFILENAME, *LPOPENFILENAME;

Private Declare Function GetSystemMenu Lib "user32" _
    (ByVal hwnd As Long, _
     ByVal bRevert As Long) As Long

Private Declare Function RemoveMenu Lib "user32" _
    (ByVal hMenu As Long, _
     ByVal nPosition As Long, _
     ByVal wFlags As Long) As Long
     
Private Const MF_BYPOSITION = &H400&

Public Declare Function GetOpenFileName Lib "comdlg32.dll" Alias "GetOpenFileNameA" (pOpenfilename As OPENFILENAME) As Long
Public Declare Function GetSaveFileName Lib "comdlg32.dll" Alias "GetSaveFileNameA" (pOpenfilename As OPENFILENAME) As Long

Private Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, nSize As Long) As Long

Private Const MAX_COMPUTERNAME_LENGTH As Long = 15&


Private Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, _
    ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, _
    ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long

Const SWP_NOSIZE = &H1
Const SWP_NOMOVE = &H2
Const SWP_SHOWWINDOW = &H40
Const HWND_NOTOPMOST = -2
Const HWND_TOPMOST = -1

'================ CLIPBOARD ======================================================

Private Declare Function OpenClipboard Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function CloseClipboard Lib "user32" () As Long
Private Declare Function EmptyClipboard Lib "user32" () As Long
Private Declare Function GetClipboardData Lib "user32" (ByVal wFormat As Long) As Long
Private Declare Function SetClipboardData Lib "user32" (ByVal wFormat As Long, ByVal hMem As Long) As Long
Private Declare Function IsClipboardFormatAvailable Lib "user32" (ByVal wFormat As Long) As Long

Public Enum ECustomClipboardErrorConstant
   eccErrorBase = vbObjectError + 1048 + 521
   eccClipboardNotOpen
   eccCantOpenClipboard
End Enum

' Memory functions:
Private Declare Function GlobalAlloc Lib "kernel32" (ByVal wFlags As Long, ByVal dwBytes As Long) As Long
Private Declare Function GlobalFree Lib "kernel32" (ByVal hMem As Long) As Long
Private Declare Function GlobalLock Lib "kernel32" (ByVal hMem As Long) As Long
Private Declare Function GlobalReAlloc Lib "kernel32" (ByVal hMem As Long, ByVal dwBytes As Long, ByVal wFlags As Long) As Long
Private Declare Function GlobalSize Lib "kernel32" (ByVal hMem As Long) As Long
Private Declare Function GlobalUnlock Lib "kernel32" (ByVal hMem As Long) As Long
Private Const GMEM_DDESHARE = &H2000
Private Const GMEM_DISCARDABLE = &H100
Private Const GMEM_DISCARDED = &H4000
Private Const GMEM_FIXED = &H0
Private Const GMEM_INVALID_HANDLE = &H8000
Private Const GMEM_LOCKCOUNT = &HFF
Private Const GMEM_MODIFY = &H80
Private Const GMEM_MOVEABLE = &H2
Private Const GMEM_NOCOMPACT = &H10
Private Const GMEM_NODISCARD = &H20
Private Const GMEM_NOT_BANKED = &H1000
Private Const GMEM_NOTIFY = &H4000
Private Const GMEM_SHARE = &H2000
Private Const GMEM_VALID_FLAGS = &H7F72
Private Const GMEM_ZEROINIT = &H40
Private Const GPTR = (GMEM_FIXED Or GMEM_ZEROINIT)
Private Const GMEM_LOWER = GMEM_NOT_BANKED
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (lpvDest As Any, lpvSource As Any, ByVal cbCopy As Long)
Private Declare Sub CopyMemoryStr Lib "kernel32" Alias "RtlMoveMemory" (lpvDest As Any, ByVal lpvSource As String, ByVal cbCopy As Long)
Private Declare Sub CopyMemoryToStr Lib "kernel32" Alias "RtlMoveMemory" (ByVal lpvDest As String, pvSource As Any, ByVal cbCopy As Long)
Private Declare Function lstrlenW Lib "kernel32.dll" (lpString As Any) As Long
' Members:
Private m_lId()         As Long
Private m_sName()       As String
Private m_iCount        As Long
Private m_bClipboardIsOpen As Boolean
Private m_hWnd          As Long


'===================================================================================

Private Const CREATE_DEFAULT_ERROR_MODE = &H4000000

Private Const LOGON_WITH_PROFILE = &H1
Private Const LOGON_NETCREDENTIALS_ONLY = &H2

Private Const LOGON32_LOGON_INTERACTIVE = 2
Private Const LOGON32_PROVIDER_DEFAULT = 0
   
Private Const INFINITE = &HFFFF

Private Type STARTUPINFO
    cb As Long
    lpReserved As Long ' !!! must be Long for Unicode string
    lpDesktop As Long  ' !!! must be Long for Unicode string
    lpTitle As Long    ' !!! must be Long for Unicode string
    dwX As Long
    dwY As Long
    dwXSize As Long
    dwYSize As Long
    dwXCountChars As Long
    dwYCountChars As Long
    dwFillAttribute As Long
    dwFlags As Long
    wShowWindow As Integer
    cbReserved2 As Integer
    lpReserved2 As Long
    hStdInput As Long
    hStdOutput As Long
    hStdError As Long
End Type

Private Type PROCESS_INFORMATION
    hProcess As Long
    hThread As Long
    dwProcessId As Long
    dwThreadId As Long
End Type

' CreateProcessWithLogonW API is available only on Windows 2000 and later.
Private Declare Function CreateProcessWithLogonW Lib "advapi32.dll" _
        (ByVal lpUsername As String, _
        ByVal lpDomain As String, _
        ByVal lpPassword As String, _
        ByVal dwLogonFlags As Long, _
        ByVal lpApplicationName As Long, _
        ByVal lpCommandLine As String, _
        ByVal dwCreationFlags As Long, _
        ByVal lpEnvironment As Long, _
        ByVal lpCurrentDirectory As String, _
        ByRef lpStartupInfo As STARTUPINFO, _
        ByRef lpProcessInformation As PROCESS_INFORMATION) As Long
      
Private Declare Function CloseHandle Lib "kernel32.dll" _
        (ByVal hObject As Long) As Long
        
Private Declare Function WaitForSingleObject Lib "kernel32" (ByVal hHandle As Long, ByVal dwMilliseconds As Long) As Long

Private Declare Function FormatMessage Lib "kernel32" Alias _
   "FormatMessageA" (ByVal dwFlags As Long, lpSource As Any, _
   ByVal dwMessageId As Long, ByVal dwLanguageId As Long, _
   ByVal lpBuffer As String, ByVal nSize As Long, _
   Arguments As Long) As Long
   
Private Const FORMAT_MESSAGE_FROM_SYSTEM = &H1000

Public Declare Function IsUserAnAdmin Lib "Shell32" Alias "#680" () As Integer

'===================================================================================

'/*
' * Predefined Clipboard Formats
' */
Public Enum EPredefinedClipboardFormatConstants
   CF_TEXT = 1
   CF_BITMAP = 2
   CF_METAFILEPICT = 3
   CF_SYLK = 4
   CF_DIF = 5
   CF_TIFF = 6
   CF_OEMTEXT = 7
   CF_DIB = 8
   CF_PALETTE = 9
   CF_PENDATA = 10
   CF_RIFF = 11
   CF_WAVE = 12
   CF_UNICODETEXT = 13
   CF_ENHMETAFILE = 14
   ''#if(WINVER >= 0x0400)
   CF_HDROP = 15
   CF_LOCALE = 16
   CF_MAX = 17
   '#endif /* WINVER >= 0x0400 */
   CF_OWNERDISPLAY = &H80
   CF_DSPTEXT = &H81
   CF_DSPBITMAP = &H82
   CF_DSPMETAFILEPICT = &H83
   CF_DSPENHMETAFILE = &H8E
   '/*
   ' * "Private" formats don't get GlobalFree()'d
   ' */
   CF_PRIVATEFIRST = &H200
   CF_PRIVATELAST = &H2FF
   '/*
   ' * "GDIOBJ" formats do get DeleteObject()'d
   ' */
   CF_GDIOBJFIRST = &H300
   CF_GDIOBJLAST = &H3FF

End Enum

'========================================
' F T P
Public Const INTERNET_SERVICE_FTP = 1
Public Const INTERNET_SERVICE_GOPHER = 2
Public Const INTERNET_SERVICE_HTTP = 3

Public Declare Function FtpGetFile _
Lib "wininet.dll" Alias "FtpGetFileA" ( _
ByVal hFtpSession As Long, _
ByVal lpszRemoteFile As String, _
ByVal lpszNewFile As String, _
ByVal fFailIfExists As Boolean, _
ByVal dwFlagsAndAttributes As Long, _
ByVal dwFlags As Long, _
ByVal dwContext As Long) As Boolean

Public Declare Function InternetOpen _
Lib "wininet.dll" Alias "InternetOpenA" ( _
ByVal sAgent As String, _
ByVal nAccessType As Long, _
ByVal sProxyName As String, _
ByVal sProxyBypass As String, _
ByVal nFlags As Long) As Long

Public Declare Function InternetConnect _
Lib "wininet.dll" Alias "InternetConnectA" ( _
ByVal hInternetSession As Long, _
ByVal sServerName As String, _
ByVal nServerPort As Integer, _
ByVal sUserName As String, _
ByVal sPassword As String, _
ByVal nService As Long, _
ByVal dwFlags As Long, _
ByVal dwContext As Long) As Long

Public Declare Function FtpSetCurrentDirectory Lib "wininet.dll" Alias "FtpSetCurrentDirectoryA" (ByVal hFtpSession As Long, ByVal lpszDirectory As String) As Boolean

Public Declare Function InternetCloseHandle Lib "wininet.dll" (ByVal hInet As Long) As Integer

'hINetSession = InternetOpen("MyFTPClient", 0, vbNullString, vbNullString, 0)
'hSession = InternetConnect(hINetSession, "ftp.microsoft.com", "21", "anonymous", "guest", INTERNET_SERVICE_FTP, 0, 0)
'If FtpGetFile(hSession, "dirmap.htm", "c:\dirmap.htm", False, 0, 1, 0) = False Then
'MsgBox "Call to FtpGetFile Failed!"
'End If
'Call InternetCloseHandle(hSession)
'Call InternetCloseHandle(hINetSession)
'========================================

'Public Type NUMBERFMT
'    NumDigits As Long ' number of decimal digits
'    LeadingZero As Long ' if leading zero in decimal fields
'    Grouping As Long ' group size left of decimal
'    lpDecimalSep As String ' ptr to decimal separator string
'    lpThousandSep As String ' ptr to thousand separator string
'    NegativeOrder As Long ' negative number ordering
'End Type
'typedef struct _numberfmtA {
'  UINT  NumDigits;
'  UINT  LeadingZero;
'  UINT  Grouping;
'  LPSTR lpDecimalSep;
'  LPSTR lpThousandSep;
'  UINT  NegativeOrder;
'} NUMBERFMTA, *LPNUMBERFMTA;
 
'Public Declare Function GetNumberFormat Lib "kernel32" Alias "GetNumberFormatA" (ByVal Locale As Long, ByVal dwFlags As Long, ByVal lpValue As String, lpFormat As NUMBERFMT, ByVal lpNumberStr As String, ByVal cchNumber As Long) As Long
 

Public Sub MS_UpdateDependency()
    ' UpdateElementDependencyState was added in 8.9.3. Code that must be
    ' backwards compatible can use the MDL function
    
    On Error Resume Next
    
'    If msapp Is Nothing Then Exit Sub
'    msapp.UpdateElementDependencyState

    mdlDependency_processAffected
    
'    Exit Sub
'err:
'    mdlDependency_processAffected
End Sub

















'Public Function UserInfo(LoginName As String) As String
''PURPOSE: Display information that is available in
''the Active Directory about a given user
'
'    'PARAMETER: Login Name for user
'
'    'RETURNS: String with selected information about
'    'user, or empty string if there is no such
'    'login on the current domain
'
'    'REQUIRES: Windows 2000 ADSI, LDAP Provider
'    'Proper Security Credentials.
'
'    'EXAMPLE: msgbox UserInfo("Administrator")
'
'    Dim conn As New ADODB.Connection
'    Dim RS As ADODB.Recordset
'    Dim oRoot As IADs
'    Dim oDomain As IADs
'    Dim sBase As String
'    Dim sFilter As String
'    Dim sDomain As String
'
'    Dim sAttribs As String
'    Dim sDepth As String
'    Dim sQuery As String
'    Dim sAns As String
'
'    Dim user As IADsUser
'
'    On Error GoTo ErrHandler:
'
'    'Get user Using LDAP/ADO.  There is an easier way
'    'to bind to a user object using the WinNT provider,
'    'but this way is a better for educational purposes
'    Set oRoot = GetObject("LDAP://rootDSE")
'    'work in the default domain
'    sDomain = oRoot.Get("defaultNamingContext")
'    Set oDomain = GetObject("LDAP://" & sDomain)
'    sBase = "<" & oDomain.ADsPath & ">"
'    'Only get user name requested
'    sFilter = "(&(objectCategory=person)(objectClass=user)(name=" _
'                & LoginName & "))"
'    sAttribs = "adsPath"
'    sDepth = "subTree"
'
'    sQuery = sBase & ";" & sFilter & ";" & sAttribs & ";" & sDepth
'
'    conn.Open _
'              "Data Source=Active Directory Provider;Provider=ADsDSOObject"
'
'    Set RS = conn.Execute(sQuery)
'
'    If Not RS.EOF Then
'        Set user = GetObject(RS("adsPath"))
'        With user
'
'            'if the attribute is not stored in AD,
'            'an error will occur.  Therefore, this
'            'will return data only from populated attributes
'            On Error Resume Next
'
'            sAns = "First Name: " & .FirstName & vbCrLf
'            sAns = sAns & "Last Name " & .LastName & vbCrLf
'            sAns = sAns & "Description: " & .Description & vbCrLf
'            sAns = sAns & "Title: " & .Title & vbCrLf
'            sAns = sAns & "Division: " & .Division & vbCrLf
'            sAns = sAns & "Department: " & .Department & vbCrLf
'            sAns = sAns & "Manager: " & .Manager & vbCrLf
'
'            sAns = sAns & "Phone Number: " & .TelephoneNumber & vbCrLf
'            sAns = sAns & "Fax Number: " & .FaxNumber & vbCrLf
'
'            sAns = sAns & "Email Address: " & .EmailAddress & vbCrLf
'            sAns = sAns & "Web Page: " & .HomePage & vbCrLf
'            sAns = sAns & "Last Login: " & .LastLogin & vbCrLf
'            sAns = sAns & "Last Logoff: " & .LastLogoff & vbCrLf
'
'            sAns = sAns & "Account Expiration Date: " _
'                 & .AccountExpirationDate & vbCrLf
'
'            'IN RC2, this returned 1/1/1970 when password
'            'never expires option is set
'            sAns = sAns & "Password Expiration Date: " _
'                 & .PasswordExpirationDate
'
'        End With
'    End If
'    UserInfo = sAns
'ErrHandler:
'
'    On Error Resume Next
'    If Not RS Is Nothing Then
'        If RS.State <> 0 Then RS.Close
'        Set RS = Nothing
'    End If
'
'    If Not conn Is Nothing Then
'        If conn.State <> 0 Then conn.Close
'        Set conn = Nothing
'    End If
'
'    Set oRoot = Nothing
'    Set oDomain = Nothing
'End Function
'


























'==================================================================================

' Set a form always on the top.
'
' the form can be specified as a Form or object
' or through its hWnd property
' If OnTop=False the always on the top mode is de-activated.

Sub SetAlwaysOnTopMode(hWndOrForm As Variant, Optional ByVal OnTop As Boolean = _
    True)
    Dim hwnd As Long
    ' get the hWnd of the form to be move on top
    If VarType(hWndOrForm) = vbLong Then
        hwnd = hWndOrForm
    Else
        hwnd = hWndOrForm.hwnd
    End If
    SetWindowPos hwnd, IIf(OnTop, HWND_TOPMOST, HWND_NOTOPMOST), 0, 0, 0, 0, _
        SWP_NOMOVE Or SWP_NOSIZE Or SWP_SHOWWINDOW
End Sub

' Get mouse X coordinates in pixels
'
' If a window handle is passed, the result is relative to the client area
' of that window, otherwise the result is relative to the screen

Function MouseX(ByVal hwnd As Long, X As Long, Y As Long) As Long
    Dim lpPoint As POINTAPI
    lpPoint.X = X / Screen.TwipsPerPixelX
    lpPoint.Y = Y / Screen.TwipsPerPixelY
    If hwnd Then ClientToScreen hwnd, lpPoint
    MouseX = lpPoint.X * Screen.TwipsPerPixelX
'    MouseX = lpPoint.x
End Function

' Get mouse Y coordinates in pixels
'
' If a window handle is passed, the result is relative to the client area
' of that window, otherwise the result is relative to the screen

Function MouseY(ByVal hwnd As Long, X As Long, Y As Long) As Long
    Dim lpPoint As POINTAPI
    lpPoint.X = X / Screen.TwipsPerPixelX
    lpPoint.Y = Y / Screen.TwipsPerPixelY
    If hwnd Then ClientToScreen hwnd, lpPoint
    MouseY = lpPoint.Y * Screen.TwipsPerPixelX
'    MouseY = lpPoint.y
End Function

'/******************************************************************************
Public Function GetThreadUserName() As String
'/******************************************************************************
    
    ' Dimension variables
    Dim lpBuff As String * 25
    Dim ret As Long
    
    ' Get the user name minus any trailing spaces found in the name.
    ret = GetUserName(lpBuff, 25)
    GetThreadUserName = left(lpBuff, InStr(lpBuff, Chr(0)) - 1)
    
End Function


Public Function curCompName() As String
    Dim lSize As Long
    Dim sBuffer As String
    sBuffer = Space$(MAX_COMPUTERNAME_LENGTH + 1)
    lSize = Len(sBuffer)
    
    If GetComputerName(sBuffer, lSize) Then
        curCompName = left$(sBuffer, lSize)
    End If
    
End Function


Public Function Ceil(ByVal Number) As Long


    If Number >= 0 Then
        If Number = Int(Number) Then
            Ceil = Number
        Else
            Ceil = Int(Number) + 1
        End If
    ElseIf Number < 0 Then
        Ceil = Int(Number)
    End If


End Function

Public Function DisableCloseButton(frm As Form) As Boolean

'PURPOSE: Removes X button from a form
'EXAMPLE: DisableCloseButton Me
'RETURNS: True if successful, false otherwise
'NOTES:   Also removes Exit Item from
'         Control Box Menu


    Dim lHndSysMenu As Long
    Dim lAns1 As Long, lAns2 As Long
    
    
    lHndSysMenu = GetSystemMenu(frm.hwnd, 0)

    'remove close button
    lAns1 = RemoveMenu(lHndSysMenu, 6, MF_BYPOSITION)

   'Remove seperator bar
    lAns2 = RemoveMenu(lHndSysMenu, 5, MF_BYPOSITION)
    
    'Return True if both calls were successful
    DisableCloseButton = (lAns1 <> 0 And lAns2 <> 0)

End Function

'======== CLIPBOARD FUNCTIONS START ===============================

'Purppose: Wrap GetTextData CF_UNICODETEXT into single call.
Public Function GetUnicodeText() As String
   Dim sText  As String
   ClipboardOpen 0
   GetTextData CF_UNICODETEXT, sText
   GetUnicodeText = sText
   ClipboardClose
End Function

'Purppose: Wrap SetTextData CF_UNICODETEXT into single call.
Public Function SetUnicodeText(ByVal sText As String) As Boolean
   ClipboardOpen 0
   ClearClipboard
   SetUnicodeText = SetTextData(CF_UNICODETEXT, sText)
   ClipboardClose
End Function

Private Function GetTextData(ByVal lFormatId As Long, ByRef sTextOut As String) As Boolean
   ' Returns a string containing text on the clipboard for
   ' format lFormatID:
   Dim lHwndCache       As Long
   Dim bData()          As Byte
   Dim sr               As String

   If (lFormatId = CF_TEXT) Or (lFormatId = CF_UNICODETEXT) Or (lFormatId = 49159) Then
      If (GetBinaryData(lFormatId, bData())) Then
         If (lFormatId = CF_TEXT) Then
            sTextOut = StrConv(bData, vbUnicode)
         Else
            sTextOut = bData
         End If
         GetTextData = True
      End If
   Else
      If (GetBinaryData(lFormatId, bData())) Then
         sTextOut = StrConv(bData, vbUnicode)
         GetTextData = True
      End If
   End If
End Function

Private Function GetClipboardMemoryHandle(ByVal lFormatId As Long) As Long
   If pbNotReady() Then Exit Function

   ' If the format id is there:
   If (IsDataAvailableForFormat(lFormatId)) Then
      ' Get the global memory handle to the clipboard data:
      GetClipboardMemoryHandle = GetClipboardData(lFormatId)
   End If
End Function

Property Get IsDataAvailableForFormat(ByVal lFormatId As Long)
   ' Returns whether data is available for a given format id:
   Dim lR               As Long
   lR = IsClipboardFormatAvailable(lFormatId)
   IsDataAvailableForFormat = (lR <> 0)
End Property

Private Function GetBinaryData(ByVal lFormatId As Long, ByRef bData() As Byte) As Boolean
   ' Returns a byte array containing binary data on the clipboard for
   ' format lFormatID:
   Dim hMem             As Long, lSize As Long, lPtr As Long

   ' Ensure the return array is clear:
   Erase bData

   hMem = GetClipboardMemoryHandle(lFormatId)
   ' If success:
   If (hMem <> 0) Then
      ' Get the size of this memory block:
      lSize = GlobalSize(hMem)
      ' Get a pointer to the memory:
      lPtr = GlobalLock(hMem)
      If (lSize > 0) Then
         ' Resize the byte array to hold the data:
         ReDim bData(0 To lSize - 1) As Byte
         ' Copy from the pointer into the array:
         CopyMemory bData(0), ByVal lPtr, lSize
      End If
      ' Unlock the memory block:
      GlobalUnlock hMem
      ' Success:
      GetBinaryData = (lSize > 0)
      ' Don't free the memory - it belongs to the clipboard.
   End If
End Function

Public Function SetBinaryData(ByVal lFormatId As Long, ByRef bData() As Byte) As Boolean
   ' Puts the binary data contained in bData() onto the clipboard under
   ' format lFormatID:
   Dim lSize            As Long
   Dim lPtr             As Long
   Dim hMem             As Long

   If pbNotReady() Then Exit Function

   ' Determine the size of the binary data to write:
   lSize = UBound(bData) - LBound(bData) + 1
   ' Generate global memory to hold this:
   hMem = GlobalAlloc(GMEM_DDESHARE, lSize)
   If (hMem <> 0) Then
      ' Get pointer to the memory block:
      lPtr = GlobalLock(hMem)
      ' Copy the data into the memory block:
      CopyMemory ByVal lPtr, bData(LBound(bData)), lSize
      ' Unlock the memory block.
      GlobalUnlock hMem

      ' Now set the clipboard data:
      If (SetClipboardData(lFormatId, hMem) <> 0) Then
         ' Success:
         SetBinaryData = True
      End If
   End If
   ' We don't free the memory because the clipboard takes
   ' care of that now.

End Function

Private Function pbNotReady() As Boolean
   ' Determines whether a call to Get or Set Data on the
   ' clipboard will work.
   'was If Not (m_bClipboardIsOpen) Or (m_hWnd = 0) Then
   If Not ((m_bClipboardIsOpen) Or (m_hWnd = 0)) Then
      Debug.Assert (1 = 0)
      err.Raise eccClipboardNotOpen, App.EXEName & ".cCustomClipboard", "Attempt to access the clipboard when clipboard not Open."
      pbNotReady = True
   End If
End Function

Private Function SetTextData(ByVal lFormatId As Long, ByVal sText As String) As Boolean
   Dim bData()          As Byte

   ' Sets the text in sText onto the clipboard under format lFormatID:
   If (Len(sText) > 0) Then
      sText = sText & ChrW$(&H0)
      bData = sText
      SetTextData = SetBinaryData(lFormatId, bData())
   End If
End Function

Private Sub ClearClipboard()
   ' Clears all data in the clipboard, and also takes ownership
   ' of the clipboard.  This method will fail
   ' unless OpenClipboard has been called first.
   If (pbNotReady()) Then Exit Sub
   EmptyClipboard
End Sub

Private Sub ClipboardClose()
   ' Closes the clipboard if this class has it open:
   If (m_bClipboardIsOpen) Then
      CloseClipboard
      m_bClipboardIsOpen = False
      m_hWnd = 0
   End If
End Sub

Private Function ClipboardOpen(ByVal hWndOwner As Long) As Boolean
   Dim lR               As Long
   ' Opens the clipboard:
   
   lR = OpenClipboard(hWndOwner)
   If (lR > 0) Then
      m_hWnd = hWndOwner
      m_bClipboardIsOpen = True
      ClipboardOpen = True
   Else
      m_hWnd = 0
      m_bClipboardIsOpen = False
      err.Raise eccCantOpenClipboard, App.EXEName & ".cCustomClipboard", "Unable to Open Clipboard."
   End If
End Function

'Purpose: Unicode aware MsgBox
'Overrides Vb6 MsgBox. HelpFile/Context not supported
Function MsgBox(Prompt As String, _
   Optional Buttons As VbMsgBoxStyle = vbOKOnly, _
   Optional Title As String) As VbMsgBoxResult

   Dim WshShell As Object
   Set WshShell = CreateObject("WScript.Shell")
   MsgBox = WshShell.Popup(Prompt, 0&, Title, Buttons)
   Set WshShell = Nothing
End Function

'======== CLIPBOARD FUNCTIONS END ===============================

Public Function W2KRunAsUser(ByVal UserName As String, _
        ByVal Password As String, _
        ByVal DomainName As String, _
        ByVal CommandLine As String, _
        ByVal CurrentDirectory As String) As Long

    Dim si As STARTUPINFO
    Dim pi As PROCESS_INFORMATION
    
    Dim wUser As String
    Dim wDomain As String
    Dim wPassword As String
    Dim wCommandLine As String
    Dim wCurrentDir As String
    
    Dim Result As Long
    
    si.cb = Len(si)
        
      
        
    wUser = StrConv(UserName + Chr$(0), vbUnicode)
    wDomain = StrConv(DomainName + Chr$(0), vbUnicode)
    wPassword = StrConv(Password + Chr$(0), vbUnicode)
    wCommandLine = StrConv(CommandLine + Chr$(0), vbUnicode)
    wCurrentDir = StrConv(CurrentDirectory + Chr$(0), vbUnicode)
    
    Result = CreateProcessWithLogonW(wUser, wDomain, wPassword, _
          LOGON_WITH_PROFILE, 0&, wCommandLine, _
          CREATE_DEFAULT_ERROR_MODE, 0&, wCurrentDir, si, pi)
    
'    #If DBG Then
'    MsgBox wUser & vbNewLine & wDomain & vbNewLine & wPassword & vbNewLine & wCommandLine & vbNewLine & wCurrentDir
'    #End If

'    If Result = 0 Then
'        Result = CreateProcessWithLogonW(UserName, DomainName, Password, _
'              LOGON_WITH_PROFILE, 0&, CommandLine, _
'              CREATE_DEFAULT_ERROR_MODE, 0&, CurrentDirectory, si, pi)
'    End If

    If Result = 0 Then W2KRunAsUser = err.LastDllError

'    If Result <> 0 Then
'        WaitForSingleObject pi.hProcess, INFINITE
'        CloseHandle pi.hThread
'        CloseHandle pi.hProcess
'        W2KRunAsUser = 0
'    Else
'        W2KRunAsUser = err.LastDllError
'        'errWriteLog "CreateProcessWithLogonW() failed with error " & err.LastDllError & " - " & APIErrorDescription(err.LastDllError) & " - " & UserName & " - " & DomainName & " - " & CommandLine & " - "
'        'MsgBox "CreateProcessWithLogonW() failed with error " & err.LastDllError & " - " & APIErrorDescription(err.LastDllError) & " - " & UserName & " - " & DomainName & " - " & CommandLine & " - " & CurrentDirectory, vbExclamation
'    End If

End Function


Public Function APIErrorDescription(ErrorCode As Long) As String
    Dim sAns As String
    Dim lRet As Long
    
    'PURPOSE: Returns Human Readable Description of
    'Error Code that occurs in API function
    
    'PARAMETERS: ErrorCode: System Error Code
    
    'Returns: Description of Error
    
    'Example: After Calling API Function:
    'MsgBox (APIErrorDescription(Err.LastDllError))
    
    sAns = Space(255)
    lRet = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, _
                         ErrorCode, 0, sAns, 255, 0)
    
    APIErrorDescription = StripNull(sAns)
    
End Function

Private Function StripNull(ByVal InString As String) As String
    
    'Input: String containing null terminator (Chr(0))
    'Returns: all character before the null terminator
    
    Dim iNull As Integer
    If Len(InString) > 0 Then
        iNull = InStr(InString, vbNullChar)
        Select Case iNull
            Case 0
                StripNull = Trim(InString)
            Case 1
                StripNull = ""
            Case Else
                StripNull = left$(Trim(InString), iNull - 1)
        End Select
    End If
    
End Function


