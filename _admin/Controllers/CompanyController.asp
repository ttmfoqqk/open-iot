<%
class CompanyController
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
		Policy()
	End Sub
	
	public Sub Policy()
		Dim PolicyHelper : set PolicyHelper = new PolicyHelper
		set Model = PolicyHelper.SelectAll()
		ViewData.add "ActionForm","?controller=Company&action=PolicyPost&partial=True"
		%> <!--#include file="../Views/Company/Policy.asp" --> <%
	End Sub

	public Sub PolicyPost()
		Dim args : Set args = Request.Form
		
		Dim obj
		set obj = new Policys

		obj.Policy1 = Trim(args("Policy1"))
		obj.Policy2 = Trim(args("Policy2"))
		
		Dim PolicyHelper : set PolicyHelper = new PolicyHelper
		PolicyHelper.Update(obj)
		
		Response.Redirect("?controller=Company&action=Policy")
	End Sub


	public Sub Member()
		ParamData.Add "mode"  , iif(Request("mode")="","List",Request("mode"))
		ParamData.Add "sDate" , iif(Request("sDate")="","",Request("sDate"))
		ParamData.Add "eDate" , iif(Request("eDate")="","",Request("eDate"))
		ParamData.Add "Id"    , iif(Request("Id")="","",Request("Id"))
		ParamData.Add "Name"  , iif(Request("Name")="","",Request("Name"))
		ParamData.Add "pageNo", iif(Request("pageNo")="",1,Request("pageNo"))
		ParamData.Add "url"   , "&sDate=" & ParamData("sDate") & "&eDate=" & ParamData("eDate") & "&Id=" & ParamData("Id") & "&Name=" & ParamData("Name")
		
		if ParamData("mode") = "List" then
			call MemberList()
		elseif ParamData("mode") = "Registe" then
			call MemberRegiste()
		end if
	End Sub
	
	
	
	private Sub MemberList()
		Dim rows    : rows    = 10
		Dim pageUrl : pageUrl = "?controller=Company&action=Member&mode=List" & ParamData("url")
		
		Dim objs : set objs = new Admin
		objs.Sdate = ParamData("sDate")
		objs.Edate = ParamData("eDate")
		objs.Id    = ParamData("Id")
		objs.Name  = ParamData("Name")
		
		Dim AdminHelper : set AdminHelper = new AdminHelper
		set Model = AdminHelper.SelectAll(objs,ParamData("pageNo"),rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if
		
		ViewData.add "pagination" ,printPageList(pTotCount, pageNo, rows, pageUrl & "&pageNo=__PAGE__")
		ViewData.add "ActionRegiste","?controller=Company&action=Member&mode=Registe" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Company&action=MemberPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionType","DELETE"
		%> <!--#include file="../Views/Company/MemberList.asp" --> <%
	End Sub
	
	private Sub MemberRegiste()
		Dim No : No = iif(Request("No")="",0,Request("No"))
		
		Dim AdminHelper : set AdminHelper = new AdminHelper
		set Model = AdminHelper.SelectByField("No",No)
		
		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			set Model = new Admin
		end if
		
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=Company&action=Member&mode=List" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Company&action=MemberPost&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/Company/MemberRegiste.asp" --> <%
	End Sub
	
	
	public Sub MemberPost()
		Dim ActionType : ActionType = Request.Form("ActionType")
		Dim Params : Params = Request.Form("Params")
		Dim No : No = Trim( iif(Request.Form("No")="",0,Request.Form("No")) )
		Dim Id : Id = Trim(Request.Form("Id"))
		Dim Pwd : Pwd = Trim(Request.Form("Pwd"))
		Dim Name : Name = Trim(Request.Form("Name"))
		
		Dim AdminHelper : set AdminHelper = new AdminHelper
		Dim obj : set obj = new Admin
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

			Set Model = AdminHelper.SelectByField("Id", Id)
			
			if Not( IsNothing(Model) ) then
				call alerts ("이미 등록된 아이디입니다.","")
			end if

			obj.Id = Id
			obj.Pwd = Pwd
			obj.Name = Name
			
			result = AdminHelper.Insert(obj)
			call alerts ("등록되었습니다.","?controller=Company&action=Member&mode=List")

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
			call alerts ("수정되었습니다.","?controller=Company&action=Member&mode=List" & Params )
			
		elseif ActionType = "DELETE" then
			response.write No
			AdminHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=Company&action=Member&mode=List" & Params )
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub

End Class
%>
    