VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsRoom"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public simID As Long

Public sRoomKKS As String
Public sRoomNameRus As String
Public sRoomNameEng As String

Public iVolume As Long
Public iLevMin As Long
Public iLevMax As Long

Public room_prps As colPrp



Private Sub Class_Initialize()

    Set room_prps = New colPrp



End Sub

Private Sub Class_Terminate()

    Set room_prps = Nothing


End Sub

Public Sub reloadProps()
    
    Dim pr As clsPrp
    Dim prop As clsPrp
    Dim I As Integer
    Dim s As String
    
    For Each pr In globPrps
        If pr.propObjID = objs("room") Then
            Dim p As clsPrp
            Set p = pr.makeClone
            Set p.parentObj = Me
            room_prps.AddSimple p, p.propName
            Set p = Nothing
        End If
    Next pr
    
    Dim RS2 As New ADODB.Recordset
    
    RS2.Open "select * from r_room_property where roomID = " & Me.simID, cn_data, adOpenForwardOnly, adLockReadOnly
    If Not RS2.EOF Then
        RS2.MoveFirst
        
        For I = 2 To RS2.Fields.Count - 1
            
            s = RS2.Fields(I).Name
            
            If Not IsNull(RS2.Fields(I).Value) Then
                
                If Not room_prps.existsProperty(s) Then
'                    Set prop = room_prps.AddByPropName(s, Me)
                Else
                    Set prop = room_prps(s)
                End If
                
                Set prop.parent = Me
                prop.setPrpValue RS2.Fields(I).Value
                
            End If
            
        Next I
        
    End If
    
    RS2.Close
    Set RS2 = Nothing
    
    For Each pr In room_prps
        If pr.propvalName = "secid" Then
            Set RS2 = New ADODB.Recordset
            RS2.Open "select * from r_room_propertylist where roomID = " & Me.simID & " and propID = " & pr.propID, cn_data, adOpenForwardOnly, adLockReadOnly
            If Not RS2.EOF Then
                RS2.MoveFirst
                Do
                    pr.setPrpValue 1, RS2.Fields("valueID").Value
                    RS2.MoveNext
                Loop Until RS2.EOF
            End If
            RS2.Close
            Set RS2 = Nothing
            
        End If
    Next pr
    
    
    
End Sub



'/******************************************************************************
Public Function loadData(ByRef cnsim As ADODB.Connection, ByRef cnpw As ADODB.Connection, ID As Long) As Boolean
'/******************************************************************************

    On Error GoTo loadData_ERR
    
    Dim strSQL As String
    
    Dim cn As New ADODB.Connection
    cn.Open "Provider=" & conn.strProvider & ".1;Persist Security Info=False;Timeout=5;User ID=so2user;Initial Catalog=" & strCurSimBase & _
        ";Data Source=" & conn.strServerName, "so2user", "so2user"
    
    Dim RS As New ADODB.Recordset
    
    strSQL = "select * from elements where simID  = " & ID
    
    RS.Open strSQL, cn, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        RS.MoveFirst
        
        simID = ID
        iVolume = RS.Fields("elemVolume").Value * 0.000000000000001 ' m3
        iLevMin = RS.Fields("pMinZ").Value
        iLevMax = RS.Fields("pMaxZ").Value
    
    End If
    
    RS.NextRecordset
    
    strSQL = "select * from i_Space where simID  = " & simID
    
    RS.Open strSQL, cn, adOpenForwardOnly, adLockReadOnly
    
    If Not RS.EOF Then
        RS.MoveFirst
        
        sRoomKKS = RS.Fields("number").Value & ""
        sRoomNameRus = RS.Fields("label").Value & ""
        sRoomNameEng = RS.Fields("label2").Value & ""
    
    End If
    
    RS.Close
    Set RS = Nothing
    
    cn.Close
    Set cn = Nothing
    
    reloadProps
    
    loadData = True

Exit Function

loadData_ERR:
    If bMainFormLoaded Then F1.SB.Panels("status").text = "loadData" & "() - " & err.Description

End Function
