<%
class AppsMenu
	private mRowNum
	private mtcount
	private mNo
	private mName
	private mOrderNo

	private sub Class_Initialize()
		mName = ""
	end sub

	private sub Class_Terminate()
		'
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
	
	public property get Name()
		Name = mName
	end property
	public property let Name(val)
		mName = val
	end property
	
	public property get OrderNo()
		OrderNo = mOrderNo
	end property
	public property let OrderNo(val)
		mOrderNo = val
	end property

end class



class AppsMenuHelper

	Dim selectSQL

	private sub Class_Initialize()
		selectSQL = " SELECT ROW_NUMBER() OVER (Order by [OrderNo] ASC,[No] DESC) AS [RowNum],count(*) over () as [tcount],* FROM [AppsMenu] "
	end sub

	private sub Class_Terminate()
	end sub
	
	public function Insert(ByRef obj)
		Dim strSQL , execResult
		strSQL= " Insert into [AppsMenu] (Name,[OrderNo]) " & _
		" Values (?,?); " & _
		" SELECT SCOPE_IDENTITY() "
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection = DbOpenConnection()
		objCommand.NamedParameters  = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Name,obj.OrderNo)) then
			Set execResult = objCommand.Execute
			Set execResult = execResult.NextRecordSet()
		End If
		obj.No = CInt(execResult(0))
		Insert = true
	end function

	
	public function SelectAll(objs,pageNo,rows)
		Dim records,selectSQL
		dim whereSql : whereSql = ""

		pageNo = iif( pageNo="",1,pageNo )
		rows   = iif( rows="",10,rows )

		if objs.Name <> "" then
			whereSql = whereSql & " and Name like '%@Name%' "
		end if

		selectSQL = "" &_
		" SET NOCOUNT ON;  " &_
		" DECLARE @Name VARCHAR(200); " &_
		" SET @Name = ?; " &_
		" WITH LIST AS (  " &_
				" SELECT " &_
				"  ROW_NUMBER() OVER (Order by [OrderNo] DESC,[No] ASC) AS RowNum " &_
				" ,count(*) over () as [tcount] " &_
				" ,* " &_
			" FROM [AppsMenu] " &_
			" WHERE [No] is not null " &_
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
			.Parameters.Append .CreateParameter( "@Name" ,adVarChar , adParamInput, 200 , objs.Name )
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
			"  ROW_NUMBER() OVER (Order by [OrderNo] ASC,[No] DESC) AS RowNum " &_
			" ,count(*) over () as [tcount] " &_
			" ,* " &_
		" FROM [AppsMenu] " &_
		" WHERE " & fieldName & " = ? "

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


	public function Update(obj)
		Dim strSQL
		strSQL= "Update [AppsMenu] set [Name] = ?, [OrderNo] = ? Where No = ? "
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Name,obj.OrderNo,obj.No)) then
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
		
		" DELETE FROM [AppsMenu] WHERE No in(SELECT T_INT FROM @T); "
		
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
			set obj = new AppsMenu
			obj.RowNum  = record("RowNum")
			obj.tcount  = record("tcount")
			obj.No      = record("No")
			obj.Name    = record("Name")
			obj.OrderNo = record("OrderNo")
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>
    