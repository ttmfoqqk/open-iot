<%
class DevicesAppsController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		%> <!--#include file="../Views/DevicesApps/Index.asp" --> <%
	End Sub

End Class
%>
    