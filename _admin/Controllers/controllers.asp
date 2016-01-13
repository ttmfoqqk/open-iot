<!--#include file="LoginController.asp" -->
<!--#include file="CompanyController.asp" -->
<!--#include file="PageController.asp" -->
<!--#include file="UserController.asp" -->
<!--#include file="CommunityController.asp" -->
<!--#include file="DevicesAppsController.asp" -->
<!--#include file="ReservationController.asp" -->
<%
Public Controllers : Set Controllers = Server.CreateObject("Scripting.Dictionary")
	Controllers.Add "LoginController", ""
	Controllers.Add "CompanyController", ""
	Controllers.Add "PageController", ""
	Controllers.Add "UserController", ""
	Controllers.Add "CommunityController", ""
	Controllers.Add "DevicesAppsController", ""
	Controllers.Add "ReservationController", ""
%>