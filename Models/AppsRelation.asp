<%
class AppsRelation
	private mNo
	private mParentNo
	private mProductNo
	private mProductName
	private mProductContents
	private mImages1
	private mImages2
	private mImages3
	private mImages4
	private mImagesList

	private sub Class_Initialize()
		'
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
	
	public property get ProductNo()
		ProductNo = mProductNo
	end property
	public property let ProductNo(val)
		mProductNo = val
	end property
	
	public property get ProductName()
		ProductName = mProductName
	end property
	public property let ProductName(val)
		mProductName = val
	end property
	
	public property get ProductContents()
		ProductContents = mProductContents
	end property
	public property let ProductContents(val)
		mProductContents = val
	end property
	
	
	public property get Images1()
		Images1 = mImages1
	end property
	public property let Images1(val)
		mImages1 = val
	end property
	
	public property get Images2()
		Images2 = mImages2
	end property
	public property let Images2(val)
		mImages2 = val
	end property
	
	public property get Images3()
		Images3 = mImages3
	end property
	public property let Images3(val)
		mImages3 = val
	end property
	
	public property get Images4()
		Images4 = mImages4
	end property
	public property let Images4(val)
		mImages4 = val
	end property
	
	public property get ImagesList()
		ImagesList = mImagesList
	end property
	public property let ImagesList(val)
		mImagesList = val
	end property

end class

class AppsRelationHelper

	Dim selectSQL

	private sub Class_Initialize()
		selectSQL = "" &_
		" SELECT " &_
			" A.*,B.Name AS ProductName,B.Contents1 AS ProductContents ,B.Images1,B.Images2,B.Images3,B.Images4,B.ImagesList " &_ 
		" FROM [AppsRelation] AS A " &_
		" INNER JOIN [Devices] AS B " &_
		" ON(A.ProductNo = B.No and B.State = 0) " &_
		" INNER JOIN [User] AS C ON(B.UserNo = C.No AND C.Delfg = 0 ) "
	end sub

	private sub Class_Terminate()
	end sub
	
	public function Insert(ByRef obj)
		Dim strSQL , execResult
		strSQL= " Insert into [AppsRelation] (ParentNo,ProductNo)" & _
		" Values (?,?); " & _
		" SELECT SCOPE_IDENTITY()  "
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection = DbOpenConnection()
		objCommand.NamedParameters  = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.ParentNo,obj.ProductNo)) then
			Set execResult = objCommand.Execute
			Set execResult = execResult.NextRecordSet()
		End If
		obj.No = CInt(execResult(0))
		Insert = true
	end function
	
	
	
	public function SelectAll(No)
		Dim records,selectSQL
		selectSQL = "" &_
		" SET NOCOUNT ON;  " &_
		" DECLARE @No INT; " &_
		" SET @No = ?; " &_
		
		" DECLARE @S VARCHAR (MAX); " &_
		" DECLARE @T TABLE(T_INT INT); " &_
		
		" INSERT INTO @T(T_INT) select [ProductNo] from [AppsRelation] where [ParentNo]=@No " &_
		" INSERT INTO @T(T_INT) select [ParentNo] from [DevicesRelation] where [ProductNo]=@No " &_
		
		" SELECT " &_
			"  0 AS [No] " &_
			" ,@No AS [ParentNo] " &_
			" ,[Devices].No AS [ProductNo] " &_
			" ,[Devices].Name AS ProductName " &_
			" ,[Devices].Contents1 AS ProductContents " &_
			" ,[Devices].Images1 " &_
			" ,[Devices].Images2 " &_
			" ,[Devices].Images3 " &_
			" ,[Devices].Images4 " &_
			" ,[Devices].ImagesList " &_
		" FROM [Devices] AS [Devices] " &_
		" INNER JOIN [User] AS [User] ON([Devices].UserNo = [User].No) " &_
		" WHERE [Devices].[State] = 0 " &_
		" AND [User].[DelFg] = 0 " &_
		" AND [Devices].[No] IN( select T_INT from @T group by T_INT ) " &_
		" ORDER BY [Devices].No DESC "
		
		
		set objCommand=Server.CreateObject("ADODB.command") 
		With objCommand
			.ActiveConnection=DbOpenConnection()
			.prepared = true
			.CommandType = adCmdText
			.CommandText = selectSQL
			.Parameters.Append .CreateParameter( "@No" ,adVarChar , adParamInput, 200 , No )
		End With
  		
  		set records = objCommand.Execute
  		if records.eof then
			Set SelectAll = Nothing
		else
			Dim results, obj, record
			Set results = Server.CreateObject("Scripting.Dictionary")
			while not records.eof
				set obj = PopulateObjectFromRecord(records)
				results.Add obj.ProductNo, obj
				records.movenext
			wend
			set SelectAll = results
			records.Close
		End If
		set records = nothing
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
		strSQL= "DELETE FROM [AppsRelation] WHERE No = ? "

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
			set obj = new AppsRelation
			obj.No        = record("No")
			obj.ParentNo  = record("ParentNo")
			obj.ProductNo = record("ProductNo")
			obj.ProductName = record("ProductName")
			obj.ProductContents = record("ProductContents")
			obj.Images1 = record("Images1")
			obj.Images2 = record("Images2")
			obj.Images3 = record("Images3")
			obj.Images4 = record("Images4")
			obj.ImagesList = record("ImagesList")
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>
    