<%
class DevicesAppsBoardController
	Dim Model
	Dim ViewData

	private sub Class_Initialize()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
		Set ParamData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		'AjaxList()
	End Sub
	
	
	public Sub AjaxList()
		Dim Code      : Code  = iif(Request("Code")="","",Request("Code"))
		Dim Types     : Types = iif(Request("Types")="","",Request("Types"))
		Dim Title     : Title = iif(Request("Title")="","",Request("Title"))
		Dim ProductNo : ProductNo = iif(Request("ProductNo")="","",Request("ProductNo"))
		Dim UserNo    : UserNo = iif(Request("UserNo")="","",Request("UserNo"))
		Dim pageNo    : pageNo = iif(Request("pageNo")="",1,Request("pageNo"))
		Dim rows      : rows  = 10000
		
		Dim BoardHelper : set BoardHelper = new DevicesAppsBoardHelper
		Dim BoardFilesHelper : set BoardFilesHelper = new DevicesAppsBoardFilesHelper
		Dim BoardFilesModel
		Dim objs : set objs = new DevicesAppsBoard
		
		objs.Code  = Code
		objs.Types = Types
		objs.Title = Title
		objs.ProductNo = ProductNo
		objs.UserNo = UserNo
		
		set Model = BoardHelper.SelectAll(objs,pageNo,rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if
		
		tPageCount = Fix((pTotCount + (rows-1)) / rows)
		
		sJsonText = sJsonText & "{'MSG':'success','T_COUNT':'"& pTotCount &"','T_PAGE':'"&tPageCount&"','C_PAGE':"&pageNo&",'LIST':["

		if Not( IsNothing(Model) ) then
			cnt = 1
			For each obj in Model.Items
				ProductName = ""
				ProductImages = ""
				if obj.Code = "Devices" then 
					ProductName = obj.DevicesName
					ProductImages = obj.DevicesImages1
					ProductImages = iif( IsNothing(ProductImages) or ProductImages="",obj.DevicesImages2,ProductImages )
					ProductImages = iif( IsNothing(ProductImages) or ProductImages="",obj.DevicesImages3,ProductImages )
					ProductImages = iif( IsNothing(ProductImages) or ProductImages="",obj.DevicesImages4,ProductImages )
					ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/Devices/"&ProductImages )
				else
					ProductName = obj.AppsName
					ProductImages = obj.AppsImages1
					ProductImages = iif( IsNothing(ProductImages) or ProductImages="",obj.AppsImages2,ProductImages )
					ProductImages = iif( IsNothing(ProductImages) or ProductImages="",obj.AppsImages3,ProductImages )
					ProductImages = iif( IsNothing(ProductImages) or ProductImages="",obj.AppsImages4,ProductImages )
					ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/Apps/"&ProductImages )
				end if
			
				sJsonText = sJsonText & "{'No' : '"& obj.No &"',"
				sJsonText = sJsonText & "'ProductName' : '"& ProductName &"',"
				sJsonText = sJsonText & "'ProductImages' : '"& ProductImages &"',"
				sJsonText = sJsonText & "'Title' : '"& Replace(toJS(obj.Title),"""","\""") &"',"
				sJsonText = sJsonText & "'Contents' : '"& Replace(toJS(obj.Contents),"""","\""") &"',"
				sJsonText = sJsonText & "'DepthNo' : '"& obj.DepthNo &"',"
				sJsonText = sJsonText & "'files' : ["

				set BoardFilesModel = BoardFilesHelper.SelectByField("ParentNo",obj.No)
				if Not( IsNothing(BoardFilesModel) ) then
					cntFiles = 1
					For each files in BoardFilesModel.Items
						sJsonText = sJsonText & "{'Name' : '"& files.Name &"'}"
						sJsonText = sJsonText & iif(cntFiles=BoardFilesModel.Count,"",",")
						cntFiles = cntFiles + 1
					next
				end if
				
				sJsonText = sJsonText & "],"
				sJsonText = sJsonText & "'Indate' : '"& left(obj.Indate,10) &"'}"
				sJsonText = sJsonText & iif(cnt=Model.Count,"",",")
				cnt = cnt + 1
			next
		end if
		
		sJsonText = sJsonText & "]}"
		sJsonText = Replace(sJsonText,"'",Chr(34))
		Response.write sJsonText
		
	End Sub
	
	public Sub DelFile()
		uploadPath = "/upload/DnABoard/"
		savePath = server.mapPath( uploadPath ) & "/"
		
		Dim No : No = iif(Request.Form("No")="",0,Request.Form("No"))
		
		Dim BoardFilesHelper : set BoardFilesHelper = new DevicesAppsBoardFilesHelper
		Dim BoardFilesModel  : set BoardFilesModel = BoardFilesHelper.SelectByField("No",No)
		
		Set FSO = Server.CreateObject("DEXT.FileUpload")
		
		if Not(IsNothing(BoardFilesModel)) then
			For each obj in BoardFilesModel.Items
				If (FSO.FileExists(savePath & obj.Name)) Then
					fso.deletefile(savePath & obj.Name)
				End If
				If (FSO.FileExists(savePath & "m_" & obj.Name)) Then
					fso.deletefile(savePath & "m_" & obj.Name)
				End If
				If (FSO.FileExists(savePath & "s_" & obj.Name)) Then
					fso.deletefile(savePath & "s_" & obj.Name)
				End If
				BoardFilesHelper.Delete(obj.No)
			Next
		end if
			
		set FSO = Nothing
	End Sub
	
	
End Class
%>
    