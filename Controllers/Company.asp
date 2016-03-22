<%
class CompanyController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "Company")
		
		'파일
		Dim FilesHelper : set FilesHelper = new PageFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentName","Company")
		
		%> <!--#include file="../Views/Company/Index.asp" --> <%
	End Sub
	
	public Sub Use()
		Dim PolicyHelper : set PolicyHelper = new PolicyHelper
		set Model = PolicyHelper.SelectAll()
		%> <!--#include file="../Views/Company/Use.asp" --> <%
	End Sub
	
	public Sub Policy()
		Dim PolicyHelper : set PolicyHelper = new PolicyHelper
		set Model = PolicyHelper.SelectAll()
		%> <!--#include file="../Views/Company/Policy.asp" --> <%
	End Sub
End Class
%>