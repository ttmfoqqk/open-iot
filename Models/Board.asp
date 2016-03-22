<%
class Board
	private mRowNum
	private mtcount
	private mNo
	private mCode
	private mParentNo
	private mOrderNo
	private mDepthNo
	private mUserNo
	private mUserId
	private mUserName
	private mTitle
	private mContents
	private mNotice
	private mDelFg
	private mReadCnt
	private mFileCnt
	private mReplyCnt
	private mIp
	private mIndate
	private mAdminNo
	private mImage
	
	private mSdate
	private mEdate

	private sub Class_Initialize()
		mUserNo = ""
		mUserId = ""
		mUserName = ""
		mTitle = ""
		mNotice = ""
		mSdate = ""
		mEdate = ""
	end sub

	private sub Class_Terminate()
		'
	end sub

	public property get RowNum()
		RowNum = mRowNum
	end property
	public property let RowNum(val)
		mRowNum = val
	end property
	
	public property get tcount()
		tcount = mtcount
	end property
	public property let tcount(val)
		mtcount = val
	end property
	
	public property get No()
		No = mNo
	end property
	public property let No(val)
		mNo = val
	end property
	
	public property get Code()
		Code = mCode
	end property
	public property let Code(val)
		mCode = val
	end property
	
	public property get ParentNo()
		ParentNo = mParentNo
	end property
	public property let ParentNo(val)
		mParentNo = val
	end property
	
	public property get OrderNo()
		OrderNo = mOrderNo
	end property
	public property let OrderNo(val)
		mOrderNo = val
	end property
	
	public property get DepthNo()
		DepthNo = mDepthNo
	end property
	public property let DepthNo(val)
		mDepthNo = val
	end property
	
	public property get UserNo()
		UserNo = mUserNo
	end property
	public property let UserNo(val)
		mUserNo = val
	end property
	
	public property get UserId()
		UserId = mUserId
	end property
	public property let UserId(val)
		mUserId = val
	end property
	
	public property get UserName()
		UserName = mUserName
	end property
	public property let UserName(val)
		mUserName = val
	end property
	
	public property get Title()
		Title = mTitle
	end property
	public property let Title(val)
		mTitle = val
	end property
	
	public property get Contents()
		Contents = mContents
	end property
	public property let Contents(val)
		mContents = val
	end property
	
	public property get Notice()
		Notice = mNotice
	end property
	public property let Notice(val)
		mNotice = val
	end property
	
	public property get DelFg()
		DelFg = mDelFg
	end property
	public property let DelFg(val)
		mDelFg = val
	end property
	
	public property get ReadCnt()
		ReadCnt = mReadCnt
	end property
	public property let ReadCnt(val)
		mReadCnt = val
	end property
	
	public property get FileCnt()
		FileCnt = mFileCnt
	end property
	public property let FileCnt(val)
		mFileCnt = val
	end property
	
	public property get ReplyCnt()
		ReplyCnt = mReplyCnt
	end property
	public property let ReplyCnt(val)
		mReplyCnt = val
	end property
	
	public property get Ip()
		Ip = mIp
	end property
	public property let Ip(val)
		mIp = val
	end property
	
	public property get Indate()
		Indate = mIndate
	end property
	public property let Indate(val)
		mIndate = val
	end property
	
	public property get AdminNo()
		AdminNo = mAdminNo
	end property
	public property let AdminNo(val)
		mAdminNo = val
	end property
	
	public property get Image()
		Image = mImage
	end property
	public property let Image(val)
		mImage = val
	end property
	
	public property get Sdate()
		Sdate = mSdate
	end property
	public property let Sdate(val)
		mSdate = val
	end property
	
	public property get Edate()
		Edate = mEdate
	end property
	public property let Edate(val)
		mEdate = val
	end property

end class

class BoardHelper

	Dim selectSQL

	private sub Class_Initialize()
		selectSQL = " SELECT ROW_NUMBER() OVER (order by [No] DESC) AS [RowNum],count(*) over () as [tcount],* FROM [Board] "
	end sub

	private sub Class_Terminate()
	end sub
	
	public function Insert(ByRef obj)
		Dim strSQL , execResult
		strSQL= " Insert into [Board] (Code,ParentNo,OrderNo,DepthNo,UserNo,Title,Contents,Notice,DelFg,ReadCnt,FileCnt,ReplyCnt,Ip,Indate,AdminNo,Image)" & _
		" Values (?,?,?,?,?,?,?,?,0,0,0,0,?,GETDATE(),?,?); " & _
		" SELECT SCOPE_IDENTITY()  "
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection = DbOpenConnection()
		objCommand.NamedParameters  = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Code, obj.ParentNo, obj.OrderNo, obj.DepthNo, obj.UserNo, obj.Title, obj.Contents,obj.Notice, obj.Ip, obj.AdminNo,obj.Image )) then
			Set execResult = objCommand.Execute
			Set execResult = execResult.NextRecordSet()
		End If
		obj.No = CInt(execResult(0))
		Insert = true
	end function

	
	public function SelectAll(objs,pageNo,rows)
		Dim records,selectSQL
		dim whereSql : whereSql = ""

		pageNo = iif( pageNo="",1,pageNo )
		rows   = iif( rows="",10,rows )

		whereSql = whereSql & " and [Board].Code = @Code "

		if objs.UserNo <> "" then
			whereSql = whereSql & " and [User].No = @UserNo "
		end if
		if objs.UserId <> "" then
			whereSql = whereSql & " and ([User].Id like '%' + @UserId + '%' or [Admin].Id like '%' + @UserId + '%') "
		end if
		if objs.UserName <> "" then
			whereSql = whereSql & " and ([User].Name like '%' + @UserName + '%' or [Admin].Name like '%' + @UserName + '%') "
		end if
		if objs.Title <> "" then
			whereSql = whereSql & " and [Board].Title like '%' + @Title + '%' "
		end if
		if objs.Sdate <> "" then
			whereSql = whereSql & " and CONVERT(VARCHAR,[Board].[Indate],23) >= @Sdate "
		end if
		if objs.Edate <> "" then
			whereSql = whereSql & " and CONVERT(VARCHAR,[Board].[Indate],23) <= @Edate "
		end if

		selectSQL = "" &_
		" SET NOCOUNT ON;  " &_
		" DECLARE @Code INT, @UserNo INT , @UserId VARCHAR(200), @UserName VARCHAR(200), @Title VARCHAR(200); " &_
		" DECLARE @Sdate VARCHAR(10) ,@Edate VARCHAR(10); " &_
		
		" SET @Code = ?; " &_
		" SET @UserNo = ?; " &_
		" SET @UserId = ?; " &_
		" SET @UserName = ?; " &_
		" SET @Title = ?; " &_
		" SET @Sdate = ?; " &_
		" SET @Edate = ?; " &_
		
		" WITH LIST AS ( " &_
			" SELECT " &_
				"  ROW_NUMBER() OVER (order by [Board].[ParentNo] ASC, [Board].[OrderNo] DESC) AS RowNum " &_
				" ,count(*) over () as [tcount] " &_
				" ,[Board].* " &_
				" ,( CASE [Board].AdminNo WHEN 0 THEN [User].[Id] ELSE [Admin].[Id] END ) AS UserId " &_
				" ,( CASE [Board].AdminNo WHEN 0 THEN [User].[Name] ELSE [Admin].[Name] END ) AS UserName " &_
			" FROM [Board] AS [Board] " &_
			" LEFT JOIN [User] AS [User] ON([Board].UserNo = [User].No AND [User].Delfg = 0 ) " &_
			" LEFT JOIN [Admin] AS [Admin] ON([Board].AdminNo = [Admin].No) " &_
			" WHERE ([Board].DelFg = 0 OR ([Board].DelFg = 1 AND [Board].ReplyCnt > 0) ) " &_
			whereSql &_
		" ) SELECT L.* FROM LIST L " &_
		" WHERE (tcount-rownum+1) BETWEEN " & ((pageNo - 1) * rows) + 1 & " AND " & ((pageNo - 1) * rows) + rows & " " &_
		" ORDER BY rownum desc "
		
		set objCommand=Server.CreateObject("ADODB.command") 
		With objCommand
			.ActiveConnection=DbOpenConnection()
			.prepared = true
			.CommandType = adCmdText
			.CommandText = selectSQL
			.Parameters.Append .CreateParameter( "@Code"   ,adInteger , adParamInput, 0   , objs.Code )
			.Parameters.Append .CreateParameter( "@UserNo" ,adVarChar , adParamInput, 200 , objs.UserNo )
			.Parameters.Append .CreateParameter( "@UserId" ,adVarChar , adParamInput, 200 , objs.UserId )
			.Parameters.Append .CreateParameter( "@UserName" ,adVarChar , adParamInput, 200 , objs.UserName )
			.Parameters.Append .CreateParameter( "@Title"  ,adVarChar , adParamInput, 200 , objs.Title )
			.Parameters.Append .CreateParameter( "@Sdate" ,adVarChar , adParamInput , 10  , objs.Sdate )
			.Parameters.Append .CreateParameter( "@Edate" ,adVarChar , adParamInput , 10  , objs.Edate )
		End With
  		
  		set records = objCommand.Execute
  		if records.eof then
			Set SelectAll = Nothing
		else
			Dim results, obj, record
			Set results = Server.CreateObject("Scripting.Dictionary")
			while not records.eof
				set obj = PopulateObjectFromRecord(records)
				results.Add obj.No, obj
				records.movenext
			wend
			set SelectAll = results
			records.Close
		End If
		set records = nothing
	end function
	
	public function SelectAllNotice(Code)
		Dim records,selectSQL

		selectSQL = "" &_
		" SET NOCOUNT ON;  " &_
		" DECLARE @Code INT;" &_
		" SET @Code = ?; " &_
		
		" SELECT * FROM ( " &_
				" SELECT " &_
				"  ROW_NUMBER() OVER (order by [Board].[ParentNo] ASC, [Board].[OrderNo] DESC) AS RowNum " &_
				" ,count(*) over () as [tcount] " &_
				" ,[Board].* " &_
				" ,( CASE [Board].AdminNo WHEN 0 THEN [User].[Id] ELSE [Admin].[Id] END ) AS UserId " &_
				" ,( CASE [Board].AdminNo WHEN 0 THEN [User].[Name] ELSE [Admin].[Name] END ) AS UserName " &_
			" FROM [Board] AS [Board] " &_
			" LEFT JOIN [User] AS [User] ON([Board].UserNo = [User].No) " &_
			" LEFT JOIN [Admin] AS [Admin] ON([Board].AdminNo = [Admin].No) " &_
			" WHERE ([Board].DelFg = 0 OR ([Board].DelFg = 1 AND [Board].ReplyCnt > 0) ) " &_
			" and [Board].Notice = 1 " &_
			" and [Board].Code = @Code " &_
		" ) AS List " &_
		" ORDER BY rownum desc "
		
		set objCommand=Server.CreateObject("ADODB.command") 
		With objCommand
			.ActiveConnection=DbOpenConnection()
			.prepared = true
			.CommandType = adCmdText
			.CommandText = selectSQL
			.Parameters.Append .CreateParameter("@Code",adInteger,adParamInput,0,Code)
		End With
  		
  		set records = objCommand.Execute
  		if records.eof then
			Set SelectAllNotice = Nothing
		else
			Dim results, obj, record
			Set results = Server.CreateObject("Scripting.Dictionary")
			while not records.eof
				set obj = PopulateObjectFromRecord(records)
				results.Add obj.No, obj
				records.movenext
			wend
			set SelectAllNotice = results
			records.Close
		End If
		set records = nothing
	end function
	
	
	public function SelectByField(fieldName, value)
		Dim record,selectSQL
		selectSQL = "" &_
		" SELECT " &_
			"  ROW_NUMBER() OVER (order by [Board].[ParentNo] ASC, [Board].[OrderNo] DESC) AS RowNum " &_
			" ,count(*) over () as [tcount] " &_
			" ,[Board].* " &_
			" ,( CASE [Board].AdminNo WHEN 0 THEN [User].[Id] ELSE [Admin].[Id] END ) AS UserId " &_
			" ,( CASE [Board].AdminNo WHEN 0 THEN [User].[Name] ELSE [Admin].[Name] END ) AS UserName " &_
		" FROM [Board] AS [Board] " &_
		" LEFT JOIN [User] AS [User] ON([Board].UserNo = [User].No) " &_
		" LEFT JOIN [Admin] AS [Admin] ON([Board].AdminNo = [Admin].No) " &_
		" WHERE ([Board].DelFg = 0 OR ([Board].DelFg = 1 AND [Board].ReplyCnt > 0) ) " &_
		" AND Board." & fieldName & " = ? "

		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = selectSQL
		objCommand.CommandType = adCmdText

		If DbAddParameters(objCommand, array(value)) Then
			set record = objCommand.Execute
			Set SelectByField = PopulateObjectFromRecord(record)
			record.Close
			set record = nothing
		Else
			Set SelectByField = Nothing
		End If
	end function


	public function Update(obj)
		Dim strSQL
		strSQL= "Update [Board] set [Title] = ? , [Contents] = ?, [Notice] = ? , [Image] = ? Where No = ? "
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Title, obj.Contents,obj.Notice,obj.Image, obj.No)) then
			objCommand.Execute
			Update = true
		Else
			Update = false
		End If
 	end function
 	
 	public function UpdateByField(fieldName, value, No)
		Dim strSQL
		strSQL= "Update [Board] set " & fieldName & " = ? Where No = ? "
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(value, No)) then
			objCommand.Execute
			UpdateByField = true
		Else
			UpdateByField = false
		End If
 	end function
 	
 	public function UpdateReply(ParentNo,OrderNo)
		Dim strSQL
		strSQL= "Update [Board] set [OrderNo] = [OrderNo] + 1 Where ParentNo = ? AND OrderNo >= ? "
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(ParentNo,OrderNo)) then
			objCommand.Execute
			UpdateReply = true
		Else
			UpdateReply = false
		End If
 	end function
 	
 	
 	
 	public function Delete(No)
		Dim strSQL
		strSQL = "" &_
		" SET NOCOUNT ON;  " &_
		
		" DECLARE @No VARCHAR(MAX); " &_
		" SET @No = ?; " &_
		
		" DECLARE @S VARCHAR (MAX); " &_
		" DECLARE @T TABLE(T_INT INT); " &_
		" SET @S = @No; " &_
		
		" WHILE CHARINDEX(',',@S)<>0 " &_
		"	BEGIN " &_
		"	INSERT INTO @T(T_INT) VALUES( SUBSTRING(@S,1,CHARINDEX(',',@S)-1) ) " &_
		"	SET @S=SUBSTRING(@S,CHARINDEX(',',@S)+1,LEN(@S))  " &_
		" END " &_
		" IF CHARINDEX(',',@S)=0 " &_
		"	BEGIN " &_
		"	INSERT INTO @T(T_INT) VALUES( SUBSTRING(@S,1,LEN(@S)) ) " &_
		" END " &_
		
		" Update [Board] set [DelFg] = 1 WHERE No in(SELECT T_INT FROM @T); "
		
		set objCommand=Server.CreateObject("ADODB.command") 
		With objCommand
			.ActiveConnection=DbOpenConnection()
			.prepared = true
			.CommandType = adCmdText
			.CommandText = strSQL
			.Parameters.Append .CreateParameter( "@No" ,adVarChar , adParamInput , 8000 , No )
			.Execute
		End With
		Delete = true
	end function
	
	
	

	private function PopulateObjectFromRecord(record)
		if record.eof then 
			Set PopulateObjectFromRecord = Nothing
	    else
			Dim obj
			set obj = new Board
			obj.RowNum    = record("RowNum")
			obj.tcount    = record("tcount")
			obj.No        = record("No")
			obj.Code      = record("Code")
			obj.ParentNo  = record("ParentNo")
			obj.OrderNo   = record("OrderNo")
			obj.DepthNo   = record("DepthNo")
			obj.UserNo    = record("UserNo")
			obj.UserId    = record("UserId")
			obj.UserName  = record("UserName")
			obj.Title     = record("Title")
			obj.Contents  = record("Contents")
			obj.Notice    = record("Notice")
			obj.DelFg     = record("DelFg")
			obj.ReadCnt   = record("ReadCnt")
			obj.FileCnt   = record("FileCnt")
			obj.ReplyCnt  = record("ReplyCnt")
			obj.Ip        = record("Ip")
			obj.Indate    = record("Indate")
			obj.AdminNo   = record("AdminNo")
			obj.Image     = record("Image")
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>
    