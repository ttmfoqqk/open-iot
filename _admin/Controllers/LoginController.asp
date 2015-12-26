<%
class LoginController
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
		ViewData.add "ActionForm"    , "?controller=Login&action=LoginPost&partial=True"
		ViewData.add "GoUrl"  , request("goUrl")
		ViewData.add "SaveId" , Request.Cookies("AdminSaveId")
		ViewData.add "SaveIdChecked" , iif( Request.Cookies("AdminSaveId")="","","checked" )
		%> <!--#include file="../Views/Admin/Login.asp" --> <%
	End Sub
	
	public Sub LoginPost()
		Dim args : Set args = Request.Form
		
		if Trim(args("Id")) = "" Then
			call alerts ("아이디를 입력해주세요.","")
		end if
		
		if Trim(args("Pwd")) = "" Then
			call alerts ("비밀번호를 입력해주세요.","")
		end if
		
		Dim obj : set obj = new Admin
		
		obj.Id  = Trim(args("Id"))
		obj.Pwd = Trim(args("Pwd"))
		
		Dim AdminHelper : set AdminHelper = new AdminHelper
		set Model = AdminHelper.Login( obj )
		
		if IsNothing(Model) Then
			call alerts ("입력하신 아이디 혹은 비밀번호가 일치하지 않습니다.","")
		end if
		
		if Trim(args("saveId"))="on" then
			Response.Cookies("AdminSaveId") = Model.Id
			Response.Cookies("AdminSaveId").expires = date + 365
		else
			Response.Cookies("AdminSaveId") = ""
			Response.Cookies("AdminSaveId").expires = date - 1
		end if
		
		session("adminNo") = Model.No
		
		if Trim(args("goUrl")) = "" then
			Response.Redirect("?controller=Company&action=Policy")
		else
			Response.Redirect(Trim(args("goUrl")))
		end if
		
	End Sub
	
	public Sub Logout()
		Session.Contents.RemoveAll()
		Response.Redirect("?")
	End Sub
	
End Class
%>
    