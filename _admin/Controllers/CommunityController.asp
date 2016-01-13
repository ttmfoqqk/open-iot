<%
class CommunityController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		Notice()
	End Sub
	
	public Sub Notice()
		ViewData.add "PageName","공지사항"
		
		Dim mode : mode = iif( Request("mode")="","List",Request("mode") )
		if mode = "List" then
			ViewData.add "ActionRegiste","?controller=Community&action=Notice&mode=Registe"
			call List()
		elseif mode = "Registe" then
			ViewData.add "ActionList","?controller=Community&action=Notice&mode=List"
			call Registe()
		end if
	End Sub

	public Sub Inquiry()
		ViewData.add "PageName","1:1 Inquiry"
		
		Dim mode : mode = iif( Request("mode")="","List",Request("mode") )
		if mode = "List" then
			ViewData.add "ActionRegiste","?controller=Community&action=Inquiry&mode=Registe"
			call List()
		elseif mode = "Registe" then
			ViewData.add "ActionList","?controller=Community&action=Inquiry&mode=List"
			call Registe()
		end if
	End Sub

	public Sub News()
		ViewData.add "PageName","News"
		
		Dim mode : mode = iif( Request("mode")="","List",Request("mode") )
		if mode = "List" then
			ViewData.add "ActionRegiste","?controller=Community&action=News&mode=Registe"
			call List()
		elseif mode = "Registe" then
			ViewData.add "ActionList","?controller=Community&action=News&mode=List"
			call Registe()
		end if
	End Sub

	public Sub Forum()
		ViewData.add "PageName","Forum"
		
		Dim mode : mode = iif( Request("mode")="","List",Request("mode") )
		if mode = "List" then
			ViewData.add "ActionRegiste","?controller=Community&action=Forum&mode=Registe"
			call List()
		elseif mode = "Registe" then
			ViewData.add "ActionList","?controller=Community&action=Forum&mode=List"
			call Registe()
		end if
	End Sub
	
	private Sub List()
		Dim BoardHelper : set BoardHelper = new BoardHelper
		Dim objs : set objs = new Board
		
		objs.Code = 0
		objs.UserNo = 0
		objs.Title = ""
		objs.ContentsNoHtml = ""
		
		set Model = BoardHelper.SelectAll(objs,1,10)
		
		ViewData.add "ActionForm","?controller=Community&action=PolicyPost&partial=True"
		%> <!--#include file="../Views/Community/CommunityList.asp" --> <%
	End Sub
	
	private Sub Registe()
		Dim BoardHelper : set BoardHelper = new BoardHelper
		set Model = BoardHelper.SelectByField("No",0)
		
		ViewData.add "ActionForm","?controller=Community&action=PolicyPost&partial=True"
		%> <!--#include file="../Views/Community/CommunityRegiste.asp" --> <%
	End Sub


End Class
%>
    