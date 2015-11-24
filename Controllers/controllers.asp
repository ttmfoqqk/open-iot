<!--#include file="MainController.asp" -->
<!--#include file="IoTOpenLab.asp" -->

<%
Public Controllers : Set Controllers = Server.CreateObject("Scripting.Dictionary")
	Controllers.Add "MainController", ""
	Controllers.Add "IoTOpenLabController", ""
%>