<%
class Oids
	private mRowNum
	private mtcount
	private mNo
	private mUserNo
	private mUserId
	private mUserName
	private mOid
	private mHphone1
	private mHphone2
	private mHphone3
	private mName
	private mEmail
	private mAddr
	private mPhone1
	private mPhone2
	private mPhone3
	private mImgLogo
	private mImgBusiness
	private mInDate
	private mState
	private mUrl
	
	private mSdate
	private mEdate

	private sub Class_Initialize()
		mUserNo = ""
		mUserId = ""
		mUserName = ""
		mOid = ""
		mName = ""
		mEmail = ""
		mSdate = ""
		mEdate = ""
		mState = ""
		mUrl = ""
	end sub

	private sub Class_Terminate()
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
	
	public property get Oid()
		Oid = mOid
	end property
	public property let Oid(val)
		mOid = val
	end property

	public property get Hphone1()
		Hphone1 = mHphone1
	end property
	public property let Hphone1(val)
		mHphone1 = val
	end property
	
	public property get Hphone2()
		Hphone2 = mHphone2
	end property
	public property let Hphone2(val)
		mHphone2 = val
	end property
	
	public property get Hphone3()
		Hphone3 = mHphone3
	end property
	public property let Hphone3(val)
		mHphone3 = val
	end property

	public property get Name()
		Name = mName
	end property
	public property let Name(val)
		mName = val
	end property

	public property get Email()
		Email = mEmail
	end property
	public property let Email(val)
		mEmail = val
	end property
	
	public property get Addr()
		Addr = mAddr
	end property
	public property let Addr(val)
		mAddr = val
	end property
	
	public property get Phone1()
		Phone1 = mPhone1
	end property
	public property let Phone1(val)
		mPhone1 = val
	end property
	
	public property get Phone2()
		Phone2 = mPhone2
	end property
	public property let Phone2(val)
		mPhone2 = val
	end property
	
	public property get Phone3()
		Phone3 = mPhone3
	end property
	public property let Phone3(val)
		mPhone3 = val
	end property
	
	public property get ImgLogo()
		ImgLogo = mImgLogo
	end property
	public property let ImgLogo(val)
		mImgLogo = val
	end property
	
	public property get ImgBusiness()
		ImgBusiness = mImgBusiness
	end property
	public property let ImgBusiness(val)
		mImgBusiness = val
	end property
	
	public property get InDate()
		InDate = mInDate
	end property
	public property let InDate(val)
		mInDate = val
	end property
	
	' 검색용 추가
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

	
	
	public property get State()
		State = mState
	end property
	public property let State(val)
		mState = val
	end property
	
	public property get Url()
		Url = mUrl
	end property
	public property let Url(val)
		mUrl = val
	end property

end class

class OidHelper

	Dim selectSQL

	private sub Class_Initialize()
		selectSQL = " SELECT ROW_NUMBER() OVER (order by [No] DESC) AS [RowNum],count(*) over () as [tcount], * FROM [Oid] "
	end sub

	private sub Class_Terminate()
	end sub

	public function Insert(ByRef obj)
		Dim strSQL , execResult
		strSQL=   " Insert into [dbo].[Oid] ( [UserNo],[Oid],[Hphone1],[Hphone2],[Hphone3],[Name],[Email],[Addr],[Phone1],[Phone2],[Phone3],[ImgLogo],[ImgBusiness],[InDate],[State],[Url] )" & _
		" Values (?,?,?,?,?,?,?,?,?,?,?,?,?,GETDATE(),?,? ); " & _
		" SELECT SCOPE_IDENTITY()  "
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection = DbOpenConnection()
		objCommand.NamedParameters  = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.UserNo,obj.Oid,obj.Hphone1,obj.Hphone2,obj.Hphone3,obj.Name,obj.Email,obj.Addr,obj.Phone1,obj.Phone2,obj.Phone3,obj.ImgLogo,obj.ImgBusiness,obj.State,obj.Url)) then
			Set execResult = objCommand.Execute
			Set execResult = execResult.NextRecordSet()
		End If
		obj.No = CInt(execResult(0))
		Insert = true
	end  function

	
	
	
	public function Update(obj)
		Dim strSQL
		strSQL= "Update [Oid] set [Oid]=?,[Hphone1]=?,[Hphone2]=?,[Hphone3]=?,[Name]=?,[Email]=?,[Addr]=?,[Phone1]=?,[Phone2]=?,[Phone3]=?,[ImgLogo]=?,[ImgBusiness]=?,[State]=?,[Url]=? Where [No] = ? "
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Oid,obj.Hphone1,obj.Hphone2,obj.Hphone3,obj.Name,obj.Email,obj.Addr,obj.Phone1,obj.Phone2,obj.Phone3,obj.ImgLogo,obj.ImgBusiness,obj.State,obj.Url,obj.No)) then
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
		
		" DELETE FROM [Oid] WHERE No in(SELECT T_INT FROM @T); "
		
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
	

	public function SelectByField(fieldName, value)
		Dim record,selectSQL
		
		selectSQL = "" &_

		" SELECT " &_
			"  ROW_NUMBER() OVER (order by A.[No] DESC) AS [RowNum] " &_
			" ,count(*) over () as [tcount] " &_
			" ,A.* " &_
			" ,B.Id AS UserId " &_
			" ,B.Name AS UserName " &_
		" FROM [Oid] AS A " &_
		" INNER JOIN [User] AS B ON(A.UserNo = B.No AND B.DelFg = 0) " &_
		" WHERE A." & fieldName & " = ? " 
		
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
	

	public function SelectAll(objs,pageNo,rows)
		Dim records,selectSQL
		dim whereSql : whereSql = ""

		pageNo = iif( pageNo ="" ,1  ,pageNo )
		rows   = iif( rows   ="" ,10 ,rows )

		if objs.UserId <> "" then
			whereSql = whereSql & " and B.Id like '%'+@UserId+'%' "
		end if
		if objs.UserName <> "" then
			whereSql = whereSql & " and B.Name like '%'+@UserName+'%' "
		end if
		if objs.Oid <> "" then
			whereSql = whereSql & " and A.Oid like '%'+@Oid+'%' "
		end if
		if objs.Name <> "" then
			whereSql = whereSql & " and A.Name like '%'+@Name+'%' "
		end if
		if objs.Email <> "" then
			whereSql = whereSql & " and A.Email like '%'+@Email+'%' "
		end if
		if objs.Sdate <> "" then
			whereSql = whereSql & " and CONVERT(VARCHAR,A.[InDate],23) >= @Sdate "
		end if
		if objs.Edate <> "" then
			whereSql = whereSql & " and CONVERT(VARCHAR,A.[InDate],23) <= @Edate "
		end if
		
		if objs.State <> "" then
			whereSql = whereSql & " and A.State = @State "
		end if


		selectSQL = "" &_
		" SET NOCOUNT ON;  " &_
		" DECLARE @UserId VARCHAR(320) ,@UserName VARCHAR(320); " &_
		" DECLARE @Oid VARCHAR(200) ,@Name VARCHAR(200); " &_
		" DECLARE @Sdate VARCHAR(10) ,@Edate VARCHAR(10); " &_
		" DECLARE @State INT , @Email VARCHAR(320); " &_
		
		" SET @UserId = ?; " &_
		" SET @UserName = ?; " &_
		" SET @Oid = ?; " &_
		" SET @Name = ?; " &_
		" SET @Sdate = ?; " &_
		" SET @Edate = ?; " &_
		" SET @State = ?; " &_
		" SET @Email = ?; " &_

		" WITH LIST AS ( " &_
				" SELECT " &_
				"  ROW_NUMBER() OVER (order by A.No ASC) AS RowNum " &_
				" ,count(*) over () as [tcount] " &_
				" ,A.* " &_
				" ,B.Id AS UserId " &_
				" ,B.Name AS UserName " &_
			" FROM [Oid] AS A " &_
			" INNER JOIN [User] AS B ON(A.UserNo = B.No AND B.DelFg = 0) " &_
			" WHERE A.No > 0 " &_
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
			.Parameters.Append .CreateParameter( "@UserId"   ,adVarChar ,adParamInput  ,320 , objs.UserId )
			.Parameters.Append .CreateParameter( "@UserName" ,adVarChar ,adParamInput  ,320 , objs.UserName )
			.Parameters.Append .CreateParameter( "@Oid"      ,adVarChar ,adParamInput  ,200 , objs.Oid )
			.Parameters.Append .CreateParameter( "@Name"     ,adVarChar ,adParamInput  ,200 , objs.Name )
			.Parameters.Append .CreateParameter( "@Sdate"    ,adVarChar , adParamInput , 10 , objs.Sdate )
			.Parameters.Append .CreateParameter( "@Edate"    ,adVarChar , adParamInput , 10 , objs.Edate )
			.Parameters.Append .CreateParameter( "@State"    ,adVarChar , adParamInput , 10 , objs.State )
			.Parameters.Append .CreateParameter( "@Email"    ,adVarChar , adParamInput , 10 , objs.Email )
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
	

		
	private function PopulateObjectFromRecord(record)
		if record.eof then
			Set PopulateObjectFromRecord = Nothing
	    else
			Dim obj
			set obj = new Oids
			
			obj.RowNum      = record("RowNum")
			obj.tcount      = record("tcount")
			obj.No          = record("No")
			obj.UserNo      = record("UserNo")
			obj.UserId      = record("UserId")
			obj.UserName    = record("UserName")
			obj.Oid         = record("Oid")
			obj.Hphone1     = record("Hphone1")
			obj.Hphone2     = record("Hphone2")
			obj.Hphone3     = record("Hphone3")
			obj.Name        = record("Name")
			obj.Email       = record("Email")
			obj.Addr        = record("Addr")
			obj.Phone1      = record("Phone1")
			obj.Phone2      = record("Phone2")
			obj.Phone3      = record("Phone3")
			obj.ImgLogo     = record("ImgLogo")
			obj.ImgBusiness = record("ImgBusiness")
			obj.InDate      = record("InDate")
			obj.State       = record("State")
			obj.Url         = record("Url")
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>
    