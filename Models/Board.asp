<%
class Board

	private mMetadata
	'=============================
	'Private properties
	private mNo
	private mCode
	private mParentNo
	private mOrderNo
	private mDepthNo
	private mUserNo
	private mTitle
	private mContents
	private mContentsNoHtml
	private mNotice
	private mDelFg
	private mReadCnt
	private mFileCnt
	private mReplyCnt
	private mIp
	private mIndate
	private mAdminNo

	private sub Class_Initialize()
		mMetadata = Array("No","Code","ParentNo","OrderNo","DepthNo","UserNo","Title","Contents","ContentsNoHtml","Notice","DelFg","ReadCnt","FileCnt","ReplyCnt","Ip","Indate","AdminNo")
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
	
	public property get Code()
		Code = mCode
	end property
	public property let Code(val)
		mCode = val
	end property
	
	public property get ParentNo()
		ParentNo = mParentNo
	end property
	public property let ParentNo(val)
		mParentNo = val
	end property
	
	public property get OrderNo()
		OrderNo = mOrderNo
	end property
	public property let OrderNo(val)
		mOrderNo = val
	end property
	
	public property get DepthNo()
		DepthNo = mDepthNo
	end property
	public property let DepthNo(val)
		mDepthNo = val
	end property
	
	public property get UserNo()
		UserNo = mUserNo
	end property
	public property let UserNo(val)
		mUserNo = val
	end property
	
	public property get Title()
		Title = mTitle
	end property
	public property let Title(val)
		mTitle = val
	end property
	
	public property get Contents()
		Contents = mContents
	end property
	public property let Contents(val)
		mContents = val
	end property
	
	public property get ContentsNoHtml()
		ContentsNoHtml = mContentsNoHtml
	end property
	public property let ContentsNoHtml(val)
		mContentsNoHtml = val
	end property
	
	public property get Notice()
		Notice = mNotice
	end property
	public property let Notice(val)
		mNotice = val
	end property
	
	public property get DelFg()
		DelFg = mDelFg
	end property
	public property let DelFg(val)
		mDelFg = val
	end property
	
	public property get ReadCnt()
		ReadCnt = mReadCnt
	end property
	public property let ReadCnt(val)
		mReadCnt = val
	end property
	
	public property get FileCnt()
		FileCnt = mFileCnt
	end property
	public property let FileCnt(val)
		mFileCnt = val
	end property
	
	public property get ReplyCnt()
		ReplyCnt = mReplyCnt
	end property
	public property let ReplyCnt(val)
		mReplyCnt = val
	end property
	
	public property get Ip()
		Ip = mIp
	end property
	public property let Ip(val)
		mIp = val
	end property
	
	public property get Indate()
		Indate = mIndate
	end property
	public property let Indate(val)
		mIndate = val
	end property
	
	public property get AdminNo()
		AdminNo = mAdminNo
	end property
	public property let AdminNo(val)
		mAdminNo = val
	end property

	public property get metadata()
		metadata = mMetadata
	end property

end class

class BoardHelper

	Dim selectSQL

	private sub Class_Initialize()
		selectSQL = " SELECT * FROM [Board] "
	end sub

	private sub Class_Terminate()
	end sub
	
	public function Insert(ByRef obj)
		Dim strSQL , execResult
		strSQL= " Insert into [Board] (Code,ParentNo,OrderNo,DepthNo,UserNo,Title,Contents,ContentsNoHtml,Notice,DelFg,ReadCnt,FileCnt,ReplyCnt,Ip,Indate,AdminNo)" & _
		" Values (?,?,?,?,?,?,?,?,?,0,0,0,0,?,GETDATE(),?); " & _
		" SELECT SCOPE_IDENTITY()  "
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection = DbOpenConnection()
		objCommand.NamedParameters  = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Code, obj.ParentNo, obj.OrderNo, obj.DepthNo, obj.UserNo, obj.Title, obj.Contents, obj.ContentsNoHtml, obj.Notice, obj.Ip, obj.AdminNo )) then
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

		whereSql = whereSql & " and [Board].Code = @Code "

		if objs.UserNo <> 0 then
			whereSql = whereSql & " and [User].No = @UserNo "
		end if
		
		if objs.Title <> "" then
			whereSql = whereSql & " and [Board].Title like '%@ContentsNoHtml%' "
		end if
		
		if objs.ContentsNoHtml <> "" then
			whereSql = whereSql & " and [Board].ContentsNoHtml like '%ContentsNoHtml%' "
		end if

		selectSQL = "" &_
		" SET NOCOUNT ON;  " &_
		" DECLARE @Code INT, @UserNo INT , @Title VARCHAR(200) ,@ContentsNoHtml VARCHAR(200); " &_
		
		" SET @Code = ?; " &_
		" SET @UserNo = ?; " &_
		" SET @Title = ?; " &_
		" SET @ContentsNoHtml = ?; " &_
		
		" SELECT * FROM ( " &_
				" SELECT " &_
				"  ROW_NUMBER() OVER (order by [Board].[ParentNo] ASC, [Board].[OrderNo] DESC) AS RowNum " &_
				" ,count(*) over () as [tcount] " &_
				" ,[Board].* " &_
				" ,[User].Id AS UserId " &_
				" ,[User].Name AS UserName " &_
				" ,[Admin].Id AS AdminId " &_
				" ,[Admin].Name AS AdminName " &_
			" FROM [Board] AS [Board] " &_
			" LEFT JOIN [User] AS [User] ON([Board].UserNo = [User].No) " &_
			" LEFT JOIN [Admin] AS [Admin] ON([Board].AdminNo = [Admin].No) " &_
			" WHERE ([Board].DelFg = 0 OR ([Board].DelFg = 1 AND [Board].ReplyCnt > 0) ) " &_
			whereSql &_
		" ) AS List " &_
		" WHERE RowNum BETWEEN " & ((pageNo - 1) * rows) + 1 & " AND " & ((pageNo - 1) * rows) + rows & " "
		
		set objCommand=Server.CreateObject("ADODB.command") 
		With objCommand
			.ActiveConnection=DbOpenConnection()
			.prepared = true
			.CommandType = adCmdText
			.CommandText = selectSQL
			.Parameters.Append .CreateParameter( "@Code" ,adInteger , adParamInput, 0 , objs.Code )
			.Parameters.Append .CreateParameter( "@UserNo" ,adInteger , adParamInput, 0 , objs.UserNo )
			.Parameters.Append .CreateParameter( "@Title" ,adVarChar , adParamInput, 200 , objs.Title )
			.Parameters.Append .CreateParameter( "@ContentsNoHtml"  ,adVarChar , adParamInput,200 , objs.ContentsNoHtml )
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
		Dim record
		set objCommand=Server.CreateObject("ADODB.command")
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = selectSQL + " Where " & fieldName & "=? and [DelFg] = 0 "
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
		strSQL= "Update [Board] set [Title] = ? , [Contents] = ? , [ContentsNoHtml] = ? , [Notice] = ? Where No = ? "
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(obj.Title, obj.Contents, obj.ContentsNoHtml, obj.Notice, obj.No)) then
			objCommand.Execute
			Update = true
		Else
			Update = false
		End If
 	end function
 	
 	public function UpdateByField(fieldName, value, No)
		Dim strSQL
		strSQL= "Update [Board] set " & fieldName & " = ? Where No = ? "
		set objCommand=Server.CreateObject("ADODB.command") 
		objCommand.ActiveConnection=DbOpenConnection()
		objCommand.NamedParameters = False
		objCommand.CommandText = strSQL
		objCommand.CommandType = adCmdText

		if DbAddParameters(objCommand, Array(value, No)) then
			objCommand.Execute
			UpdateByField = true
		Else
			UpdateByField = false
		End If
 	end function
	

	private function PopulateObjectFromRecord(record)
		if record.eof then 
			Set PopulateObjectFromRecord = Nothing
	    else
			Dim obj
			set obj = new Policy
			obj.No             = record("No")
			obj.Code           = record("Code")
			obj.ParentNo       = record("ParentNo")
			obj.OrderNo        = record("OrderNo")
			obj.DepthNo        = record("DepthNo")
			obj.UserNo         = record("UserNo")
			obj.Title          = record("Title")
			obj.Contents       = record("Contents")
			obj.ContentsNoHtml = record("ContentsNoHtml")
			obj.Notice         = record("Notice")
			obj.DelFg          = record("DelFg")
			obj.ReadCnt        = record("ReadCnt")
			obj.FileCnt        = record("FileCnt")
			obj.ReplyCnt       = record("ReplyCnt")
			obj.Ip             = record("Ip")
			obj.Indate         = record("Indate")
			obj.AdminNo        = record("AdminNo")
			set PopulateObjectFromRecord = obj
		end if
	end function

end class
%>
    