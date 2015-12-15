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
		
		session("userNo") = Model.No
		
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
		
		Dim result : result = u.Insert(obj)
		' 세션 생성 
		session("userNo") = obj.No
		Response.Redirect("?controller=Member&action=Email")
	End Sub
	
	public Sub Email()
		call checkLogin("")
		
		Dim u : set u = new UserHelper
		set Model = u.SelectByField("No",session("userNo"))
		
		dim ActionSite : ActionSite = split( Model.Id , "@" )
		
		ViewData.add "ActionSite"  ,"http://" & ActionSite(1)
		ViewData.add "ActionChange","?controller=Member&action=IdChange"
		ViewData.add "ActionReSend","?controller=Member&action=Email&m=re"
		' 이메일 발송
		
		Dim ReSend : ReSend = Trim(Request("m"))
		if ReSend = "re" then
			' 재발송 요청
			' 쿠키 삭제
		end if
		
		if Model.State = 1 then
			' 이메일 미인증만 , 쿠키 없을때
			' 발송
			'	base64( no * len(id) , id )
			' 쿠키 생성
		end if
		
		%> <!--#include file="../Views/Member/Email.asp" --> <%
	End Sub
	
	public Sub IdChange()
		' 회원가입후 이미엘 인증 받기전 아이디 변경
		%> <!--#include file="../Views/Member/IdChange.asp" --> <%
	End Sub
	
	public Sub Registered()
		' 이메일 인증 확인 페이지 생성
		%> <!--#include file="../Views/Member/Registered.asp" --> <%
	End Sub
	
	public Sub Find()
		' 처리 페이지 id 출력 , 임시비밀번호 이메일 발송 
		%> <!--#include file="../Views/Member/find.asp" --> <%
	End Sub

End Class
%>
    