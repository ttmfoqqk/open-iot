<%
class MypageController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		Modify()
	End Sub
	
	public Sub Modify()
		call checkLogin("")
		call checkEmailConfirm()
		
		Dim UserHelper : set UserHelper = new UserHelper
		set Model = UserHelper.SelectByField("No",session("userNo"))
		
		ViewData.add "ActionForm"  ,"?controller=Mypage&action=ModifyPost&partial=True"
		%> <!--#include file="../Views/Mypage/Modify.asp" --> <%
	End Sub
	
	public Sub ModifyPost()
		call checkLogin("")
		call checkEmailConfirm()
		
		Dim args : Set args = Request.Form
		
		Dim Pwd : Pwd = Trim( args("Pwd") )
		Dim PwdConfirm : PwdConfirm = Trim( args("PwdConfirm") )
		Dim Phone3 : Phone3 = Trim( args("Phone3") )
		Dim State : State = Trim( args("State") )
		
		if Trim(Pwd) = "" Then
			call alerts ("비밀번호를 입력해주세요.","")
		end if
		
		if Trim(PwdConfirm) = "" Then
			call alerts ("비밀번호 확인을 입력해주세요.","")
		end if
		
		if Trim(Pwd) <> Trim(PwdConfirm) Then
			call alerts ("비밀번호를 확인해주세요.","")
		end if
		
		if Trim(Phone3) = "" Then
			call alerts ("핸드폰 뒷자리 번호를 입력해주세요.","")
		end if
		
		Dim UserHelper : set UserHelper = new UserHelper
		set Model = UserHelper.SelectByField("No",session("userNo"))
		Dim obj : set obj = new User
		
		obj.No     = session("userNo")
		obj.Pwd    = Pwd
		obj.Phone3 = Phone3
		obj.State  = State
		
		UserHelper.Update(obj)
		UserHelper.updatePwd(obj)
		
		
		Dim strFile : strFile = server.mapPath("/Utils/email/pwdChange.html")
		dim strSubject : strSubject = "회원님의 비밀번호가 변경되었습니다."
		dim strBody : strBody = ReadFile(strFile)
		dim strTo : strTo = Model.Id
		dim strFrom : strFrom = "OPEN-IOT<no-reply@open-iot.net>"
		
		strBody = replace(strBody, "#ID#" , Model.Id )
		strBody = replace(strBody, "#DATE#" , NOW() )
		strBody = replace(strBody, "#URL#" , g_host & "/Utils/email/" )
		
		dim Mresult : Mresult = MailSend(strSubject, strBody, strTo, strFrom, "")
		
		call alerts ("변경되었습니다.","?controller=Mypage&action=Modify")
		
	End Sub
	
	public Sub Inquiry()
		call checkLogin("")
		call checkEmailConfirm()
		
		Dim Board : Board = "Inquiry"
		Dim UserNo : UserNo = session("userNo")
		Dim Title : Title = iif(Request("Title")="","",Request("Title"))
		Dim pageNo : pageNo = iif(Request("pageNo")="",1,Request("pageNo"))
		
		Dim BoardListHelper : set BoardListHelper = new BoardListHelper
		dim BoardListModel  : set BoardListModel = BoardListHelper.SelectByField("Code",Board)
		if IsNothing(BoardListModel) then
			call alerts ("잘못된 경로입니다.","")
		end if
		
		Dim BoardHelper : set BoardHelper = new BoardHelper
		Dim BoardFilesHelper : set BoardFilesHelper = new BoardFilesHelper
		Dim BoardFilesModel
		
		PageTitle = "1:1 Inquiry"
		PageSubTitle = "<b>1:1문의</b>"
		ViewData.add "PageName",BoardListModel.Name
		ViewData.add "PageTitle",PageTitle
		ViewData.add "PageSubTitle",PageSubTitle
	
		Dim mode : mode = iif(Request("mode")="","List",Request("mode"))
		Dim No    : No = iif(Request("No")="",1,Request("No"))
		
		if mode = "List" then 
			Dim rows    : rows    = 10000
			Dim objs : set objs = new Board
			objs.Code  = BoardListModel.No
			objs.Title = Title
			objs.UserNo = UserNo
			set Model = BoardHelper.SelectAll(objs,pageNo,rows)
			
			pTotCount = 0
			if Not( IsNothing(Model) ) then
				For each obj in Model.Items
					pTotCount = obj.tcount
					Exit For
				next
			end if
			
			ViewData.add "ActionRegiste","?controller=Mypage&action=Inquiry&mode=Registe"
			%> <!--#include file="../Views/Mypage/InquiryList.asp" --> <%
		elseif mode = "Registe" then
			
			set Model = BoardHelper.SelectByField("No",No)

			Dim ActionType : ActionType = "INSERT"
			if Not(IsNothing(Model)) then
				ActionType = "UPDATE"
			else
				set Model = new Board
			end if
			
			ViewData.add "ActionType",ActionType
			ViewData.add "ActionForm","?controller=Mypage&action=InquiryPost&partial=True"
			ViewData.add "ActionList","?controller=Mypage&action=Inquiry&mode=List"
			%> <!--#include file="../Views/Mypage/InquiryRegiste.asp" --> <%
		end if
	End Sub
	
	public Sub InquiryPost()
		call checkLogin("")
		call checkEmailConfirm()
		
		Dim uploadPath : uploadPath = "/upload/Board/"
		Dim savePath   : savePath   = server.mapPath( uploadPath ) & "/"
		
		Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
		UPLOAD__FORM.AutoMakeFolder = True 
		UPLOAD__FORM.CodePage = 65001
		UPLOAD__FORM.DefaultPath = savePath
		UPLOAD__FORM.MaxFileLen	= 500 * 1024 * 1024 '500메가
		
		Dim ActionType : ActionType = UPLOAD__FORM("ActionType")
		Dim Board  : Board  = UPLOAD__FORM("Board")
		
		Dim No       : No       = Trim( iif(UPLOAD__FORM("No")="",0,UPLOAD__FORM("No")) )
		Dim Title    : Title    = TagEncode( Trim(UPLOAD__FORM("Title")) )
		Dim Contents : Contents = Trim(UPLOAD__FORM("Contents"))
		
		Dim BoardListHelper : set BoardListHelper = new BoardListHelper
		Dim BoardListModel  : set BoardListModel = BoardListHelper.SelectByField("Code",Board)
		if IsNothing(BoardListModel) then
			call alerts ("잘못된 경로입니다.","")
		end if
		
		Dim BoardHelper : set BoardHelper = new BoardHelper
		Dim obj : set obj = new Board
		
		Dim BoardFilesHelper : set BoardFilesHelper = new BoardFilesHelper
		Dim BoardFiles : set BoardFiles = new BoardFiles
		
		if ActionType = "INSERT" then
			if Title = "" then 
				call alerts ("제목을 입력해주세요.","")
			end if

			obj.Code = BoardListModel.No
			obj.ParentNo = 0
			obj.OrderNo = 0
			obj.DepthNo = 0
			obj.UserNo = session("userNo")
			obj.Title = Title
			obj.Contents = Contents
			obj.Notice = 0
			obj.Ip = g_uip
			obj.AdminNo = 0
			
			result = BoardHelper.Insert(obj)
			result2 = BoardHelper.UpdateByField("ParentNo", obj.No, obj.No) 
			
			nFileCnt = UPLOAD__FORM("files").Count
			BoardFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					BoardFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = BoardFilesHelper.Insert(BoardFiles)
				end if
			Next
			call alerts ("등록되었습니다.","?controller=Mypage&action=Inquiry&mode=List")
		elseif ActionType = "UPDATE" then
			if Title = "" then 
				call alerts ("제목을 입력해주세요.","")
			end if

			obj.No = No
			obj.Title = Title
			obj.Contents = Contents
			obj.Notice = 0
			
			BoardHelper.Update(obj)
			
			nFileCnt = UPLOAD__FORM("files").Count
			BoardFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					BoardFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = BoardFilesHelper.Insert(BoardFiles)
				end if
			Next
			
			call alerts ("수정되었습니다.","?controller=Mypage&action=Inquiry&mode=List")
			
		elseif ActionType = "DELETE" then
			BoardHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=Mypage&action=Inquiry&mode=List")
		else
			call alerts ("잘못된 경로입니다.","")
		end if
	End Sub
	
	
	
	
	
	public Sub Qna()
		call checkLogin("")
		call checkEmailConfirm()
		
		Dim Code      : Code      = iif(Request("Code")="","",Request("Code"))
		Dim mode      : mode      = iif(Request("mode")="","List",Request("mode"))
		Dim No        : No        = iif(Request("No")="",0,Request("No"))
		Dim Title     : Title     = iif(Request("Title")="","",Request("Title"))
		Dim ProductNo : ProductNo = iif(Request("ProductNo")="","",Request("ProductNo"))
		Dim pageNo    : pageNo    = iif(Request("pageNo")="",1,Request("pageNo"))
		Dim rows      : rows      = 10000

		Dim ProductObj,ProductHelper,ProductModel,ProductLabel,ProductLink
		
		Dim BoardHelper : set BoardHelper = new DevicesAppsBoardHelper
		Dim BoardFilesHelper : set BoardFilesHelper = new DevicesAppsBoardFilesHelper
		Dim BoardFilesModel
		
		if mode = "List" then 
			Dim objs : set objs = new DevicesAppsBoard
	
			objs.Types = "QNA"
			objs.Title = Title
			objs.ProductNo = ProductNo
			objs.UserNo = session("UserNo")
		
			set Model = BoardHelper.SelectAll(objs,pageNo,rows)
		
			pTotCount = 0
			if Not( IsNothing(Model) ) then
				For each obj in Model.Items
					pTotCount = obj.tcount
				next
			end if
			%> <!--#include file="../Views/Mypage/QnaList.asp" --> <%
		elseif mode = "Registe" then
			set Model = BoardHelper.SelectByField("No",No)

			if Code = "Devices" then
				set ProductObj = new Devices
				set ProductHelper = new DevicesHelper
				set ProductModel = ProductHelper.SelectByField("No", ProductNo)
				ProductLink = "?controller=DevicesApps&action=DevicesDetail&No=" & ProductNo
			elseif Code = "Apps" then
				set ProductObj = new Apps
				set ProductHelper = new AppsHelper
				set ProductModel = ProductHelper.SelectByField("No", ProductNo)
				ProductLink = "?controller=DevicesApps&action=AppsDetail&No=" & ProductNo
			end if
			
			if IsNothing(ProductModel) then
				call alerts ("잘못된 경로입니다.","")
			end if
			
			'ProductImages = ProductModel.Images1
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images2,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images3,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images4,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/"&Code&"/"&ProductImages )
			
			ProductImages = ProductModel.ImagesList
			ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/"&Code&"/"&ProductImages )

			Dim ActionType : ActionType = "INSERT"
			if Not(IsNothing(Model)) then
				ActionType = "UPDATE"
			else
				set Model = new DevicesAppsBoard
			end if

			'파일
			set BoardFilesModel = BoardFilesHelper.SelectByField("ParentNo",No)

			ViewData.add "ActionType",ActionType
			ViewData.add "ActionList","?controller=Mypage&action=Qna"
			ViewData.add "ActionForm","?controller=Mypage&action=QnaPost&partial=True"
			%><!--#include file="../Views/Mypage/QnaRegiste.asp" --> <%
		elseif mode = "Detail" then
			set Model = BoardHelper.SelectByField("No",No)
			if IsNothing(Model) then
				call alerts ("잘못된 경로입니다.","")
			end if

			if Model.Code = "Devices" then
				set ProductObj = new Devices
				set ProductHelper = new DevicesHelper
				set ProductModel = ProductHelper.SelectByField("No", Model.ProductNo)
				ProductLink = "?controller=DevicesApps&action=DevicesDetail&No=" & Model.ProductNo
			elseif Model.Code = "Apps" then
				set ProductObj = new Apps
				set ProductHelper = new AppsHelper
				set ProductModel = ProductHelper.SelectByField("No", Model.ProductNo)
				ProductLink = "?controller=DevicesApps&action=AppsDetail&No=" & Model.ProductNo
			end if

			if IsNothing(ProductModel) then
				call alerts ("잘못된 경로입니다.","")
			end if
			
			'ProductImages = ProductModel.Images1
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images2,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images3,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images4,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/"&Model.Code&"/"&ProductImages )
			
			ProductImages = ProductModel.ImagesList
			ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/"&Model.Code&"/"&ProductImages )
			
			'파일
			set BoardFilesModel = BoardFilesHelper.SelectByField("ParentNo",No)

			
			ViewData.add "ActionList","?controller=Mypage&action=Qna"
			ViewData.add "ActionRegiste","?controller=Mypage&action=Qna&mode=Registe&Code="&Model.Code&"&ProductNo="&Model.ProductNo&"&No="&NO
			ViewData.add "ActionForm","?controller=Mypage&action=QnaPost&partial=True"
			%><!--#include file="../Views/Mypage/QnaDetail.asp" --> <%
		end if
	End Sub
	
	public Sub QnaPost()
		call checkLogin("")
		call checkEmailConfirm()
		
		uploadPath = "/upload/DnABoard/"
		savePath = server.mapPath( uploadPath ) & "/"
		
		Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
		UPLOAD__FORM.AutoMakeFolder = True 
		UPLOAD__FORM.CodePage = 65001
		UPLOAD__FORM.DefaultPath = savePath
		UPLOAD__FORM.MaxFileLen	= 500 * 1024 * 1024 '500메가
		
		Dim ActionType : ActionType = UPLOAD__FORM("ActionType")
		Dim BoardCode  : BoardCode  = UPLOAD__FORM("Code")
		Dim BoardType  : BoardType  = "QNA"
		
		Dim No       : No       = Trim( iif(UPLOAD__FORM("No")="",0,UPLOAD__FORM("No")) )
		Dim Title    : Title    = TagEncode( Trim(UPLOAD__FORM("Title")) )
		Dim ProductNo: ProductNo= UPLOAD__FORM("ProductNo")
		Dim Contents : Contents = UPLOAD__FORM("Contents")

		Dim BoardHelper : set BoardHelper = new DevicesAppsBoardHelper
		Dim obj : set obj = new DevicesAppsBoard
		
		Dim BoardFilesHelper : set BoardFilesHelper = new DevicesAppsBoardFilesHelper
		Dim BoardFiles : set BoardFiles = new DevicesAppsBoardFiles
		
		Dim ProductObj,ProductHelper,ProductModel,ProductLabel,ProductLink
		if BoardCode = "Devices" then
			set ProductObj = new Devices
			set ProductHelper = new DevicesHelper
		elseif BoardCode = "Apps" then
			set ProductObj = new Apps
			set ProductHelper = new AppsHelper
		end if
		set ProductModel = ProductHelper.SelectByField("No", ProductNo)
		
		if IsNothing(ProductModel) then
			call alerts ("잘못된 경로입니다.","")
		end if
		
		if ActionType = "INSERT" then
			if Title = "" then 
				call alerts ("제목을 입력해주세요.","")
			end if

			obj.Code = BoardCode
			obj.Types = BoardType
			obj.ProductNo = ProductModel.No
			obj.ManagerNo =ProductModel.UserNo
			obj.ParentNo = 0
			obj.OrderNo = 0
			obj.DepthNo = 0
			obj.UserNo = session("UserNo")
			obj.Title = Title
			obj.Contents = Contents
			obj.Ip = g_uip
			obj.AdminNo = 0
			obj.AdminFg = 0
			
			result = BoardHelper.Insert(obj)
			result2 = BoardHelper.UpdateByField("ParentNo", obj.No, obj.No)
			
			nFileCnt = UPLOAD__FORM("files").Count
			BoardFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					BoardFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = BoardFilesHelper.Insert(BoardFiles)
				end if
			Next
			
			if ProductModel.UserNo > 0 then 
				'메일 발송
				Dim UserHelper : set UserHelper = new UserHelper
				set UserModel = UserHelper.SelectByField("No", ProductModel.UserNo)
	
				Dim strFile : strFile = server.mapPath("/Utils/email/qestion.html")
				dim strSubject : strSubject = "새로운 질문이 등록되었습니다."
				dim strBody : strBody = ReadFile(strFile)
				dim strTo : strTo = UserModel.Id
				dim strFrom : strFrom = "OPEN-IOT<no-reply@open-iot.net>"
				
				strBody = replace(strBody, "#CONTENTS#" , Contents )
				strBody = replace(strBody, "#URL#" , g_host & "/Utils/email/" )
				
				dim Mresult : Mresult = MailSend(strSubject, strBody, strTo, strFrom, "")
			end if 

			call alerts ("등록되었습니다.","?controller=Mypage&action=Qna")
		elseif ActionType = "UPDATE" then
			if Title = "" then 
				call alerts ("제목을 입력해주세요.","")
			end if

			obj.No = No
			obj.Title = Title
			obj.Contents = Contents
			
			BoardHelper.Update(obj)
	
			nFileCnt = UPLOAD__FORM("files").Count
			BoardFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					BoardFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = BoardFilesHelper.Insert(BoardFiles)
				end if
			Next
			call alerts ("수정되었습니다.","?controller=Mypage&action=Qna")
		elseif ActionType = "DELETE" then
			BoardHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=Mypage&action=Qna")
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub

	
	
	
	
	
	
	
	
	
	
	
	public Sub Oid()
		call checkLogin("")
		call checkEmailConfirm()
		
		Dim UserHelper : set UserHelper = new UserHelper
		Dim UserModel : set UserModel = UserHelper.SelectByField("No",session("userNo"))
		
		Dim OidHelper : set OidHelper = new OidHelper
		set Model = OidHelper.SelectByField("UserNo",session("userNo"))
		
		Dim ActionType : ActionType = "INSERT"
		Dim PageTitle : PageTitle = "OID 신청하기"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
			PageTitle = "OID 수정하기"
		else
			set Model = new Oids
		end if
		
		ViewData.add "PageTitle",PageTitle
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionForm","?controller=Mypage&action=OidPost&partial=True"
		%> <!--#include file="../Views/Mypage/OidRegiste.asp" --> <%
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

		Dim ActionType : ActionType = UPLOAD__FORM("ActionType")
		Dim No         : No         = Trim( iif(UPLOAD__FORM("No")="",0,UPLOAD__FORM("No")) )
		Dim Oid        : Oid        = Trim( iif(UPLOAD__FORM("Oid")="","",UPLOAD__FORM("Oid")) )
		Dim Hphone1    : Hphone1    = Trim(UPLOAD__FORM("Hphone1"))
		Dim Hphone2    : Hphone2    = Trim(UPLOAD__FORM("Hphone2"))
		Dim Hphone3    : Hphone3    = Trim(UPLOAD__FORM("Hphone3"))
		Dim Name       : Name       = Trim(UPLOAD__FORM("Name"))
		Dim Email      : Email      = Trim(UPLOAD__FORM("Email"))
		Dim Addr       : Addr       = Trim(UPLOAD__FORM("Addr"))
		Dim Phone1     : Phone1     = Trim(UPLOAD__FORM("Phone1"))
		Dim Phone2     : Phone2     = Trim(UPLOAD__FORM("Phone2"))
		Dim Phone3     : Phone3     = Trim(UPLOAD__FORM("Phone3"))
		Dim Url        : Url        = Trim(UPLOAD__FORM("Url"))
		
		Dim ImgLogo         : ImgLogo         = Trim(UPLOAD__FORM("ImgLogo"))
		Dim ImgBusiness     : ImgBusiness     = Trim(UPLOAD__FORM("ImgBusiness"))
		Dim oldImgLogo      : oldImgLogo      = Trim(UPLOAD__FORM("oldImgLogo"))
		Dim oldImgBusiness  : oldImgBusiness  = Trim(UPLOAD__FORM("oldImgBusiness"))
		
		Dim State : State = Trim(UPLOAD__FORM("State"))
		
		Dim OidHelper : set OidHelper = new OidHelper
		Dim obj : set obj = new Oids
		Dim result
		
		if ActionType = "UPDATE" then
			if Hphone1 = "" or Hphone2 = "" or Hphone3 = "" then
				call alerts ("핸드폰 번호를 입력해주세요.","")
			end if
			
			if Name = "" then
				call alerts ("기업명을 입력해주세요.","")
			end if
			
			if Email = "" then
				call alerts ("담당자 메일을 입력해주세요.","")
			end if
			
			if Url = "" then
				call alerts ("Url을 입력해주세요.","")
			end if
			
			if Addr = "" then
				call alerts ("주소를 입력해주세요.","")
			end if
			
			if Phone1 = "" or Phone2 = "" or Phone3 = "" then
				call alerts ("회사연락처를 입력해주세요.","")
			end if
			
			if ImgLogo = "" and oldImgLogo = "" then
				call alerts ("회사로고를 선택해주세요.","")
			end if
			
			if ImgBusiness = "" and oldImgBusiness = "" then
				call alerts ("사업자 등록증을 선택해주세요.","")
			end if
			
			If INSTR(LCase(Url),"http://")=0 or INSTR(LCase(Url),"https://")=0 then 
				Url = "http://" & Url
			end if
			ImgLogo = fileUpload_proc(UPLOAD__FORM,savePath, ImgLogo , "ImgLogo" , oldImgLogo , "" )
			ImgBusiness = fileUpload_proc(UPLOAD__FORM,savePath, ImgBusiness , "ImgBusiness" , oldImgBusiness , "" )
			
			obj.No = No
			obj.Oid = Oid
			obj.Hphone1 = Hphone1
			obj.Hphone2 = Hphone2
			obj.Hphone3 = Hphone3
			obj.Name = Name
			obj.Email = Email
			obj.Addr = Addr
			obj.Phone1 = Phone1
			obj.Phone2 = Phone2
			obj.Phone3 = Phone3
			obj.ImgLogo = ImgLogo
			obj.ImgBusiness = ImgBusiness
			obj.State = iif( State = "0" , 0 , 1 )
			obj.Url = Url
			
			OidHelper.Update(obj)

			call alerts ("수정되었습니다.","?controller=Mypage&action=Oid" )
			
		elseif ActionType = "INSERT" then
			if Hphone1 = "" or Hphone2 = "" or Hphone3 = "" then
				call alerts ("핸드폰 번호를 입력해주세요.","")
			end if
			
			if Name = "" then
				call alerts ("기업명을 입력해주세요.","")
			end if
			
			if Email = "" then
				call alerts ("담당자 메일을 입력해주세요.","")
			end if
			
			if Url = "" then
				call alerts ("Url을 입력해주세요.","")
			end if
			
			if Addr = "" then
				call alerts ("주소를 입력해주세요.","")
			end if
			
			if Phone1 = "" or Phone2 = "" or Phone3 = "" then
				call alerts ("회사연락처를 입력해주세요.","")
			end if
			
			if ImgLogo = "" and oldImgLogo = "" then
				call alerts ("회사로고를 선택해주세요.","")
			end if
			
			if ImgBusiness = "" and oldImgBusiness = "" then
				call alerts ("사업자 등록증을 선택해주세요.","")
			end if
			
			Dim CheckName : set CheckName = OidHelper.SelectByField("Name", Name)
			if Not(IsNothing(CheckName)) then
				call alerts ("이미 사용하고 있는 기업명 입니다.","")
			end if
			
			If INSTR(LCase(Url),"http://")=0 or INSTR(LCase(Url),"https://")=0 then 
				Url = "http://" & Url
			end if

			ImgLogo = fileUpload_proc(UPLOAD__FORM,savePath, ImgLogo , "ImgLogo" , oldImgLogo , "" )
			ImgBusiness = fileUpload_proc(UPLOAD__FORM,savePath, ImgBusiness , "ImgBusiness" , oldImgBusiness , "" )
			
			obj.UserNo = session("userNo")
			obj.Oid = ""
			obj.Hphone1 = Hphone1
			obj.Hphone2 = Hphone2
			obj.Hphone3 = Hphone3
			obj.Name = Name
			obj.Email = Email
			obj.Addr = Addr
			obj.Phone1 = Phone1
			obj.Phone2 = Phone2
			obj.Phone3 = Phone3
			obj.ImgLogo = ImgLogo
			obj.ImgBusiness = ImgBusiness
			obj.State = 1
			obj.Url = Url
			
			OidHelper.INSERT(obj)

			call alerts ("신청되었습니다.","?controller=Mypage&action=Oid" )
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	public Sub DevicesApps()
		call checkLogin("")
		call checkEmailConfirm()

		Dim mode   : mode = iif( Request("mode")="","Devices",Request("mode") )
		Dim MenuNo : MenuNo = iif(Request("MenuNo")="","",Request("MenuNo"))
		
		Dim DevicesHelper , objs 
		Dim MenuObj,MenuHelper,MenuModel
		if mode = "Devices" then 
			set DevicesHelper = new DevicesHelper
			set objs = new Devices
		
			set MenuObj = new DevicesMenu
			set MenuHelper = new DevicesMenuHelper
			ViewData.add "ActionAjaxUrl","?controller=DevicesApps&action=AjaxDevicesList&UserNo=" & session("UserNo")
			ViewData.add "ActionDetail","?controller=DevicesApps&action=DevicesDetail"
			ViewData.add "ActionRegiste","?controller=DevicesApps&action=DevicesRegiste"
		elseif mode = "Apps" then
			set DevicesHelper = new AppsHelper
			set objs = new Apps
		
			set MenuObj = new AppsMenu
			set MenuHelper = new AppsMenuHelper
			ViewData.add "ActionAjaxUrl","?controller=DevicesApps&action=AjaxAppsList&UserNo=" & session("UserNo")
			ViewData.add "ActionDetail","?controller=DevicesApps&action=AppsDetail"
			ViewData.add "ActionRegiste","?controller=DevicesApps&action=AppsRegiste"
		end if
		ViewData.add "ActionDelete","?controller=Mypage&action=DevicesAppsDelete&partial=True&mode=" & mode
		ViewData.add "ActionBoard","?controller=Mypage&action=DnABoard&Code=" & mode
		
		objs.MenuNo = MenuNo
		objs.UserNo = session("UserNo")
		set Model = DevicesHelper.SelectAll(objs,1,10000)
		
		set MenuModel = MenuHelper.SelectAll(MenuObj,1,10000)
		
		%> <!--#include file="../Views/Mypage/DevicesApps.asp" --> <%
	End Sub
	
	public Sub DevicesAppsDelete()
		call checkLogin("")
		call checkEmailConfirm()
		
		Dim mode : mode = iif( Request("mode")="","Devices",Request("mode") )
		Dim No   : No   = iif( Request("No")="",0,Request("No") )
		
		Dim Helper
		if mode = "Devices" then 
			set Helper = new DevicesHelper
		elseif mode = "Apps" then
			set Helper = new AppsHelper
		end if
		
		Helper.Delete(No)
		call alerts ("삭제되었습니다.","?controller=Mypage&action=DevicesApps&mode=" & mode )
	End Sub
	
	
	public Sub DnABoard()
		call checkLogin("")
		call checkEmailConfirm()
		
		Dim mode  : mode  = iif(Request("mode")="","List",Request("mode"))
		Dim No    : No    = iif(Request("No")="",0,Request("No"))
		Dim Code  : Code  = Request("Code")
		Dim Types : Types = Request("Types")
		Dim Title     : Title = iif(Request("Title")="","",Request("Title"))
		Dim ProductNo : ProductNo = iif(Request("ProductNo")="","",Request("ProductNo"))
		Dim UserNo    : UserNo = iif(Request("UserNo")="","",Request("UserNo"))
		Dim pageNo    : pageNo = iif(Request("pageNo")="",1,Request("pageNo"))
		Dim rows      : rows  = 10000
		
		Dim ProductObj,ProductHelper,ProductModel,ProductLabel,ProductLink
		
		Dim BoardHelper : set BoardHelper = new DevicesAppsBoardHelper
		Dim BoardFilesHelper : set BoardFilesHelper = new DevicesAppsBoardFilesHelper
		Dim BoardFilesModel
		Dim ActionType
		
		if mode = "List" then 
			Dim objs : set objs = new DevicesAppsBoard
			objs.Code  = Code
			objs.Types = Types
			objs.Title = Title
			objs.ProductNo = ProductNo
			
			set Model = BoardHelper.SelectAll(objs,pageNo,rows)
			
			pTotCount = 0
			if Not( IsNothing(Model) ) then
				For each obj in Model.Items
					pTotCount = obj.tcount
				next
			end if
		
			ViewData.add "ActionAjaxUrl","?controller=DevicesAppsBoard&action=AjaxList&Types="&Types&"&Code="&Code&"&ProductNo="&ProductNo&"&partial=True"
			ViewData.add "ActionRegiste","?controller=Mypage&action=DnABoard&mode=Registe&Code="&Code&"&Types="&Types&"&ProductNo="&ProductNo
			ViewData.add "ActionDetail","?controller=Mypage&action=DnABoard&mode=Detail&Code="&Code&"&Types="&Types&"&ProductNo="&ProductNo
			
			%> <!--#include file="../Views/Mypage/DNAList.asp" --> <%
		elseif mode = "Registe" then
			set Model = BoardHelper.SelectByField("No",No)

			if Code = "Devices" then
				set ProductObj = new Devices
				set ProductHelper = new DevicesHelper
				set ProductModel = ProductHelper.SelectByField("No", ProductNo)
				ProductLink = "?controller=DevicesApps&action=DevicesDetail&No=" & ProductNo
			elseif Code = "Apps" then
				set ProductObj = new Apps
				set ProductHelper = new AppsHelper
				set ProductModel = ProductHelper.SelectByField("No", ProductNo)
				ProductLink = "?controller=DevicesApps&action=AppsDetail&No=" & ProductNo
			end if
			
			if IsNothing(ProductModel) then
				call alerts ("잘못된 경로입니다.","")
			end if
			
			'ProductImages = ProductModel.Images1
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images2,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images3,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images4,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/"&Code&"/"&ProductImages )
			
			ProductImages = ProductModel.ImagesList
			ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/"&Code&"/"&ProductImages )

			ActionType = "INSERT"
			if Not(IsNothing(Model)) then
				ActionType = "UPDATE"
			else
				set Model = new DevicesAppsBoard
			end if

			'파일
			set BoardFilesModel = BoardFilesHelper.SelectByField("ParentNo",No)

			ViewData.add "ActionType",ActionType
			ViewData.add "ActionList","?controller=Mypage&action=DnABoard&Code="&Code&"&ProductNo="&ProductNo&"&Types="&Types
			ViewData.add "ActionForm","?controller=Mypage&action=DnABoardPost&partial=True"
			%><!--#include file="../Views/Mypage/DNARegiste.asp" --> <%
		elseif mode = "Reply" then
			set Model = BoardHelper.SelectByField("No",No)
			
			if IsNothing(Model) then
				call alerts ("잘못된 경로입니다.","")
			end if

			if Code = "Devices" then
				set ProductObj = new Devices
				set ProductHelper = new DevicesHelper
				set ProductModel = ProductHelper.SelectByField("No", ProductNo)
				ProductLink = "?controller=DevicesApps&action=DevicesDetail&No=" & ProductNo
			elseif Code = "Apps" then
				set ProductObj = new Apps
				set ProductHelper = new AppsHelper
				set ProductModel = ProductHelper.SelectByField("No", ProductNo)
				ProductLink = "?controller=DevicesApps&action=AppsDetail&No=" & ProductNo
			end if

			'ProductImages = ProductModel.Images1
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images2,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images3,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images4,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/"&Code&"/"&ProductImages )
			
			ProductImages = ProductModel.ImagesList
			ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/"&Code&"/"&ProductImages )

			ActionType = "REPLY"
			'Model.Contents = "[ 답 변 ]<br><br><br>-----------------------------------------------<br> [ 질 문 ] <br>" & Model.Contents
			Model.Contents = ""

			'파일
			set BoardFilesModel = BoardFilesHelper.SelectByField("ParentNo",No)

			ViewData.add "ActionType",ActionType
			ViewData.add "ActionList","?controller=Mypage&action=DnABoard&Code="&Code&"&ProductNo="&ProductNo&"&Types="&Types
			ViewData.add "ActionForm","?controller=Mypage&action=DnABoardPost&partial=True"
			%><!--#include file="../Views/Mypage/DNARegiste.asp" --> <%
		elseif mode = "Detail" then
			set Model = BoardHelper.SelectByField("No",No)
			if IsNothing(Model) then
				call alerts ("잘못된 경로입니다.","")
			end if

			if Model.Code = "Devices" then
				set ProductObj = new Devices
				set ProductHelper = new DevicesHelper
				set ProductModel = ProductHelper.SelectByField("No", Model.ProductNo)
				ProductLink = "?controller=DevicesApps&action=DevicesDetail&No=" & Model.ProductNo
			elseif Model.Code = "Apps" then
				set ProductObj = new Apps
				set ProductHelper = new AppsHelper
				set ProductModel = ProductHelper.SelectByField("No", Model.ProductNo)
				ProductLink = "?controller=DevicesApps&action=AppsDetail&No=" & Model.ProductNo
			end if

			if IsNothing(ProductModel) then
				call alerts ("잘못된 경로입니다.","")
			end if
			
			'ProductImages = ProductModel.Images1
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images2,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images3,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",ProductModel.Images4,ProductImages )
			'ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/"&Model.Code&"/"&ProductImages )
			
			ProductImages = ProductModel.ImagesList
			ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/"&Model.Code&"/"&ProductImages )
			
			'파일
			set BoardFilesModel = BoardFilesHelper.SelectByField("ParentNo",No)

			ViewData.add "ActionReply","?controller=Mypage&action=DnABoard&mode=Reply&Code="&Code&"&Types="&Types&"&ProductNo="&ProductNo&"&No="&No
			ViewData.add "ActionList","?controller=Mypage&action=DnABoard&Code="&Code&"&ProductNo="&ProductNo&"&Types="&Types
			ViewData.add "ActionRegiste","?controller=Mypage&action=DnABoard&mode=Registe&Code="&Code&"&Types="&Types&"&ProductNo="&ProductNo&"&No="&No
			ViewData.add "ActionForm","?controller=Mypage&action=DnABoardPost&partial=True"
			%><!--#include file="../Views/Mypage/DNADetail.asp" --> <%
		end if
	End Sub
	
	public Sub DnABoardPost()
		call checkLogin("")
		call checkEmailConfirm()
		
		uploadPath = "/upload/DnABoard/"
		savePath = server.mapPath( uploadPath ) & "/"
		
		Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
		UPLOAD__FORM.AutoMakeFolder = True 
		UPLOAD__FORM.CodePage = 65001
		UPLOAD__FORM.DefaultPath = savePath
		UPLOAD__FORM.MaxFileLen	= 500 * 1024 * 1024 '500메가
		
		Dim ActionType : ActionType = UPLOAD__FORM("ActionType")
		Dim BoardCode  : BoardCode  = UPLOAD__FORM("Code")
		Dim BoardType  : BoardType  = UPLOAD__FORM("Types")
		
		Dim No       : No       = Trim( iif(UPLOAD__FORM("No")="",0,UPLOAD__FORM("No")) )
		Dim Title    : Title    = TagEncode( Trim(UPLOAD__FORM("Title")) )
		Dim ProductNo: ProductNo= UPLOAD__FORM("ProductNo")
		Dim Contents : Contents = UPLOAD__FORM("Contents")

		Dim BoardHelper : set BoardHelper = new DevicesAppsBoardHelper
		Dim obj : set obj = new DevicesAppsBoard
		
		Dim BoardFilesHelper : set BoardFilesHelper = new DevicesAppsBoardFilesHelper
		Dim BoardFiles : set BoardFiles = new DevicesAppsBoardFiles
		
		Dim ProductObj,ProductHelper,ProductModel,ProductLabel,ProductLink
		if BoardCode = "Devices" then
			set ProductObj = new Devices
			set ProductHelper = new DevicesHelper
		elseif BoardCode = "Apps" then
			set ProductObj = new Apps
			set ProductHelper = new AppsHelper
		end if
		set ProductModel = ProductHelper.SelectByField("No", ProductNo)
		
		if IsNothing(ProductModel) then
			call alerts ("잘못된 경로입니다.","")
		end if
		
		if ActionType = "INSERT" then
			if Title = "" then 
				call alerts ("제목을 입력해주세요.","")
			end if

			obj.Code = BoardCode
			obj.Types = BoardType
			obj.ProductNo = ProductModel.No
			obj.ManagerNo =ProductModel.UserNo
			obj.ParentNo = 0
			obj.OrderNo = 0
			obj.DepthNo = 0
			obj.UserNo = 0
			obj.Title = Title
			obj.Contents = Contents
			obj.Ip = g_uip
			obj.AdminNo = ProductModel.UserNo
			obj.AdminFg = 0
			
			result = BoardHelper.Insert(obj)
			result2 = BoardHelper.UpdateByField("ParentNo", obj.No, obj.No)
			
			nFileCnt = UPLOAD__FORM("files").Count
			BoardFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					BoardFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = BoardFilesHelper.Insert(BoardFiles)
				end if
			Next

			call alerts ("등록되었습니다.","?controller=Mypage&action=DnABoard&Code="&BoardCode&"&ProductNo="&ProductNo&"&Types="&BoardType)
		elseif ActionType = "UPDATE" then
			if Title = "" then 
				call alerts ("제목을 입력해주세요.","")
			end if

			obj.No = No
			obj.Title = Title
			obj.Contents = Contents
			
			BoardHelper.Update(obj)
	
			nFileCnt = UPLOAD__FORM("files").Count
			BoardFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					BoardFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = BoardFilesHelper.Insert(BoardFiles)
				end if
			Next
			call alerts ("수정되었습니다.","?controller=Mypage&action=DnABoard&Code="&BoardCode&"&ProductNo="&ProductNo&"&Types="&BoardType)
		elseif ActionType = "REPLY" then
			if Title = "" then 
				call alerts ("제목을 입력해주세요.","")
			end if
			
			set Model = BoardHelper.SelectByField("No",No)

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
			obj.AdminNo = session("UserNo")
			obj.AdminFg = 0
			
			result2 = BoardHelper.UpdateReply(obj.ParentNo,obj.OrderNo)
			result  = BoardHelper.Insert(obj)
			
			nFileCnt = UPLOAD__FORM("files").Count
			BoardFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					BoardFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = BoardFilesHelper.Insert(DevicesAppsBoardFiles)
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
			
			
			call alerts ("등록되었습니다.","?controller=Mypage&action=DnABoard&Code="&BoardCode&"&ProductNo="&ProductNo&"&Types="&BoardType)
		elseif ActionType = "DELETE" then
			BoardHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=Mypage&action=DnABoard&Code="&BoardCode&"&ProductNo="&ProductNo&"&Types="&BoardType)
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	
	public Sub Reservations()
		call checkLogin("")
		call checkEmailConfirm()

		Dim objs : set objs = new Reservation
		objs.UserNo  = session("userNo")
		
		Dim ReservationHelper : set ReservationHelper = new ReservationHelper
		set Model = ReservationHelper.SelectAll(objs,1,1000)

		%><!--#include file="../Views/Mypage/Reservation.asp" --> <%
	End Sub
	
	
	
	
	
	
	
	
	
	public Sub Secede()
		call checkLogin("")
		
		Dim UserHelper : set UserHelper = new UserHelper
		set Model = UserHelper.SelectByField("No",session("userNo"))
		
		ViewData.add "ActionForm"  ,"?controller=Mypage&action=SecedePost&partial=True"
		
		%> <!--#include file="../Views/Mypage/Secede.asp" --> <%
	End Sub
	
	public Sub SecedePost()
		call checkLogin("?controller=Mypage&action=Secede")
		
		Dim args : Set args = Request.Form
		
		Dim Pwd : Pwd = Trim( args("Pwd") )
		
		if Trim(Pwd) = "" Then
			call alerts ("비밀번호를 입력해주세요.","")
		end if
		
		Dim UserHelper : set UserHelper = new UserHelper
		Dim User : set User = UserHelper.SelectByField("No",session("userNo"))
		
		Dim obj : set obj = new User
		
		obj.Id  = User.Id
		obj.Pwd = Pwd
		
		set Model = UserHelper.Login(obj)
		
		if IsNothing(Model) Then
			call alerts ("비밀번호가 일치하지 않습니다.","")
		else
			if UserHelper.Delete(User.No) then
				
				Dim strFile : strFile = server.mapPath("/Utils/email/secede.html")
				dim strSubject : strSubject = "회원 탈퇴가 성공적으로 이루어졌습니다."
				dim strBody : strBody = ReadFile(strFile)
				dim strTo : strTo = Model.Id
				dim strFrom : strFrom = "OPEN-IOT<no-reply@open-iot.net>"
				
				strBody = replace(strBody, "#ID#" , Model.Id )
				strBody = replace(strBody, "#DATE#" , NOW() )
				strBody = replace(strBody, "#URL#" , g_host & "/Utils/email/" )
				
				dim result : result = MailSend(strSubject, strBody, strTo, strFrom, "")
		
				call alerts ("정상 처리되었습니다.","?controller=Member&action=Logout&partial=True")
			else
				call alerts ("error : 탈퇴신청이 실패 했습니다. 관리자에게 문의바랍니다.","")
			end if
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
    