<%
class OidController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		About()
	End Sub
	
	public Sub About()
		%> <!--#include file="../Views/Oid/Index.asp" --> <%
	End Sub
	
	public Sub Registe()
		%> <!--#include file="../Views/Oid/Registe.asp" --> <%
	End Sub

End Class
%>
    