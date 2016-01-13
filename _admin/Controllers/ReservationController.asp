<%
class ReservationController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	
	public Sub Index()
		Dim mode : mode = iif( Request("mode")="","List",Request("mode") )
		
		if mode = "List" then
			call List()
		elseif mode = "Registe" then
			call Registe()
		end if
	End Sub
	
	private Sub List()
		Dim ReservationHelper : set ReservationHelper = new ReservationHelper
		Dim pageNo : pageNo = 1
		Dim rows : rows = 10
		Dim url  : url  = "?controller=Reservation&action=Index&mode=List"
		
		Dim param : set param = new Reservation
		param.UserId   = iif( Request("UserId")=""  ,"",Request("UserId") )
		param.UserName = iif( Request("UserName")="","",Request("UserName") )
		
		set Model = ReservationHelper.SelectAll(param,pageNo,rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if
		
		ViewData.add "pagination",printPageList(pTotCount, pageNo, rows, url)
		%> <!--#include file="../Views/Reservation/List.asp" --> <%
	End Sub
	
	private Sub Registe()
		Dim ReservationHelper : set ReservationHelper = new ReservationHelper
		set Model = ReservationHelper.SelectByField("No", 1)
		
		ViewData.add "ActionList","?controller=Reservation&action=Index&mode=List"
		ViewData.add "ActionForm","?controller=Reservation&action=Index&mode=Registe&&partial=True"
		%> <!--#include file="../Views/Reservation/Registe.asp" --> <%
	End Sub

End Class
%>
    