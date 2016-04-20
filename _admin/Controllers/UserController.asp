<%
class UserController
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
		Member()
	End Sub
	
	public Sub Member()
		ParamData.Add "mode"  , iif(Request("mode")="","List",Request("mode"))
		ParamData.Add "sDate" , iif(Request("sDate")="","",Request("sDate"))
		ParamData.Add "eDate" , iif(Request("eDate")="","",Request("eDate"))
		ParamData.Add "Id"    , iif(Request("Id")="","",Request("Id"))
		ParamData.Add "Name"  , iif(Request("Name")="","",Request("Name"))
		ParamData.Add "State" , iif(Request("State")="","",Request("State"))
		ParamData.Add "Phone3", iif(Request("Phone3")="","",Request("Phone3"))
		ParamData.Add "pageNo", iif(Request("pageNo")="",1,Request("pageNo"))
		ParamData.Add "url"   , "&sDate=" & ParamData("sDate") & "&eDate=" & ParamData("eDate") & "&Id=" & ParamData("Id") & "&Name=" & ParamData("Name") &_
		 "&Phone3=" & ParamData("Phone3") & "&State=" & ParamData("State")
		
		if ParamData("mode") = "List" then
			call MemberList()
		elseif ParamData("mode") = "Registe" then
			call MemberRegiste()
		elseif ParamData("mode") = "Excel" then
			call MemberExcel()
		end if
	End Sub
	
	private Sub MemberList()
		Dim rows    : rows    = 10
		Dim pageUrl : pageUrl = "?controller=User&action=Member&mode=List" & ParamData("url")
		
		Dim objs : set objs = new User
		objs.Sdate  = ParamData("sDate")
		objs.Edate  = ParamData("eDate")
		objs.Id     = ParamData("Id")
		objs.Name   = ParamData("Name")
		objs.Phone3 = ParamData("Phone3")
		objs.State  = ParamData("State")
		
		Dim UserHelper : set UserHelper = new UserHelper
		set Model = UserHelper.SelectAll(objs,ParamData("pageNo"),rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if
		
		ViewData.add "pagination" ,printPageList(pTotCount, cint(ParamData("pageNo")), rows, pageUrl & "&pageNo=__PAGE__")
		ViewData.add "ActionRegiste","?controller=User&action=Member&mode=Registe" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=User&action=MemberPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionType","DELETE"
		ViewData.add "ActionExcel","?controller=User&action=Member&mode=Excel&partial=True" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/User/MemberList.asp" --> <%
	End Sub
	
	
	private Sub MemberExcel()
		Session.Timeout = 600
		Server.ScriptTimeOut = 60*60*60 '초
		
		Dim objs : set objs = new User
		objs.Sdate  = ParamData("sDate")
		objs.Edate  = ParamData("eDate")
		objs.Id     = ParamData("Id")
		objs.Name   = ParamData("Name")
		objs.Phone3 = ParamData("Phone3")
		objs.State  = ParamData("State")
		
		Dim UserHelper : set UserHelper = new UserHelper
		set Model = UserHelper.SelectAll(objs,1,100000000)
		
		
		Dim tmp_html : tmp_html = "" &_
		"<?xml version=""1.0"" encoding=""utf-8""?>" &_
		"<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:o=""urn:schemas-microsoft-com:office:office"" xmlns:x=""urn:schemas-microsoft-com:office:excel"" xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:html=""http://www.w3.org/TR/REC-html40"">" &_
		"<Worksheet ss:Name=""회원 관리""> " &_
		"<Table> " &_
		"	<Column ss:Width='300'/> " &_
		"	<Column ss:Width='200'/> " &_
		"	<Column ss:Width='100'/> " &_
		"	<Column ss:Width='100'/> " &_
		"	<Column ss:Width='200'/> " &_
		"	<Row> "&_
		"		<Cell><Data ss:Type=""String"">아이디</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">이름</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">핸드폰 뒷자리</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">인증</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">가입일</Data></Cell> "&_
		"	</Row> "
		
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				tmp_html = tmp_html & "" &_
				"	<Row> "&_
				"		<Cell><Data ss:Type=""String"">" & obj.Id & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.Name & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.Phone3 & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & iif(obj.State=0,"인증","미인증") & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.Indate & "</Data></Cell>"&_
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
		Response.AddHeader "Content-Disposition","attachment; filename=회원 관리 " & Now() & ".xls"
		
	End Sub
	
	private Sub MemberRegiste()
		Dim No : No = iif(Request("No")="",0,Request("No"))
		
		Dim UserHelper : set UserHelper = new UserHelper
		set Model = UserHelper.SelectByField("No",No)
		
		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			set Model = new User
		end if
		
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=User&action=Member&mode=List" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=User&action=MemberPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/User/MemberRegiste.asp" --> <%
	End Sub
	
	public Sub MemberPost()
		Dim ActionType : ActionType = Request.Form("ActionType")
		Dim Params     : Params     = Request.Form("Params")
		Dim No         : No         = Trim( iif(Request.Form("No")="",0,Request.Form("No")) )
		Dim Id         : Id         = Trim(Request.Form("Id"))
		Dim Pwd        : Pwd        = Trim(Request.Form("Pwd"))
		Dim Name       : Name       = Trim(Request.Form("Name"))
		Dim Phone3     : Phone3     = Trim(Request.Form("Phone3"))
		Dim State      : State      = Trim(Request.Form("State"))
		
		Dim UserHelper : set UserHelper = new UserHelper
		Dim obj : set obj = new User
		Dim result
		
		if ActionType = "UPDATE" then
			if Id = "" then
				call alerts ("아이디를 입력해주세요.","")
			end if
			if Name = "" then
				call alerts ("이름을 입력해주세요.","")
			end if
			if Phone3 = "" then
				call alerts ("핸드폰 뒷자리를 입력해주세요.","")
			end if
			
			Dim check : set check = UserHelper.SelectByField("No != " & No & " and Id", Id)
			
			if Not(IsNothing (check)) Then
				call alerts ("이미 사용중인 아이디 입니다.","")
			end if
			
			Name = replace(Name," ","")
			Name = replace(Name,".","")
			
			obj.No = No
			obj.Id = Id
			obj.Name = Name
			obj.Pwd = Pwd
			obj.Phone3 = Phone3
			obj.State = State
			
			UserHelper.Update(obj)
			
			UserHelper.ChangeId(obj)
			UserHelper.ChangeName(obj)
			
			if Pwd <> "" then 
				UserHelper.updatePwd(obj)
			end if

			call alerts ("수정되었습니다.","?controller=User&action=Member&mode=List" & Params )
			
		elseif ActionType = "DELETE" then
			UserHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=User&action=Member&mode=List" & Params )
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	
	
	
	public Sub MemberLogin()
		Dim No : No = iif(Request("No")="",0,Request("No"))
		
		Dim UserHelper : set UserHelper = new UserHelper
		set Model = UserHelper.SelectByField("No",No)
		
		session("userNo")    = Model.No
		session("userState") = Model.State
		
		response.redirect "../"
	End Sub
	
	
	
	
	
	
	public Sub Oid()
		ParamData.Add "mode"    , iif(Request("mode")="","List",Request("mode"))
		ParamData.Add "sDate"   , iif(Request("sDate")="","",Request("sDate"))
		ParamData.Add "eDate"   , iif(Request("eDate")="","",Request("eDate"))
		ParamData.Add "UserId"  , iif(Request("UserId")="","",Request("UserId"))
		ParamData.Add "UserName", iif(Request("UserName")="","",Request("UserName"))
		ParamData.Add "Oid"     , iif(Request("Oid")="","",Request("Oid"))
		ParamData.Add "Name"    , iif(Request("Name")="","",Request("Name"))
		ParamData.Add "Email"   , iif(Request("Email")="","",Request("Email"))
		ParamData.Add "State"   , iif(Request("State")="","",Request("State"))
		ParamData.Add "pageNo", iif(Request("pageNo")="",1,Request("pageNo"))
		ParamData.Add "url"   , "&sDate=" & ParamData("sDate") & "&eDate=" & ParamData("eDate") & "&UserId=" & ParamData("UserId") & "&UserName=" & ParamData("UserName") &_
		 "&Oid=" & ParamData("Oid") & "&Name=" & ParamData("Name") & "&Email=" & ParamData("Email") & "&State=" & ParamData("State")
		
		if ParamData("mode") = "List" then
			call OidList()
		elseif ParamData("mode") = "Registe" then
			call OidRegiste()
		elseif ParamData("mode") = "Excel" then
			call OidExcel()
		end if
	End Sub

	private Sub OidList()
		Dim rows    : rows    = 10
		Dim pageUrl : pageUrl = "?controller=User&action=Oid&mode=List" & ParamData("url")
		
		Dim objs : set objs = new Oids
		objs.Sdate    = ParamData("sDate")
		objs.Edate    = ParamData("eDate")
		objs.UserId   = ParamData("UserId")
		objs.UserName = ParamData("UserName")
		objs.Oid      = ParamData("Oid")
		objs.Name     = ParamData("Name")
		objs.Email    = ParamData("Email")
		objs.State    = ParamData("State")
		
		Dim OidHelper : set OidHelper = new OidHelper
		set Model = OidHelper.SelectAll(objs,ParamData("pageNo"),rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if
		
		ViewData.add "pagination" ,printPageList(pTotCount, cint(ParamData("pageNo")), rows, pageUrl & "&pageNo=__PAGE__")
		ViewData.add "ActionRegiste","?controller=User&action=Oid&mode=Registe" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=User&action=OidPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionType","DELETE"
		ViewData.add "ActionExcel","?controller=User&action=Oid&mode=Excel&partial=True" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/User/OidList.asp" --> <%
	End Sub
	
	private Sub OidExcel()
		Session.Timeout = 600
		Server.ScriptTimeOut = 60*60*60 '초
		
		Dim objs : set objs = new Oids
		objs.Sdate    = ParamData("sDate")
		objs.Edate    = ParamData("eDate")
		objs.UserId   = ParamData("UserId")
		objs.UserName = ParamData("UserName")
		objs.Oid      = ParamData("Oid")
		objs.Name     = ParamData("Name")
		objs.Email    = ParamData("Email")
		objs.State    = ParamData("State")
		
		Dim OidHelper : set OidHelper = new OidHelper
		set Model = OidHelper.SelectAll(objs,1,100000000)
		
		Dim tmp_html : tmp_html = "" &_
		"<?xml version=""1.0"" encoding=""utf-8""?>" &_
		"<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:o=""urn:schemas-microsoft-com:office:office"" xmlns:x=""urn:schemas-microsoft-com:office:excel"" xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:html=""http://www.w3.org/TR/REC-html40"">" &_
		"<Worksheet ss:Name=""기업-OID 관리""> " &_
		"<Table> " &_
		"	<Column ss:Width='100'/> " &_
		"	<Column ss:Width='200'/> " &_
		"	<Column ss:Width='100'/> " &_
		"	<Column ss:Width='100'/> " &_
		"	<Column ss:Width='150'/> " &_
		"	<Column ss:Width='200'/> " &_
		"	<Column ss:Width='200'/> " &_
		"	<Column ss:Width='100'/> " &_
		"	<Column ss:Width='80'/>  " &_
		"	<Column ss:Width='200'/> " &_
		"	<Row> "&_
		"		<Cell><Data ss:Type=""String"">OID</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">아이디</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">이름</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">핸드폰</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">기업명</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">회사메일</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">주소</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">회사연락처</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">상태</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">신청일</Data></Cell> "&_
		"	</Row> "
		
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				Hphone = obj.Hphone1 &"-"& obj.Hphone2 &"-"& obj.Hphone3
				Phone  = obj.Phone1 &"-"& obj.Phone2 &"-"& obj.Phone3
				
				if obj.State = "0" then
					State = "발급"
				elseif obj.State = "1" then
					State = "미발급"
				elseif obj.State = "2" then
					State = "기업"
				end if
			
				tmp_html = tmp_html & "" &_
				"	<Row> "&_
				"		<Cell><Data ss:Type=""String"">" & obj.Oid & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.UserId & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.UserName & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & Hphone & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.Name & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.Email & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.Addr & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & Phone & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & State & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.InDate & "</Data></Cell>"&_
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
		Response.AddHeader "Content-Disposition","attachment; filename=기업-OID 관리 " & Now() & ".xls"
		
	End Sub
	
	private Sub OidRegiste()
		Dim No : No = iif(Request("No")="",0,Request("No"))
		
		Dim OidHelper : set OidHelper = new OidHelper
		set Model = OidHelper.SelectByField("No",No)
		
		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			set Model = new Oids
		end if
		
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=User&action=Oid&mode=List" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=User&action=OidPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/User/OidRegiste.asp" --> <%
	End Sub
	
	
	public Sub OidPost()
		Dim uploadPath : uploadPath = "/upload/Oid/"
		Dim savePath   : savePath   = server.mapPath( uploadPath ) & "/"
		
		Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
		UPLOAD__FORM.AutoMakeFolder = True 
		UPLOAD__FORM.CodePage = 65001
		UPLOAD__FORM.DefaultPath = savePath
		UPLOAD__FORM.MaxFileLen	= 50 * 1024 * 1024 '50메가

		Dim ActionType : ActionType = UPLOAD__FORM("ActionType")
		Dim Params     : Params     = UPLOAD__FORM("Params")
		Dim No         : No         = Trim( iif(UPLOAD__FORM("No")="",0,UPLOAD__FORM("No")) )
		Dim Oid        : Oid        = Trim( iif(UPLOAD__FORM("Oid")="","",UPLOAD__FORM("Oid")) )
		Dim Hphone1    : Hphone1    = Trim(UPLOAD__FORM("Hphone1"))
		Dim Hphone2    : Hphone2    = Trim(UPLOAD__FORM("Hphone2"))
		Dim Hphone3    : Hphone3    = Trim(UPLOAD__FORM("Hphone3"))
		Dim Name       : Name       = Trim(UPLOAD__FORM("Name"))
		Dim State      : State      = Trim(UPLOAD__FORM("State"))
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
		Dim dellImgLogo     : dellImgLogo     = Trim(UPLOAD__FORM("dellImgLogo"))
		Dim dellImgBusiness : dellImgBusiness = Trim(UPLOAD__FORM("dellImgBusiness"))
		
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
				call alerts ("회사메일을 입력해주세요.","")
			end if
			
			if Addr = "" then
				call alerts ("주소를 입력해주세요.","")
			end if
			
			if Phone1 = "" or Phone2 = "" or Phone3 = "" then
				call alerts ("회사연락처를 입력해주세요.","")
			end if

			ImgLogo = fileUpload_proc(UPLOAD__FORM,savePath, ImgLogo , "ImgLogo" , oldImgLogo , dellImgLogo )
			ImgBusiness = fileUpload_proc(UPLOAD__FORM,savePath, ImgBusiness , "ImgBusiness" , oldImgBusiness , dellImgBusiness )
			
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
			obj.State = State
			obj.Url = Url
			
			OidHelper.Update(obj)

			call alerts ("수정되었습니다.","?controller=User&action=Oid&mode=List" & Params )
			
		elseif ActionType = "DELETE" then
			OidHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=User&action=Oid&mode=List" & Params )
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
    