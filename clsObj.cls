VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsObj"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public objID As Long
Public objname As String
Public objDescr As String

Public itable As String
Public ctable As String
Public idName As String

Public KEY As String

Public props As New colPrp
Public kinder As New Collection


Public Function knd(strKey As String) As clsObj

    On Error GoTo err

    Set knd = kinder(strKey)
    
    Exit Function
err:

    Set knd = New clsObj

End Function


Public Function getKinder(strKey As String) As clsObj

    On Error GoTo err

    Set getKinder = kinder(strKey)
    
    Exit Function
err:

    Set getKinder = Nothing

End Function

Public Function getValueFromFG(FG As VSFlexGrid, Row As Long, Clmn As clsObj, ByRef v As Variant) As Boolean

    On Error GoTo err

    Dim Col As Long

    getValueFromFG = False

    If Clmn Is Nothing Then Exit Function
    
    Col = Clmn.props("index").propValue
    
    ' empty string
    If Len(Trim(FG.TextMatrix(Row, Col))) = 0 Then Exit Function



    If typeName(v) = "String" Then
        v = FG.TextMatrix(Row, Col)
    ElseIf typeName(v) = "Double" Then
        v = getDbl(FG.TextMatrix(Row, Col))
    Else
        v = Val(FG.TextMatrix(Row, Col))
    End If

    
    getValueFromFG = True
    
    Exit Function
err:
    getValueFromFG = False

End Function

'/******************************************************************************
Public Function readXmlNode(ByRef d As MSXML2.DOMDocument, ByRef cnr As MSXML2.IXMLDOMNode) As Boolean
'/******************************************************************************

    On Error GoTo readXmlNode_ERR
    
    Dim i As Integer
    Dim cn As MSXML2.IXMLDOMNode
    Dim cnc As MSXML2.IXMLDOMNode

    If cnr.ChildNodes Is Nothing Then Exit Function


    For Each cn In cnr.ChildNodes
    
        Dim oo As New clsObj
        
        oo.objname = cn.nodeName
        oo.objID = -1
           
        ' добавление атрибутов
        If Not cn.Attributes Is Nothing Then
            For i = 0 To cn.Attributes.length - 1
            
                If cn.Attributes(i).nodeName = "id" Then
                    oo.objID = Val(cn.Attributes(i).nodeValue)
                End If
            
                oo.props.AddProp cn.Attributes(i).nodeName, cn.Attributes(i).nodeValue
                
            Next i
        End If
        
        
        If oo.objID > 0 Then oo.idName = oo.objname & CStr(oo.objID)
            
            
        oo.readXmlNode d, cn
            
        
        
        If oo.objID <= 0 Then
            kinder.Add oo, oo.objname
        Else
            kinder.Add oo, oo.objname & CStr(oo.objID)
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
