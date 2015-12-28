<%
class CompanyController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
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
		Dim mode : mode = iif( Request("mode")="","List",Request("mode") )
		
		if mode = "List" then
			call MemberList()
		elseif mode = "Registe" then
			call MemberRegiste()
		end if
	End Sub
	
	private Sub MemberList()
		Dim AdminHelper : set AdminHelper = new AdminHelper
		Dim pageNo : pageNo = 1
		Dim rows : rows = 10
		
		Dim param : set param = new Admin
		param.Id   = iif( Request("Id")=""  ,"",Request("Id") )
		param.Name = iif( Request("Name")="","",Request("Name") )
		
		set Model = AdminHelper.SelectAll(param,pageNo,rows)
		
		ViewData.add "ActionRegiste","?controller=Company&action=Member&mode=Registe"
		
		%> <!--#include file="../Views/Company/MemberList.asp" --> <%
	End Sub
	
	private Sub MemberRegiste()
		Dim PolicyHelper : set PolicyHelper = new PolicyHelper
		set Model = PolicyHelper.SelectAll()
		
		ViewData.add "ActionList","?controller=Company&action=Member&mode=List"
		ViewData.add "ActionForm","?controller=Company&action=Member&mode=Registe&&partial=True"
		%> <!--#include file="../Views/Company/MemberRegiste.asp" --> <%
	End Sub

End Class
%>
    