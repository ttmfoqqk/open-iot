<%
Dim g_uip	: g_uip		= Request.ServerVariables("REMOTE_ADDR")
Dim g_port	: g_port	= Request.ServerVariables("SERVER_PORT")
Dim g_host	: g_host	= "http://" & Request.ServerVariables("SERVER_NAME") & iif(g_port="80","",":" & g_port)
Dim g_url	: g_url		= Request.ServerVariables("PATH_INFO")
Dim ref_url	: ref_url	= Request.ServerVariables("HTTP_REFERER")

Public Function iif(psdStr, trueStr, falseStr)
  if psdStr then
    iif = trueStr
  else 
    iif = falseStr
  end if
End Function

Public Function if_then_else(psdStr, trueStr, falseStr)
	if_then_else = iif(psdStr, trueStr, falseStr)
End Function

Public Function IsNothing(var)
   if(IsObject(var)) then
      IsNothing = (var is nothing) or IsEmpty(var) or IsNull(var)
   else
      IsNothing = IsEmpty(var) or IsNull(var)
   end if
End Function

Public Function StringFormat(ByVal SourceString , Arguments() ) 
   Dim objRegEx 'As RegExp  ' regular expression object
   Dim objMatch 'As Match   ' regular expression match object
   Dim strReturn 'As String ' the string that will be returned

   Set objRegEx = New RegExp
   objRegEx.Global = True
   objRegEx.Pattern = "(\{)(\d)(\})"

   strReturn = SourceString
   For Each objMatch In objRegEx.Execute(SourceString)
      strReturn = Replace(strReturn, objMatch.Value, Arguments(CInt(objMatch.SubMatches(1))))
   Next 

   StringFormat = strReturn

End Function


 Function PrepareVariables(args())

	dim keyPairs, keyPair, key, keyValue 
	Set results = Server.CreateObject("Scripting.Dictionary")
	
   if not IsArray(args) then
	  args = Split(args, ",")
   end if
	
	for each keyPair in args
		keyPairs = Split(keyPair,"=")
		if UBound(keyPairs) = 1 then
			key = Trim(keyPairs(0))
			keyValue = Trim(keyPairs(1))
			if InStr(1,"controller, action, partial",key,1)=0 Then
				results.Add key,keyValue 
			End If
		End If
	next
	if results.Count=0 Then
		Set PrepareVariables = Nothing
	else 
		Set PrepareVariables = results
	End If
End Function   

Function CreateGUID
  Dim TypeLib
  Set TypeLib = CreateObject("Scriptlet.TypeLib")
  CreateGUID = Mid(TypeLib.Guid, 2, 36)
  Set TypeLib = Nothing
End Function 

Const blackPattern = "(?:\'|is\s+null|--|=|%|values|where|count|\sand\s|\sor\s|;|\slike\s|,|\/\*|\*\/|@@|\s@|\schar|nchar|varchar|nvarchar|alter|begin|cast|create\s|cursor|declare|database|delete|drop|end|exec|execute|fetch|from|insert|kill|open|select|sys|sysobjects|syscolumns|table|update|values|xp_cmdshell)"

Function detectInjection(strtoclean)
  Set absoluteNoValidator = New RegExp
  absoluteNoValidator.Pattern = blackPattern
  absoluteNoValidator.IgnoreCase = True
  If absoluteNoValidator.Test(strtoclean) Then
      detectInjection = True
      Exit Function
  End If
  detectInjection = False
End Function


Sub checkLogin(url)
	If session("userNo")="" or IsNull(session("userNo"))=True Then 
		response.redirect "?controller=Member&action=Login&goUrl="&server.urlencode(url &  "?" & Request.ServerVariables("QUERY_STRING") )
	End If
End Sub

Sub checkEmailConfirm()
	If session("userState") = "1" Then 
		response.redirect "?controller=Member&action=Email"
	End If	
End Sub

Sub alerts(pMsg, pBack) 
	response.write "<script Language='JavaScript'>"
	response.write "	alert('" & toJS(pMsg) & "');"
	if (pBack="") then 
		response.write "	history.back();"
	else
		response.write "	location.href='" & pBack & "';"
	end if
	response.write "</script>"
	response.end
End Sub

Function toJS(pStr)
	Dim str : str= replace(replace(replace(pStr,"\","\\"), "'","\'"), vbCrLf,"\n")
	toJS = str
End Function






'** ---------------------------------------------------------------------------
' 함 수 명 : MailSend(strSubject, strBody, strTo, strFrom)
' 인    자 : 1. strSubject	: 메일 제목
'         2. strBody    : 메일 내용
'         3. strTo      : 받는 사람 메일 주소
'         4. strFrom    : 보내는 사람 메일 주소
'** ---------------------------------------------------------------------------
function MailSend(strSubject, strBody, strTo, strFrom, attachPath)
	dim result
	Dim objConfig, objSendMail, Flds

	on error resume Next
	
	Const cdoSendUsingMethod		= "http://schemas.microsoft.com/cdo/configuration/sendusing" 
	Const cdoSendUsingPort			= 1  ' 1:로컬, 1:외부
	Const cdoSMTPServer				= "http://schemas.microsoft.com/cdo/configuration/smtpserver" 
	Const cdoSMTPServerPort			= "http://schemas.microsoft.com/cdo/configuration/smtpserverport"
	Const cdoSMTPConnectionTimeout	= "http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout" 
	Const cdoSMTPAccountName		= "http://schemas.microsoft.com/cdo/configuration/smtpaccountname" 
	Const cdoSMTPAuthenticate		= "http://schemas.microsoft.com/cdo/configuration/smtpauthenticate" 
	Const cdoSMTPPickupDirectory	= "http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory" 
	Const cdoBasic					= 1 
	Const cdoSendUserName			= "http://schemas.microsoft.com/cdo/configuration/sendusername" 
	Const cdoSendPassword			= "http://schemas.microsoft.com/cdo/configuration/sendpassword" 

	' SMTP Configuration 
	set objConfig = createobject("CDO.Configuration") 
	Set Flds = objConfig.Fields 
	With Flds 
		.Item(cdoSendUsingMethod) = cdoSendUsingPort 
		.Item(cdoSMTPServer) = "127.0.0.1"  ' 로컬호스트 
		.Item(cdoSMTPServerPort) = 25 
		.Item(cdoSMTPAuthenticate) = cdoBasic 
		.Item(cdoSMTPPickupDirectory) = "C:\Inetpub\mailroot\Pickup"  ' 픽업 디렉토리 경로 지정
		'.Item(cdoSendUserName) = "계정 id"
		'.Item(cdoSendPassword) = "계정 pwd"
		.Update
	End With 
	
	Set objSendMail = Server.CreateObject("CDO.Message")
	With objSendMail 
		.BodyPart.Charset = "ks_c_5601-1987" 
		.Configuration = objConfig 
		'.MimeFormatted = false 
		.From		= strFrom
		.To			= strTo
		.Subject	= strSubject
		.HTMLBody	= strBody
		if LEN(attachPath)>0 then
			.AddAttachment attachPath
		end if
		.fields.update 
		.Send
	End With

	Set objSendMail = Nothing

	if err.number <> 0 then
		result = replace(replace(replace(err.description,vbCrLf,""),vbCr,""),vbLf,"")
	else
		result = "ok"
	end if

	MailSend = result
end function



function Base64decode(ByVal asContents)
Const sBASE_64_CHARACTERS = _
           "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" 
           Dim lsResult
           Dim lnPosition
           Dim lsGroup64, lsGroupBinary
           Dim Char1, Char2, Char3, Char4
           Dim Byte1, Byte2, Byte3
           if Len(asContents) Mod 4 > 0 _
          Then asContents = asContents & String(4 - (Len(asContents) Mod 4), " ")
           lsResult = ""

           For lnPosition = 1 To Len(asContents) Step 4
                   lsGroupBinary = ""
                   lsGroup64 = Mid(asContents, lnPosition, 4)
                   Char1 = INSTR(sBASE_64_CHARACTERS, Mid(lsGroup64, 1, 1)) - 1
                   Char2 = INSTR(sBASE_64_CHARACTERS, Mid(lsGroup64, 2, 1)) - 1
                   Char3 = INSTR(sBASE_64_CHARACTERS, Mid(lsGroup64, 3, 1)) - 1
                   Char4 = INSTR(sBASE_64_CHARACTERS, Mid(lsGroup64, 4, 1)) - 1
                   Byte1 = Chr(((Char2 And 48) \ 16) Or (Char1 * 4) And &HFF)
                   Byte2 = lsGroupBinary & Chr(((Char3 And 60) \ 4) Or (Char2 * 16) And &HFF)
                   Byte3 = Chr((((Char3 And 3) * 64) And &HFF) Or (Char4 And 63))
                   lsGroupBinary = Byte1 & Byte2 & Byte3

                   lsResult = lsResult + lsGroupBinary
           Next
Base64decode = lsResult
End Function

'----------------------------------------------------------------------------------------------
' 문자열 64비트 인코딩
'----------------------------------------------------------------------------------------------
function Base64encode(ByVal asContents)
Const sBASE_64_CHARACTERS = _
           "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" 
        Dim lnPosition
        Dim lsResult
        Dim Char1
        Dim Char2
        Dim Char3
        Dim Char4
        Dim Byte1
        Dim Byte2
        Dim Byte3
        Dim SaveBits1
        Dim SaveBits2
        Dim lsGroupBinary
        Dim lsGroup64

        if Len(asContents) Mod 3 > 0 Then _
        asContents = asContents & String(3 - (Len(asContents) Mod 3), " ")
        lsResult = ""

        For lnPosition = 1 To Len(asContents) Step 3
               lsGroup64 = ""
               lsGroupBinary = Mid(asContents, lnPosition, 3)

               Byte1 = Asc(Mid(lsGroupBinary, 1, 1)): SaveBits1 = Byte1 And 3
               Byte2 = Asc(Mid(lsGroupBinary, 2, 1)): SaveBits2 = Byte2 And 15
               Byte3 = Asc(Mid(lsGroupBinary, 3, 1))

               Char1 = Mid(sBASE_64_CHARACTERS, ((Byte1 And 252) \ 4) + 1, 1)
               Char2 = Mid(sBASE_64_CHARACTERS, (((Byte2 And 240) \ 16) Or _
               (SaveBits1 * 16) And &HFF) + 1, 1)
               Char3 = Mid(sBASE_64_CHARACTERS, (((Byte3 And 192) \ 64) Or _
               (SaveBits2 * 4) And &HFF) + 1, 1)
               Char4 = Mid(sBASE_64_CHARACTERS, (Byte3 And 63) + 1, 1)
               lsGroup64 = Char1 & Char2 & Char3 & Char4

               lsResult = lsResult + lsGroup64
         Next

         Base64encode = lsResult
End Function


Function RandomNumber(NumberLength,NumberString)

	Const DefaultString = "ABCDEFGHIJKLMNOPQRSTUVXYZ1234567890"
	Dim nCount,RanNum,nNumber,nLength

	Randomize
	If NumberString = "" Then 
		NumberString = DefaultString
	End If

	nLength = Len(NumberString)

	For nCount = 1 To NumberLength
	nNumber = Int((nLength * Rnd)+1)
	RanNum = RanNum & Mid(NumberString,nNumber,1)
	Next

	RandomNumber = RanNum
End Function



Function isValidEmail(myEmail)
	dim isValidE
	dim regEx

	isValidE = True
	set regEx = New RegExp

	regEx.IgnoreCase = False

	regEx.Pattern = "^[a-zA-Z\-\_][\w\.-]*[a-zA-Z0-9\-\_]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"
	isValidE = regEx.Test(myEmail)

	isValidEmail = isValidE
End Function

%>