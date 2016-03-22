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
		
		ParamData.Add "pageNo"     , iif(Request("pageNo")="",1,Request("pageNo"))
		ParamData.Add "url"        , "&sDate=" & ParamData("sDate") & "&eDate=" & ParamData("eDate") & "&sRDate=" & ParamData("sRDate") & "&eRDate=" & ParamData("eRDate") &_
		 "&UserId=" & ParamData("UserId") & "&UserName=" & ParamData("UserName") &_
		 "&Location=" & ParamData("Location") & "&Facilities=" & ParamData("Facilities") & "&State=" & ParamData("State")
		
		if ParamData("mode") = "List" then
			call List()
		elseif ParamData("mode") = "Registe" then
			call Registe()
		end if
	End Sub
	
	private Sub List()
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
		
		%> <!--#include file="../Views/Reservation/List.asp" --> <%
	End Sub
	
	private Sub Registe()
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
		Dim Purpose    : Purpose    = Trim(Request.Form("Purpose"))
		Dim State      : State      = Trim(Request.Form("State"))
		
		Dim Stime1      : Stime1    = iif(Request.Form("Stime1")="","00",Request.Form("Stime1"))
		Dim Stime2      : Stime2    = iif(Request.Form("Stime2")="","00",Request.Form("Stime2"))
		Dim Etime1      : Etime1    = iif(Request.Form("Etime1")="","00",Request.Form("Etime1"))
		Dim Etime2      : Etime2    = iif(Request.Form("Etime2")="","00",Request.Form("Etime2"))
		
		Dim ReservationHelper : set ReservationHelper = new ReservationHelper
		Dim obj : set obj = new Reservation
		Dim result
		
		if ActionType = "UPDATE" then
			if Location = "" then
				call alerts ("구분을 선택해주세요.","")
			end if
			
			if Facilities = "" then
				call alerts ("시설명을 선택해주세요.","")
			end if
			
			if Hphone1 = "" or Hphone2 = "" or Hphone3 = "" then
				call alerts ("핸드폰을 입력해주세요.","")
			end if
			
			if UseDate = "" then
				call alerts ("사용 희망일을 입력해주세요.","")
			end if
			
			if State = "" then
				call alerts ("상태를 선택해주세요.","")
			end if
			
			obj.No = No
			obj.Location = Location
			obj.Facilities = Facilities
			obj.Hphone1 = Hphone1
			obj.Hphone2 = Hphone2
			obj.Hphone3 = Hphone3
			obj.UseDate = UseDate
			obj.Purpose = Purpose
			obj.State = State
			obj.Stime = Stime1 &":"& Stime2
			obj.Etime = Etime1 &":"& Etime2
			
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
		ParamData.Add "url"      , "&Name=" & ParamData("Name")
		 
		if ParamData("mode") = "List" then
			call MenuList()
		elseif ParamData("mode") = "Registe" then
			call MenuRegiste()
		end if
	End Sub
	
	
	private Sub MenuList()
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
		
		%> <!--#include file="../Views/Reservation/ReservationMenuList.asp" --> <%
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
    