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
		%> <!--#include file="../Views/Member/Login.asp" --> <%
	End Sub
	
	public Sub Logout()
		'
	End Sub
	
	public Sub Registe()
		%> <!--#include file="../Views/Member/Registe.asp" --> <%
	End Sub
	
	public Sub Email()
		%> <!--#include file="../Views/Member/Email.asp" --> <%
	End Sub
	
	public Sub IdChange()
		%> <!--#include file="../Views/Member/IdChange.asp" --> <%
	End Sub
	
	public Sub Registered()
		%> <!--#include file="../Views/Member/Registered.asp" --> <%
	End Sub
	
	public Sub find()
		%> <!--#include file="../Views/Member/find.asp" --> <%
	End Sub

End Class
%>
    