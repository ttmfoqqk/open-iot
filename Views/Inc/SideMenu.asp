<aside>
	<div class="inner">
		<%if controller = "IoTOpenLab" then %>
		<div class="title">IoT OpenLab</div>
		<ul>
			<li><a class="<%=iif(action="About","active","")%>" href="?controller=IoTOpenLab&action=About">About OpenLab</a></li>
			<li><a class="<%=iif(action="Facility","active","")%>" href="?controller=IoTOpenLab&action=Facility">Facility</a></li>
			<li><a class="<%=iif(action="Reservation","active","")%>" href="?controller=IoTOpenLab&action=Reservation">OpenLab Reservation</a></li>
		</ul>
		<%end if%>

		<%if controller = "DeveloperSupport" then %>
		<div class="title">Developer Support</div>
		<ul>
			<li><a class="<%=iif(action="Device","active","")%>" href="?controller=DeveloperSupport&action=Device">Device Developer</a></li>
			<li><a class="<%=iif(action="App","active","")%>" href="?controller=DeveloperSupport&action=App">App Developer</a></li>
		</ul>
		<%end if%>

		<%if controller = "Community" then %>
		<div class="title">Community</div>
		<ul>
			<li><a href="?controller=Community">Notice</a></li>
			<li><a href="?controller=Community">1:1 Inquiry</a></li>
			<li><a href="?controller=Community&action=Gallery">News</a></li>
			<li><a href="?controller=Community">Forum</a></li>
		</ul>
		<%end if%>

		<%if controller = "Oid" then %>
		<div class="title">OID</div>
		<ul>
			<li><a class="<%=iif(action="About","active","")%>" href="?controller=Oid&action=About">About OID</a></li>
			<li><a class="<%=iif(action="Registe","active","")%>" href="?controller=Oid&action=Registe">Get OID</a></li>
		</ul>
		<%end if%>
		
		<%if controller = "Mypage" then %>
		<div class="title">My Page</div>
		<ul>
			<li><a class="<%=iif(action="Modify","active","")%>" href="?controller=Mypage&action=Modify">회원정보수정</a></li>
			<li><a class="<%=iif(action="Inquiry","active","")%>" href="?controller=Mypage&action=Inquiry">1:1 Inquiry</a></li>
			<li><a class="<%=iif(action="Qna","active","")%>" href="?controller=Mypage&action=Qna">나의 Q&A</a></li>
			<li><a class="<%=iif(action="Oid","active","")%>" href="?controller=Mypage&action=Oid">OID 현황</a></li>
			<li><a class="<%=iif(action="DevicesApps","active","")%>" href="?controller=Mypage&action=DevicesApps">Devices & Apps 관리</a></li>
			<li><a class="<%=iif(action="Secede","active","")%>" href="?controller=Mypage&action=Secede">탈퇴신청</a></li>
		</ul>
		<%end if%>
	</div>
</aside>