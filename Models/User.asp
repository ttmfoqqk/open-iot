<%
class User

	private mMetadata

	'=============================
	'Private properties
	private mNo
	private mId
	private mPwd
	private mName
	private mPhone3
	private mIndate
	private mState
	private mDelFg

	private sub Class_Initialize()
		mMetadata = Array( "No" , "Id" , "Pwd" , "Name" , "Phone3" , "Indate" , "State" , "DelFg" )
	end sub

	private sub Class_Terminate()
	end sub

	'=============================
	'public properties
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

	public property get Phone3()
		Phone3 = mPhone3
	end property

	public property let Phone3(val)
		mPhone3 = val
	end property

	public property get Indate()
		Indate = mIndate
	end property

	public property let Indate(val)
		mIndate = val
	end property
	
	public property get State()
		State = mState
	end property

	public property let State(val)
		mState = val
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

end class 'User

class UserHelper

	Dim selectSQL

	private sub Class_Initialize()
		selectSQL = " SELECT * FROM [User] "
	end sub

	private sub Class_Terminate()
	end sub

	'=============================
	'public Functions

	' Create a new User.
	' true - if successful, false otherwise
	public function Insert(ByRef obj)
		Dim strSQL , execResult
		strSQL=   " Insert into [dbo].[User] ( [Id] , [Pwd] , [Name] , [Phone3] , [Indate] , [State] , [DelFg] )" & _
		" Values (?  , pwdencrypt(?) , ? , ? , GETDATE() , 1 , 0 ); " & _
		" SELECT SCOPE_IDENTITY()  "
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection = DbOpenConnection()
		objCommand.NamedParameters  = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array( obj.Id , obj.Pwd , obj.Name , obj.Phone3 )) then
			Set execResult = objCommand.Execute
			Set execResult = execResult.NextRecordSet() ' ---- Fix for having a second command in the SQL batch
		End If
		obj.No = CInt(execResult(0))
		Insert = true
	end  function

	' Update the User
	public function Update(obj)
		Dim strSQL
		strSQL= "Update [User] set [Id]=?  , [Name]=?  , [Phone3]=? Where Id = ? " 
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Id, obj.Name, obj.Phone3 , obj.Id)) then
			objCommand.Execute
			Update = true
		Else
			Update = false
		End If
 
	end function 
  
	' Delete the User
	public function Delete(Id)
		Dim strSQL
		strSQL= "DELETE FROM [User] WHERE Id = ?"
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText
		if DbAddParameters(objCommand, array(Id)) Then
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
		objCommand.CommandText = selectSQL + " Where " & fieldName & "=? and DelFg = 0 "
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
	
	public function Login(obj)
		Dim record
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = selectSQL + " Where Id=? and pwdcompare( ? ,[Pwd]) = convert(varchar(50),'1') and DelFg = 0 "
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
			set obj = new User

			obj.No     = record("No")
			obj.Id     = record("Id")
			obj.Pwd    = record("Pwd")
			obj.Name   = record("Name")
			obj.Phone3 = record("Phone3")
			obj.Indate = record("Indate")
			obj.State  = record("State")
			obj.DelFg  = record("DelFg")
			set PopulateObjectFromRecord = obj
		end if
	end function

end class 'UserHelper
%>
    