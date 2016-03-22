<%
class BoardList
	private mNo
	private mCode
	private mTypes
	private mName
	private mOrder
	private mDelFg

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
	
	public property get Code()
		Code = mCode
	end property
	public property let Code(val)
		mCode = val
	end property
	
	public property get Types()
		Types = mTypes
	end property
	public property let Types(val)
		mTypes = val
	end property
	
	public property get Name()
		Name = mName
	end property
	public property let Name(val)
		mName = val
	end property
	
	public property get Order()
		Order = mOrder
	end property
	public property let Order(val)
		Order = val
	end property
	
	public property get DelFg()
		DelFg = mDelFg
	end property
	public property let DelFg(val)
		DelFg = val
	end property

end class 

class BoardListHelper

	Dim selectSQL

	private sub Class_Initialize()
		selectSQL = " SELECT * FROM [BoardList] "
	end sub

	private sub Class_Terminate()
	end sub
	
	public function SelectAll()
		Dim records
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = selectSQL & " Where DelFg = 0 order by [Order] ASC"
		objCommand.CommandType = adCmdText
		set records = objCommand.Execute

		if records.eof then
			Set SelectAll = Nothing
		else
			Dim results, obj, record
			Set results = Server.CreateObject("Scripting.Dictionary")
			while not records.eof
				set obj = PopulateObjectFromRecord(records)
				results.Add obj.Id, obj
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
		objCommand.CommandText = selectSQL + " Where " & fieldName & "=? and [DelFg] = 0 order by [Order] desc"
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
			set obj = new BoardList
	        
			obj.No    = record("No")
			obj.Code  = record("Code")
			obj.Types = record("Type")
			obj.Name  = record("Name")
			obj.Order = record("Order")
			obj.DelFg = record("DelFg")
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>    