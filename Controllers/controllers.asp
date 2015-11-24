<!--#include file="MainController.asp" -->
<!--#include file="IoTOpenLab.asp" -->
<!--#include file="DeveloperSupport.asp" -->
<!--#include file="DevicesApps.asp" -->
<!--#include file="Community.asp" -->
<!--#include file="Oid.asp" -->

<%
Public Controllers : Set Controllers = Server.CreateObject("Scripting.Dictionary")
	Controllers.Add "MainController", ""
	Controllers.Add "IoTOpenLabController", ""
	Controllers.Add "DeveloperSupportController", ""
	Controllers.Add "DevicesAppsController", ""
	Controllers.Add "CommunityController", ""
	Controllers.Add "OidController", ""
%>