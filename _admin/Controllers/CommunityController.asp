<%
class CommunityController
	Dim Model
	Dim ViewData
	Dim ParamData

	private sub Class_Initialize()
		admin_checkLogin()
		Set ViewData = Server.CreateObject("Scripting.Dictionary")
		Set ParamData = Server.CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Terminate()
		'
	end sub

	public Sub Index()
		Notice()
	End Sub
	
	private Sub SetParams()
		ParamData.Add "mode"     , iif(Request("mode")="","List",Request("mode"))
		ParamData.Add "sDate"    , iif(Request("sDate")="","",Request("sDate"))
		ParamData.Add "eDate"    , iif(Request("eDate")="","",Request("eDate"))
		ParamData.Add "UserId"   , iif(Request("UserId")="","",Request("UserId"))
		ParamData.Add "UserName" , iif(Request("UserName")="","",Request("UserName"))
		ParamData.Add "Title"    , iif(Request("Title")="","",Request("Title"))
		ParamData.Add "pageNo"   , iif(Request("pageNo")="",1,Request("pageNo"))
		ParamData.Add "No"       , iif(Request("No")="",0,Request("No"))
		ParamData.Add "url"      , "&sDate=" & ParamData("sDate") & "&eDate=" & ParamData("eDate") &_
		 "&UserId=" & ParamData("UserId") & "&UserName=" & ParamData("UserName")
	End Sub
	
	public Sub Notice()
		SetParams()
		if ParamData("mode") = "List" then
			call List()
		elseif ParamData("mode") = "Registe" then
			call Registe()
		elseif ParamData("mode") = "Reply" then
			call Reply()
		end if
	End Sub

	public Sub Inquiry()
		SetParams()
		if ParamData("mode") = "List" then
			call List()
		elseif ParamData("mode") = "Registe" then
			call Registe()
		elseif ParamData("mode") = "Reply" then
			call Reply()
		end if
	End Sub

	public Sub News()
		SetParams()
		if ParamData("mode") = "List" then
			call List()
		elseif ParamData("mode") = "Registe" then
			call Registe()
		elseif ParamData("mode") = "Reply" then
			call Reply()
		end if
	End Sub

	public Sub Forum()
		SetParams()
		if ParamData("mode") = "List" then
			call List()
		elseif ParamData("mode") = "Registe" then
			call Registe()
		elseif ParamData("mode") = "Reply" then
			call Reply()
		end if
	End Sub
	
	private Sub List()
		Dim BoardListHelper : set BoardListHelper = new BoardListHelper
		dim BoardListModel  : set BoardListModel = BoardListHelper.SelectByField("Code",action)
		if IsNothing(BoardListModel) then
			call alerts ("잘못된 경로입니다.","")
		end if
	
		Dim rows    : rows    = 10
		Dim pageUrl : pageUrl = "?controller=Community&action=" & BoardListModel.Code & "&mode=List" & ParamData("url")
		Dim BoardHelper : set BoardHelper = new BoardHelper
		
		'공지
		'Dim NoticeModel : set NoticeModel = BoardHelper.SelectAllNotice(BoardListModel.No)
		
		Dim objs : set objs = new Board
		objs.Code     = BoardListModel.No
		objs.Sdate    = ParamData("sDate")
		objs.Edate    = ParamData("eDate")
		objs.UserId   = ParamData("UserId")
		objs.UserName = ParamData("UserName")
		objs.Title    = ParamData("Title")
		set Model = BoardHelper.SelectAll(objs,ParamData("pageNo"),rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
			next
		end if
		
		ViewData.add "PageName",BoardListModel.Name
		ViewData.add "pagination" ,printPageList(pTotCount, cint(ParamData("pageNo")), rows, pageUrl & "&pageNo=__PAGE__")
		ViewData.add "ActionRegiste","?controller=Community&action=" & BoardListModel.Code & "&mode=Registe" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Community&action=Post&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionType","DELETE"
		%> <!--#include file="../Views/Community/CommunityList.asp" --> <%
	End Sub
	
	private Sub Registe()
		Dim BoardListHelper : set BoardListHelper = new BoardListHelper
		Dim BoardListModel  : set BoardListModel = BoardListHelper.SelectByField("Code",action)
		if IsNothing(BoardListModel) then
			call alerts ("잘못된 경로입니다.","")
		end if

		Dim BoardHelper : set BoardHelper = new BoardHelper
		set Model = BoardHelper.SelectByField("No",ParamData("No"))
		
		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			Dim AdminHelper : set AdminHelper = new AdminHelper
			Dim AdminModel  : set AdminModel = AdminHelper.SelectByField("No",session("adminNo"))
		
			set Model = new Board
			Model.UserId = AdminModel.Id
			Model.UserName = AdminModel.Name
		end if
		
		'파일
		Dim BoardFilesHelper : set BoardFilesHelper = new BoardFilesHelper
		Dim BoardFilesModel  : set BoardFilesModel = BoardFilesHelper.SelectByField("ParentNo",ParamData("No"))
		
		
		ViewData.add "PageName",BoardListModel.Name
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=Community&action="&BoardListModel.Code&"&mode=List" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionReply","?controller=Community&action="&BoardListModel.Code&"&mode=Reply" & ParamData("url") & "&pageNo=" & ParamData("pageNo") & "&No=" & ParamData("No")
		ViewData.add "ActionForm","?controller=Community&action=Post&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/Community/CommunityRegiste.asp" --> <%
	End Sub
	
	private Sub Reply()
		Dim BoardListHelper : set BoardListHelper = new BoardListHelper
		Dim BoardListModel  : set BoardListModel = BoardListHelper.SelectByField("Code",action)
		if IsNothing(BoardListModel) then
			call alerts ("잘못된 경로입니다.","")
		end if

		Dim BoardHelper : set BoardHelper = new BoardHelper
		set Model = BoardHelper.SelectByField("No",ParamData("No"))

		if IsNothing(Model) then
			call alerts ("잘못된 경로입니다.","")
		end if
		
		'Model.Contents = "[ 답 변 ]<br><br><br>-----------------------------------------------<br> [ 질 문 ] <br>" & Model.Contents
		Model.Contents = ""
		
		Dim ActionType : ActionType = "REPLY"
		
		ViewData.add "PageName",BoardListModel.Name
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=Community&action="&BoardListModel.Code&"&mode=List" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionReply","?controller=Community&action="&BoardListModel.Code&"&mode=Reply" & ParamData("url") & "&pageNo=" & ParamData("pageNo")
		ViewData.add "ActionForm","?controller=Community&action=Post&partial=True"
		ViewData.add "Params", ParamData("url") & "&pageNo=" & ParamData("pageNo")
		%> <!--#include file="../Views/Community/CommunityRegiste.asp" --> <%
	End Sub
	
	public Sub Post()
		Dim uploadPath : uploadPath = "/upload/Board/"
		Dim savePath   : savePath   = server.mapPath( uploadPath ) & "/"
		
		Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
		UPLOAD__FORM.AutoMakeFolder = True 
		UPLOAD__FORM.CodePage = 65001
		UPLOAD__FORM.DefaultPath = savePath
		UPLOAD__FORM.MaxFileLen	= 500 * 1024 * 1024 '500메가
		
		Dim ActionType : ActionType = UPLOAD__FORM("ActionType")
		Dim Params     : Params     = UPLOAD__FORM("Params")
		Dim BoardName  : BoardName  = UPLOAD__FORM("BoardName")
		
		Dim No       : No       = Trim( iif(UPLOAD__FORM("No")="",0,UPLOAD__FORM("No")) )
		Dim Title    : Title    = TagEncode( Trim(UPLOAD__FORM("Title")) )
		Dim Contents : Contents = Trim(UPLOAD__FORM("Contents"))
		Dim Notice   : Notice   = Trim(UPLOAD__FORM("Notice"))
		
		Dim Image     : Image      = Trim(UPLOAD__FORM("Image"))
		Dim oldImage  : oldImage = Trim(UPLOAD__FORM("oldImage"))
		Dim dellImage : dellImage  = Trim(UPLOAD__FORM("dellImage"))
		
		Dim BoardListHelper : set BoardListHelper = new BoardListHelper
		Dim BoardListModel  : set BoardListModel = BoardListHelper.SelectByField("Code",BoardName)
		if IsNothing(BoardListModel) then
			call alerts ("잘못된 경로입니다.","")
		end if
		
		Dim BoardHelper : set BoardHelper = new BoardHelper
		Dim obj : set obj = new Board
		
		Dim BoardFilesHelper : set BoardFilesHelper = new BoardFilesHelper
		Dim BoardFiles : set BoardFiles = new BoardFiles
		
		if ActionType = "INSERT" then
			if Title = "" then 
				call alerts ("제목을 입력해주세요.","")
			end if
			
			Image = fileUpload_proc(UPLOAD__FORM,savePath, Image , "Image" , oldImage , dellImage )

			obj.Code = BoardListModel.No
			obj.ParentNo = 0
			obj.OrderNo = 0
			obj.DepthNo = 0
			obj.UserNo = 0
			obj.Title = Title
			obj.Contents = Contents
			obj.Notice = Notice
			obj.Ip = g_uip
			obj.AdminNo = session("adminNo")
			obj.Image = Image
			
			result = BoardHelper.Insert(obj)
			result2 = BoardHelper.UpdateByField("ParentNo", obj.No, obj.No) 
			
			nFileCnt = UPLOAD__FORM("files").Count
			BoardFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					BoardFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = BoardFilesHelper.Insert(BoardFiles)
				end if
			Next
			
			
			call alerts ("등록되었습니다.","?controller=Community&action="& BoardName &"&mode=List")
			
		elseif ActionType = "REPLY" then
			if Title = "" then 
				call alerts ("제목을 입력해주세요.","")
			end if
			
			set Model = BoardHelper.SelectByField("No",No)

			obj.Code = Model.Code
			obj.ParentNo = Model.ParentNo
			obj.OrderNo = Model.OrderNo + 1
			obj.DepthNo = Model.DepthNo + 1
			obj.UserNo = Model.UserNo
			obj.Title = Title
			obj.Contents = Contents
			obj.Notice = Notice
			obj.Ip = g_uip
			obj.AdminNo = session("adminNo")
			
			result2 = BoardHelper.UpdateReply(obj.ParentNo,obj.OrderNo)
			result  = BoardHelper.Insert(obj)
			
			nFileCnt = UPLOAD__FORM("files").Count
			BoardFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					BoardFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = BoardFilesHelper.Insert(BoardFiles)
				end if
			Next
			
			
			call alerts ("등록되었습니다.","?controller=Community&action="& BoardName &"&mode=List")
		elseif ActionType = "UPDATE" then
			if Title = "" then 
				call alerts ("제목을 입력해주세요.","")
			end if
			
			Image = fileUpload_proc(UPLOAD__FORM,savePath, Image , "Image" , oldImage , dellImage )
			
			obj.No = No
			obj.Title = Title
			obj.Contents = Contents
			obj.Notice = Notice
			obj.Image = Image
			
			BoardHelper.Update(obj)
			
			nFileCnt = UPLOAD__FORM("files").Count
			BoardFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					BoardFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = BoardFilesHelper.Insert(BoardFiles)
				end if
			Next
			
			call alerts ("수정되었습니다.","?controller=Community&action="& BoardName &"&mode=List" & Params )
			
		elseif ActionType = "DELETE" then
			BoardHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=Community&action="& BoardName &"&mode=List" & Params )
		else
			call alerts ("잘못된 경로입니다.","")
		end if

	End Sub
	
	public Sub DelFile()
		Dim uploadPath : uploadPath = "/upload/Board/"
		Dim savePath   : savePath   = server.mapPath( uploadPath ) & "/"
		Dim No : No = iif(Request.Form("No")="",0,Request.Form("No"))
		
		Dim BoardFilesHelper : set BoardFilesHelper = new BoardFilesHelper
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
	
	
	function fileUpload_proc( UPLOAD__FORM ,savePath , file , input , oldFile , delfg )
		dim return_fileName
		If file <>"" Then 
			If UPLOAD__FORM.MaxFileLen >= UPLOAD__FORM(input).FileLen Then 
				return_fileName = DextFileUpload(UPLOAD__FORM(input),savePath,true)
			Else
				call alerts ("파일의 크기는 50MB 를 넘길수 없습니다.","")
			End If

			If oldFile <> "" Then
				Set FSO = Server.CreateObject("DEXT.FileUpload")
					If (FSO.FileExists(savePath & oldFile)) Then
						fso.deletefile(savePath & oldFile)
					End If
					If (FSO.FileExists(savePath & "m_" & oldFile)) Then
						fso.deletefile(savePath & "m_" & oldFile)
					End If
					If (FSO.FileExists(savePath & "s_" & oldFile)) Then
						fso.deletefile(savePath & "s_" & oldFile)
					End If
				set FSO = Nothing
			End If
		Else
			If delfg = "1" Then 
				If oldFile <> "" Then
					Set FSO = Server.CreateObject("DEXT.FileUpload")
						If (FSO.FileExists(savePath & oldFile)) Then
							fso.deletefile(savePath & oldFile)
						End If
						If (FSO.FileExists(savePath & "m_" & oldFile)) Then
							fso.deletefile(savePath & "m_" & oldFile)
						End If
						If (FSO.FileExists(savePath & "s_" & oldFile)) Then
							fso.deletefile(savePath & "s_" & oldFile)
						End If
					set FSO = Nothing
				End If
				return_fileName = ""
			else
				return_fileName = oldFile
			End If		
		End If
		fileUpload_proc = return_fileName
	end function


End Class
%>
    