<%
class DevicesAppsBoardController
	Dim Model
	Dim ViewData
	Dim ParamData
	Dim uploadPath
	Dim savePath

	private sub Class_Initialize()
		admin_checkLogin()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
		Set ParamData = Server.CreateObject("Scripting.Dictionary")
		
		uploadPath = "/upload/DnABoard/"
		savePath = server.mapPath( uploadPath ) & "/"
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		DevicesFAQ()
	End Sub
	
	private Sub SetParams()
		ParamData.Add "mode"     , iif(Request("mode")="","List",Request("mode"))
		ParamData.Add "sDate"    , iif(Request("sDate")="","",Request("sDate"))
		ParamData.Add "eDate"    , iif(Request("eDate")="","",Request("eDate"))
		ParamData.Add "UserId"   , iif(Request("UserId")="","",Request("UserId"))
		ParamData.Add "UserName" , iif(Request("UserName")="","",Request("UserName"))
		ParamData.Add "Title"    , iif(Request("Title")="","",Request("Title"))
		ParamData.Add "pageNo"   , iif(Request("pageNo")="",1,Request("pageNo"))
		ParamData.Add "No"       , iif(Request("No")="",0,Request("No"))
		ParamData.Add "url"      , "&sDate=" & ParamData("sDate") & "&eDate=" & ParamData("eDate") &_
		 "&UserId=" & ParamData("UserId") & "&UserName=" & ParamData("UserName")
	End Sub
	
	public Sub DevicesFAQ()
		SetParams()
		ViewData.add "PageName","Devices FAQ"
		if ParamData("mode") = "List" then
			call List("Devices","FAQ")
		elseif ParamData("mode") = "Registe" then
			call Registe("Devices","FAQ")
		end if
	End Sub

	public Sub DevicesQNA()
		SetParams()
		ViewData.add "PageName","Devices QNA"
		ViewData.add "BoardType","QNA"

		if ParamData("mode") = "List" then
			call List("Devices","QNA")
		elseif ParamData("mode") = "Registe" then
			call Registe("Devices","QNA")
		elseif ParamData("mode") = "Reply" then
			call Reply("Devices","QNA")
		end if
	End Sub

	public Sub AppsFAQ()
		SetParams()
		ViewData.add "PageName","Apps FAQ"
		if ParamData("mode") = "List" then
			call List("Apps","FAQ")
		elseif ParamData("mode") = "Registe" then
			call Registe("Apps","FAQ")
		end if
	End Sub

	public Sub AppsQNA()
		SetParams()
		ViewData.add "PageName","Apps QNA"
		ViewData.add "BoardType","QNA"

		if ParamData("mode") = "List" then
			call List("Apps","QNA")
		elseif ParamData("mode") = "Registe" then
			call Registe("Apps","QNA")
		elseif ParamData("mode") = "Reply" then
			call Reply("Apps","QNA")
		end if
	End Sub
	
	private Sub List(Code,Types)
		Dim rows    : rows    = 10
		Dim pageUrl : pageUrl = "?controller=DevicesAppsBoard&action=" & Code & Types & "&mode=List" & ParamData("url")
		Dim DevicesAppsBoardHelper : set DevicesAppsBoardHelper = new DevicesAppsBoardHelper

		Dim objs : set objs = new DevicesAppsBoard
		objs.Code     = Code
		objs.Types    = Types
		objs.Sdate    = ParamData("sDate")
		objs.Edate    = ParamData("eDate")
		objs.UserId   = ParamData("UserId")
		objs.UserName = ParamData("UserName")
		objs.Title    = ParamData("Title")
		set Model = DevicesAppsBoardHelper.SelectAll(objs,ParamData("pageNo"),rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if
		
		
		ViewData.add "pagination" ,printPageList(pTotCount, cint(ParamData("pageNo")), rows, pageUrl & "&pageNo=__PAGE__")
		ViewData.add "ActionRegiste","?controller=DevicesAppsBoard&action=" & Code & Types & "&mode=Registe" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=DevicesAppsBoard&action=Post&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionType","DELETE"
		%> <!--#include file="../Views/DevicesApps/CommunityList.asp" --> <%
	End Sub
	
	private Sub Registe(Code,Types)
		Dim DevicesAppsBoardHelper : set DevicesAppsBoardHelper = new DevicesAppsBoardHelper
		set Model = DevicesAppsBoardHelper.SelectByField("No",ParamData("No"))
		
		Dim ProductObj,ProductHelper,ProductModel,ProductLabel
		if Code = "Devices" then
			set ProductObj = new Devices
			set ProductHelper = new DevicesHelper
			set ProductModel = ProductHelper.SelectAll(ProductObj,1,1000) 
			ProductLabel = "디바이스"
		elseif Code = "Apps" then
			set ProductObj = new Apps
			set ProductHelper = new AppsHelper
			set ProductModel = ProductHelper.SelectAll(ProductObj,1,1000)
			ProductLabel = "Apps"
		end if 
		
		
		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			Dim AdminHelper : set AdminHelper = new AdminHelper
			Dim AdminModel  : set AdminModel = AdminHelper.SelectByField("No",session("adminNo"))
		
			set Model = new DevicesAppsBoard
			Model.UserId = AdminModel.Id
			Model.UserName = AdminModel.Name
		end if
		
		'파일
		Dim DevicesAppsBoardFilesHelper : set DevicesAppsBoardFilesHelper = new DevicesAppsBoardFilesHelper
		Dim DevicesAppsBoardFilesModel  : set DevicesAppsBoardFilesModel = DevicesAppsBoardFilesHelper.SelectByField("ParentNo",ParamData("No"))
		
		
		ViewData.add "ProductLabel",ProductLabel
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=DevicesAppsBoard&action="& Code & Types  &"&mode=List" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionReply","?controller=DevicesAppsBoard&action="& Code & Types  &"&mode=Reply" & ParamData("url") & "&pageNo=" & ParamData("pageNo") & "&No=" & ParamData("No")
		ViewData.add "ActionForm","?controller=DevicesAppsBoard&action=Post&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/DevicesApps/CommunityRegiste.asp" --> <%
	End Sub
	
	private Sub Reply(Code,Types)
		Dim DevicesAppsBoardHelper : set DevicesAppsBoardHelper = new DevicesAppsBoardHelper
		set Model = DevicesAppsBoardHelper.SelectByField("No",ParamData("No"))
		
		Dim ProductObj,ProductHelper,ProductModel,ProductLabel
		if Code = "Devices" then
			set ProductObj = new Devices
			set ProductHelper = new DevicesHelper
			set ProductModel = ProductHelper.SelectAll(ProductObj,1,1000) 
			ProductLabel = "디바이스"
		elseif Code = "Apps" then
			set ProductObj = new Apps
			set ProductHelper = new AppsHelper
			set ProductModel = ProductHelper.SelectAll(ProductObj,1,1000)
			ProductLabel = "Apps"
		end if 

		if IsNothing(Model) then
			call alerts ("잘못된 경로입니다.","")
		end if
		
		'Model.Contents = "[ 답 변 ]<br><br><br>-----------------------------------------------<br> [ 질 문 ] <br>" & Model.Contents
		Model.Contents = ""
		
		Dim ActionType : ActionType = "REPLY"
		
		ViewData.add "ProductLabel",ProductLabel
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=DevicesAppsBoard&action="& Code & Types &"&mode=List" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionReply","?controller=DevicesAppsBoard&action="& Code & Types &"&mode=Reply" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=DevicesAppsBoard&action=Post&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/DevicesApps/CommunityRegiste.asp" --> <%
	End Sub
	
	public Sub Post()
		Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
		UPLOAD__FORM.AutoMakeFolder = True 
		UPLOAD__FORM.CodePage = 65001
		UPLOAD__FORM.DefaultPath = savePath
		UPLOAD__FORM.MaxFileLen	= 500 * 1024 * 1024 '500메가
		
		Dim ActionType : ActionType = UPLOAD__FORM("ActionType")
		Dim Params     : Params     = UPLOAD__FORM("Params")
		Dim BoardCode  : BoardCode  = UPLOAD__FORM("BoardCode")
		Dim BoardType  : BoardType  = UPLOAD__FORM("BoardType")
		
		Dim No       : No       = Trim( iif(UPLOAD__FORM("No")="",0,UPLOAD__FORM("No")) )
		Dim Title    : Title    = TagEncode( Trim(UPLOAD__FORM("Title")) )
		Dim ProductNo: ProductNo= TagEncode( Trim(UPLOAD__FORM("ProductNo")) )
		Dim Contents : Contents = Trim(UPLOAD__FORM("Contents"))

		
		Dim DevicesAppsBoardHelper : set DevicesAppsBoardHelper = new DevicesAppsBoardHelper
		Dim obj : set obj = new DevicesAppsBoard
		
		Dim DevicesAppsBoardFilesHelper : set DevicesAppsBoardFilesHelper = new DevicesAppsBoardFilesHelper
		Dim DevicesAppsBoardFiles : set DevicesAppsBoardFiles = new DevicesAppsBoardFiles
		
		if ActionType = "INSERT" then
			if ProductNo = "" then 
				call alerts ("Devices/Apps를 선택해주세요.","")
			end if
			
			if Title = "" then 
				call alerts ("제목을 입력해주세요.","")
			end if

			obj.Code = BoardCode
			obj.Types = BoardType
			obj.ProductNo = ProductNo
			obj.ManagerNo =0 
			obj.ParentNo = 0
			obj.OrderNo = 0
			obj.DepthNo = 0
			obj.UserNo = 0
			obj.Title = Title
			obj.Contents = Contents
			obj.Ip = g_uip
			obj.AdminNo = session("adminNo")
			obj.AdminFg = 1
			
			result = DevicesAppsBoardHelper.Insert(obj)
			result2 = DevicesAppsBoardHelper.UpdateByField("ParentNo", obj.No, obj.No) 
			
			nFileCnt = UPLOAD__FORM("files").Count
			DevicesAppsBoardFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					DevicesAppsBoardFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = DevicesAppsBoardFilesHelper.Insert(DevicesAppsBoardFiles)
				end if
			Next
			
			
			call alerts ("등록되었습니다.","?controller=DevicesAppsBoard&action="& BoardCode & BoardType &"&mode=List")
			
		elseif ActionType = "REPLY" then
			if ProductNo = "" then 
				call alerts ("Devices/Apps를 선택해주세요.","")
			end if
			
			if Title = "" then 
				call alerts ("제목을 입력해주세요.","")
			end if
			
			set Model = DevicesAppsBoardHelper.SelectByField("No",No)

			obj.Code = Model.Code
			obj.Types = Model.Types
			obj.ProductNo = Model.ProductNo
			obj.ManagerNo = Model.ManagerNo
			obj.ParentNo = Model.ParentNo
			obj.OrderNo = Model.OrderNo + 1
			obj.DepthNo = Model.DepthNo + 1
			obj.UserNo = Model.UserNo
			obj.Title = Title
			obj.Contents = Contents
			obj.Ip = g_uip
			obj.AdminNo = session("adminNo")
			obj.AdminFg = 1
			
			result2 = DevicesAppsBoardHelper.UpdateReply(obj.ParentNo,obj.OrderNo)
			result  = DevicesAppsBoardHelper.Insert(obj)
			
			nFileCnt = UPLOAD__FORM("files").Count
			DevicesAppsBoardFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					DevicesAppsBoardFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = DevicesAppsBoardFilesHelper.Insert(DevicesAppsBoardFiles)
				end if
			Next

			'메일 발송
			Dim UserHelper : set UserHelper = new UserHelper
			set UserModel = UserHelper.SelectByField("No", Model.UserNo)

			Dim strFile : strFile = server.mapPath("/Utils/email/anser.html")
			dim strSubject : strSubject = "문의하신 질문의 답변이 등록되었습니다."
			dim strBody : strBody = ReadFile(strFile)
			dim strTo : strTo = UserModel.Id
			dim strFrom : strFrom = "OPEN-IOT<no-reply@open-iot.net>"
			
			strBody = replace(strBody, "#ANSER#" , Contents )
			strBody = replace(strBody, "#QESTION#" , Model.Contents )
			strBody = replace(strBody, "#URL#" , g_host & "/Utils/email/" )
			
			dim Mresult : Mresult = MailSend(strSubject, strBody, strTo, strFrom, "")
			
			
			
			call alerts ("등록되었습니다.","?controller=DevicesAppsBoard&action="& BoardCode & BoardType &"&mode=List")
		elseif ActionType = "UPDATE" then
			if Title = "" then 
				call alerts ("제목을 입력해주세요.","")
			end if

			obj.No = No
			obj.Title = Title
			obj.Contents = Contents
			
			DevicesAppsBoardHelper.Update(obj)
			
			
			nFileCnt = UPLOAD__FORM("files").Count
			DevicesAppsBoardFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					DevicesAppsBoardFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = DevicesAppsBoardFilesHelper.Insert(DevicesAppsBoardFiles)
				end if
			Next
			
			call alerts ("수정되었습니다.","?controller=DevicesAppsBoard&action="& BoardCode & BoardType &"&mode=List" & Params )
			
		elseif ActionType = "DELETE" then
			DevicesAppsBoardHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=DevicesAppsBoard&action="& BoardCode & BoardType &"&mode=List" & Params )
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	public Sub DelFile()
		Dim No : No = iif(Request.Form("No")="",0,Request.Form("No"))
		
		Dim DevicesAppsBoardFilesHelper : set DevicesAppsBoardFilesHelper = new DevicesAppsBoardFilesHelper
		Dim DevicesAppsBoardFilesModel  : set DevicesAppsBoardFilesModel = DevicesAppsBoardFilesHelper.SelectByField("No",No)
		
		Set FSO = Server.CreateObject("DEXT.FileUpload")
		
		if Not(IsNothing(DevicesAppsBoardFilesModel)) then
			For each obj in DevicesAppsBoardFilesModel.Items
				If (FSO.FileExists(savePath & obj.Name)) Then
					fso.deletefile(savePath & obj.Name)
				End If
				If (FSO.FileExists(savePath & "m_" & obj.Name)) Then
					fso.deletefile(savePath & "m_" & obj.Name)
				End If
				If (FSO.FileExists(savePath & "s_" & obj.Name)) Then
					fso.deletefile(savePath & "s_" & obj.Name)
				End If
				DevicesAppsBoardFilesHelper.Delete(obj.No)
			Next
		end if
			
		set FSO = Nothing
	End Sub


End Class
%>
    