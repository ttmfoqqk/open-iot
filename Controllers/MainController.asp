<%
class MainController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		Dim Board : set Board = new Board
		Dim BoardHelper : set BoardHelper = new BoardHelper
		
		Board.Code = 1
		Dim NoticeModel : set NoticeModel = BoardHelper.SelectAll(Board,1,3)
		Board.Code = 3
		Dim NewsModel : set NewsModel = BoardHelper.SelectAll(Board,1,3)
		Board.Code = 4
		Dim ForumModel : set ForumModel = BoardHelper.SelectAll(Board,1,3)

		Dim DevicesHelper : set DevicesHelper = new DevicesHelper
		Dim Devices : set Devices = new Devices
		Devices.State = 0
		Dim DevicesModel : set DevicesModel = DevicesHelper.SelectAll(Devices,1,12)
		
		DevicesCount = 0
		if Not( IsNothing(DevicesModel) ) then
			For each obj in DevicesModel.Items
				DevicesCount = obj.tcount
				Exit For
			next
		end if
		
		Dim AppsHelper : set AppsHelper = new AppsHelper
		Dim Apps : set Apps = new Apps
		Apps.State = 0
		Dim AppsModel : set AppsModel = AppsHelper.SelectAll(Apps,1,12)
		
		AppsCount = 0
		if Not( IsNothing(AppsModel) ) then
			For each obj in AppsModel.Items
				AppsCount = obj.tcount
				Exit For
			next
		end if
		
		Dim OidHelper : set OidHelper = new OidHelper
		Dim Oids : set Oids = new Oids
		
		Oids.State = 0
		Dim OidModel : set OidModel = OidHelper.SelectAll(Oids,1,10000)
		
		OidCount = 0
		if Not( IsNothing(OidModel) ) then
			For each obj in OidModel.Items
				OidCount = obj.tcount
				Exit For
			next
		end if
		
		
		Dim AgencieHelper : set AgencieHelper = new AgencieHelper
		Dim Agencie : set Agencie = new Agencie
		Dim AgencieModel : set AgencieModel = AgencieHelper.SelectAll(Agencie,1,10000)
		
		
		Dim AdBanner : set AdBanner = new AdBanner
		Dim AdBannerHelper : set AdBannerHelper = new AdBannerHelper
		Dim AdBannerModel : set AdBannerModel = AdBannerHelper.SelectByField("Position","Main")
		
		%> <!--#include file="../Views/Main/Index.asp" --> <%
	End Sub

End Class
%>
    