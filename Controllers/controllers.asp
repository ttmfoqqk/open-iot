<!--#include file="MainController.asp" -->
<!--#include file="IoTOpenLab.asp" -->
<!--#include file="DeveloperSupport.asp" -->
<!--#include file="DevicesApps.asp" -->
<!--#include file="Community.asp" -->
<!--#include file="Oid.asp" -->
<!--#include file="Member.asp" -->
<!--#include file="Mypage.asp" -->
<!--#include file="DevicesAppsBoardController.asp" -->
<!--#include file="Company.asp" -->

<%
Public Controllers : Set Controllers = Server.CreateObject("Scripting.Dictionary")
	Controllers.Add "MainController", ""
	Controllers.Add "IoTOpenLabController", ""
	Controllers.Add "DeveloperSupportController", ""
	Controllers.Add "DevicesAppsController", ""
	Controllers.Add "CommunityController", ""
	Controllers.Add "OidController", ""
	Controllers.Add "MemberController", ""
	Controllers.Add "MypageController", ""
	Controllers.Add "DevicesAppsBoardController", ""
	Controllers.Add "CompanyController", ""
%>