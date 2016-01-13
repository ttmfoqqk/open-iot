<%
class PageController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		AboutOpenLab()
	End Sub
	
	public Sub AboutOpenLab()
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "AboutOpenLab")
		
		if IsNothing(Model) Then
			call alerts ("잘못된 경로 입니다.","")
		end if
		
		ViewData.add "PageName","About OpenLab"
		ViewData.add "ActionForm","?controller=Page&action=RegistePost&partial=True"
		%> <!--#include file="../Views/Page/Registe.asp" --> <%
	End Sub
	
	public Sub Facility()
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "Facility")
		
		if IsNothing(Model) Then
			call alerts ("잘못된 경로 입니다.","")
		end if
		
		ViewData.add "PageName","Facility"
		ViewData.add "ActionForm","?controller=Page&action=RegistePost&partial=True"
		%> <!--#include file="../Views/Page/Registe.asp" --> <%
	End Sub
	
	public Sub DeviceDeveloper()
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "DeviceDeveloper")
		
		if IsNothing(Model) Then
			call alerts ("잘못된 경로 입니다.","")
		end if
		
		ViewData.add "PageName","Device Developer"
		ViewData.add "ActionForm","?controller=Page&action=RegistePost&partial=True"
		%> <!--#include file="../Views/Page/Registe.asp" --> <%
	End Sub
	
	public Sub AppDeveloper()
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "AppDeveloper")
		
		if IsNothing(Model) Then
			call alerts ("잘못된 경로 입니다.","")
		end if
		
		ViewData.add "PageName","App Developer"
		ViewData.add "ActionForm","?controller=Page&action=RegistePost&partial=True"
		%> <!--#include file="../Views/Page/Registe.asp" --> <%
	End Sub
	
	public Sub AboutOID()
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "AboutOID")
		
		if IsNothing(Model) Then
			call alerts ("잘못된 경로 입니다.","")
		end if
		
		ViewData.add "PageName","About OID"
		ViewData.add "ActionForm","?controller=Page&action=RegistePost&partial=True"
		%> <!--#include file="../Views/Page/Registe.asp" --> <%
	End Sub
	
	
	
	

	public Sub RegistePost()
		Dim args : Set args = Request.Form
		
		Dim obj
		set obj = new Page

		obj.No = Trim(args("No"))
		obj.Contents = Trim(args("Contents"))
		
		Dim PageHelper : set PageHelper = new PageHelper
		PageHelper.Update(obj)
		
		Response.Redirect("?controller=Page&action=" & Trim(args("action")) )
	End Sub

End Class
%>
    