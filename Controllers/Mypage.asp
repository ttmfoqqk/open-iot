<%
class MypageController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		Modify()
	End Sub
	
	public Sub Modify()
		call checkLogin("")
		call checkEmailConfirm()
		
		Dim UserHelper : set UserHelper = new UserHelper
		set Model = UserHelper.SelectByField("No",session("userNo"))
		
		ViewData.add "ActionForm"  ,"?controller=Mypage&action=ModifyPost&partial=True"
		%> <!--#include file="../Views/Mypage/Modify.asp" --> <%
	End Sub
	
	public Sub ModifyPost()
		call checkLogin("?controller=Mypage&action=Modify")
		call checkEmailConfirm()
		
		Dim args : Set args = Request.Form
		
		Dim Pwd : Pwd = Trim( args("Pwd") )
		Dim PwdConfirm : PwdConfirm = Trim( args("PwdConfirm") )
		Dim Phone3 : Phone3 = Trim( args("Phone3") )
		
		if Trim(Pwd) = "" Then
			call alerts ("비밀번호를 입력해주세요.","")
		end if
		
		if Trim(PwdConfirm) = "" Then
			call alerts ("비밀번호 확인을 입력해주세요.","")
		end if
		
		if Trim(Pwd) <> Trim(PwdConfirm) Then
			call alerts ("비밀번호를 확인해주세요.","")
		end if
		
		if Trim(Phone3) = "" Then
			call alerts ("핸드폰 뒷자리 번호를 입력해주세요.","")
		end if
		
		Dim UserHelper : set UserHelper = new UserHelper
		Dim obj : set obj = new User
		
		obj.No     = session("userNo")
		obj.Pwd    = Pwd
		obj.Phone3 = Phone3
		
		if UserHelper.Update(obj) then 
			call alerts ("변경되었습니다.","?controller=Mypage&action=Modify")
		else
			call alerts ("error : 정보변경이 실패 했습니다. 관리자에게 문의바랍니다.","")
		end if
		
	End Sub
	
	public Sub Inquiry()
		%> <!--#include file="../Views/Mypage/Index.asp" --> <%
	End Sub
	
	public Sub Qna()
		%> <!--#include file="../Views/Mypage/Index.asp" --> <%
	End Sub
	
	public Sub Oid()
		%> <!--#include file="../Views/Mypage/Oid.asp" --> <%
	End Sub
	
	public Sub DevicesApps()
		%> <!--#include file="../Views/Mypage/DevicesApps.asp" --> <%
	End Sub
	
	public Sub Secede()
		call checkLogin("")
		
		Dim UserHelper : set UserHelper = new UserHelper
		set Model = UserHelper.SelectByField("No",session("userNo"))
		
		ViewData.add "ActionForm"  ,"?controller=Mypage&action=SecedePost&partial=True"
		
		%> <!--#include file="../Views/Mypage/Secede.asp" --> <%
	End Sub
	
	public Sub SecedePost()
		call checkLogin("?controller=Mypage&action=Secede")
		
		Dim args : Set args = Request.Form
		
		Dim Pwd : Pwd = Trim( args("Pwd") )
		
		if Trim(Pwd) = "" Then
			call alerts ("비밀번호를 입력해주세요.","")
		end if
		
		Dim UserHelper : set UserHelper = new UserHelper
		Dim User : set User = UserHelper.SelectByField("No",session("userNo"))
		
		Dim obj : set obj = new User
		
		obj.Id  = User.Id
		obj.Pwd = Pwd
		
		set Model = UserHelper.Login(obj)
		
		if IsNothing(Model) Then
			call alerts ("비밀번호가 일치하지 않습니다.","")
		else
			if UserHelper.Delete(User.No) then
				call alerts ("정상 처리되었습니다.","?controller=Member&action=Logout&partial=True")
			else
				call alerts ("error : 탈퇴신청이 실패 했습니다. 관리자에게 문의바랍니다.","")
			end if
		end if

	End Sub
	
End Class
%>
    