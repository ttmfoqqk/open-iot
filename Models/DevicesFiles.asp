<%
class DevicesFiles
	private mNo
	private mParentNo
	private mName

	private sub Class_Initialize()
		
	end sub

	private sub Class_Terminate()
		'
	end sub
	
	public property get No()
		No = mNo
	end property
	public property let No(val)
		mNo = val
	end property

	public property get ParentNo()
		ParentNo = mParentNo
	end property
	public property let ParentNo(val)
		mParentNo = val
	end property
	
	public property get Name()
		Name = mName
	end property
	public property let Name(val)
		mName = val
	end property

end class

class DevicesFilesHelper

	Dim selectSQL

	private sub Class_Initialize()
		selectSQL = " SELECT * FROM [DevicesFiles] "
	end sub

	private sub Class_Terminate()
	end sub
	
	public function Insert(ByRef obj)
		Dim strSQL , execResult
		strSQL= " Insert into [DevicesFiles] (ParentNo,Name)" & _
		" Values (?,?); " & _
		" SELECT SCOPE_IDENTITY()  "
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection = DbOpenConnection()
		objCommand.NamedParameters  = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.ParentNo,obj.Name)) then
			Set execResult = objCommand.Execute
			Set execResult = execResult.NextRecordSet()
		End If
		obj.No = CInt(execResult(0))
		Insert = true
	end function

	
	public function SelectByField(fieldName, value)
          Dim records
          set objCommand=Server.CreateObject("ADODB.command")
          objCommand.ActiveConnection=DbOpenConnection()
          objCommand.NamedParameters = False
          objCommand.CommandText = selectSQL + " where " + fieldName + "=?"
          objCommand.CommandType = adCmdText
          If DbAddParameters(objCommand, array(value)) Then
              set records = objCommand.Execute
              if records.eof then
                  Set SelectByField = Nothing
              else
                  Dim results, obj, record
                  Set results = Server.CreateObject("Scripting.Dictionary")
                  while not records.eof
                      set obj = PopulateObjectFromRecord(records)
                      results.Add obj.No, obj
                      records.movenext
                  wend
                  set SelectByField = results
                  records.Close
              End If
                set records = nothing
          Else
              set SelectByField = Nothing
          End If
      end function

 	public function Delete(No)
		Dim strSQL
		strSQL= "DELETE FROM [DevicesFiles] WHERE No = ? "

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
	
	
	

	private function PopulateObjectFromRecord(record)
		if record.eof then 
			Set PopulateObjectFromRecord = Nothing
	    else
			Dim obj
			set obj = new DevicesFiles
			obj.No        = record("No")
			obj.ParentNo  = record("ParentNo")
			obj.Name      = record("Name")
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>
    