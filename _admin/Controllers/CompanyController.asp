<%
class CompanyController
	Dim Model
	Dim ViewData
	Dim ParamData

	private sub Class_Initialize()
		admin_checkLogin()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
		Set ParamData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		Policy()
	End Sub
	
	public Sub Policy()
		Dim PolicyHelper : set PolicyHelper = new PolicyHelper
		set Model = PolicyHelper.SelectAll()
		ViewData.add "ActionForm","?controller=Company&action=PolicyPost&partial=True"
		%> <!--#include file="../Views/Company/Policy.asp" --> <%
	End Sub

	public Sub PolicyPost()
		Dim args : Set args = Request.Form
		
		Dim obj
		set obj = new Policys

		obj.Policy1 = Trim(args("Policy1"))
		obj.Policy2 = Trim(args("Policy2"))
		
		Dim PolicyHelper : set PolicyHelper = new PolicyHelper
		PolicyHelper.Update(obj)
		
		Response.Redirect("?controller=Company&action=Policy")
	End Sub


	public Sub Member()
		ParamData.Add "mode"  , iif(Request("mode")="","List",Request("mode"))
		ParamData.Add "sDate" , iif(Request("sDate")="","",Request("sDate"))
		ParamData.Add "eDate" , iif(Request("eDate")="","",Request("eDate"))
		ParamData.Add "Id"    , iif(Request("Id")="","",Request("Id"))
		ParamData.Add "Name"  , iif(Request("Name")="","",Request("Name"))
		ParamData.Add "pageNo", iif(Request("pageNo")="",1,Request("pageNo"))
		ParamData.Add "url"   , "&sDate=" & ParamData("sDate") & "&eDate=" & ParamData("eDate") & "&Id=" & ParamData("Id") & "&Name=" & ParamData("Name")
		
		if ParamData("mode") = "List" then
			call MemberList()
		elseif ParamData("mode") = "Registe" then
			call MemberRegiste()
		end if
	End Sub
	
	
	
	private Sub MemberList()
		Dim rows    : rows    = 10
		Dim pageUrl : pageUrl = "?controller=Company&action=Member&mode=List" & ParamData("url")
		
		Dim objs : set objs = new Admin
		objs.Sdate = ParamData("sDate")
		objs.Edate = ParamData("eDate")
		objs.Id    = ParamData("Id")
		objs.Name  = ParamData("Name")
		
		Dim AdminHelper : set AdminHelper = new AdminHelper
		set Model = AdminHelper.SelectAll(objs,ParamData("pageNo"),rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if
		
		ViewData.add "pagination" ,printPageList(pTotCount, cint(ParamData("pageNo")), rows, pageUrl & "&pageNo=__PAGE__")
		ViewData.add "ActionRegiste","?controller=Company&action=Member&mode=Registe" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Company&action=MemberPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionType","DELETE"
		%> <!--#include file="../Views/Company/MemberList.asp" --> <%
	End Sub
	
	private Sub MemberRegiste()
		Dim No : No = iif(Request("No")="",0,Request("No"))
		
		Dim AdminHelper : set AdminHelper = new AdminHelper
		set Model = AdminHelper.SelectByField("No",No)
		
		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			set Model = new Admin
		end if
		
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=Company&action=Member&mode=List" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Company&action=MemberPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/Company/MemberRegiste.asp" --> <%
	End Sub
	
	
	public Sub MemberPost()
		Dim ActionType : ActionType = Request.Form("ActionType")
		Dim Params : Params = Request.Form("Params")
		Dim No : No = Trim( iif(Request.Form("No")="",0,Request.Form("No")) )
		Dim Id : Id = Trim(Request.Form("Id"))
		Dim Pwd : Pwd = Trim(Request.Form("Pwd"))
		Dim Name : Name = Trim(Request.Form("Name"))
		Dim Email : Email = Trim(Request.Form("Email"))
		
		Dim AdminHelper : set AdminHelper = new AdminHelper
		Dim obj : set obj = new Admin
		Dim result
		
		if ActionType = "INSERT" then
			if Id = "" then 
				call alerts ("아이디를 입력해주세요.","")
			end if
			if Pwd = "" then 
				call alerts ("비밀번호를 입력해주세요.","")
			end if
			if Name = "" then 
				call alerts ("이름을 입력해주세요.","")
			end if
			if Email = "" then 
				call alerts ("이메일을 입력해주세요.","")
			end if

			Set Model = AdminHelper.SelectByField("Id", Id)
			
			if Not( IsNothing(Model) ) then
				call alerts ("이미 등록된 아이디입니다.","")
			end if

			obj.Id = Id
			obj.Pwd = Pwd
			obj.Name = Name
			obj.Email = Email
			
			result = AdminHelper.Insert(obj)
			call alerts ("등록되었습니다.","?controller=Company&action=Member&mode=List")

		elseif ActionType = "UPDATE" then
			if Pwd = "" then 
				call alerts ("비밀번호를 입력해주세요.","")
			end if
			if Name = "" then 
				call alerts ("이름을 입력해주세요.","")
			end if
			
			obj.No = No
			obj.Pwd = Pwd
			obj.Name = Name
			obj.Email = Email
			
			AdminHelper.Update(obj)
			call alerts ("수정되었습니다.","?controller=Company&action=Member&mode=List" & Params )
			
		elseif ActionType = "DELETE" then
			AdminHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=Company&action=Member&mode=List" & Params )
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	
	
	
	
	
	
	
	public Sub Agencies()
		ParamData.Add "mode"  , iif(Request("mode")="","List",Request("mode"))
		ParamData.Add "Name"  , iif(Request("Name")="","",Request("Name"))
		ParamData.Add "pageNo", iif(Request("pageNo")="",1,Request("pageNo"))
		ParamData.Add "url"   , "&Name=" & ParamData("Name")
		
		if ParamData("mode") = "List" then
			call AgenciesList()
		elseif ParamData("mode") = "Registe" then
			call AgenciesRegiste()
		elseif ParamData("mode") = "Excel" then
			call AgenciesExcel()
		end if
	End Sub
	
	private Sub AgenciesList()
		Dim rows    : rows    = 10
		Dim pageUrl : pageUrl = "?controller=Company&action=Agencies&mode=List" & ParamData("url")

		Dim objs : set objs = new Agencie
		objs.Name  = ParamData("Name")
		
		Dim AgencieHelper : set AgencieHelper = new AgencieHelper
		set Model = AgencieHelper.SelectAll(objs,ParamData("pageNo"),rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if
		
		ViewData.add "pagination" ,printPageList(pTotCount, cint(ParamData("pageNo")), rows, pageUrl & "&pageNo=__PAGE__")
		ViewData.add "ActionRegiste","?controller=Company&action=Agencies&mode=Registe" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Company&action=AgenciesPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionType","DELETE"
		ViewData.add "ActionExcel","?controller=Company&action=Agencies&mode=Excel&partial=True" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/Company/AgencieList.asp" --> <%
	End Sub
	
	private Sub AgenciesExcel()
		Session.Timeout = 600
		Server.ScriptTimeOut = 60*60*60 '초
		
		Dim objs : set objs = new Agencie
		objs.Name  = ParamData("Name")
		
		Dim AgencieHelper : set AgencieHelper = new AgencieHelper
		set Model = AgencieHelper.SelectAll(objs,1,100000000)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if
		
		Dim tmp_html : tmp_html = "" &_
		"<?xml version=""1.0"" encoding=""utf-8""?>" &_
		"<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:o=""urn:schemas-microsoft-com:office:office"" xmlns:x=""urn:schemas-microsoft-com:office:excel"" xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:html=""http://www.w3.org/TR/REC-html40"">" &_
		"<Worksheet ss:Name=""관련 기관 관리""> " &_
		"<Table> " &_
		"	<Column ss:Width='300'/> " &_
		"	<Column ss:Width='400'/> " &_
		"	<Column ss:Width='80'/> " &_
		"	<Row> "&_
		"		<Cell><Data ss:Type=""String"">이름</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">URL</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">순서</Data></Cell> "&_
		"	</Row> "
		
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				tmp_html = tmp_html & "" &_
				"	<Row> "&_
				"		<Cell><Data ss:Type=""String"">" & obj.Name & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.Url & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & iif(obj.OrderNo="" or IsNothing(obj.OrderNo),"0",obj.OrderNo) & "</Data></Cell>"&_
				"	</Row> "
			next
		else
			tmp_html = tmp_html & "<Row><Cell><Data ss:Type=""String"">등록된 내용이 없습니다.</Data></Cell></Row>"
		end if
		tmp_html = tmp_html & "</Table></Worksheet></Workbook>"
		Response.write tmp_html
		
		Response.Buffer = True
		Response.ContentType = "appllication/vnd.ms-excel" '// 엑셀로 지정
		Response.CacheControl = "public"
		Response.AddHeader "Content-Disposition","attachment; filename=관련 기관 관리 " & Now() & ".xls"
		
	End Sub
	
	private Sub AgenciesRegiste()
		Dim No : No = iif(Request("No")="",0,Request("No"))
		
		Dim AgencieHelper : set AgencieHelper = new AgencieHelper
		set Model = AgencieHelper.SelectByField("No",No)
		
		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			set Model = new Agencie
		end if
		
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=Company&action=Agencies&mode=List" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Company&action=AgenciesPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/Company/AgencieRegiste.asp" --> <%
	End Sub
	
	
	public Sub AgenciesPost()
		Dim uploadPath : uploadPath = "/upload/Agencie/"
		Dim savePath   : savePath   = server.mapPath( uploadPath ) & "/"
		
		Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
		UPLOAD__FORM.AutoMakeFolder = True 
		UPLOAD__FORM.CodePage = 65001
		UPLOAD__FORM.DefaultPath = savePath
		UPLOAD__FORM.MaxFileLen	= 500 * 1024 * 1024 '500메가
		
		Dim ActionType : ActionType = UPLOAD__FORM("ActionType")
		Dim Params     : Params     = UPLOAD__FORM("Params")
		
		Dim No       : No       = Trim( iif(UPLOAD__FORM("No")="",0,UPLOAD__FORM("No")) )
		Dim Name    : Name    = TagEncode( Trim(UPLOAD__FORM("Name")) )
		Dim Url : Url = Trim(UPLOAD__FORM("Url"))
		Dim OrderNo : OrderNo = Trim( iif(UPLOAD__FORM("OrderNo")="",0,UPLOAD__FORM("OrderNo")) )
		
		Dim Images     : Images      = Trim(UPLOAD__FORM("Images"))
		Dim oldImages  : oldImages = Trim(UPLOAD__FORM("oldImages"))
		Dim dellImages : dellImages  = Trim(UPLOAD__FORM("dellImages"))
		

		Dim AgencieHelper : set AgencieHelper = new AgencieHelper
		Dim obj : set obj = new Agencie
		
		if ActionType = "INSERT" then
			if Name = "" then 
				call alerts ("이름을 입력해주세요.","")
			end if

			Images = fileUpload_proc(UPLOAD__FORM,savePath, Images , "Images" , oldImages , dellImages )

			obj.Name = Name
			obj.Url = Url
			obj.Images = Images
			obj.OrderNo = OrderNo

			AgencieHelper.Insert(obj)
			call alerts ("등록되었습니다.","?controller=Company&action=Agencies&mode=List")
		
		elseif ActionType = "UPDATE" then
			if Name = "" then 
				call alerts ("이름을 입력해주세요.","")
			end if

			Images = fileUpload_proc(UPLOAD__FORM,savePath, Images , "Images" , oldImages , dellImages )
			
			obj.No = No
			obj.Name = Name
			obj.Url = Url
			obj.Images = Images
			obj.OrderNo = OrderNo

			AgencieHelper.Update(obj)
			call alerts ("수정되었습니다.","?controller=Company&action=Agencies&mode=List" & Params )
		elseif ActionType = "DELETE" then
			AgencieHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=Company&action=Agencies&mode=List" & Params )
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	
	
	
	
	'''''''''''''''''''''''''''
	public Sub AdBanners()
		ParamData.Add "mode"  , iif(Request("mode")="","List",Request("mode"))
		ParamData.Add "Name"  , iif(Request("Name")="","",Request("Name"))
		ParamData.Add "pageNo", iif(Request("pageNo")="",1,Request("pageNo"))
		ParamData.Add "url"   , "&Name=" & ParamData("Name")
		
		'if ParamData("mode") = "List" then
		'	call AdBannerList()
		'elseif ParamData("mode") = "Registe" then
		'	call AdBannerRegiste()
		'end if
		
		call AdBannerRegiste()
	End Sub
	
	private Sub AdBannerList()
		Dim rows    : rows    = 10
		Dim pageUrl : pageUrl = "?controller=Company&action=AdBanners&mode=List" & ParamData("url")

		Dim objs : set objs = new AdBanner
		objs.Name  = ParamData("Name")
		
		Dim AdBannerHelper : set AdBannerHelper = new AdBannerHelper
		set Model = AdBannerHelper.SelectAll(objs,ParamData("pageNo"),rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if
		
		ViewData.add "pagination" ,printPageList(pTotCount, cint(ParamData("pageNo")), rows, pageUrl & "&pageNo=__PAGE__")
		ViewData.add "ActionRegiste","?controller=Company&action=AdBanners&mode=Registe" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Company&action=AdBannerPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionType","DELETE"
		%> <!--#include file="../Views/Company/AdBannerList.asp" --> <%
	End Sub
	
	private Sub AdBannerRegiste()
		'Dim No : No = iif(Request("No")="",0,Request("No"))
		Dim No : No = 1
		
		Dim AdBannerHelper : set AdBannerHelper = new AdBannerHelper
		set Model = AdBannerHelper.SelectByField("No",No)
		
		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			set Model = new AdBanner
		end if
		
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=Company&action=AdBanners&mode=List" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Company&action=AdBannerPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/Company/AdBannerRegiste.asp" --> <%
	End Sub
	
	
	public Sub AdBannerPost()
		Dim uploadPath : uploadPath = "/upload/AdBanner/"
		Dim savePath   : savePath   = server.mapPath( uploadPath ) & "/"
		
		Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
		UPLOAD__FORM.AutoMakeFolder = True 
		UPLOAD__FORM.CodePage = 65001
		UPLOAD__FORM.DefaultPath = savePath
		UPLOAD__FORM.MaxFileLen	= 500 * 1024 * 1024 '500메가
		
		Dim ActionType : ActionType = UPLOAD__FORM("ActionType")
		Dim Params     : Params     = UPLOAD__FORM("Params")
		
		Dim No      : No      = Trim( iif(UPLOAD__FORM("No")="",0,UPLOAD__FORM("No")) )
		Dim Position: Position= Trim(UPLOAD__FORM("Position"))
		Dim Name    : Name    = TagEncode( Trim(UPLOAD__FORM("Name")) )
		Dim Url     : Url     = Trim(UPLOAD__FORM("Url"))
		Dim OrderNo : OrderNo = Trim( iif(UPLOAD__FORM("OrderNo")="",0,UPLOAD__FORM("OrderNo")) )
		
		Dim Image     : Image      = Trim(UPLOAD__FORM("Image"))
		Dim oldImage  : oldImage = Trim(UPLOAD__FORM("oldImage"))
		Dim dellImage : dellImage  = Trim(UPLOAD__FORM("dellImage"))
		

		Dim AdBannerHelper : set AdBannerHelper = new AdBannerHelper
		Dim obj : set obj = new AdBanner
		
		if ActionType = "INSERT" then
			if Name = "" then 
				call alerts ("이름을 입력해주세요.","")
			end if

			Image = fileUpload_proc(UPLOAD__FORM,savePath, Image , "Image" , oldImage , dellImage )
			
			obj.Position = Position
			obj.Name = Name
			obj.Url = Url
			obj.Image = Image
			obj.OrderNo = OrderNo

			AdBannerHelper.Insert(obj)
			call alerts ("등록되었습니다.","?controller=Company&action=AdBanners&mode=List")
		
		elseif ActionType = "UPDATE" then
			if Name = "" then 
				call alerts ("이름을 입력해주세요.","")
			end if

			Image = fileUpload_proc(UPLOAD__FORM,savePath, Image , "Image" , oldImage , dellImage )
			
			obj.Position = Position
			obj.No = No
			obj.Name = Name
			obj.Url = Url
			obj.Image = Image
			obj.OrderNo = OrderNo

			AdBannerHelper.Update(obj)
			call alerts ("수정되었습니다.","?controller=Company&action=AdBanners&mode=List" & Params )
		elseif ActionType = "DELETE" then
			BoardHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=Company&action=AdBanners&mode=List" & Params )
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	
	
	
	
	
	
	
	function fileUpload_proc( UPLOAD__FORM ,savePath , file , input , oldFile , delfg )
		dim return_fileName
		If file <>"" Then 
			If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM(input).FileLen Then 
				return_fileName = DextFileUpload(UPLOAD__FORM(input),savePath,true)
			Else
				call alerts ("파일의 크기는 50MB 를 넘길수 없습니다.","")
			End If

			If oldFile <> "" Then
				Set FSO = Server.CreateObject("DEXT.FileUpload")
					If (FSO.FileExists(savePath & oldFile)) Then
						fso.deletefile(savePath & oldFile)
					End If
					If (FSO.FileExists(savePath & "m_" & oldFile)) Then
						fso.deletefile(savePath & "m_" & oldFile)
					End If
					If (FSO.FileExists(savePath & "s_" & oldFile)) Then
						fso.deletefile(savePath & "s_" & oldFile)
					End If
				set FSO = Nothing
			End If
		Else
			If delfg = "1" Then 
				If oldFile <> "" Then
					Set FSO = Server.CreateObject("DEXT.FileUpload")
						If (FSO.FileExists(savePath & oldFile)) Then
							fso.deletefile(savePath & oldFile)
						End If
						If (FSO.FileExists(savePath & "m_" & oldFile)) Then
							fso.deletefile(savePath & "m_" & oldFile)
						End If
						If (FSO.FileExists(savePath & "s_" & oldFile)) Then
							fso.deletefile(savePath & "s_" & oldFile)
						End If
					set FSO = Nothing
				End If
				return_fileName = ""
			else
				return_fileName = oldFile
			End If		
		End If
		fileUpload_proc = return_fileName
	end function

End Class
%>
    