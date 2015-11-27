<%
class CommunityController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		List()
	End Sub
	
	public Sub List()
		%> <!--#include file="../Views/Community/List.asp" --> <%
	End Sub
	
	public Sub Registe()
		%> <!--#include file="../Views/Community/Registe.asp" --> <%
	End Sub
	
	public Sub Proc()
		'
	End Sub

End Class
%>
    