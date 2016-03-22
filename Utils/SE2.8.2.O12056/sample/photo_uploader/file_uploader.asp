<%@Language="VBScript" CODEPAGE="65001" %>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
%>
<!-- #include file = "../../../utils.asp" -->
<%
Dim uploadPath : uploadPath = "/upload/SmtEdit/"
Dim savePath   : savePath   = server.mapPath( uploadPath ) & "/"

Set UPLOAD__FORM = Server.CreateObject("DEXT.FileUpload") 
UPLOAD__FORM.AutoMakeFolder = True 
UPLOAD__FORM.CodePage = 65001
UPLOAD__FORM.DefaultPath = savePath

Dim upload_file   : upload_file   = UPLOAD__FORM("Filedata")
Dim callback_func : callback_func = UPLOAD__FORM("callback_func")

If upload_file <> "" Then
	upload_file = DextFileUpload(UPLOAD__FORM("Filedata"), savePath , False)
End If

Dim url : url = uploadPath & upload_file

Response.redirect "callback.html?callback_func=" & callback_func & "&bNewLine=true&sFileName=" & upload_file & "&sFileURL=" & url
%>