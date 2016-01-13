<%
class Reservation

	private mMetadata
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

	private sub Class_Initialize()
		mMetadata = Array("RowNum" , "tcount","No","UserNo","UserId","UserName","Location","Facilities","Hphone1","Hphone2","Hphone3","UseDate","Purpose","State","InDate")
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

	public property get metadata()
		metadata = mMetadata
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
		strSQL= "Update [Reservation] set [Location]=?,[Facilities]=?,[Hphone1]=?,[Hphone2]=?,[Hphone3]=?,[UseDate]=?,[Purpose]=?,[State]=? Where [No]=?; "
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Location, obj.Facilities, obj.Hphone1, obj.Hphone2, obj.Hphone3, obj.UseDate, obj.Purpose, obj.State, obj.No)) then
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

		if objs.UserId <> "" then
			whereSql = whereSql & " and B.[Id] like '%'+@Id+'%' "
		end if
		
		if objs.UserName <> "" then
			whereSql = whereSql & " and B.[Name] like '%'+@Name+'%' "
		end if

		selectSQL = "" &_
		" SET NOCOUNT ON;  " &_
		" DECLARE @Id VARCHAR(320) ,@Name VARCHAR(320); " &_
		
		" SET @Id = ?; " &_
		" SET @Name = ?; " &_
		
		" SELECT * FROM ( " &_
				" SELECT " &_
				"  ROW_NUMBER() OVER (order by A.[No] DESC) AS RowNum " &_
				" ,count(*) over () as [tcount] " &_
				" ,A.* " &_
				" ,B.[Id] AS UserId " &_
				" ,B.[Name] AS UserName " &_
			" FROM [Reservation] AS A " &_
			" INNER JOIN [User] AS B ON(A.[UserNo]=B.[No]) " &_
			" WHERE B.[DelFg] = 0 " &_
			whereSql &_
		" ) AS List " &_
		" WHERE RowNum BETWEEN " & ((pageNo - 1) * rows) + 1 & " AND " & ((pageNo - 1) * rows) + rows & " "
		
		set objCommand=Server.CreateObject("ADODB.command")
		With objCommand
			.ActiveConnection=DbOpenConnection()
			.prepared = true
			.CommandType = adCmdText
			.CommandText = selectSQL
			.Parameters.Append .CreateParameter( "@Id"     ,adVarChar , adParamInput , 320 , objs.UserId )
			.Parameters.Append .CreateParameter( "@Name"   ,adVarChar , adParamInput , 320 , objs.UserName )
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
		Dim record
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = selectSQL + " Where " & fieldName & "=? "
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


	private function PopulateObjectFromRecord(record)
		if record.eof then 
			Set PopulateObjectFromRecord = Nothing
	    else
			Dim obj
			set obj = new Reservation
			
			obj.mRowNum    = record("mRowNum")
			obj.mtcount    = record("mtcount")
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
			
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>    