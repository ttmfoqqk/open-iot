<%
class DeveloperSupportController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		Device()
	End Sub
	
	public Sub Device()
		%> <!--#include file="../Views/DeveloperSupport/Device.asp" --> <%
	End Sub
	
	public Sub App()
		%> <!--#include file="../Views/DeveloperSupport/App.asp" --> <%
	End Sub

End Class
%>
    