<%
class Apps
	private mRowNum
	private mtcount
	private mNo
	private mUserNo
	private mUserId
	private mUserName
	private mMenuNo
	private mMenuName
	private mName
	private mContents1
	private mContents2
	private mContents3
	private mIndate
	private mAdminNo
	
	private mImages1
	private mImages2
	private mImages3
	private mImages4
	private mImagesList
	private mDelFg
	private mState
	
	private mSdate
	private mEdate

	private sub Class_Initialize()
		mUserNo  = ""
		mUserId = ""
		mUserName = ""
		mMenuNo = ""
		mMenuName = ""
		mName = ""
		mSdate = ""
		mEdate = ""
		mState = ""
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
	
	public property get MenuNo()
		MenuNo = mMenuNo
	end property
	public property let MenuNo(val)
		mMenuNo = val
	end property
	
	public property get MenuName()
		MenuName = mMenuName
	end property
	public property let MenuName(val)
		mMenuName = val
	end property
	
	public property get Name()
		Name = mName
	end property
	public property let Name(val)
		mName = val
	end property
	
	public property get Contents1()
		Contents1 = mContents1
	end property
	public property let Contents1(val)
		mContents1 = val
	end property
	
	public property get Contents2()
		Contents2 = mContents2
	end property
	public property let Contents2(val)
		mContents2 = val
	end property
	
	public property get Contents3()
		Contents3 = mContents3
	end property
	public property let Contents3(val)
		mContents3 = val
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
	
	public property get Images1()
		Images1 = mImages1
	end property
	public property let Images1(val)
		mImages1 = val
	end property
	
	public property get Images2()
		Images2 = mImages2
	end property
	public property let Images2(val)
		mImages2 = val
	end property
	
	public property get Images3()
		Images3 = mImages3
	end property
	public property let Images3(val)
		mImages3 = val
	end property
	
	public property get Images4()
		Images4 = mImages4
	end property
	public property let Images4(val)
		mImages4 = val
	end property
	
	public property get ImagesList()
		ImagesList = mImagesList
	end property
	public property let ImagesList(val)
		mImagesList = val
	end property
	
	public property get DelFg()
		DelFg = mDelFg
	end property
	public property let DelFg(val)
		mDelFg = val
	end property
	
	public property get State()
		State = mState
	end property
	public property let State(val)
		mState = val
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



class AppsHelper

	Dim selectSQL

	private sub Class_Initialize()
		selectSQL = " SELECT ROW_NUMBER() OVER (order by [No] DESC) AS [RowNum],count(*) over () as [tcount],* FROM [Apps] "
	end sub

	private sub Class_Terminate()
	end sub
	
	public function Insert(ByRef obj)
		Dim strSQL , execResult
		strSQL= " Insert into [Apps] (UserNo,MenuNo,Name,Contents1,Contents2,Contents3,InDate,AdminNo,Images1,Images2,Images3,Images4,DelFg,State,ImagesList)" & _
		" Values (?,?,?,?,?,?,GETDATE(),?,?,?,?,?,0,?,?); " & _
		" SELECT SCOPE_IDENTITY() "
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection = DbOpenConnection()
		objCommand.NamedParameters  = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.UserNo, obj.MenuNo, obj.Name, obj.Contents1, obj.Contents2, obj.Contents3,obj.AdminNo,obj.Images1,obj.Images2,obj.Images3,obj.Images4,obj.State,obj.ImagesList)) then
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

		if objs.UserNo <> "" then
			whereSql = whereSql & " and [User].No = @UserNo "
		end if
		if objs.UserId <> "" then
			whereSql = whereSql & " and ([User].Id like '%' + @UserId + '%' or [Admin].Id like '%' + @UserId + '%') "
		end if
		if objs.UserName <> "" then
			whereSql = whereSql & " and ([User].Name like '%' + @UserName + '%' or [Admin].Name like '%' + @UserName + '%') "
		end if
		
		if objs.MenuNo <> "" then
			whereSql = whereSql & " and [Apps].MenuNo = @MenuNo "
		end if
		if objs.Name <> "" then
			whereSql = whereSql & " and [Apps].Name like '%'+ @Name+ '%' "
		end if
		if objs.Sdate <> "" then
			whereSql = whereSql & " and CONVERT(VARCHAR,[Apps].[InDate],23) >= @Sdate "
		end if
		if objs.Edate <> "" then
			whereSql = whereSql & " and CONVERT(VARCHAR,[Apps].[InDate],23) <= @Edate "
		end if
		
		if objs.State <> "" then
			whereSql = whereSql & " and [Apps].State = @State "
		end if
		

		selectSQL = "" &_
		" SET NOCOUNT ON;  " &_
		" DECLARE @UserNo INT, @MenuNo INT , @Name VARCHAR(200); " &_
		" DECLARE @UserId VARCHAR(320), @UserName VARCHAR(50); " &_
		" DECLARE @Sdate VARCHAR(10) ,@Edate VARCHAR(10); " &_
		" DECLARE @State INT; " &_
		
		" SET @UserNo = ?; " &_
		" SET @UserId = ?; " &_
		" SET @UserName = ?; " &_
		" SET @MenuNo = ?; " &_
		" SET @Name = ?; " &_
		" SET @Sdate = ?; " &_
		" SET @Edate = ?; " &_
		" SET @State = ?; " &_
		
		" WITH LIST AS ( " &_
			" SELECT " &_
				"  ROW_NUMBER() OVER (order by [Apps].[No] ASC) AS RowNum " &_
				" ,count(*) over () as [tcount] " &_
				" ,[Apps].* " &_
				" ,[AppsMenu].Name AS MenuName " &_
				" ,( CASE [Apps].AdminNo WHEN 0 THEN [User].[Id] ELSE [Admin].[Id] END ) AS UserId " &_
				" ,( CASE [Apps].AdminNo WHEN 0 THEN [User].[Name] ELSE [Admin].[Name] END ) AS UserName " &_
			" FROM [Apps] AS [Apps] " &_
			" INNER JOIN [User] AS [User] ON([Apps].UserNo = [User].No) " &_
			" LEFT JOIN [AppsMenu] AS [AppsMenu] ON([Apps].MenuNo = [AppsMenu].No) " &_
			" LEFT JOIN [Admin] AS [Admin] ON([Apps].AdminNo = [Admin].No) " &_
			" WHERE [Apps].[DelFg] = 0 AND [User].[DelFg] = 0 " &_
			whereSql &_
		" ) SELECT L.* FROM LIST L " &_
		" WHERE (tcount-rownum+1) BETWEEN " & ((pageNo - 1) * rows) + 1 & " AND " & ((pageNo - 1) * rows) + rows & " "&_
		" ORDER BY rownum desc "
		
		
		set objCommand=Server.CreateObject("ADODB.command") 
		With objCommand
			.ActiveConnection=DbOpenConnection()
			.prepared = true
			.CommandType = adCmdText
			.CommandText = selectSQL
			.Parameters.Append .CreateParameter( "@UserNo"   ,adVarChar , adParamInput, 200 , objs.UserNo )
			.Parameters.Append .CreateParameter( "@UserId"   ,adVarChar , adParamInput, 200 , objs.UserId )
			.Parameters.Append .CreateParameter( "@UserName" ,adVarChar , adParamInput, 200 , objs.UserName )
			.Parameters.Append .CreateParameter( "@MenuNo"   ,adVarChar , adParamInput, 200 , objs.MenuNo )
			.Parameters.Append .CreateParameter( "@Name"     ,adVarChar , adParamInput, 200 , objs.Name )
			.Parameters.Append .CreateParameter( "@Sdate"    ,adVarChar , adParamInput , 10 , objs.Sdate )
			.Parameters.Append .CreateParameter( "@Edate"    ,adVarChar , adParamInput , 10 , objs.Edate )
			.Parameters.Append .CreateParameter( "@State"    ,adVarChar , adParamInput , 10 , objs.State )
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
			"  ROW_NUMBER() OVER (order by [Apps].[No] DESC) AS RowNum " &_
			" ,count(*) over () as [tcount] " &_
			" ,[Apps].* " &_
			" ,[AppsMenu].Name AS MenuName " &_
			" ,( CASE [Apps].AdminNo WHEN 0 THEN [User].[Id] ELSE [Admin].[Id] END ) AS UserId " &_
			" ,( CASE [Apps].AdminNo WHEN 0 THEN [User].[Name] ELSE [Admin].[Name] END ) AS UserName " &_
		" FROM [Apps] AS [Apps] " &_
		" LEFT JOIN [AppsMenu] AS [AppsMenu] ON([Apps].MenuNo = [AppsMenu].No) " &_
		" LEFT JOIN [User] AS [User] ON([Apps].UserNo = [User].No) " &_
		" LEFT JOIN [Admin] AS [Admin] ON([Apps].AdminNo = [Admin].No) " &_
		" WHERE [Apps]." & fieldName & " = ? "

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
		strSQL= "Update [Apps] set [MenuNo] = ?, [Name] = ?, [Contents1] = ?, [Contents2] = ?, [Contents3] = ?,[Images1]=?,[Images2]=?,[Images3]=?,[Images4]=?,[State]=?,[ImagesList]=? Where No = ? "
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.MenuNo,obj.Name,obj.Contents1,obj.Contents2,obj.Contents3,obj.Images1,obj.Images2,obj.Images3,obj.Images4,obj.State,obj.ImagesList,obj.No)) then
			objCommand.Execute
			Update = true
		Else
			Update = false
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
		
		" DELETE FROM [Apps] WHERE No in(SELECT T_INT FROM @T); "
		
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
			set obj = new Apps
			obj.RowNum    = record("RowNum")
			obj.tcount    = record("tcount")
			obj.No        = record("No")
			obj.UserNo    = record("UserNo")
			obj.UserId    = record("UserId")
			obj.UserName  = record("UserName")
			obj.MenuNo    = record("MenuNo")
			obj.MenuName  = record("MenuName")
			obj.Name      = record("Name")
			obj.Contents1 = record("Contents1")
			obj.Contents2 = record("Contents2")
			obj.Contents3 = record("Contents3")
			obj.Indate    = record("Indate")
			obj.AdminNo   = record("AdminNo")
			obj.Images1   = record("Images1")
			obj.Images2   = record("Images2")
			obj.Images3   = record("Images3")
			obj.Images4   = record("Images4")
			obj.ImagesList= record("ImagesList")
			obj.DelFg     = record("DelFg")
			obj.State     = record("State")
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>
    