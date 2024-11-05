VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "colAts"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "Top_Level" ,"No"
Attribute VB_Ext_KEY = "Collection" ,"colAts"
Attribute VB_Ext_KEY = "Member0" ,"colAts"
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Option Explicit

Public atname As String
Public atIDent As String

Public ats As Collection ' of clsAtt

'local variable to hold collection
Private mCol As Collection ' of colAts

'/******************************************************************************
Public Function existElem(strPropName As String) As Boolean
'/******************************************************************************

    On Error GoTo existsProperty_ERR


    Dim p As colAts
    
    Set p = mCol(strPropName)

    existElem = True

Exit Function

existsProperty_ERR:

    existElem = False

End Function


'/******************************************************************************
Public Function existAttr(strAtName As String) As Boolean
'/******************************************************************************

    On Error GoTo existAttr_ERR
    
    Dim at As clsAtt
    
    Set at = ats(strAtName)
    
    existAttr = True

Exit Function

existAttr_ERR:
    existAttr = False
    'MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "existAttr - Error"

End Function


'/******************************************************************************
Public Function AddElem(p As colAts, Optional sKey As String = "") As colAts
'/******************************************************************************

    On Error GoTo AddElem_ERR

    
    
    If Len(sKey) = 0 Then
        mCol.Add p
    Else
        mCol.Add p, sKey
    End If
    
    Set p = Nothing
    
    If Len(sKey) = 0 Then
        Set AddElem = mCol(mCol.Count) ' 1 based
    Else
        Set AddElem = mCol(sKey)
    End If


Exit Function

AddElem_ERR:
    Set AddElem = New colAts
    'MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "AddElem - Error"

End Function


Public Function AddAttByNameValue(sName As String, vValue As Variant) As Boolean

    On Error GoTo err

    Dim p As New clsAtt
    p.attName = sName
    p.attValue = vValue
    ats.Add p, Trim(p.attName)
    Set p = Nothing
    
    AddAttByNameValue = True
    
    Exit Function
err:
    AddAttByNameValue = False

End Function


'/******************************************************************************
Public Function AddOrGetElem(ByRef p As colAts) As colAts
'/******************************************************************************

    On Error GoTo AddOrGetElem_ERR


    Dim sKey As String

    sKey = Trim(p.atname)
    
    Set AddOrGetElem = New clsAtt
    
    If Len(sKey) = 0 Then Exit Function

    If existElem(p.atname) Then
        Set AddOrGetElem = Me(sKey)
        Exit Function
    End If

    mCol.Add p, sKey
    
    Set p = Nothing

    Set AddOrGetElem = mCol(sKey)


Exit Function

AddOrGetElem_ERR:
    Set AddOrGetElem = New colAts
    'MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "AddOrGetElem - Error"

End Function

'/******************************************************************************
Public Property Get att(attName As String) As clsAtt
'/******************************************************************************

    On Error GoTo att_ERR
    
    Set att = ats(attName)


Exit Property

att_ERR:
    Set att = New clsAtt
    'MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "att - Error"

End Property

'/******************************************************************************
Public Property Get attval(attName As String, Optional defVal As Variant = "") As Variant
'/******************************************************************************

    On Error GoTo att_ERR
    


    
    Dim att As clsAtt
    
    Set att = ats(attName)
    
    
    
    If typeName(defVal) = "Boolean" Then
        attval = CBool(att.attValue)
    Else
        attval = att.attValue
    End If



Exit Property

att_ERR:
    attval = defVal
    'MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "att - Error"

End Property



Public Property Get Item(IndexKey As Variant) As colAts
Attribute Item.VB_UserMemId = 0

    On Error GoTo Item_ERR

  
    If typeName(IndexKey) = "String" Then
        Set Item = mCol(Trim(IndexKey))
    Else
        Set Item = mCol(IndexKey)
    End If

Exit Property

Item_ERR:
    Set Item = New colAts

End Property

'/******************************************************************************
Public Sub Clear()
'/******************************************************************************

    On Error GoTo Clear_ERR
    
    Set ats = New Collection
    Set mCol = New Collection

Exit Sub

Clear_ERR:

End Sub

Public Property Get Count() As Long
    Count = mCol.Count
End Property


'/******************************************************************************
Public Sub RemoveElem(vntIndexKey As Variant)
'/******************************************************************************

    On Error GoTo RemoveElem_ERR



    If typeName(vntIndexKey) = "String" Then
        mCol.Remove Trim(vntIndexKey)
    Else
        mCol.Remove vntIndexKey
    End If


Exit Sub

RemoveElem_ERR:
    'MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "RemoveElem - Error"

End Sub


Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
    'this property allows you to enumerate
    'this collection with the For...Each syntax
    Set NewEnum = mCol.[_NewEnum]
End Property


Private Sub Class_Initialize()
    'creates the collection when this class is created
    Set mCol = New Collection
    Set ats = New Collection
End Sub


Private Sub Class_Terminate()
    'destroys collection when this class is terminated
    Set mCol = Nothing
    Set ats = Nothing
End Sub



'/******************************************************************************
Public Function readXmlNode(ByRef d As MSXML2.DOMDocument, ByRef cnr As MSXML2.IXMLDOMNode) As Boolean
'/******************************************************************************

    On Error GoTo readXmlNode_ERR
    
    Dim i As Integer
    Dim cn As MSXML2.IXMLDOMNode
    Dim cnc As MSXML2.IXMLDOMNode

    If cnr.ChildNodes Is Nothing Then Exit Function


    For Each cn In cnr.ChildNodes
    
        Dim oo As New colAts
        
        oo.atname = cn.nodeName
        'oo.atIDent = "-1"
           
        If cn.nodeType = NODE_TEXT Then
        
            oo.atname = cn.nodeValue
        
            Set oo = AddElem(oo)
        
        ElseIf cn.nodeType = NODE_COMMENT Then
        
        'ElseIf cn.nodeType = NODE_ELEMENT Then
        Else
        
            ' добавление атрибутов
            If Not cn.Attributes Is Nothing Then
                For i = 0 To cn.Attributes.length - 1
                
                    If StrComp(cn.Attributes(i).nodeName, "id", vbTextCompare) = 0 Then
                        oo.atIDent = cn.Attributes(i).nodeValue
                    ElseIf StrComp(cn.Attributes(i).nodeName, "index", vbTextCompare) = 0 Then
                        oo.atIDent = cn.Attributes(i).nodeValue
                    ElseIf StrComp(cn.Attributes(i).nodeName, "key", vbTextCompare) = 0 Then
                        oo.atIDent = cn.Attributes(i).nodeValue
                    'ElseIf cn.Attributes(i).nodeName = "name" Then
                    '    oo.atIDent = cn.Attributes(i).nodeValue ' может сбить забор элементов по ID
                    End If
                    
                    oo.AddAttByNameValue cn.Attributes(i).nodeName, cn.Attributes(i).nodeValue
                    
                Next i
            End If
            
            If Len(oo.atIDent) = 0 Then
                Set oo = AddElem(oo, oo.atname)
            Else
                Set oo = AddElem(oo, oo.atname & oo.atIDent)
            End If
            
            
            oo.readXmlNode d, cn
            
        End If
        
           
        
            
        
        Set oo = Nothing
            
    Next

    readXmlNode = True

Exit Function

readXmlNode_ERR:
    'MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "readXmlNode - Error"

End Function



'/******************************************************************************
Public Function readXmlNodeByPath(ByRef d As MSXML2.DOMDocument, sPath As String) As Boolean
'/******************************************************************************

    On Error GoTo readNode_ERR
    
    readXmlNodeByPath = False

    Dim cnr As MSXML2.IXMLDOMNode
    
    For Each cnr In d.selectNodes(sPath)

        readXmlNode d, cnr
        
        'Exit For ' only one...
    
    
    Next
    
    
    Exit Function
    
    readXmlNodeByPath = True

readNode_ERR:
    'MsgBox "[" & err.Number & "] " & err.Description, vbCritical, "readNode - Error"

End Function

