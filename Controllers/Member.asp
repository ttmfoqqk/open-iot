<%
class MemberController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		Login()
	End Sub
	
	public Sub Login()
		ViewData.add "ActionForm"    , "?controller=Member&action=LoginPost&partial=True"
		ViewData.add "ActionRegeste" , "?controller=Member&action=Registe"
		ViewData.add "ActionFind"    , "?controller=Member&action=Find"
		ViewData.add "GoUrl"  , request("goUrl")
		ViewData.add "SaveId" , Request.Cookies("saveId")
		ViewData.add "SaveIdChecked" , iif( Request.Cookies("saveId")="","","checked" )
		
		%> <!--#include file="../Views/Member/Login.asp" --> <%
	End Sub
	
	public Sub LoginPost()
		Dim args : Set args = Request.Form
		
		if Trim(args("Id")) = "" Then
			call alerts ("아이디를 입력해주세요.","")
		end if
		
		if Trim(args("Pwd")) = "" Then
			call alerts ("비밀번호를 입력해주세요.","")
		end if
		
		Dim obj : set obj = new User
		
		obj.Id  = Trim(args("Id"))
		obj.Pwd = Trim(args("Pwd"))
		
		Dim u : set u = new UserHelper
		set Model = u.Login( obj )
		
		if IsNothing(Model) Then
			call alerts ("입력하신 아이디 혹은 비밀번호가 일치하지 않습니다.","")
		end if
		
		if Trim(args("saveId"))="on" then
			Response.Cookies("saveId") = Model.Id
			Response.Cookies("saveId").expires = date + 365
		else
			Response.Cookies("saveId") = ""
			Response.Cookies("saveId").expires = date - 1
		end if
		
		session("userNo")    = Model.No
		session("userState") = Model.State
		
		if Trim(args("goUrl")) = "" then
			Response.Redirect("/")
		else
			Response.Redirect(Trim(args("goUrl")))
		end if
		
	End Sub
	
	public Sub Logout()
		Session.Contents.RemoveAll()
		Response.Redirect("/")
	End Sub
	
	' 회원 가입
	public Sub Registe()
		Dim p : set p = new PolicyHelper
		set Model = p.SelectAll()
		
		ViewData.add "ActionForm","?controller=Member&action=RegistePost&partial=True"
		
		%> <!--#include file="../Views/Member/Registe.asp" --> <%
	End Sub
	
	' 회원 가입 - 검증 , 등록
	public Sub RegistePost()
		Dim RedirectUrl : RedirectUrl = "?controller=Member&action=Registe"
		Dim args : Set args = Request.Form

		' 보안 문자 검증
		if IsEmpty(Session("ASPCAPTCHA")) or Trim(Session("ASPCAPTCHA")) = "" or args("txtCaptcha") = "" then
			call alerts ("보안문자를 입력해주세요.",RedirectUrl)
		end if
		
		Dim TestValue : TestValue = Trim(args("txtCaptcha"))
		TestValue = Replace(TestValue, "i", "I", 1, -1, 1)
		TestValue = Replace(TestValue, "İ", "I", 1, -1, 1)
		TestValue = Replace(TestValue, "ı", "I", 1, -1, 1)
		TestValue = UCase(TestValue)
        
		if StrComp(TestValue, Trim(Session("ASPCAPTCHA")), 1) = 0 then
			'
		else
			call alerts ("보안문자가 일치하지 않습니다.",RedirectUrl)
		end if
		Session("ASPCAPTCHA") = vbNullString
		Session.Contents.Remove("ASPCAPTCHA")

		'-- 필수 입력폼 검증
		' 약관 동의 검증
		if Trim(args("agree")) = "" Then
			call alerts ("Open-IoT 개인정보취급방침에 동의해주세요.",RedirectUrl)
		end if
 
		'id 검증
		if Trim(args("Id")) = "" Then
			call alerts ("아이디를 입력해주세요.",RedirectUrl)
		end if

		Dim u : set u = new UserHelper
		Dim check : set check = u.SelectByField("Id", args("Id"))

		if Not(IsNothing (check)) Then
			call alerts ("이미 사용중인 아이디 입니다.",RedirectUrl)
		end if

		'pwd 검증
		if Trim(args("Pwd")) = "" Then
			call alerts ("비밀번호를 입력해주세요.",RedirectUrl)
		end if
		
		if Trim(args("Pwd")) <> Trim(args("PwdConfirm")) Then
			call alerts ("비밀번호를 확인해주세요.",RedirectUrl)
		end if
		
		'Name 검증
		if Trim(args("Name")) = "" Then
			call alerts ("이름을 입력해주세요.",RedirectUrl)
		end if
		
		'Phone3 검증
		if Trim(args("Phone3")) = "" Then
			call alerts ("핸드폰 뒷자리 번호를 입력해주세요.",RedirectUrl)
		end if
		
		Dim obj
		set obj = new User
		
		obj.Id     = Trim(args("Id"))
		obj.Pwd    = Trim(args("Pwd"))
		obj.Name   = Trim(args("Name"))
		obj.Phone3 = Trim(args("Phone3"))
		obj.State  = 1
		
		Dim result : result = u.Insert(obj)
		' 세션 생성 
		session("userNo")    = obj.No
		session("userState") = 1
		Response.Redirect("?controller=Member&action=EmailPost&partial=True")
	End Sub
	
	public Sub Email()
		call checkLogin("")

		Dim u : set u = new UserHelper
		set Model = u.SelectByField("No",session("userNo"))
		
		if Model.State = "0" then
			response.redirect "?controller=Mypage&action=Modify"
		end if
		
		dim ActionSite : ActionSite = split( Model.Id , "@" )
		
		ViewData.add "ActionSite"  ,"http://" & ActionSite(1)
		ViewData.add "ActionChange","?controller=Member&action=IdChange"
		ViewData.add "ActionReSend","?controller=Member&action=EmailPost&partial=True&m=re"

		%> <!--#include file="../Views/Member/Email.asp" --> <%
	End Sub
	
	public Sub EmailPost()
		call checkLogin("")

		Dim u : set u = new UserHelper
		set Model = u.SelectByField("No",session("userNo"))
		
		if Model.State = "0" then
			response.redirect "?controller=Mypage&action=Modify"
		end if
		
		' 발송
		'	base64( no * len(id) , id )
		dim code : code = Base64encode( (Model.No * len(Model.Id)) & "," & Model.Id )
		
		dim strSubject : strSubject = Model.Name & "님 요청하신 인증번호 입니다."
		dim strBody : strBody = "이메일 인증하기<br><br><a href="""& g_host &"?controller=Member&action=Registered&code="& code &""">인증하기</a>"
		dim strTo : strTo = Model.Id
		dim strFrom : strFrom = "OPEN-IOT<no-reply@open-iot.net>"
		
		dim result : result = MailSend(strSubject, strBody, strTo, strFrom, "")
		
		
		if Trim( Request("m") ) = "re" then
			call alerts ("재발송 되었습니다.","?controller=Member&action=Email")
		else
			Response.Redirect("?controller=Member&action=Email")
		end if
	End Sub
	
	' 회원가입후 이미엘 인증 받기전 아이디 변경
	public Sub IdChange()
		call checkLogin("")
		
		Dim u : set u = new UserHelper
		set Model = u.SelectByField("No",session("userNo"))
		
		if Model.State = "0" then
			response.redirect "?controller=Mypage&action=Modify"
		end if
		
		ViewData.add "ActionForm"  ,"?controller=Member&action=IdChangePost&partial=True"
		
		%> <!--#include file="../Views/Member/IdChange.asp" --> <%
	End Sub
	
	public Sub IdChangePost()
		call checkLogin("?controller=Member&action=IdChange")
		
		Dim u : set u = new UserHelper
		set Model = u.SelectByField("No",session("userNo"))
		
		if Model.State = "0" then
			response.redirect "?controller=Mypage&action=Modify"
		end if
		
		Dim args : Set args = Request.Form
		
		if Trim(args("Id")) = "" Then
			call alerts ("아이디를 입력해주세요.","")
		end if
		if Trim(args("IdConfirm")) = "" Then
			call alerts ("아이디 확인을 입력해주세요.","")
		end if
		
		if Trim(args("Id")) <> Trim(args("IdConfirm")) Then
			call alerts ("아이디를 확인해주세요.","")
		end if
		
		Dim check : set check = u.SelectByField("Id", args("Id"))

		if Not(IsNothing (check)) Then
			call alerts ("이미 사용중인 아이디 입니다.","")
		end if
		
		Dim obj
		set obj = new User
		
		obj.Id = Trim(args("Id"))
		obj.No = session("userNo")
		
		if u.ChangeId(obj) then
			'call alerts ("변경 되었습니다.","?controller=Member&action=EmailPost&partial=True")
			call alerts ("변경 되었습니다. 다시 로그인 해주세요.","?controller=Member&action=Logout&partial=True")
		else
			call alerts ("error : 아이디 변경이 실패 했습니다. 관리자에게 문의바랍니다.","")
		end if
		

	End Sub
	
	' 이메일 인증 확인 , 회원 가입 완료
	public Sub Registered()
		dim code : code = Trim( request("code") )
		
		dim complete_code : complete_code = Base64decode( code )
		dim temp_array : temp_array = split(complete_code,",")
		dim result : result = false
		
		If ( UBound(temp_array) > 0 ) Then
		
			No = trim(temp_array(0))
			Id = trim(temp_array(1))
			No = No / len(Id)

			Dim u : set u = new UserHelper
			Dim user : set user = u.SelectByField("No", No)

			if Not(IsNothing (user)) Then
				if user.Id = Id then 
					if user.State = "0" then
						result = true
					else
						if u.EmailComplete(No) then
							result = true
						end if
					end if
					
					session("userState") = 0
				end if
			end if

		End if
		
		ViewData.add "Result" , result
		ViewData.add "ActionUrl" , "?controller=Member&action=Login"
		%> <!--#include file="../Views/Member/Registered.asp" --> <%
	End Sub
	
	public Sub Find()
		ViewData.add "ActionForm"  ,"?controller=Member&action=FindPost"
		%> <!--#include file="../Views/Member/Find.asp" --> <%
	End Sub
	
	public Sub FindPost()
		Dim args : Set args = Request.Form
		
		Dim Mode   : Mode   = Trim(args("Mode"))
		Dim Id     : Id     = Trim(args("Id"))
		Dim Name   : Name   = Trim(args("Name"))
		Dim Phone3 : Phone3 = Trim(args("Phone3"))
		
		Dim u : set u = new UserHelper
		' id 찾기
		if Mode = "findId" Then
			if Name = "" Then
				call alerts ("이름을 입력해주세요.","")
			end if
			if Phone3 = "" Then
				call alerts ("핸드폰 뒷자리 번호 4개를 입력해주세요.","")
			end if
			
			set Model = u.SelectCustom( " where Name = ? and Phone3 = ? and DelFg = 0 order by No desc " , array(Name,Phone3) )
			
			ViewData.add "ActionLogin" , "?controller=Member&action=Login"
			%> <!--#include file="../Views/Member/FindResultId.asp" --> <%
		
		' pwd 찾기
		elseif Mode = "findPwd" Then
			if Id = "" Then
				call alerts ("아이디를 입력해주세요.","")
			end if
			if Name = "" Then
				call alerts ("이름을 입력해주세요.","")
			end if
			if Phone3 = "" Then
				call alerts ("핸드폰 뒷자리 번호 4개르 입력해주세요.","")
			end if
			
			dim result : result = false
			set Model = u.SelectByField("Id", Id)
			
			if Not(IsNothing(Model)) then
				if Model.Name = Name and Model.Phone3 = Phone3 then
				
					Dim obj
					set obj = new User
					
					obj.Pwd = RandomNumber(10,"")
					obj.No  = Model.No
					'update
					if u.updatePwd(obj) then 
						'메일 발송
						
						dim strSubject : strSubject = Model.Name & "님 요청하신 임시 비밀번호 입니다."
						dim strBody : strBody = "임시 비밀번호 : " & obj.Pwd
						dim strTo : strTo = Model.Id
						dim strFrom : strFrom = "OPEN-IOT<no-reply@open-iot.net>"
						
						dim result_mail : result_mail = MailSend(strSubject, strBody, strTo, strFrom, "")
						
						result = true
					else
						call alerts ("error : 임시 비밀번호 생성이 실패 했습니다. 관리자에게 문의바랍니다.","")
					end if
					
					result = true
				end if
			end if
			
			' 메일 발송 
			ViewData.add "Result" , result
			ViewData.add "ActionLogin" , "?controller=Member&action=Login"
			%> <!--#include file="../Views/Member/FindResultPwd.asp" --> <%
		else
			call alerts ("잘못된 접근 입니다.","")
		end if
	End Sub
	 
End Class
%>
    