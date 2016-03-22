<aside>
	<div class="inner">
		<%if controller = "IoTOpenLab" then %>
		<div class="title"><div><label></label>IoT OpenLab</div></div>
		<ul>
			<li><a class="<%=iif(action="About","active","")%>" href="?controller=IoTOpenLab&action=About">About OpenLab</a></li>
			<li><a class="<%=iif(action="Facility","active","")%>" href="?controller=IoTOpenLab&action=Facility">Facility</a></li>
			<li><a class="<%=iif(action="Reservations","active","")%>" href="?controller=IoTOpenLab&action=Reservations">OpenLab Reservation</a></li>
		</ul>
		<%end if%>

		<%if controller = "DeveloperSupport" then %>
		<div class="title"><div><label></label>Developer Support</div></div>
		<ul>
			<li><a class="<%=iif(action="Device","active","")%>" href="?controller=DeveloperSupport&action=Device">Device Developer</a></li>
			<li><a class="<%=iif(action="App","active","")%>" href="?controller=DeveloperSupport&action=App">App Developer</a></li>
		</ul>
		<%end if%>

		<%if controller = "Community" then %>
		<div class="title"><div><label></label>Community</div></div>
		<ul>
			<li><a class="<%=iif(Request("Board")="Notice","active","")%>" href="?controller=Community&action=List&Board=Notice">Notice</a></li>
			<li><a class="<%=iif(Request("Board")="Inquiry","active","")%>" href="?controller=Community&action=List&Board=Inquiry">1:1 Inquiry</a></li>
			<li><a class="<%=iif(Request("Board")="News","active","")%>" href="?controller=Community&action=List&Board=News">News</a></li>
			<li><a class="<%=iif(Request("Board")="Forum","active","")%>" href="?controller=Community&action=List&Board=Forum">Forum</a></li>
		</ul>
		<%end if%>

		<%if controller = "Oid" then %>
		<div class="title"><div><label></label>OID</div></div>
		<ul>
			<li><a class="<%=iif(action="About","active","")%>" href="?controller=Oid&action=About">About OID</a></li>
			<li><a class="<%=iif(action="Registe","active","")%>" href="?controller=Oid&action=Registe">Get OID</a></li>
		</ul>
		<%end if%>
		
		<%if controller = "Mypage" then %>
		<div class="title"><div><label></label>My Page</div></div>
		<ul>
			<li><a class="<%=iif(action="Modify","active","")%>" href="?controller=Mypage&action=Modify">회원정보수정</a></li>
			<li><a class="<%=iif(action="Inquiry","active","")%>" href="?controller=Mypage&action=Inquiry">1:1 Inquiry</a></li>
			<li><a class="<%=iif(action="Qna","active","")%>" href="?controller=Mypage&action=Qna">나의 Q&A</a></li>
			<li><a class="<%=iif(action="Oid","active","")%>" href="?controller=Mypage&action=Oid">기업/OID 관리</a></li>
			<li><a class="<%=iif(action="Reservations","active","")%>" href="?controller=Mypage&action=Reservations">OpenLab 예약신청 내역</a></li>
			<li><a class="<%=iif(action="DevicesApps" or action="DnABoard" ,"active","")%>" href="?controller=Mypage&action=DevicesApps">Devices & Apps 관리</a></li>
			<li><a class="<%=iif(action="Secede","active","")%>" href="?controller=Mypage&action=Secede">탈퇴신청</a></li>
		</ul>
		<%end if%>
		
		<%if controller = "Company" then %>
		<div class="title"><div><label></label>Company</div></div>
		<ul>
			<li><a class="<%=iif(action="Index","active","")%>" href="?controller=Company&action=Index">사이트소개</a></li>
			<li><a class="<%=iif(action="Use","active","")%>" href="?controller=Company&action=Use">이용약관</a></li>
			<li><a class="<%=iif(action="Policy","active","")%>" href="?controller=Company&action=Policy">개인정보취급방침</a></li>
		</ul>
		<%end if%>
	</div>
</aside>