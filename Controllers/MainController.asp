<%
class MainController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		call checkEmailConfirm()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		%> <!--#include file="../Views/Main/Index.asp" --> <%
	End Sub

End Class
%>
    