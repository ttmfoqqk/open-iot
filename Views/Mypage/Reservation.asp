<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue">OpenLab 예약신청 내역</h2>
			<div class="sub_title_description"><b>OpenLab 예약신청 내역</b></div>
			<span class="sub_navigation">My Page <span class="bar">></span> <b>OpenLab 예약신청 내역</b></span>
			
			<div class="sub_description">
				
				<table class="form">
					<tr align="center">
						<td class="title" style="width:10%;border-right: 1px solid #f0f2f4;">구분</td>
						<td class="title" style="width:40%;border-right: 1px solid #f0f2f4;">시설</td>
						<td class="title" style="width:40%;border-right: 1px solid #f0f2f4;">사용 희망일시</td>
						<td class="title" style="width:10%;">상태</td>
					</tr>
					<%if IsNothing(Model) then %>
					<tr>
						<td colspan="5" align="center">등록된 내용이 없습니다.</td>
					</tr>
					<%else
						Dim obj,anchor,phone
						For each obj in Model.Items
						phone  = obj.Hphone1 &"-"& obj.Hphone2 &"-"& obj.Hphone3
						anchor = ViewData("ActionRegiste") & "&No=" & obj.No
						
						if obj.Location = "1" then
							Location = "판교"
						elseif obj.Location = "2" then
							Location = "송도" 
						end if
						
					%>
						<tr align="center">
							<td style="border-right: 1px solid #f0f2f4;"><%=Location%></td>
							<td style="border-right: 1px solid #f0f2f4;"><%=obj.FacilitiesName%></td>
							<td style="border-right: 1px solid #f0f2f4;">
								<%=obj.UseDate%>
								<%=iif(obj.State=0,"&nbsp;&nbsp;&nbsp;" & left( obj.Stime,5 ) &"~"& left( obj.Etime,5 ) ,"")%>
							</td>
							<td><%=iif(obj.State=0,"완료","<span style=""color:red"">신청</span>")%></td>
						</tr>
					<%
						Next
					end if%>
				</table>
				
			

			</div>
			
		</div>
	</div>
</div>