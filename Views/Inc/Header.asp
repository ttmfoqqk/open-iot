<header>
	<div id="header">
		<div class="max_width_wrap">
			<a href="/"><h1 class="logo"><span class="blind">OPEN-IOT</span></h1></a>
			<div class="member">
				<a href="?controller=Member&action=Login" class="btn1">Login</a>
				<a href="?controller=Member&action=Registe" class="btn2">Join</a>
			</div>
			
			<nav>
				<ul>
					<li class="item item1"><a class="<%=iif(controller = "IoTOpenLab","active","")%>" href="?controller=IoTOpenLab">IoT OpenLab</a></li>
					<li class="item item2"><a class="<%=iif(controller = "DeveloperSupport","active","")%>" href="?controller=DeveloperSupport">Developer Support</a></li>
					<li class="item item3"><a class="<%=iif(controller = "DevicesApps","active","")%>" href="?controller=DevicesApps">Devices & Apps</a></li>
					<li class="item item4"><a class="<%=iif(controller = "Community","active","")%>" href="?controller=Community">Community</a></li>
					<li class="item item5"><a class="<%=iif(controller = "Oid","active","")%>" href="?controller=Oid">OID</a></li>
				</ul>
				<div id="top_nav_line" class="nav_line"></div>
			</nav>
			
		</div>
	</div>
</header>