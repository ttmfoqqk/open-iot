<div class="max_width_wrap">
	
	<div class="sub_contents_full">
		<div class="inner">
			<h2 class="sub_title_black">ID 찾기 결과</h2>
			<div class="sub_title_img"></div>
			
			<div class="Detail_full">
				<div class="area_member">
					<div class="sub_description">
						
						
						<div class="form_tab" id="tab_id">
							<div style="border:1px solid #e1e1e1;padding:40px;margin-bottom:50px;text-align:center;font-size:18px;">
								<%if IsNothing(Model) then%>
									등록된 아이디가 없습니다.
								<%else
        							For each obj in Model.Items
								%>
									<div>고객님의 아이디는 <span style="color:#305c92;"><%=obj.Id%></span> 입니다.</div>
								<%
									Next
								end if%>
							</div>
							
							<center>
								<%if IsNothing(Model) then%>
									<button type="button" class="blue" onclick="history.go(-1);">다시찾기</button>
								<%else%>
									<button type="button" class="blue" onclick="document.location.href='<%=ViewData("ActionLogin")%>';">로그인</button>
								<%end if%>
							</center>
						</div>

					</div>
				</div>
			</div>
			
			
			
		</div>
	</div>
</div>
