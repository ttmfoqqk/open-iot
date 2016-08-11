<%
class ReservationController
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
		ParamData.Add "mode"       , iif(Request("mode")="","List",Request("mode"))
		ParamData.Add "sDate"      , iif(Request("sDate")="","",Request("sDate"))
		ParamData.Add "eDate"      , iif(Request("eDate")="","",Request("eDate"))
		ParamData.Add "sRDate"     , iif(Request("sRDate")="","",Request("sRDate"))
		ParamData.Add "eRDate"     , iif(Request("eRDate")="","",Request("eRDate"))
		ParamData.Add "UserId"     , iif(Request("UserId")="","",Request("UserId"))
		ParamData.Add "UserName"   , iif(Request("UserName")="","",Request("UserName"))
		ParamData.Add "Location"   , iif(Request("Location")="","",Request("Location"))
		ParamData.Add "Facilities" , iif(Request("Facilities")="","",Request("Facilities"))
		ParamData.Add "State"      , iif(Request("State")="","",Request("State"))
		ParamData.Add "Company"    , iif(Request("Company")="","",Request("Company"))
		
		ParamData.Add "pageNo"     , iif(Request("pageNo")="",1,Request("pageNo"))
		ParamData.Add "url"        , "&sDate=" & ParamData("sDate") & "&eDate=" & ParamData("eDate") & "&sRDate=" & ParamData("sRDate") & "&eRDate=" & ParamData("eRDate") &_
		 "&UserId=" & ParamData("UserId") & "&UserName=" & ParamData("UserName") &_
		 "&Location=" & ParamData("Location") & "&Facilities=" & ParamData("Facilities") & "&State=" & ParamData("State")
		
		if ParamData("mode") = "List" then
			call List()
		elseif ParamData("mode") = "Registe" then
			call Registe()
		elseif ParamData("mode") = "Excel" then
			call Excel()
		end if
	End Sub
	
	private Sub List()
		Dim AdminHelper : set AdminHelper = new AdminHelper
		Dim AdminModel  : set AdminModel = AdminHelper.SelectByField("No",session("adminNo"))
		
		if AdminModel.Level = "1" then 
			ParamData("Location") = 1
		elseif AdminModel.Level = "2" then
			ParamData("Location") = 2
		elseif AdminModel.Level = "3" then
			ParamData("Location") = 3
		end if
	
		Dim rows    : rows    = 10
		Dim pageUrl : pageUrl = "?controller=Reservation&action=Index&mode=List" & ParamData("url")
		
		Dim objs : set objs = new Reservation
		objs.Sdate      = ParamData("sDate")
		objs.Edate      = ParamData("eDate")
		objs.SRdate     = ParamData("sRDate")
		objs.ERdate     = ParamData("eRDate")
		objs.UserId     = ParamData("UserId")
		objs.UserName   = ParamData("UserName")
		objs.Location   = ParamData("Location")
		objs.Facilities = ParamData("Facilities")
		objs.State      = ParamData("State")
		objs.Company    = ParamData("Company")
		
		Dim ReservationHelper : set ReservationHelper = new ReservationHelper
		set Model = ReservationHelper.SelectAll(objs,ParamData("pageNo"),rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if
		
		ViewData.add "pagination" ,printPageList(pTotCount, cint(ParamData("pageNo")), rows, pageUrl & "&pageNo=__PAGE__")
		ViewData.add "ActionRegiste","?controller=Reservation&action=Index&mode=Registe" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Reservation&action=Post&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionType","DELETE"
		ViewData.add "ActionExcel","?controller=Reservation&action=Index&mode=Excel&partial=True" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/Reservation/List.asp" --> <%
	End Sub
	
	
	private Sub Excel()
		Session.Timeout = 600
		Server.ScriptTimeOut = 60*60*60 '초
		
		Dim AdminHelper : set AdminHelper = new AdminHelper
		Dim AdminModel  : set AdminModel = AdminHelper.SelectByField("No",session("adminNo"))
		
		if AdminModel.Level = "1" then 
			ParamData("Location") = 1
		elseif AdminModel.Level = "2" then
			ParamData("Location") = 2
		elseif AdminModel.Level = "3" then
			ParamData("Location") = 3
		end if
		
		Dim objs : set objs = new Reservation
		objs.Sdate      = ParamData("sDate")
		objs.Edate      = ParamData("eDate")
		objs.SRdate     = ParamData("sRDate")
		objs.ERdate     = ParamData("eRDate")
		objs.UserId     = ParamData("UserId")
		objs.UserName   = ParamData("UserName")
		objs.Location   = ParamData("Location")
		objs.Facilities = ParamData("Facilities")
		objs.State      = ParamData("State")
		objs.Company    = ParamData("Company")
		
		Dim ReservationHelper : set ReservationHelper = new ReservationHelper
		set Model = ReservationHelper.SelectAll(objs,1,100000000)
		
		Dim tmp_html : tmp_html = "" &_
		"<?xml version=""1.0"" encoding=""utf-8""?>" &_
		"<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:o=""urn:schemas-microsoft-com:office:office"" xmlns:x=""urn:schemas-microsoft-com:office:excel"" xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:html=""http://www.w3.org/TR/REC-html40"">" &_
		"<Worksheet ss:Name=""예약 관리""> " &_
		"<Table> " &_
		"	<Column ss:Width='200'/> " &_
		"	<Column ss:Width='100'/> " &_
		"	<Column ss:Width='100'/> " &_
		"	<Column ss:Width='100'/> " &_
		"	<Column ss:Width='150'/> " &_
		"	<Column ss:Width='100'/> " &_
		"	<Column ss:Width='250'/> " &_
		"	<Column ss:Width='200'/> " &_
		"	<Column ss:Width='200'/> " &_
		"	<Column ss:Width='80'/> " &_
		"	<Column ss:Width='150'/> " &_
		"	<Row> "&_
		"		<Cell><Data ss:Type=""String"">아이디</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">이름</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">기업명</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">구분</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">시설</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">핸드폰</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">사용 희망일</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">이용목적</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">비고</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">상태</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">작성일</Data></Cell> "&_
		"	</Row> "
		
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				phone  = obj.Hphone1 &"-"& obj.Hphone2 &"-"& obj.Hphone3
				
				if obj.Location = "1" then
					Location = "판교"
				elseif obj.Location = "2" then
					Location = "송도" 
				elseif obj.Location = "3" then
					Location = "TTA IoT 시험소" 
				end if
				
				if obj.State = "0" then
					State = "지원완료"
				elseif obj.State = "1" then
					State = "<p class=""text-danger"">예약</p>" 
				elseif obj.State = "2" then
					State = "확정" 
				end if
			
				tmp_html = tmp_html & "" &_
				"	<Row> "&_
				"		<Cell><Data ss:Type=""String"">" & obj.UserId & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.UserName & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.Company & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & Location & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.FacilitiesName & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & phone & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.UseDate & " ~ " & iif(obj.UseEndDate="" or IsNothing(obj.UseEndDate) ,obj.UseDate,obj.UseEndDate) & iif( obj.State=0 or obj.State=2 , "   " & left(obj.Stime,5) & " ~ " & left(obj.Etime,5) , "" ) & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.Purpose & "</Data></Cell>"&_
				"		<Cell><Data ss:Type=""String"">" & obj.Bigo & "</Data></Cell>"&_
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
		Response.AddHeader "Content-Disposition","attachment; filename=예약 관리 " & Now() & ".xls"
		
	End Sub
	
	private Sub Registe()
		Dim AdminHelper : set AdminHelper = new AdminHelper
		Dim AdminModel  : set AdminModel = AdminHelper.SelectByField("No",session("adminNo"))

	
		Dim No : No = iif(Request("No")="",0,Request("No"))
		
		Dim ReservationHelper : set ReservationHelper = new ReservationHelper
		set Model = ReservationHelper.SelectByField("No",No)
		
		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			set Model = new Reservation
		end if
		
		if IsNothing(Model.Stime) or Model.Stime="" then
			Stime1 = ""
			Stime2 = ""
		else
			Stime1 = split(Model.Stime,":")(0)
			Stime2 = split(Model.Stime,":")(1)
		end if
		
		if IsNothing(Model.Etime) or Model.Etime="" then
			Etime1 = ""
			Etime2 = ""
		else
			Etime1 = split(Model.Etime,":")(0)
			Etime2 = split(Model.Etime,":")(1)
		end if
		
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=Reservation&action=Index&mode=List" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Reservation&action=Post&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/Reservation/Registe.asp" --> <%
	End Sub
	
	
	public Sub Post()
		Dim ActionType : ActionType = Request.Form("ActionType")
		Dim Params     : Params     = Request.Form("Params")
		
		Dim No         : No         = Trim( iif(Request.Form("No")="",0,Request.Form("No")) )
		Dim Location   : Location   = Trim(Request.Form("Location"))
		Dim Facilities : Facilities = Trim(Request.Form("Facilities"))
		Dim Hphone1    : Hphone1    = Trim(Request.Form("Hphone1"))
		Dim Hphone2    : Hphone2    = Trim(Request.Form("Hphone2"))
		Dim Hphone3    : Hphone3    = Trim(Request.Form("Hphone3"))
		Dim UseDate    : UseDate    = Trim(Request.Form("UseDate"))
		Dim UseEndDate : UseEndDate = Trim(Request.Form("UseEndDate"))
		Dim Purpose    : Purpose    = Trim(Request.Form("Purpose"))
		Dim State      : State      = Trim(Request.Form("State"))
		Dim Bigo       : Bigo       = Trim(Request.Form("Bigo"))
		Dim Company    : Company    = Trim(Request.Form("Company"))
		
		Dim Stime1      : Stime1    = iif(Request.Form("Stime1")="","00",Request.Form("Stime1"))
		Dim Stime2      : Stime2    = iif(Request.Form("Stime2")="","00",Request.Form("Stime2"))
		Dim Etime1      : Etime1    = iif(Request.Form("Etime1")="","00",Request.Form("Etime1"))
		Dim Etime2      : Etime2    = iif(Request.Form("Etime2")="","00",Request.Form("Etime2"))
		
		Dim ReservationHelper : set ReservationHelper = new ReservationHelper
		set Model = ReservationHelper.SelectByField("No",No)
		
		Dim ReservationMenuHelper : set ReservationMenuHelper = new ReservationMenuHelper
		Dim ReservationMenuModel  : set ReservationMenuModel  = ReservationMenuHelper.SelectByField("No",Facilities)
		
		Dim obj : set obj = new Reservation
		Dim result
		
		if ActionType = "UPDATE" then
			if Location = "" then
				call alerts ("구분을 선택해주세요.","")
			end if
			
			if Facilities = "" then
				call alerts ("시설명을 선택해주세요.","")
			end if
			
			if Company = "" then
				call alerts ("기업명을 입력해주세요.","")
			end if
			
			if Hphone1 = "" or Hphone2 = "" or Hphone3 = "" then
				call alerts ("핸드폰을 입력해주세요.","")
			end if
			
			if UseDate = "" then
				call alerts ("사용 희망일을 입력해주세요.","")
			end if
			
			if UseEndDate = "" then
				call alerts ("사용 희망일을 입력해주세요.","")
			end if
			
			if State = "" then
				call alerts ("상태를 선택해주세요.","")
			end if
			
			
			
			
			if Location = "1" then
				LocationTxt = "판교"
			elseif Location = "2" then
				LocationTxt = "송도"
			elseif Location = "3" then
				LocationTxt = "TTA IoT 시험소"
			end if
			
			
			Dim strFile : strFile = server.mapPath("/Utils/email/newReservations2.html")
			dim strSubject : strSubject = "오픈랩 예약이 확정되었습니다."
			dim strBody : strBody = ReadFile(strFile)
			dim strFrom : strFrom = "OPEN-IOT<no-reply@open-iot.net>"
			
			Dim strName : strName = LocationTxt & " > " & ReservationMenuModel.Name
			
			strBody = replace(strBody, "#ID#"   , Model.UserId )
			strBody = replace(strBody, "#NAME#" , strName )
			strBody = replace(strBody, "#USEDATE#" , UseDate & " ~ " & UseEndDate )
			strBody = replace(strBody, "#USETIME#" , left(Model.Stime,5) & " ~ " & left(Model.Etime,5) )
			strBody = replace(strBody, "#DATE#" , NOW() )
			strBody = replace(strBody, "#URL#"  , g_host & "/Utils/email/" )
			
			if Model.State <> 2 and State = 2 then
				Mresult = MailSend(strSubject, strBody, Model.UserId, strFrom, "")
			end if
			
			
			
			obj.No = No
			obj.Location = Location
			obj.Facilities = Facilities
			obj.Hphone1 = Hphone1
			obj.Hphone2 = Hphone2
			obj.Hphone3 = Hphone3
			obj.UseDate = UseDate
			obj.UseEndDate = UseEndDate
			obj.Purpose = Purpose
			obj.State = State
			obj.Stime = Stime1 &":"& Stime2
			obj.Etime = Etime1 &":"& Etime2
			obj.Bigo  = Bigo
			obj.Company  = Company
			
			ReservationHelper.Update(obj)
			
			
			
			call alerts ("수정되었습니다.","?controller=Reservation&action=Index&mode=List" & Params )
		elseif ActionType = "DELETE" then
			ReservationHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=Reservation&action=Index&mode=List" & Params )
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	
	
	
	
	
	
	
	
	
	public Sub Menu()
		ParamData.Add "mode"     , iif(Request("mode")="","List",Request("mode"))
		ParamData.Add "Name"     , iif(Request("Name")="","",Request("Name"))
		ParamData.Add "Location" , iif(Request("Location")="","",Request("Location"))
		ParamData.Add "pageNo"   , iif(Request("pageNo")="",1,Request("pageNo"))
		ParamData.Add "No"       , iif(Request("No")="",0,Request("No"))
		ParamData.Add "url"      , "&Location=" & ParamData("Location") & "&Name=" & ParamData("Name")
		 
		if ParamData("mode") = "List" then
			call MenuList()
		elseif ParamData("mode") = "Registe" then
			call MenuRegiste()
		elseif ParamData("mode") = "Excel" then
			call MenuExcel()
		end if
	End Sub
	
	
	private Sub MenuList()
		Dim AdminHelper : set AdminHelper = new AdminHelper
		Dim AdminModel  : set AdminModel = AdminHelper.SelectByField("No",session("adminNo"))
		
		if AdminModel.Level = "1" then 
			ParamData("Location") = 1
		elseif AdminModel.Level = "2" then
			ParamData("Location") = 2
		elseif AdminModel.Level = "3" then
			ParamData("Location") = 3
		end if
	
		Dim rows    : rows    = 10
		Dim pageUrl : pageUrl = "?controller=Reservation&action=Menu&mode=List" & ParamData("url")
		
		Dim objs : set objs = new ReservationMenu
		objs.Name = ParamData("Name")
		objs.Location = ParamData("Location")

		Dim ReservationMenuHelper : set ReservationMenuHelper = new ReservationMenuHelper
		set Model = ReservationMenuHelper.SelectAll(objs,ParamData("pageNo"),rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if

		ViewData.add "pagination" ,printPageList(pTotCount, cint(ParamData("pageNo")), rows, pageUrl & "&pageNo=__PAGE__")
		ViewData.add "ActionRegiste","?controller=Reservation&action=Menu&mode=Registe" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Reservation&action=MenuPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionType","DELETE"
		ViewData.add "ActionExcel","?controller=Reservation&action=Menu&mode=Excel&partial=True" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		
		%> <!--#include file="../Views/Reservation/ReservationMenuList.asp" --> <%
	End Sub
	
	
	private Sub MenuExcel()
		Session.Timeout = 600
		Server.ScriptTimeOut = 60*60*60 '초
		
		Dim AdminHelper : set AdminHelper = new AdminHelper
		Dim AdminModel  : set AdminModel = AdminHelper.SelectByField("No",session("adminNo"))
		
		if AdminModel.Level = "1" then 
			ParamData("Location") = 1
		elseif AdminModel.Level = "2" then
			ParamData("Location") = 2
		elseif AdminModel.Level = "3" then
			ParamData("Location") = 3
		end if
		
		Dim objs : set objs = new ReservationMenu
		objs.Name = ParamData("Name")
		objs.Location = ParamData("Location")

		Dim ReservationMenuHelper : set ReservationMenuHelper = new ReservationMenuHelper
		set Model = ReservationMenuHelper.SelectAll(objs,1,100000000)
		
		Dim tmp_html : tmp_html = "" &_
		"<?xml version=""1.0"" encoding=""utf-8""?>" &_
		"<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:o=""urn:schemas-microsoft-com:office:office"" xmlns:x=""urn:schemas-microsoft-com:office:excel"" xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet"" xmlns:html=""http://www.w3.org/TR/REC-html40"">" &_
		"<Worksheet ss:Name=""시설 관리""> " &_
		"<Table> " &_
		"	<Column ss:Width='100'/> " &_
		"	<Column ss:Width='200'/> " &_
		"	<Column ss:Width='100'/> " &_
		"	<Row> "&_
		"		<Cell><Data ss:Type=""String"">구분</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">이름</Data></Cell> "&_
		"		<Cell><Data ss:Type=""String"">순서</Data></Cell> "&_
		"	</Row> "
		
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items

				if obj.Location = "1" then
					Location = "판교"
				elseif obj.Location = "2" then
					Location = "송도" 
				elseif obj.Location = "3" then
					Location = "TTA IoT 시험소" 
				end if
			
				tmp_html = tmp_html & "" &_
				"	<Row> "&_
				"		<Cell><Data ss:Type=""String"">" & Location & "</Data></Cell>"&_
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
		Response.AddHeader "Content-Disposition","attachment; filename=시설 관리 " & Now() & ".xls"
		
	End Sub
	
	
	public Sub AjaxMenuList()
		Dim Location : Location = iif( Request("Location")="","0",Request("Location") )
		
		Dim objs : set objs = new ReservationMenu
		objs.Location = Location
		Dim ReservationMenuHelper : set ReservationMenuHelper = new ReservationMenuHelper
		set Model = ReservationMenuHelper.SelectAll(objs,1,1000)
		
		sJsonText = sJsonText & "["
		if Not( IsNothing(Model) ) then
			cnt = 1
			For each obj in Model.Items
				sJsonText = sJsonText & "{'No' : '"& obj.No &"',"
				sJsonText = sJsonText & "'Name' : '"& obj.Name &"'}"
				sJsonText = sJsonText & iif(cnt=Model.Count,"",",")
				cnt = cnt + 1
			next
		end if
		
		sJsonText = sJsonText & "]"
		sJsonText = Replace(sJsonText,"'",Chr(34))
		Response.write sJsonText
		
	End Sub
	
	private Sub MenuRegiste()
		Dim AdminHelper : set AdminHelper = new AdminHelper
		Dim AdminModel  : set AdminModel = AdminHelper.SelectByField("No",session("adminNo"))
		
		Dim ReservationMenuHelper : set ReservationMenuHelper = new ReservationMenuHelper
		set Model = ReservationMenuHelper.SelectByField("No",ParamData("No"))
		
		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			set Model = new ReservationMenu
			Model.OrderNo = 0
		end if
		
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=Reservation&action=Menu&mode=List" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Reservation&action=MenuPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/Reservation/ReservationMenuRegiste.asp" --> <%
	End Sub
	
	public Sub MenuPost()
		Dim ActionType : ActionType = Request.Form("ActionType")
		Dim Params     : Params     = Request.Form("Params")
		
		Dim No       : No       = Trim( iif(Request.Form("No")="",0,Request.Form("No")) )
		Dim Location : Location = Trim(Request.Form("Location"))
		Dim Name     : Name     = Trim(Request.Form("Name"))
		Dim OrderNo  : OrderNo  = Trim( iif(Request.Form("OrderNo")="",0,Request.Form("OrderNo")) )
		
		Dim ReservationMenuHelper : set ReservationMenuHelper = new ReservationMenuHelper
		Dim obj : set obj = new ReservationMenu
		Dim result
		
		if ActionType = "INSERT" then
			if Location = "" then 
				call alerts ("장소를 입력해주세요.","")
			end if
			if Name = "" then 
				call alerts ("이름을 입력해주세요.","")
			end if
			if OrderNo = "" then 
				call alerts ("순서를 입력해주세요.","")
			end if
			
			obj.Location = Location
			obj.Name = Name
			obj.OrderNo = OrderNo
			
			result = ReservationMenuHelper.Insert(obj)

			call alerts ("등록되었습니다.","?controller=Reservation&action=Menu&mode=List")
		elseif ActionType = "UPDATE" then
			if Location = "" then 
				call alerts ("장소를 입력해주세요.","")
			end if
			if Name = "" then 
				call alerts ("디바이스명을 입력해주세요.","")
			end if
			if OrderNo = "" then 
				call alerts ("순서를 입력해주세요.","")
			end if
			
			obj.No = No
			obj.Location = Location
			obj.Name = Name
			obj.OrderNo = OrderNo
			
			ReservationMenuHelper.Update(obj)
			call alerts ("수정되었습니다.","?controller=Reservation&action=Menu&mode=List" & Params )
			
		elseif ActionType = "DELETE" then
			ReservationMenuHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=Reservation&action=Menu&mode=List" & Params )
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub

End Class
%>
    