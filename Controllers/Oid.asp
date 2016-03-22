<%
class OidController
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
		set Model = PageHelper.SelectByField("Name", "AboutOID")
		
		'파일
		Dim FilesHelper : set FilesHelper = new PageFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentName","AboutOID")
		
		%> <!--#include file="../Views/Oid/Index.asp" --> <%
	End Sub
	
	public Sub Registe()
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
		ViewData.add "ActionForm","?controller=Oid&action=Post&partial=True"
		%> <!--#include file="../Views/Oid/Registe.asp" --> <%
	End Sub
	
	
	public Sub Post()
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

			call alerts ("수정되었습니다.","?controller=Oid&action=Registe" )
			
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

			call alerts ("신청되었습니다.","?controller=Oid&action=Registe" )
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	public Sub AjaxCheckName()
		Dim Name : Name = Request("Name")
		
		Dim OidHelper : set OidHelper = new OidHelper
		set Model = OidHelper.SelectByField("UserNo != " & session("userNo") & " AND  A.Name", Name)

		if IsNothing(Model) then
			Response.write "true"
		else
			Response.write "false"
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
    