<%
class Admin

	private mMetadata
	private mNo
	private mId
	private mPwd
	private mName
	private mIndate
	private mDelFg

	private sub Class_Initialize()
		mMetadata = Array( "No" , "Id" , "Pwd" , "Name" , "Indate" , "DelFg" )
	end sub

	private sub Class_Terminate()
	end sub

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

	public property get metadata()
		metadata = mMetadata
	end property

end class

class AdminHelper

	Dim selectSQL

	private sub Class_Initialize()
		selectSQL = " SELECT * FROM [Admin] "
	end sub

	private sub Class_Terminate()
	end sub


	public function Insert(ByRef obj)
		Dim strSQL , execResult
		strSQL=   " Insert into [Admin] ([Id],[Pwd],[Name],[Indate],[DelFg] ) " &_
		" Values (?,?,?,GETDATE(),0); " &_
		" SELECT SCOPE_IDENTITY()  "
		
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection = DbOpenConnection()
		objCommand.NamedParameters  = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array( obj.Id, obj.Pwd, obj.Name )) then
			Set execResult = objCommand.Execute
			Set execResult = execResult.NextRecordSet()
		End If
		obj.No = CInt(execResult(0))
		Insert = true
	end  function
	

	public function Update(obj)
		Dim strSQL
		strSQL= "Update [Admin] set [Pwd] = ? , [Name] = ? Where [No] = ? "
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Pwd, obj.Name, obj.No)) then
			objCommand.Execute
			Update = true
		Else
			Update = false
		End If
 
	end function
 
 
	public function Delete(No)
		Dim strSQL
		strSQL= "Update [Admin] set [DelFg] = 1 WHERE No = ? "
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
		objCommand.CommandText = selectSQL + " Where " & fieldName & "=? and DelFg = 0 order by No desc"
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

		selectSQL = "" &_
		" SET NOCOUNT ON;  " &_
		" DECLARE @Id VARCHAR(320) ,@Name VARCHAR(320); " &_
		
		" SET @Id = ?; " &_
		" SET @Name = ?; " &_

		" SELECT * FROM ( " &_
				" SELECT " &_
				"  ROW_NUMBER() OVER (order by [No] DESC) AS RowNum " &_
				" ,count(*) over () as [tcount] " &_
				" ,* " &_
			" FROM [Admin] " &_
			" WHERE DelFg = 0 " &_
			whereSql &_
		" ) AS List " &_
		" WHERE RowNum BETWEEN " & ((pageNo - 1) * rows) + 1 & " AND " & ((pageNo - 1) * rows) + rows & " "
		
		set objCommand=Server.CreateObject("ADODB.command") 
		With objCommand
			.ActiveConnection=DbOpenConnection()
			.prepared = true
			.CommandType = adCmdText
			.CommandText = selectSQL
			.Parameters.Append .CreateParameter( "@Id"   ,adVarChar , adParamInput , 320 , objs.Id )
			.Parameters.Append .CreateParameter( "@Name" ,adVarChar , adParamInput , 320 , objs.Name )
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

			obj.No     = record("No")
			obj.Id     = record("Id")
			obj.Pwd    = record("Pwd")
			obj.Name   = record("Name")
			obj.Indate = record("Indate")
			obj.DelFg  = record("DelFg")
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>
    