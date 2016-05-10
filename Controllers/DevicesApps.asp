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
		DevicesList()
	End Sub
	
	public Sub DevicesList()
		Dim pageNo : pageNo = iif(Request("pageNo")="",1,Request("pageNo"))
		Dim Name : Name = iif(Request("Name")="","",Request("Name"))
		Dim MenuNo : MenuNo = iif(Request("MenuNo")="","",Request("MenuNo"))
		Dim UserNo : UserNo = iif(Request("UserNo")="","",Request("UserNo"))
		Dim rows   : rows    = iif(Request("rows")="",10,Request("rows"))
		
		Dim DevicesHelper : set DevicesHelper = new DevicesHelper
		Dim objs : set objs = new Devices
		objs.Name = Name
		objs.MenuNo = MenuNo
		objs.State = 0
		set Model = DevicesHelper.SelectAll(objs,1,10000)

	
	
		'메뉴
		Dim MenuObj : set MenuObj = new DevicesMenu
		Dim MenuHelper : set MenuHelper = new DevicesMenuHelper
		Dim MenuModel  : set MenuModel = MenuHelper.SelectAll(MenuObj,1,1000)
	
		ViewData.add "ActionRegiste","?controller=DevicesApps&action=DevicesRegiste"
		ViewData.add "ActionAjaxUrl","?controller=DevicesApps&action=AjaxDevicesList"
		ViewData.add "ActionDetail","?controller=DevicesApps&action=DevicesDetail"
		%> <!--#include file="../Views/DevicesApps/List.asp" --> <%
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
	
	public Sub DevicesDetail()
		Dim No : No = iif(Request("No")="",0,Request("No"))
		Dim DevicesHelper : set DevicesHelper = new DevicesHelper
		set Model = DevicesHelper.SelectByField("No",No)
		
		if IsNothing(Model) then
			call alerts ("잘못된 경로입니다.","")
		end if
		
		Images = Model.Images1
		Images = iif( IsNothing(Images) or Images="",Model.Images2,Images )
		Images = iif( IsNothing(Images) or Images="",Model.Images3,Images )
		Images = iif( IsNothing(Images) or Images="",Model.Images4,Images )
		
		' OID 검색
		
		Dim OidHelper : set OidHelper = new OidHelper
		Dim OidModel : set OidModel = OidHelper.SelectByField("UserNo",iif( IsNothing(Model.UserNo) or Model.UserNo="",0,Model.UserNo))
		
		'파일
		Dim FilesHelper : set FilesHelper = new DevicesFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentNo",No)

		'관련 어플 - 등록 어플 리스트
		Dim RelationHelper : set RelationHelper = new DevicesRelationHelper
		Dim RelationModel : set RelationModel = RelationHelper.SelectAll(No)
		%> <!--#include file="../Views/DevicesApps/DevicesDetail.asp" --> <%
	End Sub
	
	public Sub DevicesRegiste()
		call checkLogin("")
		call checkEmailConfirm()
		
		Dim OidHelper : set OidHelper = new OidHelper
		Dim OidModel : set OidModel = OidHelper.SelectByField("UserNo",session("userNo"))
		
		if IsNothing(OidModel) then
			response.redirect "?controller=DevicesApps&action=OidRegiste&GoUrl=" & server.urlencode("?" & Request.ServerVariables("QUERY_STRING"))
		end if
		
		Dim No : No = iif(Request("No")="",0,Request("No"))
		Dim DevicesHelper : set DevicesHelper = new DevicesHelper
		set Model = DevicesHelper.SelectByField("No",No)

		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			set Model = new Devices
		end if
		
		'메뉴
		Dim MenuObj : set MenuObj = new DevicesMenu
		Dim MenuHelper : set MenuHelper = new DevicesMenuHelper
		Dim MenuModel  : set MenuModel = MenuHelper.SelectAll(MenuObj,1,1000)
		
		
		
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
		Dim RelationModel : set RelationModel = RelationHelper.SelectByField("ParentNo", No)
		
		'파일
		Dim FilesHelper : set FilesHelper = new DevicesFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentNo",No)
		
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionForm","?controller=DevicesApps&action=DevicesPost&partial=True"
		%> <!--#include file="../Views/DevicesApps/DevicesRegiste.asp" --> <%
	End Sub
	
	public Sub DevicesPost()
		Dim uploadPath : uploadPath = "/upload/Devices/"
		Dim savePath   : savePath   = server.mapPath( uploadPath ) & "/"
		
		Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
		UPLOAD__FORM.AutoMakeFolder = True 
		UPLOAD__FORM.CodePage = 65001
		UPLOAD__FORM.DefaultPath = savePath
		UPLOAD__FORM.MaxFileLen	= 50 * 1024 * 1024 '50메가
		
		Dim ActionType : ActionType = UPLOAD__FORM("ActionType")
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

			obj.UserNo = session("userNo")
			obj.MenuNo = MenuNo
			obj.Name = Name
			obj.Contents1 = Contents1
			obj.Contents2 = Contents2
			obj.Contents3 = Contents3
			obj.AdminNo = 0
			obj.State = 1
			
			obj.Images1 = fileUpload_proc(UPLOAD__FORM,savePath, Images1 , "images_files1" , "" , "" )
			obj.Images2 = fileUpload_proc(UPLOAD__FORM,savePath, Images2 , "images_files2" , "" , "" )
			obj.Images3 = fileUpload_proc(UPLOAD__FORM,savePath, Images3 , "images_files3" , "" , "" )
			obj.Images4 = fileUpload_proc(UPLOAD__FORM,savePath, Images4 , "images_files4" , "" , "" )
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
			
			
			'관리자에게 이메일 발송
			dim Mresult
			Dim UserHelper : set UserHelper = new UserHelper
			Dim UserModel  : set UserModel  = UserHelper.SelectByField("No",session("userNo"))
			
			Dim Admin : set Admin = new Admin
			Admin.Level = "0"
			Dim AdminHelper : set AdminHelper = new AdminHelper
			Dim AdminModel  : set AdminModel  = AdminHelper.SelectAll(Admin,1,1000)
			
			Dim strFile : strFile = server.mapPath("/Utils/email/newProducts.html")
			dim strSubject : strSubject = "새로운 디바이스가 등록되었습니다."
			dim strBody : strBody = ReadFile(strFile)
			'dim strTo : strTo = UserModel.Id
			dim strFrom : strFrom = "OPEN-IOT<no-reply@open-iot.net>"
			
			strBody = replace(strBody, "#MODE#" , "디바이스" )
			strBody = replace(strBody, "#ID#"   , UserModel.Id )
			strBody = replace(strBody, "#NAME#" , obj.Name )
			strBody = replace(strBody, "#DATE#" , NOW() )
			strBody = replace(strBody, "#URL#"  , g_host & "/Utils/email/" )
			
			if Not( IsNothing(AdminModel) ) then
				For each AdminObj in AdminModel.Items
					if Not( IsNothing(AdminObj.Email) ) then 
						Mresult = MailSend(strSubject, strBody, AdminObj.Email, strFrom, "")
					end if
				next
			end if

			call alerts ("등록되었습니다.","?controller=Mypage&action=DevicesApps&mode=Devices")
		elseif ActionType = "UPDATE" then
			if MenuNo = "" then 
				call alerts ("분류를 입력해주세요.","")
			end if			
			if Name = "" then 
				call alerts ("디바이스명을 입력해주세요.","")
			end if
			
			set Model = DevicesHelper.SelectByField("No",No)

			obj.No = No
			obj.MenuNo = MenuNo
			obj.Name = Name
			obj.Contents1 = Contents1
			obj.Contents2 = Contents2
			obj.Contents3 = Contents3
			obj.State = Model.State
			
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
			call alerts ("수정되었습니다.","?controller=Mypage&action=DevicesApps&mode=Devices")
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	
	
	
	
	
	
	public Sub AppsList()
		Dim pageNo : pageNo = iif(Request("pageNo")="",1,Request("pageNo"))
		Dim Name : Name = iif(Request("Name")="","",Request("Name"))
		Dim MenuNo : MenuNo = iif(Request("MenuNo")="","",Request("MenuNo"))
		Dim UserNo : UserNo = iif(Request("UserNo")="","",Request("UserNo"))
		Dim rows   : rows    = iif(Request("rows")="",10,Request("rows"))
		
		Dim AppsHelper : set AppsHelper = new AppsHelper
		Dim objs : set objs = new Apps
		objs.Name = Name
		objs.MenuNo = MenuNo
		objs.State = 0
		set Model = AppsHelper.SelectAll(objs,1,10000)
		

		'메뉴
		Dim MenuObj : set MenuObj = new AppsMenu
		Dim MenuHelper : set MenuHelper = new AppsMenuHelper
		Dim MenuModel  : set MenuModel = MenuHelper.SelectAll(MenuObj,1,1000)

		ViewData.add "ActionRegiste","?controller=DevicesApps&action=AppsRegiste"
		ViewData.add "ActionAjaxUrl","?controller=DevicesApps&action=AjaxAppsList"
		ViewData.add "ActionDetail","?controller=DevicesApps&action=AppsDetail"
		%> <!--#include file="../Views/DevicesApps/List.asp" --> <%
	End Sub
	
	public sub AjaxAppsList()
		Dim MenuNo : MenuNo = iif(Request("MenuNo")="","0",Request("MenuNo"))
		Dim AppsHelper : set AppsHelper = new AppsHelper
		Dim objs : set objs = new Apps
		
		objs.MenuNo = MenuNo
		objs.State = 0
		set Model = AppsHelper.SelectAll(objs,1,1000)
		
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
	

	public Sub AppsDetail()
		Dim No : No = iif(Request("No")="",0,Request("No"))
		Dim AppsHelper : set AppsHelper = new AppsHelper
		set Model = AppsHelper.SelectByField("No",No)
		
		if IsNothing(Model) then
			call alerts ("잘못된 경로입니다.","")
		end if
		
		Images = Model.Images1
		Images = iif( IsNothing(Images) or Images="",Model.Images2,Images )
		Images = iif( IsNothing(Images) or Images="",Model.Images3,Images )
		Images = iif( IsNothing(Images) or Images="",Model.Images4,Images )
		
		' OID 검색
		
		Dim OidHelper : set OidHelper = new OidHelper
		Dim OidModel : set OidModel = OidHelper.SelectByField("UserNo",iif( IsNothing(Model.UserNo) or Model.UserNo="",0,Model.UserNo))
		
		'파일
		Dim FilesHelper : set FilesHelper = new AppsFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentNo",No)

		'관련 어플 - 등록 어플 리스트
		Dim RelationHelper : set RelationHelper = new AppsRelationHelper
		Dim RelationModel : set RelationModel = RelationHelper.SelectAll(No)
		%> <!--#include file="../Views/DevicesApps/AppsDetail.asp" --> <%
	End Sub
	
	
	
	public Sub AppsRegiste()
	
		call checkLogin("")
		call checkEmailConfirm()
		
		Dim OidHelper : set OidHelper = new OidHelper
		Dim OidModel : set OidModel = OidHelper.SelectByField("UserNo",session("userNo"))
		
		if IsNothing(OidModel) then
			response.redirect "?controller=DevicesApps&action=OidRegiste&GoUrl=" & server.urlencode("?" & Request.ServerVariables("QUERY_STRING"))
		end if
		
		Dim No : No = iif(Request("No")="",0,Request("No"))
		Dim AppsHelper : set AppsHelper = new AppsHelper
		set Model = AppsHelper.SelectByField("No",No)

		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			set Model = new Apps
		end if
		
		'메뉴
		Dim MenuObj : set MenuObj = new AppsMenu
		Dim MenuHelper : set MenuHelper = new AppsMenuHelper
		Dim MenuModel  : set MenuModel = MenuHelper.SelectAll(MenuObj,1,1000)

		
		'관련 디바이스 - 메뉴
		Dim ProductMenu : set ProductMenu = new DevicesMenu
		Dim ProductMenuHelper : set ProductMenuHelper = new DevicesMenuHelper
		Dim ProductMenuModel  : set ProductMenuModel = ProductMenuHelper.SelectAll(ProductMenu,1,1000)
		'관련 디바이스 - 전체 디바이스 리스트
		'Dim ProductObj : set ProductObj = new Devices
		'ProductObj.State = 0
		'Dim ProductHelper : set ProductHelper = new DevicesHelper
		'Dim ProductModel : set ProductModel = ProductHelper.SelectAll(ProductObj,1,1000)
		
		'관련 디바이스 - 등록 디바이스 리스트
		Dim RelationHelper : set RelationHelper = new AppsRelationHelper
		Dim RelationModel : set RelationModel = RelationHelper.SelectByField("ParentNo", No)
		
		'파일
		Dim FilesHelper : set FilesHelper = new AppsFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentNo",No)
		
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionForm","?controller=DevicesApps&action=AppsPost&partial=True"
		
		%> <!--#include file="../Views/DevicesApps/AppsRegiste.asp" --> <%
	End Sub
	
	public Sub AppsPost()
		Dim uploadPath : uploadPath = "/upload/Apps/"
		Dim savePath   : savePath   = server.mapPath( uploadPath ) & "/"
		
		Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
		UPLOAD__FORM.AutoMakeFolder = True 
		UPLOAD__FORM.CodePage = 65001
		UPLOAD__FORM.DefaultPath = savePath
		UPLOAD__FORM.MaxFileLen	= 50 * 1024 * 1024 '50메가
		
		Dim ActionType : ActionType = UPLOAD__FORM("ActionType")
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
		
		Dim AppsHelper : set AppsHelper = new AppsHelper
		Dim obj : set obj = new Apps
		
		'파일
		Dim AppsFilesHelper : set AppsFilesHelper = new AppsFilesHelper
		Dim AppsFiles : set AppsFiles = new AppsFiles
		
		'관련 디바이스
		Dim AppsRelationHelper : set AppsRelationHelper = new AppsRelationHelper
		Dim AppsRelation : set AppsRelation = new AppsRelation
		
		if ActionType = "INSERT" then
			if MenuNo = "" then 
				call alerts ("분류를 입력해주세요.","")
			end if			
			if Name = "" then 
				call alerts ("디바이스명을 입력해주세요.","")
			end if

			obj.UserNo = session("userNo")
			obj.MenuNo = MenuNo
			obj.Name = Name
			obj.Contents1 = Contents1
			obj.Contents2 = Contents2
			obj.Contents3 = Contents3
			obj.AdminNo = 0
			obj.State = 1
			
			obj.Images1 = fileUpload_proc(UPLOAD__FORM,savePath, Images1 , "images_files1" , "" , "" )
			obj.Images2 = fileUpload_proc(UPLOAD__FORM,savePath, Images2 , "images_files2" , "" , "" )
			obj.Images3 = fileUpload_proc(UPLOAD__FORM,savePath, Images3 , "images_files3" , "" , "" )
			obj.Images4 = fileUpload_proc(UPLOAD__FORM,savePath, Images4 , "images_files4" , "" , "" )
			obj.ImagesList = fileUpload_proc(UPLOAD__FORM,savePath, ImagesList , "ImagesList" , OldImagesList , "" )
			
			result = AppsHelper.Insert(obj)
			
			nFileCnt = UPLOAD__FORM("files").Count
			AppsFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					AppsFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = AppsFilesHelper.Insert(AppsFiles)
				end if
			Next
			
			nRelation = UPLOAD__FORM("Relation").Count
			AppsRelation.ParentNo = obj.No
			For i = 1 to nRelation
				If UPLOAD__FORM("Relation")(i) <> "" Then 
					AppsRelation.ProductNo = UPLOAD__FORM("Relation")(i)

					resultRelation = AppsRelationHelper.Insert(AppsRelation)
				end if
			Next
			
			
			'관리자에게 이메일 발송
			dim Mresult
			Dim UserHelper : set UserHelper = new UserHelper
			Dim UserModel  : set UserModel  = UserHelper.SelectByField("No",session("userNo"))
			
			Dim Admin : set Admin = new Admin
			Admin.Level = "0"
			Dim AdminHelper : set AdminHelper = new AdminHelper
			Dim AdminModel  : set AdminModel  = AdminHelper.SelectAll(Admin,1,1000)
			
			Dim strFile : strFile = server.mapPath("/Utils/email/newProducts.html")
			dim strSubject : strSubject = "새로운 서비스가 등록되었습니다."
			dim strBody : strBody = ReadFile(strFile)
			'dim strTo : strTo = UserModel.Id
			dim strFrom : strFrom = "OPEN-IOT<no-reply@open-iot.net>"
			
			strBody = replace(strBody, "#MODE#" , "서비스" )
			strBody = replace(strBody, "#ID#"   , UserModel.Id )
			strBody = replace(strBody, "#NAME#" , obj.Name )
			strBody = replace(strBody, "#DATE#" , NOW() )
			strBody = replace(strBody, "#URL#"  , g_host & "/Utils/email/" )
			
			if Not( IsNothing(AdminModel) ) then
				For each AdminObj in AdminModel.Items
					if Not( IsNothing(AdminObj.Email) ) then 
						Mresult = MailSend(strSubject, strBody, AdminObj.Email, strFrom, "")
					end if
				next
			end if
			
			

			call alerts ("등록되었습니다.","?controller=Mypage&action=DevicesApps&mode=Apps")
		elseif ActionType = "UPDATE" then
			if MenuNo = "" then 
				call alerts ("분류를 입력해주세요.","")
			end if			
			if Name = "" then 
				call alerts ("디바이스명을 입력해주세요.","")
			end if
			
			set Model = AppsHelper.SelectByField("No",No)

			obj.No = No
			obj.MenuNo = MenuNo
			obj.Name = Name
			obj.Contents1 = Contents1
			obj.Contents2 = Contents2
			obj.Contents3 = Contents3
			obj.State = Model.State
			
			obj.Images1 = fileUpload_proc(UPLOAD__FORM,savePath, Images1 , "images_files1" , OldImages1 , Del_images_files1 )
			obj.Images2 = fileUpload_proc(UPLOAD__FORM,savePath, Images2 , "images_files2" , OldImages2 , Del_images_files2 )
			obj.Images3 = fileUpload_proc(UPLOAD__FORM,savePath, Images3 , "images_files3" , OldImages3 , Del_images_files3 )
			obj.Images4 = fileUpload_proc(UPLOAD__FORM,savePath, Images4 , "images_files4" , OldImages4 , Del_images_files4 )
			obj.ImagesList = fileUpload_proc(UPLOAD__FORM,savePath, ImagesList , "ImagesList" , OldImagesList , Del_ImagesList )
			
			AppsHelper.Update(obj)
			
			nFileCnt = UPLOAD__FORM("files").Count
			AppsFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					AppsFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = AppsFilesHelper.Insert(AppsFiles)
				end if
			Next
			
			nRelation = UPLOAD__FORM("Relation").Count
			AppsRelation.ParentNo = obj.No
			For i = 1 to nRelation
				If UPLOAD__FORM("Relation")(i) <> "" Then 
					AppsRelation.ProductNo = UPLOAD__FORM("Relation")(i)

					resultRelation = AppsRelationHelper.Insert(AppsRelation)
				end if
			Next
			
			call alerts ("수정되었습니다.","?controller=Mypage&action=DevicesApps&mode=Apps")
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	
	
	
	public Sub DelRelation()
		Dim No : No = iif(Request.Form("No")="",0,Request.Form("No"))
		Dim mode : mode = Request.Form("mode")
		Dim RelationHelper
		
		if mode = "Devices" then 
			set RelationHelper = new DevicesRelationHelper
		elseif mode = "Apps" then
			set RelationHelper = new AppsRelationHelper
		end if
		
		RelationHelper.Delete(No)
	End Sub
	
	
	
	public Sub DelFile()
		Dim No : No = iif(Request.Form("No")="",0,Request.Form("No"))
		Dim mode : mode = Request.Form("mode")
		
		Dim FilesHelper
		Dim FilesModel
		Dim uploadPath
		Dim savePath
		
		if mode = "Devices" then 
			set FilesHelper = new DevicesFilesHelper
			
			uploadPath = "/upload/Devices/"
			savePath   = server.mapPath( uploadPath ) & "/"
		elseif mode = "Apps" then
			set FilesHelper = new AppsFilesHelper
			
			uploadPath = "/upload/Apps/"
			savePath   = server.mapPath( uploadPath ) & "/"
		end if
		
		set FilesModel = FilesHelper.SelectByField("No",No)
		
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
	
	
	public Sub OidRegiste()
		call checkLogin("")
		call checkEmailConfirm()
		
		Dim GoUrl : GoUrl = Request("GoUrl")
		
		Dim OidHelper : set OidHelper = new OidHelper
		set Model = OidHelper.SelectByField("UserNo",session("userNo"))
		
		if Not(IsNothing(Model)) then
			response.redirect "?controller=Oid&action=Registe"
		end if

		ViewData.add "ActionForm","?controller=DevicesApps&action=OidPost&partial=True"
		%> <!--#include file="../Views/DevicesApps/OidRegiste.asp" --> <%
	End Sub
	
	public Sub OidPost()
		call checkLogin("")
		call checkEmailConfirm()
		
		Dim uploadPath : uploadPath = "/upload/Oid/"
		Dim savePath   : savePath   = server.mapPath( uploadPath ) & "/"
		
		Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
		UPLOAD__FORM.AutoMakeFolder = True 
		UPLOAD__FORM.CodePage = 65001
		UPLOAD__FORM.DefaultPath = savePath
		UPLOAD__FORM.MaxFileLen	= 50 * 1024 * 1024 '50메가
		
		Dim GoUrl   : GoUrl   = Trim(UPLOAD__FORM("GoUrl"))
		Dim Name    : Name    = Trim(UPLOAD__FORM("Name"))
		Dim Email   : Email   = Trim(UPLOAD__FORM("Email"))
		Dim Url     : Url     = Trim(UPLOAD__FORM("Url"))
		Dim Phone1  : Phone1  = Trim(UPLOAD__FORM("Phone1"))
		Dim Phone2  : Phone2  = Trim(UPLOAD__FORM("Phone2"))
		Dim Phone3  : Phone3  = Trim(UPLOAD__FORM("Phone3"))
		Dim ImgLogo : ImgLogo = Trim(UPLOAD__FORM("ImgLogo"))
		
		Dim OidHelper : set OidHelper = new OidHelper
		Dim obj : set obj = new Oids
		Dim result
		
		if Name = "" then
			call alerts ("기업명을 입력해주세요.","")
		end if
		
		if Email = "" then
			call alerts ("담당자 메일을 입력해주세요.","")
		end if
		

		Dim CheckName : set CheckName = OidHelper.SelectByField("Name", Name)
		if Not(IsNothing(CheckName)) then
			call alerts ("이미 사용하고 있는 기업명 입니다.","")
		end if
		
		if Url <> "" then 
			If INSTR(LCase(Url),"http://")=0 or INSTR(LCase(Url),"https://")=0 then 
				Url = "http://" & Url
			end if
		end if
		ImgLogo = fileUpload_proc(UPLOAD__FORM,savePath, ImgLogo , "ImgLogo" , oldImgLogo , "" )
		
		obj.UserNo = session("userNo")
		obj.Oid = ""
		obj.Hphone1 = ""
		obj.Hphone2 = ""
		obj.Hphone3 = ""
		obj.Name = Name
		obj.Email = Email
		obj.Addr = ""
		obj.Phone1 = Phone1
		obj.Phone2 = Phone2
		obj.Phone3 = Phone3
		obj.ImgLogo = ImgLogo
		obj.ImgBusiness = ""
		obj.State = 2
		obj.Url = Url

		OidHelper.INSERT(obj)

		call alerts ("가입되었습니다.", GoUrl )
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