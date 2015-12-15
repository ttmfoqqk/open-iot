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
		List()
	End Sub
	
	public Sub List()
		%> <!--#include file="../Views/DevicesApps/List.asp" --> <%
	End Sub
	
	public Sub Detail(vars)
		%> <!--#include file="../Views/DevicesApps/Detail.asp" --> <%
	End Sub
	
	public Sub Registe()
		%> <!--#include file="../Views/DevicesApps/Registe.asp" --> <%
	End Sub

End Class
%>