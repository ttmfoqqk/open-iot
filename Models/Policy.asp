<%
class Policy

	private mMetadata

	'=============================
	'Private properties
	private mPolicy1
	private mPolicy2

	private sub Class_Initialize()
		mMetadata = Array("Policy1",  "Policy2")
	end sub

	private sub Class_Terminate()
	end sub

	'=============================
	'public properties
	public property get Policy1()
		Policy1 = mPolicy1
	end property

	public property let Policy1(val)
		mPolicy1 = val
	end property
	
	public property get Policy2()
		Policy2 = mPolicy2
	end property

	public property let Policy2(val)
		mPolicy2 = val
	end property

	public property get metadata()
		metadata = mMetadata
	end property

end class 'Policy

class PolicyHelper

	Dim selectSQL

	private sub Class_Initialize()
		selectSQL = " SELECT * FROM [Policy] "
	end sub

	private sub Class_Terminate()
	end sub
	
	public function SelectAll()
		Dim record
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = selectSQL
		objCommand.CommandType = adCmdText
		
		set record = objCommand.Execute
		Set SelectAll = PopulateObjectFromRecord(record)
		record.Close
		set record = nothing
	end function


	' Update the User
	public function Update(obj)
		Dim strSQL
		strSQL= "Update [Policy] set [Policy1]=?  , [Policy2]=? " 
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Policy1, obj.Policy2 )) then
			objCommand.Execute
			Update = true
		Else
			Update = false
		End If
 
	end function
	

	private function PopulateObjectFromRecord(record)
		if record.eof then 
			Set PopulateObjectFromRecord = Nothing
	    else
			Dim obj
			set obj = new Policy
	        
			obj.Policy1 = record("Policy1")
			obj.Policy2 = record("Policy2")
			set PopulateObjectFromRecord = obj
		end if
	end function

end class 'PolicyHelper
%>
    