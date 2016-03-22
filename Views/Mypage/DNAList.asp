<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue">Devices & Apps 관리</h2>
			<div class="sub_title_description">Devices & Apps <b>상품 및 고객관리</b></div>
			<span class="sub_navigation">My Page <span class="bar">></span> <b>Devices & Apps 관리</b></span>
			
			<div class="sub_description">
				<form method="get">
				<input type="hidden" name="controller" value="<%=controller%>">
				<input type="hidden" name="action" value="<%=action%>">
				<input type="hidden" name="Code" value="<%=Code%>">
				<input type="hidden" name="Types" value="<%=Types%>">
				<input type="hidden" name="ProductNo" value="<%=ProductNo%>">
				
				<div class="bbs_search">
					<div class="input_wrap">
						<input type="text" id="Title" name="Title" value="<%=Request("Title")%>" placeholder="SEARCH">
					</div>
					<button class="submit submit2"><span class="blind">검색</span></button>
				</div>
				</form>
				
				<div class="bbs_list">
				<%if Not( IsNothing(Model) ) then
					For each obj in Model.Items
						ProductName = ""
						ProductImages = ""
						if obj.Code = "Devices" then 
							ProductName = obj.DevicesName
							'ProductImages = obj.DevicesImages1
							'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",obj.DevicesImages2,ProductImages )
							'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",obj.DevicesImages3,ProductImages )
							'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",obj.DevicesImages4,ProductImages )
							'ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/Devices/"&ProductImages )
							
							ProductImages = obj.DevicesImagesList
							ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/Devices/"&ProductImages )
						else
							ProductName = obj.AppsName
							'ProductImages = obj.AppsImages1
							'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",obj.AppsImages2,ProductImages )
							'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",obj.AppsImages3,ProductImages )
							'ProductImages = iif( IsNothing(ProductImages) or ProductImages="",obj.AppsImages4,ProductImages )
							'ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/Apps/"&ProductImages )
							
							ProductImages = obj.AppsImagesList
							ProductImages = iif( IsNothing(ProductImages) or ProductImages="","/images/bg_no_image.png","/upload/Apps/"&ProductImages )
						end if
						
						nbsp = ""
						margin = 0
						if obj.DepthNo > 0 then
							margin = (obj.DepthNo-1) * 30
							nbsp = "<img src=""/images/bg_icon_reply.png"" style=""margin-right:10px;""> "
						end if
				%>
					<div class="rows">
						<a href="<%=ViewData("ActionDetail")%>&No=<%=obj.No%>" class="images">
							<label><img class="trick"><img src="<%=ProductImages%>" style="max-width:95%;max-height:95%;"></label>
							<span class="title"><span style="margin-left:<%=margin%>px;"><%=nbsp & obj.Title%></span></span>
							<span class="icon"><%=left(obj.Indate,10)%></span>
						</a>
					</div>
				<%
					next
				else%>
					<div style="text-align:center;margin-top:50px;">등록된 내용이 없습니다.</div>
				<%end if%>
					<%if Types = "FAQ" then %>
					<div style="margin-top:30px;text-align:right;">
						<button class="blue mini" onclick="location.href='<%=ViewData("ActionRegiste")%>';">등록</button>
					</div>
					<%end if%>
				</div>
			</div>
			
		</div>
	</div>
</div>