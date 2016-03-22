<%
class PageController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		admin_checkLogin()
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
		
		'파일
		Dim FilesHelper : set FilesHelper = new PageFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentName","AboutOpenLab")
		
		ViewData.add "PageName","About OpenLab"
		ViewData.add "ActionForm","?controller=Page&action=RegistePost&partial=True"
		%> <!--#include file="../Views/Page/Registe.asp" --> <%
	End Sub
	
	public Sub Facility1()
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "Facility")
		
		if IsNothing(Model) Then
			call alerts ("잘못된 경로 입니다.","")
		end if
		
		'파일
		Dim FilesHelper : set FilesHelper = new PageFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentName","Facility1")
		
		ViewData.add "PageName","Facility - 판교"
		ViewData.add "ActionForm","?controller=Page&action=RegistePost&partial=True"
		%> <!--#include file="../Views/Page/Registe.asp" --> <%
	End Sub
	
	public Sub Facility2()
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "Facility2")
		
		if IsNothing(Model) Then
			call alerts ("잘못된 경로 입니다.","")
		end if
		
		'파일
		Dim FilesHelper : set FilesHelper = new PageFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentName","Facility2")
		
		ViewData.add "PageName","Facility - 송도"
		ViewData.add "ActionForm","?controller=Page&action=RegistePost&partial=True"
		%> <!--#include file="../Views/Page/Registe.asp" --> <%
	End Sub
	
	public Sub DeviceDeveloper()
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "DeviceDeveloper")
		
		if IsNothing(Model) Then
			call alerts ("잘못된 경로 입니다.","")
		end if
		
		'파일
		Dim FilesHelper : set FilesHelper = new PageFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentName","DeviceDeveloper")
		
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
		
		'파일
		Dim FilesHelper : set FilesHelper = new PageFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentName","AppDeveloper")
		
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
		
		'파일
		Dim FilesHelper : set FilesHelper = new PageFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentName","AboutOID")
		
		ViewData.add "PageName","About OID"
		ViewData.add "ActionForm","?controller=Page&action=RegistePost&partial=True"
		%> <!--#include file="../Views/Page/Registe.asp" --> <%
	End Sub
	
	
	public Sub Company()
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "Company")
		
		if IsNothing(Model) Then
			call alerts ("잘못된 경로 입니다.","")
		end if
		
		'파일
		Dim FilesHelper : set FilesHelper = new PageFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentName","Company")
		
		ViewData.add "PageName","사이트소개"
		ViewData.add "ActionForm","?controller=Page&action=RegistePost&partial=True"
		%> <!--#include file="../Views/Page/Registe.asp" --> <%
	End Sub
	
	
	
	

	public Sub RegistePost()
		Dim uploadPath : uploadPath = "/upload/Page/"
		Dim savePath   : savePath   = server.mapPath( uploadPath ) & "/"
		
		Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
		UPLOAD__FORM.AutoMakeFolder = True 
		UPLOAD__FORM.CodePage = 65001
		UPLOAD__FORM.DefaultPath = savePath
		UPLOAD__FORM.MaxFileLen	= 50 * 1024 * 1024
		
		Dim FilesHelper : set FilesHelper = new PageFilesHelper
		Dim PageFiles : set PageFiles = new PageFiles

		Dim obj
		set obj = new Page
		action = UPLOAD__FORM("action")
		
		obj.No = UPLOAD__FORM("No")
		obj.Contents = UPLOAD__FORM("Contents")
		
		Dim PageHelper : set PageHelper = new PageHelper
		PageHelper.Update(obj)
		
		nFileCnt = UPLOAD__FORM("files").Count
		PageFiles.ParentName = action
		For i = 1 to nFileCnt
			If UPLOAD__FORM("files")(i) <> "" Then 
				PageFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
				resultFiles = FilesHelper.Insert(PageFiles)
			end if
		Next
		
		Response.Redirect("?controller=Page&action=" & Trim(action) )
	End Sub
	
	
	
	public Sub DelFile()
		Dim uploadPath : uploadPath = "/upload/Page/"
		Dim savePath   : savePath   = server.mapPath( uploadPath ) & "/"
		Dim No : No = iif(Request.Form("No")="",0,Request.Form("No"))
		
		Dim FilesHelper : set FilesHelper = new PageFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("No",No)
		
		Set FSO = Server.CreateObject("DEXT.FileUpload")
		
		if Not(IsNothing(FilesModel)) then
			For each obj in FilesModel.Items
				If (FSO.FileExists(savePath & obj.Name)) Then
					fso.deletefile(savePath & obj.Name)
				End If
				If (FSO.FileExists(savePath & "m_" & obj.Name)) Then
					fso.deletefile(savePath & "m_" & obj.Name)
				End If
				If (FSO.FileExists(savePath & "s_" & obj.Name)) Then
					fso.deletefile(savePath & "s_" & obj.Name)
				End If
				FilesHelper.Delete(obj.No)
			Next
		end if
			
		set FSO = Nothing
	End Sub

End Class
%>
    