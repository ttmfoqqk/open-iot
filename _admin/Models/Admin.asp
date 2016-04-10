<%
class Admin
	private mRowNum
	private mtcount
	private mNo
	private mId
	private mPwd
	private mName
	private mIndate
	private mDelFg
	private mEmail
	
	private mSdate
	private mEdate

	private sub Class_Initialize()
		mId  = ""
		mName = ""
		mSdate = ""
		mEdate = ""
		mEmail = ""
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
	
	public property get Id()
		Id = mId
	end property
	public property let Id(val)
		mId = val
	end property
	
	public property get Pwd()
		Pwd = mPwd
	end property
	public property let Pwd(val)
		mPwd = val
	end property

	public property get Name()
		Name = mName
	end property
	public property let Name(val)
		mName = val
	end property

	public property get Indate()
		Indate = mIndate
	end property
	public property let Indate(val)
		mIndate = val
	end property

	public property get DelFg()
		DelFg = mDelFg
	end property
	public property let DelFg(val)
		mDelFg = val
	end property
	
	public property get Email()
		Email = mEmail
	end property
	public property let Email(val)
		mEmail = val
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
end class

class AdminHelper

	Dim selectSQL

	private sub Class_Initialize()
		selectSQL = " SELECT ROW_NUMBER() OVER (order by [No] DESC) AS [RowNum],count(*) over () as [tcount],* FROM [Admin] "
	end sub

	private sub Class_Terminate()
	end sub


	public function Insert(ByRef obj)
		Dim strSQL , execResult
		strSQL=   " Insert into [Admin] ([Id],[Pwd],[Name],[Indate],[DelFg],[Email] ) " &_
		" Values (?,?,?,GETDATE(),0,?); " &_
		" SELECT SCOPE_IDENTITY()  "
		
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection = DbOpenConnection()
		objCommand.NamedParameters  = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array( obj.Id, obj.Pwd, obj.Name , obj.Email )) then
			Set execResult = objCommand.Execute
			Set execResult = execResult.NextRecordSet()
		End If
		obj.No = CInt(execResult(0))
		Insert = true
	end  function
	

	public function Update(obj)
		Dim strSQL
		strSQL= "Update [Admin] set [Pwd] = ? , [Name] = ? , [Email] = ? Where [No] = ? "
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Pwd, obj.Name, obj.Email, obj.No)) then
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
		
		" Update [Admin] set [DelFg] = 1 WHERE No in(SELECT T_INT FROM @T); "
		
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
		Dim record
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = selectSQL + " Where " & fieldName & "= ?; "
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

		if objs.Id <> "" then
			whereSql = whereSql & " and [Id] like '%'+@Id+'%' "
		end if
		if objs.Name <> "" then
			whereSql = whereSql & " and [Name] like '%'+@Name+'%' "
		end if
		if objs.Sdate <> "" then
			whereSql = whereSql & " and CONVERT(VARCHAR,[Indate],23) >= @Sdate "
		end if
		if objs.Edate <> "" then
			whereSql = whereSql & " and CONVERT(VARCHAR,[Indate],23) <= @Edate "
		end if

		selectSQL = "" &_
		" SET NOCOUNT ON;  " &_
		" DECLARE @Id VARCHAR(320) ,@Name VARCHAR(320); " &_
		" DECLARE @Sdate VARCHAR(10) ,@Edate VARCHAR(10); " &_
		
		" SET @Id = ?; " &_
		" SET @Name = ?; " &_
		" SET @Sdate = ?; " &_
		" SET @Edate = ?; " &_

		" WITH LIST AS ( " &_
				" SELECT " &_
				"  ROW_NUMBER() OVER (order by [No] ASC) AS RowNum " &_
				" ,count(*) over () as [tcount] " &_
				" ,* " &_
			" FROM [Admin] " &_
			" WHERE DelFg = 0 " &_
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
			.Parameters.Append .CreateParameter( "@Id"   ,adVarChar , adParamInput , 320 , objs.Id )
			.Parameters.Append .CreateParameter( "@Name" ,adVarChar , adParamInput , 320 , objs.Name )
			.Parameters.Append .CreateParameter( "@Sdate" ,adVarChar , adParamInput , 10 , objs.Sdate )
			.Parameters.Append .CreateParameter( "@Edate" ,adVarChar , adParamInput , 10 , objs.Edate )
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
	
	
	public function Login(obj)
		Dim record
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = selectSQL + " Where Id=? and [Pwd] = ? and DelFg = 0 "
		objCommand.CommandType = adCmdText
		
		If DbAddParameters(objCommand, Array(obj.Id,obj.Pwd)) Then
			set record = objCommand.Execute
			Set Login = PopulateObjectFromRecord(record)
			record.Close
			set record = nothing
		Else
			Set Login = Nothing
		End If
	end function
	
	
	private function PopulateObjectFromRecord(record)
		if record.eof then
			Set PopulateObjectFromRecord = Nothing
	    else
			Dim obj
			set obj = new Admin

			obj.RowNum  = record("RowNum")
			obj.tcount  = record("tcount")
			obj.No      = record("No")
			obj.Id      = record("Id")
			obj.Pwd     = record("Pwd")
			obj.Name    = record("Name")
			obj.Indate  = record("Indate")
			obj.DelFg   = record("DelFg")
			obj.Email   = record("Email")
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>
    