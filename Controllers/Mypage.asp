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
		%> <!--#include file="../Views/Mypage/Modify.asp" --> <%
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
		%> <!--#include file="../Views/Mypage/Secede.asp" --> <%
	End Sub
End Class
%>
    