<header>
	<div id="header">
		<div class="max_width_wrap">
			<a href="/"><h1 class="logo"><span class="blind">OPEN-IOT</span></h1></a>
			<div class="member">
			<%If session("userNo")="" or IsNull(session("userNo"))=True Then %>
				<a href="?controller=Member&action=Login" class="btn1">Login</a>
				<a href="?controller=Member&action=Registe" class="btn2">Join</a>
			<%else%>
				<a href="?controller=Member&action=Logout&partial=True" class="btn1">Logout</a>
				<a href="?controller=Mypage&action=Modify" class="btn2">Mypage</a>
			<%End If%>
			</div>
			
			<nav>
				<ul>
					<li class="item item1"><a class="<%=iif(controller = "IoTOpenLab","active","")%>" href="?controller=IoTOpenLab&action=About">IoT OpenLab</a></li>
					<li class="item item2"><a class="<%=iif(controller = "DeveloperSupport","active","")%>" href="?controller=DeveloperSupport&action=Device">Dev Support</a></li>
					<li class="item item3"><a class="<%=iif(controller = "DevicesApps","active","")%>" href="?controller=DevicesApps&action=DevicesList">Devices & Apps</a></li>
					<li class="item item4"><a class="<%=iif(controller = "Community","active","")%>" href="?controller=Community&action=List&Board=Notice">Community</a></li>
					<li class="item item5"><a class="<%=iif(controller = "Oid","active","")%>" href="?controller=Oid&action=About">OID</a></li>
				</ul>
				<div id="top_nav_line" class="nav_line"></div>
			</nav>
			
		</div>
	</div>
</header>