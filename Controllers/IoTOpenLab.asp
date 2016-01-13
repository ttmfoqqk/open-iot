<%
class IoTOpenLabController
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
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "AboutOpenLab")
		%> <!--#include file="../Views/IoTOpenLab/Index.asp" --> <%
	End Sub
	
	public Sub Facility()
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "Facility")
		%> <!--#include file="../Views/IoTOpenLab/Facility.asp" --> <%
	End Sub
	
	public Sub Reservation()
		%> <!--#include file="../Views/IoTOpenLab/Reservation.asp" --> <%
	End Sub

End Class
%>