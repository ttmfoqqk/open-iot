<aside>
	<div class="inner">
		<%if controller = "IoTOpenLab" then %>
		<div class="title">IoT OpenLab</div>
		<ul>
			<li><a href="#">About OpenLab</a></li>
			<li><a href="#">Facility</a></li>
			<li><a href="#">OpenLab Reservation</a></li>
		</ul>
		<%end if%>

		<%if controller = "DeveloperSupport" then %>
		<div class="title">Developer Support</div>
		<ul>
			<li><a href="#">Device Developer</a></li>
			<li><a href="#">App Developer</a></li>
		</ul>
		<%end if%>

		<%if controller = "Community" then %>
		<div class="title">Community</div>
		<ul>
			<li><a href="#">Notice</a></li>
			<li><a href="#">1:1 Inquiry</a></li>
			<li><a href="#">News</a></li>
			<li><a href="#">Forum</a></li>
		</ul>
		<%end if%>

		<%if controller = "Oid" then %>
		<div class="title">OID</div>
		<ul>
			<li><a href="#">About OID</a></li>
			<li><a href="#">Get OID</a></li>
		</ul>
		<%end if%>
	</div>
</aside>