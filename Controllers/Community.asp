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
		List()
	End Sub
	
	public Sub List()
		dim BoardHelper : set BoardHelper = new BoardHelper
		dim obj : set obj = new Board

		obj.Code = 22
		obj.UserNo = 0
		obj.Title = "Title"
		obj.ContentsNoHtml = "ContentsNoHtml"
		
		
		set Model = BoardHelper.SelectAll(obj,pageNo,rows)
		%> <!--#include file="../Views/Community/List.asp" --> <%
	End Sub
	
	public Sub Gallery()
		%> <!--#include file="../Views/Community/List_Gallery.asp" --> <%
	End Sub
	
	public Sub Registe()
		%> <!--#include file="../Views/Community/Registe.asp" --> <%
	End Sub
	
	public Sub Proc()
		'
	End Sub

End Class
%>
    