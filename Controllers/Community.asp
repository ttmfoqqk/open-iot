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
		Dim Board : Board = Request("Board")
		Dim Title : Title = iif(Request("Title")="","",Request("Title"))
		Dim pageNo : pageNo = iif(Request("pageNo")="",1,Request("pageNo"))
		
		Dim BoardListHelper : set BoardListHelper = new BoardListHelper
		dim BoardListModel  : set BoardListModel = BoardListHelper.SelectByField("Code",Board)
		if IsNothing(BoardListModel) then
			call alerts ("잘못된 경로입니다.","")
		end if
		
		Dim rows    : rows    = 10000
		Dim BoardHelper : set BoardHelper = new BoardHelper
		Dim BoardFilesHelper : set BoardFilesHelper = new BoardFilesHelper
		Dim BoardFilesModel
		
		Dim objs : set objs = new Board
		objs.Code  = BoardListModel.No
		objs.Title = Title
		set Model = BoardHelper.SelectAll(objs,pageNo,rows)
		
		pTotCount = 0
		if Not( IsNothing(Model) ) then
			For each obj in Model.Items
				pTotCount = obj.tcount
				Exit For
			next
		end if
		
		
		PageTitle = BoardListModel.Code
		if BoardListModel.Code = "Notice" then
			PageSubTitle = "<b>" & BoardListModel.Name & "</b>"
		elseif BoardListModel.Code = "Inquiry" then
			PageTitle = "1:1 " & PageTitle
			PageSubTitle = "<b>1:1문의</b>"
		elseif BoardListModel.Code = "News" then
			PageSubTitle = "<b>최신뉴스</b>"
		elseif BoardListModel.Code = "Forum" then
			PageSubTitle = "<b>포럼</b>"
		end if
		
		ViewData.add "PageName",BoardListModel.Name
		ViewData.add "PageTitle",PageTitle
		ViewData.add "PageSubTitle",PageSubTitle
		ViewData.add "ActionRegiste","?controller=Community&action=Registe&Board=" & BoardListModel.Code
		
		if BoardListModel.Types = "GALLERY" then
		%> <!--#include file="../Views/Community/List_Gallery.asp" --> <%
		else
		%> <!--#include file="../Views/Community/List.asp" --> <%
		end if
	End Sub
	
	public sub AjaxList()
		Dim Board : Board = Request("Board")
		Dim Title : Title = iif(Request("Title")="","",Request("Title"))
		Dim UserNo : UserNo = iif(Request("UserNo")="","",Request("UserNo"))
		Dim pageNo : pageNo = iif(Request("pageNo")="",1,Request("pageNo"))
		Dim BoardListHelper : set BoardListHelper = new BoardListHelper
		dim BoardListModel  : set BoardListModel = BoardListHelper.SelectByField("Code",Board)
		
		sJsonText = ""
		if IsNothing(BoardListModel) then
			sJsonText = sJsonText & "[{'MSG':'잘못된 계시판 코드 입니다.'}]"
		else
			Dim rows    : rows    = 10000
			Dim BoardHelper : set BoardHelper = new BoardHelper
			Dim BoardFilesHelper : set BoardFilesHelper = new BoardFilesHelper
			Dim BoardFilesModel
			
			Dim objs : set objs = new Board
			objs.Code  = BoardListModel.No
			objs.Title = Title
			objs.UserNo = UserNo
			set Model = BoardHelper.SelectAll(objs,pageNo,rows)
			
			pTotCount = 0
			if Not( IsNothing(Model) ) then
				For each obj in Model.Items
					pTotCount = obj.tcount
					Exit For
				next
			end if
			
			tPageCount = Fix((pTotCount + (rows-1)) / rows)
			
			sJsonText = sJsonText & "{'MSG':'success','T_COUNT':'"& pTotCount &"','T_PAGE':'"&tPageCount&"','C_PAGE':"&pageNo&",'LIST':["

			if Not( IsNothing(Model) ) then
				cnt = 1
				For each obj in Model.Items
					sJsonText = sJsonText & "{'No' : '"& obj.No &"',"
					sJsonText = sJsonText & "'Title' : '"& Replace(toJS(obj.Title),"""","\""") &"',"
					sJsonText = sJsonText & "'Contents' : '"& Replace(toJS(obj.Contents),"""","\""") &"',"
					sJsonText = sJsonText & "'Image' : '"& obj.Image &"',"
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
		end if
		
		Response.write sJsonText
	end sub
	
	public Sub Detail()
		Dim Board : Board = Request("Board")
		Dim No    : No = iif(Request("No")="",0,Request("No"))
		Dim BoardListHelper : set BoardListHelper = new BoardListHelper
		dim BoardListModel  : set BoardListModel = BoardListHelper.SelectByField("Code",Board)
		if IsNothing(BoardListModel) then
			call alerts ("잘못된 경로입니다.","")
		end if
		
		PageTitle = BoardListModel.Code
		if BoardListModel.Code = "Notice" then
			PageSubTitle = "<b>" & BoardListModel.Name & "</b>"
		elseif BoardListModel.Code = "Inquiry" then
			PageTitle = "1:1 " & PageTitle
			PageSubTitle = "<b>1:1문의</b>"
		elseif BoardListModel.Code = "News" then
			PageSubTitle = "<b>최신뉴스</b>"
		elseif BoardListModel.Code = "Forum" then
			PageSubTitle = "<b>포럼</b>"
		end if
		
		
		Dim BoardHelper : set BoardHelper = new BoardHelper
		set Model = BoardHelper.SelectByField("No",No)
		
		Dim BoardFilesHelper : set BoardFilesHelper = new BoardFilesHelper
		Dim BoardFilesModel : set BoardFilesModel = BoardFilesHelper.SelectByField("ParentNo",Model.No)
		
		if IsNothing(Model) then
			call alerts ("잘못된 경로입니다.","")
		end if
		
		ViewData.add "PageName",BoardListModel.Name
		ViewData.add "PageTitle",PageTitle
		ViewData.add "PageSubTitle",PageSubTitle
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionList","?controller=Community&action=List&Board=" & BoardListModel.Code
		%> <!--#include file="../Views/Community/Detail.asp" --> <%
	End Sub

	public Sub Registe()
		call checkLogin("")
		call checkEmailConfirm()
		
		
		Dim Board : Board = Request("Board")
		Dim No    : No = iif(Request("No")="",1,Request("No"))
		Dim BoardListHelper : set BoardListHelper = new BoardListHelper
		dim BoardListModel  : set BoardListModel = BoardListHelper.SelectByField("Code",Board)
		if IsNothing(BoardListModel) then
			call alerts ("잘못된 경로입니다.","")
		end if
		
		PageTitle = BoardListModel.Code
		if BoardListModel.Code = "Notice" then
			PageSubTitle = "<b>" & BoardListModel.Name & "</b>"
		elseif BoardListModel.Code = "Inquiry" then
			PageTitle = "1:1 " & PageTitle
			PageSubTitle = "<b>1:1문의</b>"
		elseif BoardListModel.Code = "News" then
			PageSubTitle = "<b>최신뉴스</b>"
		elseif BoardListModel.Code = "Forum" then
			PageSubTitle = "<b>포럼</b>"
		end if
		
		
		Dim BoardHelper : set BoardHelper = new BoardHelper
		set Model = BoardHelper.SelectByField("No",No)
		
		
		
		Dim ActionType : ActionType = "INSERT"
		if Not(IsNothing(Model)) then
			ActionType = "UPDATE"
		else
			set Model = new Board
		end if
		
		ViewData.add "PageName",BoardListModel.Name
		ViewData.add "PageTitle",PageTitle
		ViewData.add "PageSubTitle",PageSubTitle
		
		ViewData.add "ActionType",ActionType
		ViewData.add "ActionForm","?controller=Community&action=Post&partial=True"
		ViewData.add "ActionList","?controller=Community&action=List&Board=" & BoardListModel.Code
		
		%> <!--#include file="../Views/Community/Registe.asp" --> <%
	End Sub
	
	public Sub Post()
		call checkLogin("")
		call checkEmailConfirm()
		
		
		Dim uploadPath : uploadPath = "/upload/Board/"
		Dim savePath   : savePath   = server.mapPath( uploadPath ) & "/"
		
		Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
		UPLOAD__FORM.AutoMakeFolder = True 
		UPLOAD__FORM.CodePage = 65001
		UPLOAD__FORM.DefaultPath = savePath
		UPLOAD__FORM.MaxFileLen	= 500 * 1024 * 1024 '500메가
		
		Dim ActionType : ActionType = UPLOAD__FORM("ActionType")
		Dim Board  : Board  = UPLOAD__FORM("Board")
		
		Dim No       : No       = Trim( iif(UPLOAD__FORM("No")="",0,UPLOAD__FORM("No")) )
		Dim Title    : Title    = TagEncode( Trim(UPLOAD__FORM("Title")) )
		Dim Contents : Contents = Trim(UPLOAD__FORM("Contents"))
		
		Dim BoardListHelper : set BoardListHelper = new BoardListHelper
		Dim BoardListModel  : set BoardListModel = BoardListHelper.SelectByField("Code",Board)
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

			obj.Code = BoardListModel.No
			obj.ParentNo = 0
			obj.OrderNo = 0
			obj.DepthNo = 0
			obj.UserNo = session("userNo")
			obj.Title = Title
			obj.Contents = Contents
			obj.Notice = 0
			obj.Ip = g_uip
			obj.AdminNo = 0
			
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
			call alerts ("등록되었습니다.","?controller=Community&action=List&Board="& Board)
		elseif ActionType = "UPDATE" then
			if Title = "" then 
				call alerts ("제목을 입력해주세요.","")
			end if

			obj.No = No
			obj.Title = Title
			obj.Contents = Contents
			obj.Notice = 0
			
			BoardHelper.Update(obj)
			
			nFileCnt = UPLOAD__FORM("files").Count
			BoardFiles.ParentNo = obj.No
			For i = 1 to nFileCnt
				If UPLOAD__FORM("files")(i) <> "" Then 
					BoardFiles.Name = DextFileUpload(UPLOAD__FORM("files")(i),savePath,true)
					resultFiles = BoardFilesHelper.Insert(BoardFiles)
				end if
			Next
			
			call alerts ("수정되었습니다.","?controller=Community&action=List&Board="& Board)
			
		elseif ActionType = "DELETE" then
			BoardHelper.Delete(No)
			call alerts ("삭제되었습니다.","?controller=Community&action=List&Board="& Board)
		else
			call alerts ("잘못된 경로입니다.","")
		end if
	End Sub

End Class
%>
    