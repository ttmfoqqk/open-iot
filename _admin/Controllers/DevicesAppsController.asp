<%
class DevicesAppsController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		Devices()
	End Sub
	
	public Sub Devices()
		ViewData.add "PageName","Devices"
		
		Dim mode : mode = iif( Request("mode")="","List",Request("mode") )
		if mode = "List" then
			ViewData.add "ActionRegiste","?controller=DevicesApps&action=Devices&mode=Registe"
			call List()
		elseif mode = "Registe" then
			ViewData.add "ActionList","?controller=DevicesApps&action=Devices&mode=List"
			call Registe()
		end if

	End Sub
	
	public Sub Apps()
		ViewData.add "PageName","Apps"
		
		Dim mode : mode = iif( Request("mode")="","List",Request("mode") )
		if mode = "List" then
			ViewData.add "ActionRegiste","?controller=DevicesApps&action=Apps&mode=Registe"
			call List()
		elseif mode = "Registe" then
			ViewData.add "ActionList","?controller=DevicesApps&action=Apps&mode=List"
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
		
		ViewData.add "ActionForm","?controller=DevicesApps&action=PolicyPost&partial=True"
		%> <!--#include file="../Views/DevicesApps/List.asp" --> <%
	End Sub
	
	private Sub Registe()
		Dim BoardHelper : set BoardHelper = new BoardHelper
		set Model = BoardHelper.SelectByField("No",0)
		
		ViewData.add "ActionForm","?controller=DevicesApps&action=PolicyPost&partial=True"
		%> <!--#include file="../Views/DevicesApps/Registe.asp" --> <%
	End Sub


End Class
%>