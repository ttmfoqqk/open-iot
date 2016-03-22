<%
class Page
	private mNo
	private mName
	private mContents

	private sub Class_Initialize()
		
	end sub

	private sub Class_Terminate()
	end sub

	public property get No()
		No = mNo
	end property
	public property let No(val)
		mNo = val
	end property
	
	public property get Name()
		Name = mName
	end property
	public property let Name(val)
		mName = val
	end property
	
	public property get Contents()
		Contents = mContents
	end property
	public property let Contents(val)
		mContents = val
	end property

end class 

class PageHelper

	Dim selectSQL

	private sub Class_Initialize()
		selectSQL = " SELECT * FROM [PageContents] "
	end sub

	private sub Class_Terminate()
	end sub
	
	
	public function Insert(ByRef obj)
		Dim strSQL , execResult
		strSQL= " Insert into [PageContents] ([Name],[Contents]) Values (?,?); " & _
		" SELECT SCOPE_IDENTITY() "
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection = DbOpenConnection()
		objCommand.NamedParameters  = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Name, obj.Contents)) then
			Set execResult = objCommand.Execute
			Set execResult = execResult.NextRecordSet()
		End If
		obj.No = CInt(execResult(0))
		Insert = true
	end function


	public function Update(obj)
		Dim strSQL
		strSQL= "Update [PageContents] set [Contents]=? Where [No] = ? "
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Contents, obj.No )) then
			objCommand.Execute
			Update = true
		Else
			Update = false
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


	private function PopulateObjectFromRecord(record)
		if record.eof then
			Set PopulateObjectFromRecord = Nothing
	    else
			Dim obj
			set obj = new Page
	        
			obj.No       = record("No")
			obj.Name     = record("Name")
			obj.Contents = record("Contents")
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>    