<!--#include file="LoginController.asp" -->
<!--#include file="CompanyController.asp" -->
<%
Public Controllers : Set Controllers = Server.CreateObject("Scripting.Dictionary")
	Controllers.Add "LoginController", ""
	Controllers.Add "CompanyController", ""
%>