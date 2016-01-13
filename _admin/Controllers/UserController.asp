<%
class UserController
	Dim Model
	Dim ViewData
	Dim ParamData

	private sub Class_Initialize()
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
		end if
	End Sub
	
	public Sub Oid()
		Dim mode : mode = iif( Request("mode")="","List",Request("mode") )
		
		if mode = "List" then
			call OidList()
		elseif mode = "Registe" then
			call OidRegiste()
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
		
		ViewData.add "pagination" ,printPageList(pTotCount, pageNo, rows, pageUrl & "&pageNo=__PAGE__")
		ViewData.add "ActionRegiste","?controller=User&action=Member&mode=Registe" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=User&action=MemberPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionType","DELETE"
		%> <!--#include file="../Views/User/MemberList.asp" --> <%
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
		Dim Params : Params = Request.Form("Params")
		Dim No : No = Trim( iif(Request.Form("No")="",0,Request.Form("No")) )
		Dim Id : Id = Trim(Request.Form("Id"))
		Dim Pwd : Pwd = Trim(Request.Form("Pwd"))
		Dim Name : Name = Trim(Request.Form("Name"))
		Dim Phone3 : Phone3 = Trim(Request.Form("Phone3"))
		Dim State : State = Trim(Request.Form("State"))
		
		Dim UserHelper : set UserHelper = new UserHelper
		Dim obj : set obj = new User
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
			if Phone3 = "" then 
				call alerts ("핸드폰 뒷자리를 입력해주세요.","")
			end if

			Set Model = AdminHelper.SelectByField("Id", Id)
			
			if Not( IsNothing(Model) ) then
				call alerts ("이미 등록된 아이디입니다.","")
			end if

			obj.Id = Id
			obj.Pwd = Pwd
			obj.Name = Name
			obj.Name = Phone3
			obj.State = State
			
			result = AdminHelper.Insert(obj)
			call alerts ("등록되었습니다.","?controller=User&action=Member&mode=List")

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
			
			AdminHelper.Update(obj)
			call alerts ("수정되었습니다.","?controller=User&action=Member&mode=List" & Params )
			
		elseif ActionType = "DELETE" then
			response.write No
			AdminHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=User&action=Member&mode=List" & Params )
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	
	
	private Sub OidList()
		Dim OidHelper : set OidHelper = new OidHelper
		Dim pageNo : pageNo = 1
		Dim rows : rows = 10
		Dim url  : url  = "?controller=User&action=Oid&mode=List"
		
		Dim param : set param = new Oids
		param.UserId   = iif( Request("Id")=""  ,"",Request("Id") )
		param.UserName = iif( Request("Name")="","",Request("Name") )
		
		set Model = OidHelper.SelectAll(param,pageNo,rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if 
		
		ViewData.add "pagination",printPageList(pTotCount, pageNo, rows, url)
		ViewData.add "ActionRegiste","?controller=User&action=Oid&mode=Registe"
		%> <!--#include file="../Views/User/OidList.asp" --> <%
	End Sub
	
	private Sub OidRegiste()
		Dim OidHelper : set OidHelper = new OidHelper
		set Model = OidHelper.SelectByField("No",0)
		
		ViewData.add "ActionList","?controller=User&action=Oid&mode=List"
		ViewData.add "ActionForm","?controller=User&action=Oid&mode=Registe&&partial=True"
		%> <!--#include file="../Views/User/OidRegiste.asp" --> <%
	End Sub

End Class
%>
    