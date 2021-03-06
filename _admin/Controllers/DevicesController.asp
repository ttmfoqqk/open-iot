<%
class DevicesController
	Dim Model
	Dim ViewData
	Dim ParamData
	Dim uploadPath
	Dim savePath
	private sub Class_Initialize()
		admin_checkLogin()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
		Set ParamData = Server.CreateObject("Scripting.Dictionary")
		uploadPath = "/upload/Devices/"
		savePath   = server.mapPath( uploadPath ) & "/"
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		ParamData.Add "mode"     , iif(Request("mode")="","List",Request("mode"))
		ParamData.Add "sDate"    , iif(Request("sDate")="","",Request("sDate"))
		ParamData.Add "eDate"    , iif(Request("eDate")="","",Request("eDate"))
		ParamData.Add "UserId"   , iif(Request("UserId")="","",Request("UserId"))
		ParamData.Add "UserName" , iif(Request("UserName")="","",Request("UserName"))
		ParamData.Add "Name"     , iif(Request("Name")="","",Request("Name"))
		ParamData.Add "MenuNo"   , iif(Request("MenuNo")="","",Request("MenuNo"))
		ParamData.Add "State"    , iif(Request("State")="","",Request("State"))
		ParamData.Add "pageNo"   , iif(Request("pageNo")="",1,Request("pageNo"))
		ParamData.Add "No"       , iif(Request("No")="",0,Request("No"))
		ParamData.Add "url"      , "&sDate=" & ParamData("sDate") & "&eDate=" & ParamData("eDate") &_
		 "&UserId=" & ParamData("UserId") & "&UserName=" & ParamData("UserName") & "&Name=" & ParamData("Name") & "&MenuNo=" & ParamData("MenuNo") &_
		 "&State=" & ParamData("State")
		 
		if ParamData("mode") = "List" then
			call DevicesList()
		elseif ParamData("mode") = "Registe" then
			call DevicesRegiste()
		elseif ParamData("mode") = "Excel" then
			call DevicesExcel()
		end if
	End Sub
	
	
	private Sub DevicesList()
		Dim rows    : rows    = 10
		Dim pageUrl : pageUrl = "?controller=Devices&action=Index&mode=List" & ParamData("url")
		
		Dim objs : set objs = new Devices
		objs.UserId   = ParamData("UserId")
		objs.UserName = ParamData("UserName")
		objs.Name     = ParamData("Name")
		objs.MenuNo   = ParamData("MenuNo")
		objs.Sdate    = ParamData("sDate")
		objs.Edate    = ParamData("eDate")
		objs.State    = ParamData("State")
		
		'메뉴
		Dim MenuObj : set MenuObj = new DevicesMenu
		MenuObj.Name = ""
		Dim DevicesMenuHelper : set DevicesMenuHelper = new DevicesMenuHelper
		Dim DevicesMenuModel  : set DevicesMenuModel = DevicesMenuHelper.SelectAll(MenuObj,1,1000)

		Dim DevicesHelper : set DevicesHelper = new DevicesHelper
		set Model = DevicesHelper.SelectAll(objs,ParamData("pageNo"),rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if
		

		ViewData.add "pagination" ,printPageList(pTotCount, cint(ParamData("pageNo")), rows, pageUrl & "&pageNo=__PAGE__")
		ViewData.add "ActionRegiste","?controller=Devices&action=Index&mode=Registe" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Devices&action=DevicesPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionType","DELETE"
		ViewData.add "ActionExcel","?controller=Devices&action=Index&mode=Excel&partial=True" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/DevicesApps/DevicesList.asp" --> <%
	End Sub
	
	private Sub DevicesExcel()
		Session.Timeout = 600
		Server.ScriptTimeOut = 60*60*60 '초
		
		Dim objs : set objs = new Devices
		objs.UserId   = ParamData("UserId")
		objs.UserName = ParamData("UserName")
		objs.Name     = ParamData("Name")
		objs.MenuNo   = ParamData("MenuNo")
		objs.Sdate    = ParamData("sDate")
		objs.Edate    = ParamData("eDate")
		objs.State    = ParamData("State")
		
		Dim DevicesHelper : set DevicesHelper = new DevicesHelper
		set Model = DevicesHelper.SelectAll(objs,1,100000000)
		
		Dim tmp_html : tmp_html = "" &_
		"<?xml version=""1.0"" encoding=""utf-8""?>" &_
		"<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:o=""urn:schemas-microsoft-com:office:office"" xmlns:x=""urn:schemas-microsoft-com:office:excel"" xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:html=""http://www.w3.org/TR/REC-html40"">" &_
		"<Worksheet ss:Name=""Devices 관리""> " &_
		"<Table> " &_
		"	<Column ss:Width='200'/> " &_
		"	<Column ss:Width='200'/> " &_
		"	<Column ss:Width='200'/> " &_
		"	<Column ss:Width='150'/> " &_
		"	<Column ss:Width='150'/> " &_
		"	<Column ss:Width='80'/> " &_
		"	<Row> "&_
		"		<Cell><Data ss:Type=""String"">분류</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">디바이스명</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">아이디</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">이름</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">등록일</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">상태</Data></Cell> "&_
		"	</Row> "
		
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items

				tmp_html = tmp_html & "" &_
				"	<Row> "&_
				"		<Cell><Data ss:Type=""String"">" & obj.MenuName & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.Name & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.UserId & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.UserName & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.Indate & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & iif(obj.State="0","승인","미승인") & "</Data></Cell>"&_
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
		Response.AddHeader "Content-Disposition","attachment; filename=Devices 관리 " & Now() & ".xls"
		
	End Sub
	
	
	public sub AjaxDevicesList()
		Dim MenuNo : MenuNo = iif(Request("MenuNo")="","",Request("MenuNo"))

		Dim DevicesHelper : set DevicesHelper = new DevicesHelper
		Dim objs : set objs = new Devices
		
		objs.MenuNo = MenuNo
		objs.State = 0
		set Model = DevicesHelper.SelectAll(objs,1,1000)

		
		sJsonText = ""
		sJsonText = sJsonText & "{'MSG':'success','LIST':["

		if Not( IsNothing(Model) ) then
			cnt = 1
			For each obj in Model.Items

				sJsonText = sJsonText & "{"
				sJsonText = sJsonText & "'No' : '" & obj.No & "',"
				sJsonText = sJsonText & "'Name' : '" & Replace(toJS(obj.Name),"""","\""") & "'"
				sJsonText = sJsonText & "}"
				sJsonText = sJsonText & iif(cnt=Model.Count,"",",")
				cnt = cnt + 1
			next
		end if
		
		sJsonText = sJsonText & "]}"
		sJsonText = Replace(sJsonText,"'",Chr(34))
		Response.write sJsonText
	end sub
	
	private Sub DevicesRegiste()
		Dim DevicesHelper : set DevicesHelper = new DevicesHelper
		set Model = DevicesHelper.SelectByField("No",ParamData("No"))

		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			Dim AdminHelper : set AdminHelper = new AdminHelper
			Dim AdminModel  : set AdminModel = AdminHelper.SelectByField("No",session("adminNo"))
		
			set Model = new Devices
			Model.UserId = AdminModel.Id
			Model.UserName = AdminModel.Name
		end if
		
		'메뉴
		Dim MenuObj : set MenuObj = new DevicesMenu
		MenuObj.Name = ""
		Dim DevicesMenuHelper : set DevicesMenuHelper = new DevicesMenuHelper
		Dim DevicesMenuModel  : set DevicesMenuModel = DevicesMenuHelper.SelectAll(MenuObj,1,1000)
		
		'파일
		Dim DevicesFilesHelper : set DevicesFilesHelper = new DevicesFilesHelper
		Dim DevicesFilesModel  : set DevicesFilesModel = DevicesFilesHelper.SelectByField("ParentNo",ParamData("No"))
		
		
		'관련 어플 - 메뉴
		Dim ProductMenu : set ProductMenu = new AppsMenu
		Dim ProductMenuHelper : set ProductMenuHelper = new AppsMenuHelper
		Dim ProductMenuModel  : set ProductMenuModel = ProductMenuHelper.SelectAll(ProductMenu,1,1000)
		'관련 어플 - 전체 어플 리스트
		'Dim ProductObj : set ProductObj = new Apps
		'ProductObj.State = 0
		'Dim ProductHelper : set ProductHelper = new AppsHelper
		'Dim ProductModel : set ProductModel = ProductHelper.SelectAll(ProductObj,1,1000)
		
		'관련 어플 - 등록 어플 리스트
		Dim RelationHelper : set RelationHelper = new DevicesRelationHelper
		Dim RelationModel : set RelationModel = RelationHelper.SelectByField("ParentNo", ParamData("No"))
		
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=Devices&action=Index&mode=List" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Devices&action=DevicesPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/DevicesApps/DevicesRegiste.asp" --> <%
	End Sub
	
	public Sub DevicesPost()
		Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
		UPLOAD__FORM.AutoMakeFolder = True 
		UPLOAD__FORM.CodePage = 65001
		UPLOAD__FORM.DefaultPath = savePath
		UPLOAD__FORM.MaxFileLen	= 50 * 1024 * 1024 '50메가
		
		Dim ActionType : ActionType = UPLOAD__FORM("ActionType")
		Dim Params     : Params     = UPLOAD__FORM("Params")
		
		Dim No        : No        = Trim( iif(UPLOAD__FORM("No")="",0,UPLOAD__FORM("No")) )
		Dim Name      : Name      = TagEncode( Trim(UPLOAD__FORM("Name")) )
		Dim MenuNo    : MenuNo    = Trim(UPLOAD__FORM("MenuNo"))
		Dim Contents1 : Contents1 = Trim(UPLOAD__FORM("Contents1"))
		Dim Contents2 : Contents2 = Trim(UPLOAD__FORM("Contents2"))
		Dim Contents3 : Contents3 = Trim(UPLOAD__FORM("Contents3"))
		
		Dim Images1 : Images1 = UPLOAD__FORM("images_files1")
		Dim Images2 : Images2 = UPLOAD__FORM("images_files2")
		Dim Images3 : Images3 = UPLOAD__FORM("images_files3")
		Dim Images4 : Images4 = UPLOAD__FORM("images_files4")
		Dim ImagesList : ImagesList = UPLOAD__FORM("ImagesList")
		
		Dim OldImages1 : OldImages1 = UPLOAD__FORM("images_files1_old")
		Dim OldImages2 : OldImages2 = UPLOAD__FORM("images_files2_old")
		Dim OldImages3 : OldImages3 = UPLOAD__FORM("images_files3_old")
		Dim OldImages4 : OldImages4 = UPLOAD__FORM("images_files4_old")
		Dim OldImagesList : OldImagesList = UPLOAD__FORM("ImagesList_old")
		
		Dim Del_images_files1 : Del_images_files1 = UPLOAD__FORM("Del_images_files1")
		Dim Del_images_files2 : Del_images_files2 = UPLOAD__FORM("Del_images_files2")
		Dim Del_images_files3 : Del_images_files3 = UPLOAD__FORM("Del_images_files3")
		Dim Del_images_files4 : Del_images_files4 = UPLOAD__FORM("Del_images_files4")
		Dim Del_ImagesList : Del_ImagesList = UPLOAD__FORM("Del_ImagesList")
		
		Dim State : State = iif(UPLOAD__FORM("State")="",1,UPLOAD__FORM("State"))
		
		Dim DevicesHelper : set DevicesHelper = new DevicesHelper
		Dim obj : set obj = new Devices
		
		'파일
		Dim DevicesFilesHelper : set DevicesFilesHelper = new DevicesFilesHelper
		Dim DevicesFiles : set DevicesFiles = new DevicesFiles
		
		'관련 어플
		Dim DevicesRelationHelper : set DevicesRelationHelper = new DevicesRelationHelper
		Dim DevicesRelation : set DevicesRelation = new DevicesRelation
		
		if ActionType = "INSERT" then
			if MenuNo = "" then 
				call alerts ("분류를 입력해주세요.","")
			end if			
			if Name = "" then 
				call alerts ("디바이스명을 입력해주세요.","")
			end if

			obj.UserNo = 0
			obj.MenuNo = MenuNo
			obj.Name = Name
			obj.Contents1 = Contents1
			obj.Contents2 = Contents2
			obj.Contents3 = Contents3
			obj.AdminNo = session("adminNo")
			obj.State = State
			
			obj.Images1 = fileUpload_proc(UPLOAD__FORM,savePath, Images1 , "images_files1" , OldImages1 , "" )
			obj.Images2 = fileUpload_proc(UPLOAD__FORM,savePath, Images2 , "images_files2" , OldImages2 , "" )
			obj.Images3 = fileUpload_proc(UPLOAD__FORM,savePath, Images3 , "images_files3" , OldImages3 , "" )
			obj.Images4 = fileUpload_proc(UPLOAD__FORM,savePath, Images4 , "images_files4" , OldImages4 , "" )
			obj.ImagesList = fileUpload_proc(UPLOAD__FORM,savePath, ImagesList , "ImagesList" , OldImagesList , "" )
			
			result = DevicesHelper.Insert(obj)
			
			nFileCnt = UPLOAD__FORM("files").Count
			DevicesFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					DevicesFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = DevicesFilesHelper.Insert(DevicesFiles)
				end if
			Next
			
			nRelation = UPLOAD__FORM("Relation").Count
			DevicesRelation.ParentNo = obj.No
			For i = 1 to nRelation
				If UPLOAD__FORM("Relation")(i) <> "" Then 
					DevicesRelation.ProductNo = UPLOAD__FORM("Relation")(i)

					resultRelation = DevicesRelationHelper.Insert(DevicesRelation)
				end if
			Next

			call alerts ("등록되었습니다.","?controller=Devices&action=Index&mode=List")
		elseif ActionType = "UPDATE" then
			if MenuNo = "" then 
				call alerts ("분류를 입력해주세요.","")
			end if			
			if Name = "" then 
				call alerts ("디바이스명을 입력해주세요.","")
			end if

			obj.No = No
			obj.MenuNo = MenuNo
			obj.Name = Name
			obj.Contents1 = Contents1
			obj.Contents2 = Contents2
			obj.Contents3 = Contents3
			obj.State = State
			
			obj.Images1 = fileUpload_proc(UPLOAD__FORM,savePath, Images1 , "images_files1" , OldImages1 , Del_images_files1 )
			obj.Images2 = fileUpload_proc(UPLOAD__FORM,savePath, Images2 , "images_files2" , OldImages2 , Del_images_files2 )
			obj.Images3 = fileUpload_proc(UPLOAD__FORM,savePath, Images3 , "images_files3" , OldImages3 , Del_images_files3 )
			obj.Images4 = fileUpload_proc(UPLOAD__FORM,savePath, Images4 , "images_files4" , OldImages4 , Del_images_files4 )
			obj.ImagesList = fileUpload_proc(UPLOAD__FORM,savePath, ImagesList , "ImagesList" , OldImagesList , Del_ImagesList )
			
			DevicesHelper.Update(obj)
			
			nFileCnt = UPLOAD__FORM("files").Count
			DevicesFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					DevicesFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = DevicesFilesHelper.Insert(DevicesFiles)
				end if
			Next
			
			nRelation = UPLOAD__FORM("Relation").Count
			DevicesRelation.ParentNo = obj.No
			For i = 1 to nRelation
				If UPLOAD__FORM("Relation")(i) <> "" Then 
					DevicesRelation.ProductNo = UPLOAD__FORM("Relation")(i)

					resultRelation = DevicesRelationHelper.Insert(DevicesRelation)
				end if
			Next
			
			call alerts ("수정되었습니다.","?controller=Devices&action=Index&mode=List" & Params )
			
		elseif ActionType = "DELETE" then
			DevicesHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=Devices&action=Index&mode=List" & Params )
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	
	
	
	public Sub Menu()
		ParamData.Add "mode"     , iif(Request("mode")="","List",Request("mode"))
		ParamData.Add "Name"     , iif(Request("Name")="","",Request("Name"))
		ParamData.Add "pageNo"   , iif(Request("pageNo")="",1,Request("pageNo"))
		ParamData.Add "No"       , iif(Request("No")="",0,Request("No"))
		ParamData.Add "url"      , "&Name=" & ParamData("Name")
		 
		if ParamData("mode") = "List" then
			call MenuList()
		elseif ParamData("mode") = "Registe" then
			call MenuRegiste()
		elseif ParamData("mode") = "Excel" then
			call MenuExcel()
		end if
	End Sub
	
	
	private Sub MenuList()
		Dim rows    : rows    = 10
		Dim pageUrl : pageUrl = "?controller=Devices&action=Menu&mode=List" & ParamData("url")
		
		Dim objs : set objs = new DevicesMenu
		objs.Name = ParamData("Name")

		Dim DevicesMenuHelper : set DevicesMenuHelper = new DevicesMenuHelper
		set Model = DevicesMenuHelper.SelectAll(objs,ParamData("pageNo"),rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if

		ViewData.add "pagination" ,printPageList(pTotCount, cint(ParamData("pageNo")), rows, pageUrl & "&pageNo=__PAGE__")
		ViewData.add "ActionRegiste","?controller=Devices&action=Menu&mode=Registe" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Devices&action=MenuPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionType","DELETE"
		ViewData.add "ActionExcel","?controller=Devices&action=Menu&mode=Excel&partial=True" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/DevicesApps/DevicesMenuList.asp" --> <%
	End Sub
	
	
	private Sub MenuExcel()
		Session.Timeout = 600
		Server.ScriptTimeOut = 60*60*60 '초
		
		Dim objs : set objs = new DevicesMenu
		objs.Name = ParamData("Name")

		Dim DevicesMenuHelper : set DevicesMenuHelper = new DevicesMenuHelper
		set Model = DevicesMenuHelper.SelectAll(objs,1,100000000)
		
		Dim tmp_html : tmp_html = "" &_
		"<?xml version=""1.0"" encoding=""utf-8""?>" &_
		"<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:o=""urn:schemas-microsoft-com:office:office"" xmlns:x=""urn:schemas-microsoft-com:office:excel"" xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:html=""http://www.w3.org/TR/REC-html40"">" &_
		"<Worksheet ss:Name=""Devices 분류 관리""> " &_
		"<Table> " &_
		"	<Column ss:Width='200'/> " &_
		"	<Column ss:Width='80'/> " &_
		"	<Row> "&_
		"		<Cell><Data ss:Type=""String"">이름</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">순서</Data></Cell> "&_
		"	</Row> "
		
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				tmp_html = tmp_html & "" &_
				"	<Row> "&_
				"		<Cell><Data ss:Type=""String"">" & obj.Name & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.OrderNo & "</Data></Cell>"&_
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
		Response.AddHeader "Content-Disposition","attachment; filename=Devices 분류 관리 " & Now() & ".xls"
		
	End Sub
	
	
	private Sub MenuRegiste()
		Dim DevicesMenuHelper : set DevicesMenuHelper = new DevicesMenuHelper
		set Model = DevicesMenuHelper.SelectByField("No",ParamData("No"))
		
		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			set Model = new DevicesMenu
			Model.OrderNo = 0
		end if
		
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=Devices&action=Menu&mode=List" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Devices&action=MenuPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/DevicesApps/DevicesMenuRegiste.asp" --> <%
	End Sub
	
	public Sub MenuPost()
		Dim ActionType : ActionType = Request.Form("ActionType")
		Dim Params     : Params     = Request.Form("Params")
		
		Dim No    : No    = Trim( iif(Request.Form("No")="",0,Request.Form("No")) )
		Dim Name  : Name  = Trim(Request.Form("Name"))
		Dim OrderNo : OrderNo = Trim( iif(Request.Form("OrderNo")="",0,Request.Form("OrderNo")) )
		
		Dim DevicesMenuHelper : set DevicesMenuHelper = new DevicesMenuHelper
		Dim obj : set obj = new DevicesMenu
		Dim result
		
		if ActionType = "INSERT" then
			if Name = "" then 
				call alerts ("디바이스명을 입력해주세요.","")
			end if
			if OrderNo = "" then 
				call alerts ("순서를 입력해주세요.","")
			end if

			obj.Name = Name
			obj.OrderNo = OrderNo
			
			result = DevicesMenuHelper.Insert(obj)

			call alerts ("등록되었습니다.","?controller=Devices&action=Menu&mode=List")
		elseif ActionType = "UPDATE" then
			if Name = "" then 
				call alerts ("디바이스명을 입력해주세요.","")
			end if
			if OrderNo = "" then 
				call alerts ("순서를 입력해주세요.","")
			end if
			
			obj.No = No
			obj.Name = Name
			obj.OrderNo = OrderNo
			
			DevicesMenuHelper.Update(obj)
			call alerts ("수정되었습니다.","?controller=Devices&action=Menu&mode=List" & Params )
			
		elseif ActionType = "DELETE" then
			DevicesMenuHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=Devices&action=Menu&mode=List" & Params )
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	
	
	public Sub DelFile()
		Dim No : No = iif(Request.Form("No")="",0,Request.Form("No"))
		
		Dim DevicesFilesHelper : set DevicesFilesHelper = new DevicesFilesHelper
		Dim DevicesFilesModel  : set DevicesFilesModel = DevicesFilesHelper.SelectByField("No",No)
		
		Set FSO = Server.CreateObject("DEXT.FileUpload")
		
		if Not(IsNothing(DevicesFilesModel)) then
			For each obj in DevicesFilesModel.Items
				If (FSO.FileExists(savePath & obj.Name)) Then
					fso.deletefile(savePath & obj.Name)
				End If
				If (FSO.FileExists(savePath & "m_" & obj.Name)) Then
					fso.deletefile(savePath & "m_" & obj.Name)
				End If
				If (FSO.FileExists(savePath & "s_" & obj.Name)) Then
					fso.deletefile(savePath & "s_" & obj.Name)
				End If
				DevicesFilesHelper.Delete(obj.No)
			Next
		end if
			
		set FSO = Nothing
	End Sub
	
	public Sub DelRelation()
		Dim No : No = iif(Request.Form("No")="",0,Request.Form("No"))
		
		Dim RelationHelper : set RelationHelper = new DevicesRelationHelper
		RelationHelper.Delete(No)
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