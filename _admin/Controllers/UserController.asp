<%
class UserController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		Member()
	End Sub
	
	public Sub Member()
		Dim mode : mode = iif( Request("mode")="","List",Request("mode") )
		
		if mode = "List" then
			call MemberList()
		elseif mode = "Registe" then
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
		Dim UserHelper : set UserHelper = new UserHelper
		Dim pageNo : pageNo = 1
		Dim rows : rows = 10
		Dim url  : url  = "?controller=User&action=Member&mode=List"
		
		Dim param : set param = new User
		param.Id     = iif( Request("Id")=""  ,"",Request("Id") )
		param.Name   = iif( Request("Name")="","",Request("Name") )
		param.Phone3 = iif( Request("Phone3")="","",Request("Phone3") )
		
		set Model = UserHelper.SelectAll(param,pageNo,rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if 
		
		ViewData.add "pagination",printPageList(pTotCount, pageNo, rows, url)
		ViewData.add "ActionRegiste","?controller=User&action=Member&mode=Registe"
		%> <!--#include file="../Views/User/MemberList.asp" --> <%
	End Sub
	
	private Sub MemberRegiste()
		Dim PolicyHelper : set PolicyHelper = new PolicyHelper
		set Model = PolicyHelper.SelectAll()
		
		ViewData.add "ActionList","?controller=User&action=Member&mode=List"
		ViewData.add "ActionForm","?controller=User&action=Member&mode=Registe&&partial=True"
		%> <!--#include file="../Views/User/MemberRegiste.asp" --> <%
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
    