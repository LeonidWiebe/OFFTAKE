VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cl_SortedList"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'-----------------------------------------------------------------------------
'              Класс - коллекция с автосортиоровкой по ключу
'ez 21-08-2017 доб.
'-----------------------------------------------------------------------------

Private pr_Dct As Dictionary
Private pr_UpdateCnt As Integer
Private pr_Keys() As Variant
Private pr_Values() As Variant
'

Public Property Get Count() As Integer
    Count = pr_Dct.Count
End Property

Public Property Get Keys() As Variant
    If pr_RequiresUpdate Then Call pr_Update
    Keys = pr_Keys
End Property

Public Property Get Values() As Variant
    If pr_RequiresUpdate Then Call pr_Update
    Values = pr_Values
End Property

'КОНСТУКТОР
Private Sub Class_Initialize()
    Set pr_Dct = New Dictionary
    pr_UpdateCnt = 0
End Sub

Private Function pr_RequiresUpdate() As Boolean
    pr_RequiresUpdate = Not (pr_UpdateCnt = pr_Dct.Count)
End Function

Private Sub pr_Update()
    Dim Buff As New Dictionary
    Dim SortArr() As Variant
    ReDim SortArr(pr_Dct.Count - 1) As Variant
    
    Dim Key As Variant, Val As Variant
    
    Dim i%: i = 0
    For Each Key In pr_Dct.Keys
        Dim SortedKey As Variant: SortedKey = CodeKey(Key)
        SortArr(i) = SortedKey
        Call Buff.Add(SortedKey, Key)
        i = i + 1
    Next
    
    Call QuickSort(SortArr) 'сортировка
    
    ReDim pr_Keys(pr_Dct.Count - 1)
    ReDim pr_Values(pr_Dct.Count - 1)
    i = 0
    
    For Each SortedKey In SortArr
        If IsObject(Buff(SortedKey)) Then
            Set Key = Buff(SortedKey)
            Set pr_Keys(i) = Key
        Else: Key = Buff(SortedKey)
            pr_Keys(i) = Key
        End If
        
        If IsObject(pr_Dct(Key)) Then
            Set pr_Values(i) = pr_Dct(Key)
        Else: pr_Values(i) = pr_Dct(Key)
        End If
        i = i + 1
    Next
    
    pr_UpdateCnt = pr_Dct.Count
End Sub

Public Sub Add(Key As Variant, Value As Variant)
    If pr_Dct.Exists(Key) Then Exit Sub
    
    pr_Dct.Add Key, Value
    
End Sub

Public Property Get Item(Key As Variant) As Variant
    If pr_Dct.Exists(Key) Then
        If IsObject(pr_Dct(Key)) Then Set Item = pr_Dct(Key) Else Item = pr_Dct(Key)
    End If
End Property

Public Sub Remove(Key As Variant)
    'If Not pr_Dct.Exists(Key) Then Exit Sub
    Call pr_Dct.Remove(Key)
End Sub

Public Sub RemoveAll()
    pr_Dct.RemoveAll
End Sub

Public Sub RemoveTry(Key As Variant)
    If Not pr_Dct.Exists(Key) Then Exit Sub
    Call pr_Dct.Remove(Key)
End Sub

Public Function Exists(Key As Variant) As Boolean
    Exists = pr_Dct.Exists(Key)
End Function

Public Function ContainsKey(Key As Variant)
    ContainsKey = pr_Dct.Exists(Key)
End Function

Public Function ContainsValue(Value As Variant) As Boolean
    If IsObject(Value) Then
        Dim Val As Variant
        For Each Val In pr_Dct.items
            If IsObject(Val) Then
                If Val Is Value Then ContainsValue = True: Exit Function
            End If
        Next
    Else
        For Each Val In pr_Dct.items
            If Not IsObject(Val) Then
                If Val = Value Then ContainsValue = True: Exit Function
            End If
        Next
    End If
    ContainsValue = False
End Function

Private Function CodeKey(ByVal Key As String) As String
    Dim Template As String: Template = "XXXXXXXXXX"
    
    Dim Result As String: Result = ""
    Dim buffer As String: buffer = ""
    
    For i = 1 To Len(Key)
        Dim letter As String: letter = Mid(Key, i, 1)
              
        If Not letter Like "#" Then
            If Len(buffer) = 0 Then
                Result = Result & letter
            Else
                buffer = "1" & buffer
                Do While Not Len(buffer) = Len(Template) + 1
                    buffer = "0" & buffer
                Loop
                buffer = "%%" & buffer
                Result = Result & buffer & letter: buffer = ""
            End If
        Else
            buffer = buffer & letter
        End If
    Next i
    
    If Not buffer = "" Then
        buffer = "1" & buffer
        Do While Not Len(buffer) = Len(Template) + 1
            buffer = "0" & buffer
        Loop
         buffer = "%%" & buffer
        Result = Result & buffer: buffer = ""
    End If

    CodeKey = Result
End Function

Public Function DecodeKey(ByVal Key As String) As String
    Dim Result As String: Result = Key
    Dim buffer As String: buffer = ""
    
    Do While InStr(Result, "%%") > 0
        Dim Index%, i%: Index = InStr(Result, "%%")
  
        i = Index + 2
        Dim letter As String: letter = Mid(Result, i, 1)
        
        Do Until letter = "1"
            i = i + 1
            letter = Mid(Result, i, 1)
        Loop
        i = i + 1
        
        If Index = 1 Then
             Result = Mid(Result, i, Len(Result))
        Else
             Result = Mid(Result, 1, Index - 1) & Mid(Result, i, Len(Result))
        End If
    Loop
    
    DecodeKey = Result
End Function

Private Sub QuickSort(ByRef Arr As Variant, Optional numEls As Variant, _
    Optional descending As Boolean)

    Dim Value As Variant, temp As Variant
    Dim sp As Integer
    Dim leftStk(32) As Long, rightStk(32) As Long
    Dim leftNdx As Long, rightNdx As Long
    Dim i As Long, j As Long

    If IsMissing(numEls) Then numEls = UBound(Arr)

    leftNdx = LBound(Arr)
    rightNdx = numEls

    sp = 1
    leftStk(sp) = leftNdx
    rightStk(sp) = rightNdx

    Do
        If rightNdx > leftNdx Then
            Value = Arr(rightNdx)
            i = leftNdx - 1
            j = rightNdx

            If descending Then
                Do
                    Do: i = i + 1: Loop Until Arr(i) <= Value
                    Do: j = j - 1: Loop Until j = leftNdx Or Arr(j) >= Value
                    temp = Arr(i)
                    Arr(i) = Arr(j)
                    Arr(j) = temp
                Loop Until j <= i
            Else
                Do
                    Do: i = i + 1: Loop Until Arr(i) >= Value
                    Do: j = j - 1: Loop Until j = leftNdx Or Arr(j) <= Value
                    temp = Arr(i)
                    Arr(i) = Arr(j)
                    Arr(j) = temp
                Loop Until j <= i
            End If

            temp = Arr(j)
            Arr(j) = Arr(i)
            Arr(i) = Arr(rightNdx)
            Arr(rightNdx) = temp

            sp = sp + 1
            If (i - leftNdx) > (rightNdx - i) Then
                leftStk(sp) = leftNdx
                rightStk(sp) = i - 1
                leftNdx = i + 1
            Else
                leftStk(sp) = i + 1
                rightStk(sp) = rightNdx
                rightNdx = i - 1
            End If
        Else
            leftNdx = leftStk(sp)
            rightNdx = rightStk(sp)
            sp = sp - 1
            If sp = 0 Then Exit Do
        End If
    Loop
End Sub

