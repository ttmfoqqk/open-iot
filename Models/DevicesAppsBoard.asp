<%
class DevicesAppsBoard
	private mRowNum
	private mtcount
	private mNo
	private mCode
	private mTypes
	private mProductNo
	private mManagerNo
	private mParentNo
	private mOrderNo
	private mDepthNo
	private mUserNo
	private mUserId
	private mUserName
	private mTitle
	private mContents
	private mDelFg
	private mReadCnt
	private mReplyCnt
	private mIp
	private mIndate
	private mAdminNo
	private mAdminFg
	
	private mSdate
	private mEdate
	
	private mDevicesName
	private mDevicesImages1
	private mDevicesImages2
	private mDevicesImages3
	private mDevicesImages4
	private mDevicesImagesList
	private mAppsName
	private mAppsImages1
	private mAppsImages2
	private mAppsImages3
	private mAppsImages4
	private mAppsImagesList

	private sub Class_Initialize()
		mCode  = ""
		mTypes  = ""
		mUserNo  = ""
		mUserId = ""
		mUserName = ""
		mTitle = ""
		mSdate = ""
		mEdate = ""
		mProductNo = ""
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
	
	public property get Types()
		Types = mTypes
	end property
	public property let Types(val)
		mTypes = val
	end property
	
	public property get ProductNo()
		ProductNo = mProductNo
	end property
	public property let ProductNo(val)
		mProductNo = val
	end property
	
	public property get ManagerNo()
		ManagerNo = mManagerNo
	end property
	public property let ManagerNo(val)
		mManagerNo = val
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
	
	public property get AdminFg()
		AdminFg = mAdminFg
	end property
	public property let AdminFg(val)
		mAdminFg = val
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
	
	
	
	public property get DevicesName()
		DevicesName = mDevicesName
	end property
	public property let DevicesName(val)
		mDevicesName = val
	end property
	public property get DevicesImages1()
		DevicesImages1 = mDevicesImages1
	end property
	public property let DevicesImages1(val)
		mDevicesImages1 = val
	end property
	public property get DevicesImages2()
		DevicesImages2 = mDevicesImages2
	end property
	public property let DevicesImages2(val)
		mDevicesImages2 = val
	end property
	public property get DevicesImages3()
		DevicesImages3 = mDevicesImages3
	end property
	public property let DevicesImages3(val)
		mDevicesImages3 = val
	end property
	public property get DevicesImages4()
		DevicesImages4 = mDevicesImages4
	end property
	public property let DevicesImages4(val)
		mDevicesImages4 = val
	end property
	public property get DevicesImagesList()
		DevicesImagesList = mDevicesImagesList
	end property
	public property let DevicesImagesList(val)
		mDevicesImagesList = val
	end property
	
	public property get AppsName()
		AppsName = mAppsName
	end property
	public property let AppsName(val)
		mAppsName = val
	end property
	public property get AppsImages1()
		AppsImages1 = mAppsImages1
	end property
	public property let AppsImages1(val)
		mAppsImages1 = val
	end property
	public property get AppsImages2()
		AppsImages2 = mAppsImages2
	end property
	public property let AppsImages2(val)
		mAppsImages2 = val
	end property
	public property get AppsImages3()
		AppsImages3 = mAppsImages3
	end property
	public property let AppsImages3(val)
		mAppsImages3 = val
	end property
	public property get AppsImages4()
		AppsImages4 = mAppsImages4
	end property
	public property let AppsImages4(val)
		mAppsImages4 = val
	end property
	public property get AppsImagesList()
		AppsImagesList = mAppsImagesList
	end property
	public property let AppsImagesList(val)
		mAppsImagesList = val
	end property

	
end class

class DevicesAppsBoardHelper

	Dim selectSQL

	private sub Class_Initialize()
		'
	end sub

	private sub Class_Terminate()
	end sub
	
	public function Insert(ByRef obj)
		Dim strSQL , execResult
		strSQL= " Insert into [DevicesAppsBoard] (Code,Type,ProductNo,ManagerNo,ParentNo,OrderNo,DepthNo,UserNo,Title,Contents,DelFg,ReadCnt,ReplyCnt,Ip,Indate,AdminNo,AdminFg)" & _
		" Values (?,?,?,?,?,?,?,?,?,?,0,0,0,?,GETDATE(),?,?); " & _
		" SELECT SCOPE_IDENTITY()  "
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection = DbOpenConnection()
		objCommand.NamedParameters  = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Code, obj.Types, obj.ProductNo, obj.ManagerNo, obj.ParentNo, obj.OrderNo, obj.DepthNo, obj.UserNo, obj.Title, obj.Contents, obj.Ip, obj.AdminNo, obj.AdminFg )) then
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

		if objs.Code <> "" then
			whereSql = whereSql & " and [Board].Code = @Code "
		end if
		if objs.Types <> "" then
			whereSql = whereSql & " and [Board].Type = @Type "
		end if
		
		if objs.UserNo <> "" then
			whereSql = whereSql & " and [User].No = @UserNo "
		end if
		if objs.UserId <> "" then
			whereSql = whereSql & " and ([User].Id like '%' + @UserId + '%' or [User2].Id like '%' + @UserId + '%' or [Admin].Id like '%' + @UserId + '%') "
		end if
		if objs.UserName <> "" then
			whereSql = whereSql & " and ([User].Name like '%' + @UserName + '%' or [User2].Name like '%' + @UserName + '%' or [Admin].Name like '%' + @UserName + '%') "
		end if
		if objs.Title <> "" then
			whereSql = whereSql & " and [Board].Title like '%'+ @Title +'%' "
		end if
		if objs.Sdate <> "" then
			whereSql = whereSql & " and CONVERT(VARCHAR,[Board].[InDate],23) >= @Sdate "
		end if
		if objs.Edate <> "" then
			whereSql = whereSql & " and CONVERT(VARCHAR,[Board].[InDate],23) <= @Edate "
		end if
		
		if objs.ProductNo <> "" then
			whereSql = whereSql & " and [Board].[ProductNo] = @ProductNo "
		end if

		selectSQL = "" &_
		" SET NOCOUNT ON;  " &_
		" DECLARE @Code VARCHAR(50),@Type VARCHAR(50), @UserNo INT , @UserId VARCHAR(200) , @UserName VARCHAR(200) , @Title VARCHAR(200); " &_
		" DECLARE @Sdate VARCHAR(10) ,@Edate VARCHAR(10); " &_
		" DECLARE @ProductNo INT; " &_
		
		" SET @Code = ?; " &_
		" SET @Type = ?; " &_
		" SET @UserNo = ?; " &_
		" SET @UserId = ?; " &_
		" SET @UserName = ?; " &_
		" SET @Title = ?; " &_
		" SET @Sdate = ?; " &_
		" SET @Edate = ?; " &_
		
		" SET @ProductNo = ?; " &_
		
		" WITH LIST AS ( " &_
				" SELECT " &_
				"  ROW_NUMBER() OVER (order by [Board].[ParentNo] ASC, [Board].[OrderNo] DESC) AS RowNum " &_
				" ,count(*) over () as [tcount] " &_
				" ,[Board].* " &_
				" ,[Devices].Name AS DevicesName,[Devices].ImagesList AS DevicesImagesList,[Devices].Images1 AS DevicesImages1,[Devices].Images2 AS DevicesImages2,[Devices].Images3 AS DevicesImages3,[Devices].Images4 AS DevicesImages4 " &_
				" ,[Apps].Name AS AppsName,[Apps].ImagesList AS AppsImagesList,[Apps].Images1 AS AppsImages1,[Apps].Images2 AS AppsImages2,[Apps].Images3 AS AppsImages3,[Apps].Images4 AS AppsImages4 " &_
				" ,( CASE [Board].AdminNo WHEN 0 THEN [User].[Id] ELSE (CASE [Board].AdminFg WHEN 0 THEN [User2].[Id] ELSE [Admin].[Id] END) END ) AS UserId " &_
				" ,( CASE [Board].AdminNo WHEN 0 THEN [User].[Name] ELSE (CASE [Board].AdminFg WHEN 0 THEN [User2].[Name] ELSE [Admin].[Name] END) END ) AS UserName " &_
			" FROM [DevicesAppsBoard] AS [Board] " &_
			" LEFT JOIN (SELECT [Devices].* FROM [Devices] AS [Devices] INNER JOIN [User] AS [User] ON([Devices].UserNo = [User].No AND [User].Delfg=0) ) AS [Devices] ON([Board].ProductNo = [Devices].No) " &_
			" LEFT JOIN (SELECT [Apps].* FROM [Apps] AS [Apps] INNER JOIN [User] AS [User] ON([Apps].UserNo = [User].No AND [User].Delfg=0) ) AS [Apps] ON([Board].ProductNo = [Apps].No) " &_
			" LEFT JOIN [User] AS [User] ON([Board].UserNo = [User].No and [User].Delfg = 0) " &_
			" LEFT JOIN [User] AS [User2] ON([Board].AdminNo = [User2].No and [User2].Delfg = 0) " &_
			" LEFT JOIN [Admin] AS [Admin] ON([Board].AdminNo = [Admin].No) " &_
			" WHERE ([Board].DelFg = 0 OR ([Board].DelFg = 1 AND [Board].ReplyCnt > 0) ) AND ([Devices].No is not null OR [Apps].No is not null) " &_
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
			.Parameters.Append .CreateParameter( "@Code"   ,adVarChar , adParamInput, 50  , objs.Code )
			.Parameters.Append .CreateParameter( "@Types"   ,adVarChar , adParamInput, 50  , objs.Types )
			.Parameters.Append .CreateParameter( "@UserNo" ,adVarChar , adParamInput, 200 , objs.UserNo )
			.Parameters.Append .CreateParameter( "@UserId" ,adVarChar , adParamInput, 200 , objs.UserId )
			.Parameters.Append .CreateParameter( "@UserName" ,adVarChar , adParamInput, 200 , objs.UserName )
			.Parameters.Append .CreateParameter( "@Title"  ,adVarChar , adParamInput, 200 , objs.Title )
			.Parameters.Append .CreateParameter( "@Sdate"  ,adVarChar , adParamInput , 10 , objs.Sdate )
			.Parameters.Append .CreateParameter( "@Edate"  ,adVarChar , adParamInput , 10 , objs.Edate )
			.Parameters.Append .CreateParameter( "@ProductNo" ,adVarChar , adParamInput, 200 , objs.ProductNo )
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


	public function SelectByField(fieldName, value)
		Dim record,selectSQL
		selectSQL = "" &_
		" SELECT " &_
			"  ROW_NUMBER() OVER (order by [Board].[ParentNo] ASC, [Board].[OrderNo] DESC) AS RowNum " &_
			" ,count(*) over () as [tcount] " &_
			" ,[Board].* " &_
			" ,[Devices].Name AS DevicesName,[Devices].ImagesList AS DevicesImagesList,[Devices].Images1 AS DevicesImages1,[Devices].Images2 AS DevicesImages2,[Devices].Images3 AS DevicesImages3,[Devices].Images4 AS DevicesImages4 " &_
			" ,[Apps].Name AS AppsName,[Apps].ImagesList AS AppsImagesList,[Apps].Images1 AS AppsImages1,[Apps].Images2 AS AppsImages2,[Apps].Images3 AS AppsImages3,[Apps].Images4 AS AppsImages4 " &_
			" ,( CASE [Board].AdminNo WHEN 0 THEN [User].[Id] ELSE (CASE [Board].AdminFg WHEN 0 THEN [User2].[Id] ELSE [Admin].[Id] END) END ) AS UserId " &_
			" ,( CASE [Board].AdminNo WHEN 0 THEN [User].[Name] ELSE (CASE [Board].AdminFg WHEN 0 THEN [User2].[Name] ELSE [Admin].[Name] END) END ) AS UserName " &_
		" FROM [DevicesAppsBoard] AS [Board] " &_
		" LEFT JOIN [Devices] AS [Devices] ON([Board].ProductNo = [Devices].No) " &_
		" LEFT JOIN [Apps] AS [Apps] ON([Board].ProductNo = [Apps].No) " &_
		" LEFT JOIN [User] AS [User] ON([Board].UserNo = [User].No) " &_
		" LEFT JOIN [User] AS [User2] ON([Board].AdminNo = [User2].No) " &_
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
		strSQL= "Update [DevicesAppsBoard] set [Title] = ? , [Contents] = ? Where No = ? "
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Title, obj.Contents,obj.No)) then
			objCommand.Execute
			Update = true
		Else
			Update = false
		End If
 	end function
 	
 	public function UpdateByField(fieldName, value, No)
		Dim strSQL
		strSQL= "Update [DevicesAppsBoard] set " & fieldName & " = ? Where No = ? "
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
		strSQL= "Update [DevicesAppsBoard] set [OrderNo] = [OrderNo] + 1 Where ParentNo = ? AND OrderNo >= ? "
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
		
		" Update [DevicesAppsBoard] set [DelFg] = 1 WHERE No in(SELECT T_INT FROM @T); "
		
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
			set obj = new DevicesAppsBoard
			obj.RowNum    = record("RowNum")
			obj.tcount    = record("tcount")
			obj.No             = record("No")
			obj.Code           = record("Code")
			obj.Types          = record("Type")
			obj.ProductNo      = record("ProductNo")
			obj.ManagerNo      = record("ManagerNo")
			obj.ParentNo       = record("ParentNo")
			obj.OrderNo        = record("OrderNo")
			obj.DepthNo        = record("DepthNo")
			obj.UserNo         = record("UserNo")
			obj.UserId         = record("UserId")
			obj.UserName       = record("UserName")
			obj.Title          = record("Title")
			obj.Contents       = record("Contents")
			obj.DelFg          = record("DelFg")
			obj.ReadCnt        = record("ReadCnt")
			obj.ReplyCnt       = record("ReplyCnt")
			obj.Ip             = record("Ip")
			obj.Indate         = record("Indate")
			obj.AdminNo        = record("AdminNo")
			obj.AdminFg        = record("AdminFg")
			obj.DevicesName    = record("DevicesName")
			obj.DevicesImages1 = record("DevicesImages1")
			obj.DevicesImages2 = record("DevicesImages2")
			obj.DevicesImages3 = record("DevicesImages3")
			obj.DevicesImages4 = record("DevicesImages4")
			obj.DevicesImagesList = record("DevicesImagesList")
			obj.AppsName       = record("AppsName")
			obj.AppsImages1    = record("AppsImages1")
			obj.AppsImages2    = record("AppsImages2")
			obj.AppsImages3    = record("AppsImages3")
			obj.AppsImages4    = record("AppsImages4")
			obj.AppsImagesList    = record("AppsImagesList")
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>
    