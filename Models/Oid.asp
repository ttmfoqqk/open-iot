<%
class Oids

	private mMetadata

	'=============================
	'Private properties
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

	private sub Class_Initialize()
		mMetadata = Array("RowNum","tcount","No","UserNo","UserId","UserName","Oid","Hphone1","Hphone2","Hphone3","Name","Email","Addr","Phone1","Phone2","Phone3","ImgLogo","ImgBusiness","InDate")
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
	
	

	public property get metadata()
		metadata = mMetadata
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
		strSQL=   " Insert into [dbo].[Oid] ( [UserNo],[Oid],[Hphone1],[Hphone2],[Hphone3],[Name],[Email],[Addr],[Phone1],[Phone2],[Phone3],[ImgLogo],[ImgBusiness],[InDate] )" & _
		" Values (?,?,?,?,?,?,?,?,?,?,?,?,?,GETDATE() ); " & _
		" SELECT SCOPE_IDENTITY()  "
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection = DbOpenConnection()
		objCommand.NamedParameters  = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.UserNo,obj.Oid,obj.Hphone1,obj.Hphone2,obj.Hphone3,obj.Name,obj.Email,obj.Addr,obj.Phone1,obj.Phone2,obj.Phone3,obj.ImgLogo,obj.ImgBusiness)) then
			Set execResult = objCommand.Execute
			Set execResult = execResult.NextRecordSet()
		End If
		obj.No = CInt(execResult(0))
		Insert = true
	end  function

	
	
	
	public function Update(obj)
		Dim strSQL
		strSQL= "Update [Oid] set [Oid]=?,[Hphone1]=?,[Hphone2]=?,[Hphone3]=?,[Name]=?,[Email]=?,[Addr]=?,[Phone1]=?,[Phone2]=?,[Phone3]=?,[ImgLogo]=?,[ImgBusiness]=? Where [No] = ? "
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Oid,obj.Hphone1,obj.Hphone2,obj.Hphone3,obj.Name,obj.Email,obj.Addr,obj.Phone1,obj.Phone2,obj.Phone3,obj.ImgLogo,obj.ImgBusiness)) then
			objCommand.Execute
			Update = true
		Else
			Update = false
		End If
 	end function
  

	public function Delete(No)
		Dim strSQL
		strSQL= "DELETE FROM [Oid] WHERE No = ?"
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText
		if DbAddParameters(objCommand, array(No)) Then
			objCommand.Execute
			Delete = true
		else
			Delete = false
		End If
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


		selectSQL = "" &_
		" SET NOCOUNT ON;  " &_
		" DECLARE @UserId VARCHAR(320) ,@UserName VARCHAR(320); " &_
		
		" SET @UserId = ?; " &_
		" SET @UserName = ?; " &_

		" SELECT * FROM ( " &_
				" SELECT " &_
				"  ROW_NUMBER() OVER (order by A.No DESC) AS RowNum " &_
				" ,count(*) over () as [tcount] " &_
				" ,A.* " &_
				" ,B.Id AS UserId " &_
				" ,B.Name AS UserName " &_
			" FROM [Oid] AS A " &_
			" INNER JOIN [User] AS B ON(A.UserNo = B.No) " &_
			" WHERE A.No > 0 " &_
			whereSql &_
		" ) AS List " &_
		" WHERE RowNum BETWEEN " & ((pageNo - 1) * rows) + 1 & " AND " & ((pageNo - 1) * rows) + rows & " "
		
		set objCommand=Server.CreateObject("ADODB.command")
		With objCommand
			.ActiveConnection=DbOpenConnection()
			.prepared = true
			.CommandType = adCmdText
			.CommandText = selectSQL
			.Parameters.Append .CreateParameter( "@UserId"   ,adVarChar ,adParamInput ,320 , objs.UserId )
			.Parameters.Append .CreateParameter( "@UserName" ,adVarChar ,adParamInput ,320 , objs.UserName )
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
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>
    