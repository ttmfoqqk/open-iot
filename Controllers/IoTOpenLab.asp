<%
class IoTOpenLabController
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
		set Model = PageHelper.SelectByField("Name", "AboutOpenLab")
		
		'파일
		Dim FilesHelper : set FilesHelper = new PageFilesHelper
		Dim FilesModel  : set FilesModel = FilesHelper.SelectByField("ParentName","AboutOpenLab")
		
		%> <!--#include file="../Views/IoTOpenLab/Index.asp" --> <%
	End Sub
	
	public Sub Facility()
		Dim PageHelper : set PageHelper = new PageHelper
		set Model = PageHelper.SelectByField("Name", "Facility")
		Dim Model2 : set Model2 = PageHelper.SelectByField("Name", "Facility2")
		Dim Model3 : set Model3 = PageHelper.SelectByField("Name", "Facility3")
		
		'파일
		Dim FilesHelper  : set FilesHelper = new PageFilesHelper
		Dim FilesModel1  : set FilesModel1 = FilesHelper.SelectByField("ParentName","Facility")
		Dim FilesModel2  : set FilesModel2 = FilesHelper.SelectByField("ParentName","Facility2")
		Dim FilesModel3  : set FilesModel3 = FilesHelper.SelectByField("ParentName","Facility3")
		
		
		%> <!--#include file="../Views/IoTOpenLab/Facility.asp" --> <%
	End Sub
	
	public Sub Reservations()
		checkLogin("")
		checkEmailConfirm()
		
		Dim UserHelper : set UserHelper = new UserHelper
		set Model = UserHelper.SelectByField("No",session("userNo"))
		
		Dim OidHelper : set OidHelper = new OidHelper
		Dim OidModel : set OidModel = OidHelper.SelectByField("UserNo",session("userNo"))
		
		if IsNothing(OidModel) then 
			set OidModel = new Oids
		else
			if OidModel.State <> "0" then
				set OidModel = new Oids
			end if
		end if
		
		ViewData.add "ActionForm","?controller=IoTOpenLab&action=ReservationPost&partial=True"
		%> <!--#include file="../Views/IoTOpenLab/Reservation.asp" --> <%
	End Sub
	
	public Sub AjaxCalendarList()
		Dim Location : Location = iif(Request("Location")="","0",Request("Location"))
		
		Dim ReservationHelper : set ReservationHelper = new ReservationHelper
		set Model = ReservationHelper.SelectByCalendar(Location)

		sJsonText = sJsonText & "["
		
		if Not( IsNothing(Model) ) then
			cnt = 1
			For each obj in Model.Items
				url = "javascript:void(call_calendar_detail("&Location&",'"&left(obj.UseDate,10)&"'))"
				sJsonText = sJsonText & "{"
				sJsonText = sJsonText & "'title' : '시설 "& obj.tcount &"건',"
				sJsonText = sJsonText & "'start' : '"& left(obj.UseDate,10) &"',"
				sJsonText = sJsonText & "'url' : '"& Replace(toJS(url),"""","\""") &"',"
				sJsonText = sJsonText & "'color' : 'transparent' "
				sJsonText = sJsonText & "}"
				sJsonText = sJsonText & iif(cnt=Model.Count,"",",")
				cnt = cnt + 1
			next
		end if
		
		sJsonText = sJsonText & "]"
		sJsonText = Replace(sJsonText,"'",Chr(34))
		Response.write sJsonText
	End Sub
	
	public Sub AjaxCalendarDetail()
		Dim Location : Location = iif(Request("Location")="","0",Request("Location"))
		Dim InDate : InDate = iif(Request("InDate")="",Date(),Request("InDate"))
		
		
		Dim ReservationHelper : set ReservationHelper = new ReservationHelper
		Dim Reservation : set Reservation = new Reservation
		Reservation.Location = Location
		Reservation.SRdate = InDate
		Reservation.ERdate = InDate
		Reservation.State = "0,2"
		
		set Model = ReservationHelper.SelectAll(Reservation,1,1000)

		sJsonText = sJsonText & "["
		
		if Not( IsNothing(Model) ) then
			cnt = 1
			
			For each obj in Model.Items
				sJsonText = sJsonText & "{"
				sJsonText = sJsonText & "'title' : '"& obj.FacilitiesName &"',"
				sJsonText = sJsonText & "'time' : '"& left(obj.Stime,5) & " ~ "& left(obj.Etime,5) &"'"
				sJsonText = sJsonText & "}"
				sJsonText = sJsonText & iif(cnt=Model.Count,"",",")
				cnt = cnt + 1
			next
		end if
		
		sJsonText = sJsonText & "]"
		sJsonText = Replace(sJsonText,"'",Chr(34))
		Response.write sJsonText
	End Sub
	
	public Sub ReservationPost()
		call checkLogin("")
		call checkEmailConfirm()
		
		Dim Location   : Location   = Trim(Request.Form("Location"))
		Dim Facilities : Facilities = Trim(Request.Form("Facilities"))
		Dim Hphone1    : Hphone1    = Trim(Request.Form("Hphone1"))
		Dim Hphone2    : Hphone2    = Trim(Request.Form("Hphone2"))
		Dim Hphone3    : Hphone3    = Trim(Request.Form("Hphone3"))
		Dim UseDate    : UseDate    = Trim(Request.Form("UseDate"))
		Dim UseEndDate : UseEndDate = Trim(Request.Form("UseEndDate"))
		Dim Purpose    : Purpose    = Trim(Request.Form("Purpose"))
		Dim Company    : Company    = Trim(Request.Form("Company"))
		
		Dim ReservationHelper : set ReservationHelper = new ReservationHelper
		Dim obj : set obj = new Reservation
		
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
		
		obj.UserNo = session("userNo")
		obj.Location = Location
		obj.Facilities = Facilities
		obj.Hphone1 = Hphone1
		obj.Hphone2 = Hphone2
		obj.Hphone3 = Hphone3
		obj.UseDate = UseDate
		obj.UseEndDate = UseEndDate
		obj.Purpose = Purpose
		obj.Company = Company
		
		ReservationHelper.Insert(obj)
		
		'관리자에게 이메일 발송
		dim Mresult
		Dim ReservationMenuHelper : set ReservationMenuHelper = new ReservationMenuHelper
		Dim ReservationMenuModel  : set ReservationMenuModel  = ReservationMenuHelper.SelectByField("No",Facilities)
		
		Dim UserHelper : set UserHelper = new UserHelper
		Dim UserModel  : set UserModel  = UserHelper.SelectByField("No",session("userNo"))
		
		Dim Admin : set Admin = new Admin
		Admin.Level = "0"
		if Location = "1" then
			Admin.Level = Admin.Level & ",1"
			LocationTxt = "판교"
		elseif Location = "2" then
			Admin.Level = Admin.Level & ",2"
			LocationTxt = "송도"
		elseif Location = "3" then
			Admin.Level = Admin.Level & ",3"
			LocationTxt = "TTA IoT 시험소"
		end if
		
		Dim AdminHelper : set AdminHelper = new AdminHelper
		Dim AdminModel  : set AdminModel  = AdminHelper.SelectAll(Admin,1,1000)
		
		Dim strFile : strFile = server.mapPath("/Utils/email/newReservations.html")
		dim strSubject : strSubject = "새로운 오픈랩 예약이 등록되었습니다."
		dim strBody : strBody = ReadFile(strFile)
		dim strFrom : strFrom = "OPEN-IOT<no-reply@open-iot.net>"
		
		Dim strName : strName = LocationTxt & " > " & ReservationMenuModel.Name
		
		strBody = replace(strBody, "#ID#"   , UserModel.Id )
		strBody = replace(strBody, "#NAME#" , strName )
		strBody = replace(strBody, "#USEDATE#" , UseDate & " ~ " & UseEndDate )
		strBody = replace(strBody, "#DATE#" , NOW() )
		strBody = replace(strBody, "#URL#"  , g_host & "/Utils/email/" )
		
		if Not( IsNothing(AdminModel) ) then
			For each AdminObj in AdminModel.Items
				if Not( IsNothing(AdminObj.Email) ) then 
					Mresult = MailSend(strSubject, strBody, AdminObj.Email, strFrom, "")
				end if
			next
		end if
		
		
		call alerts ("신청되었습니다.","?controller=IoTOpenLab&action=Reservations" )

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

End Class
%>