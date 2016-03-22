<%
class Reservation
	private mRowNum
	private mtcount
	private mNo
	private mUserNo
	private mUserId
	private mUserName
	private mLocation
	private mFacilities
	private mHphone1
	private mHphone2
	private mHphone3
	private mUseDate
	private mPurpose
	private mState
	private mInDate
	private mStime
	private mEtime
	
	private mSdate
	private mEdate
	private mSRdate
	private mERdate
	
	private mFacilitiesName

	private sub Class_Initialize()
		mUserNo  = ""
		mUserId = ""
		mUserName = ""
		
		mLocation = ""
		mFacilities = ""
		mState = ""
		
		mSdate = ""
		mEdate = ""
		mSRdate = ""
		mERdate = ""
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
	
	public property get Location()
		Location = mLocation
	end property
	public property let Location(val)
		mLocation = val
	end property
	
	public property get Facilities()
		Facilities = mFacilities
	end property
	public property let Facilities(val)
		mFacilities = val
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
	
	public property get UseDate()
		UseDate = mUseDate
	end property
	public property let UseDate(val)
		mUseDate = val
	end property
	
	public property get Purpose()
		Purpose = mPurpose
	end property
	public property let Purpose(val)
		mPurpose = val
	end property
	
	public property get State()
		State = mState
	end property
	public property let State(val)
		mState = val
	end property
	
	public property get InDate()
		InDate = mInDate
	end property
	public property let InDate(val)
		mInDate = val
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
	
	public property get SRdate()
		SRdate = mSRdate
	end property
	public property let SRdate(val)
		mSRdate = val
	end property
	
	public property get ERdate()
		ERdate = mERdate
	end property
	public property let ERdate(val)
		mERdate = val
	end property
	
	public property get Stime()
		Stime = mStime
	end property
	public property let Stime(val)
		mStime = val
	end property
	
	public property get Etime()
		Etime = mEtime
	end property
	public property let Etime(val)
		mEtime = val
	end property
	
	public property get FacilitiesName()
		FacilitiesName = mFacilitiesName
	end property
	public property let FacilitiesName(val)
		mFacilitiesName = val
	end property
	
	
	

end class

class ReservationHelper

	Dim selectSQL

	private sub Class_Initialize()
		selectSQL = " SELECT ROW_NUMBER() OVER (order by [No] DESC) AS [RowNum],count(*) over () as [tcount], * FROM [Reservation] "
	end sub

	private sub Class_Terminate()
	end sub
	
	public function Insert(ByRef obj)
		Dim strSQL , execResult
		strSQL= " Insert into [Reservation] (UserNo,Location,Facilities,Hphone1,Hphone2,Hphone3,UseDate,Purpose,State,InDate)" & _
		" Values (?,?,?,?,?,?,?,?,1,GETDATE()); " & _
		" SELECT SCOPE_IDENTITY()  "
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection = DbOpenConnection()
		objCommand.NamedParameters  = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.UserNo, obj.Location, obj.Facilities, obj.Hphone1, obj.Hphone2, obj.Hphone3, obj.UseDate, obj.Purpose)) then
			Set execResult = objCommand.Execute
			Set execResult = execResult.NextRecordSet()
		End If
		obj.No = CInt(execResult(0))
		Insert = true
	end function
	
	
	public function Update(obj)
		Dim strSQL
		strSQL= "Update [Reservation] set [Location]=?,[Facilities]=?,[Hphone1]=?,[Hphone2]=?,[Hphone3]=?,[UseDate]=?,[Purpose]=?,[State]=?,[Stime]=?,[Etime]=? Where [No]=?; "
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Location, obj.Facilities, obj.Hphone1, obj.Hphone2, obj.Hphone3, obj.UseDate, obj.Purpose, obj.State,obj.Stime,obj.Etime, obj.No)) then
			objCommand.Execute
			Update = true
		Else
			Update = false
		End If
 	end function
	
	public function SelectAll(objs,pageNo,rows)
		Dim records,selectSQL
		dim whereSql : whereSql = ""

		pageNo = iif( pageNo ="" ,1  ,pageNo )
		rows   = iif( rows   ="" ,10 ,rows )
		
		if objs.UserNo <> "" then
			whereSql = whereSql & " and B.No = @UserNo "
		end if
		if objs.UserId <> "" then
			whereSql = whereSql & " and B.Id like '%'+@UserId+'%' "
		end if
		if objs.UserName <> "" then
			whereSql = whereSql & " and B.Name like '%'+@UserName+'%' "
		end if
		if objs.Location <> "" then
			whereSql = whereSql & " and A.Location = @Location "
		end if
		if objs.Facilities <> "" then
			whereSql = whereSql & " and A.Facilities = @Facilities "
		end if
		if objs.State <> "" then
			whereSql = whereSql & " and A.State = @State "
		end if
		if objs.Sdate <> "" then
			whereSql = whereSql & " and CONVERT(VARCHAR,A.[InDate],23) >= @Sdate "
		end if
		if objs.Edate <> "" then
			whereSql = whereSql & " and CONVERT(VARCHAR,A.[InDate],23) <= @Edate "
		end if
		if objs.SRdate <> "" then
			whereSql = whereSql & " and CONVERT(VARCHAR,A.[UseDate],23) >= @SRdate "
		end if
		if objs.ERdate <> "" then
			whereSql = whereSql & " and CONVERT(VARCHAR,A.[UseDate],23) <= @SRdate "
		end if

		selectSQL = "" &_
		" SET NOCOUNT ON;  " &_
		" DECLARE @UserNo INT; " &_
		" DECLARE @UserId VARCHAR(320) ,@UserName VARCHAR(320); " &_
		" DECLARE @Location VARCHAR(10) ,@Facilities VARCHAR(10),@State VARCHAR(10); " &_
		" DECLARE @Sdate VARCHAR(10) ,@Edate VARCHAR(10),@SRdate VARCHAR(10) ,@ERdate VARCHAR(10); " &_
		
		
		" SET @UserNo = ?; " &_
		" SET @UserId = ?; " &_
		" SET @UserName = ?; " &_
		" SET @Location = ?; " &_
		" SET @Facilities = ?; " &_
		" SET @State = ?; " &_
		" SET @Sdate = ?; " &_
		" SET @Edate = ?; " &_
		" SET @SRdate = ?; " &_
		" SET @ERdate = ?; " &_
		
		" WITH LIST AS ( " &_
				" SELECT " &_
				"  ROW_NUMBER() OVER (order by A.[No] ASC) AS RowNum " &_
				" ,count(*) over () as [tcount] " &_
				" ,A.* " &_
				" ,B.[Id] AS UserId " &_
				" ,B.[Name] AS UserName " &_
				" ,C.[Name] AS FacilitiesName " &_
			" FROM [Reservation] AS A " &_
			" INNER JOIN [User] AS B ON(A.[UserNo]=B.[No] AND B.Delfg=0) " &_
			" LEFT JOIN [ReservationMenu] AS C ON(A.[Facilities]=C.[No] AND A.[Location]=C.[Location]) " &_
			" WHERE B.[DelFg] = 0 " &_
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
			.Parameters.Append .CreateParameter( "@UserNo"     ,adVarChar , adParamInput , 320 , objs.UserNo )
			.Parameters.Append .CreateParameter( "@UserId"     ,adVarChar , adParamInput , 320 , objs.UserId )
			.Parameters.Append .CreateParameter( "@UserName"   ,adVarChar , adParamInput , 10  , objs.UserName )
			.Parameters.Append .CreateParameter( "@Location"   ,adVarChar , adParamInput , 10  , objs.Location )
			.Parameters.Append .CreateParameter( "@Facilities" ,adVarChar , adParamInput , 10  , objs.Facilities )
			.Parameters.Append .CreateParameter( "@State"      ,adVarChar , adParamInput , 10  , objs.State )
			.Parameters.Append .CreateParameter( "@Sdate"      ,adVarChar , adParamInput , 10  , objs.Sdate )
			.Parameters.Append .CreateParameter( "@Edate"      ,adVarChar , adParamInput , 10  , objs.Edate )
			.Parameters.Append .CreateParameter( "@SRdate"     ,adVarChar , adParamInput , 10  , objs.SRdate )
			.Parameters.Append .CreateParameter( "@ERdate"     ,adVarChar , adParamInput , 10  , objs.ERdate )
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
			"  ROW_NUMBER() OVER (order by A.[No] DESC) AS [RowNum] " &_
			" ,count(*) over () as [tcount] " &_
			" ,A.* " &_
			" ,B.Id AS UserId " &_
			" ,B.Name AS UserName " &_
			" ,C.[Name] AS FacilitiesName " &_
		" FROM [Reservation] AS A " &_
		" INNER JOIN [User] AS B ON(A.UserNo = B.No) " &_
		" LEFT JOIN [ReservationMenu] AS C ON(A.[Facilities]=C.[No] AND A.[Location]=C.[Location]) " &_
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
	
	
	public function SelectByCalendar(value)
		Dim records,selectSQL
		
		selectSQL = "" &_

		" SELECT " &_
			"  count(*) as [tcount] " &_
			" ,[UseDate] " &_
		" FROM [Reservation] " &_
		" WHERE [State] = 0 and [Location] = ? " &_
		" group by [UseDate] "
		
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = selectSQL
		objCommand.CommandType = adCmdText

		If DbAddParameters(objCommand, array(value)) Then
			set records = objCommand.Execute
			if records.eof then
				Set SelectByCalendar = Nothing
			else
				Dim results, obj, record
				Set results = Server.CreateObject("Scripting.Dictionary")
				while not records.eof
					set obj = new Reservation
					obj.tcount     = records("tcount")
					obj.UseDate    = records("UseDate")
					results.Add obj.UseDate, obj
					records.movenext
				wend
				set SelectByCalendar = results
				records.Close
			End If
			set record = nothing
		Else
			Set SelectByCalendar = Nothing
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
		
		" DELETE FROM [Reservation] WHERE No in(SELECT T_INT FROM @T); "
		
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
			set obj = new Reservation
			
			obj.RowNum     = record("RowNum")
			obj.tcount     = record("tcount")
			obj.No         = record("No")
			obj.UserNo     = record("UserNo")
			obj.UserId     = record("UserId")
			obj.UserName   = record("UserName")
			obj.Location   = record("Location")
			obj.Facilities = record("Facilities")
			obj.Hphone1    = record("Hphone1")
			obj.Hphone2    = record("Hphone2")
			obj.Hphone3    = record("Hphone3")
			obj.UseDate    = record("UseDate")
			obj.Purpose    = record("Purpose")
			obj.State      = record("State")
			obj.InDate     = record("InDate")
			obj.Stime      = record("Stime")
			obj.Etime      = record("Etime")
			obj.FacilitiesName = record("FacilitiesName")
			
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>    