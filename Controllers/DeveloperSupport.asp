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
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "DeviceDeveloper")
		
		'파일
		Dim FilesHelper : set FilesHelper = new PageFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentName","DeviceDeveloper")
		
		%> <!--#include file="../Views/DeveloperSupport/Device.asp" --> <%
	End Sub
	
	public Sub App()
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "AppDeveloper")
		
		'파일
		Dim FilesHelper : set FilesHelper = new PageFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentName","AppDeveloper")
		
		%> <!--#include file="../Views/DeveloperSupport/App.asp" --> <%
	End Sub

End Class
%>
    