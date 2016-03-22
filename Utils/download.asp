<%
On Error Resume Next

pach = Server.MapPath(Request("pach"))
file = Request("file")
'파일 이름

Response.ContentType = "application/unknown"

Dim OsInformation : OsInformation = Request.ServerVariables("HTTP_USER_AGENT")

If instr(OsInformation, "MSIE" ) > 0 Then
	Response.AddHeader "Content-Disposition","attachment; filename=""" & Server.URLPathEncode( file ) & ""
End If

Set objDownload = Server.CreateObject("DEXT.FileDownload")
objDownload.Download pach & "\" & file
Set objDownload = Nothing 

If Err Then
	Response.Write "File not found"
	'Response.Write Err.Description
End If
%>
