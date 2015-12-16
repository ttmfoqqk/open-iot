<div class="max_width_wrap">
	
	<div class="sub_contents_full">
		<div class="inner">
			<h2 class="sub_title_black">비밀번호 찾기 결과</h2>
			<div class="sub_title_img"></div>
			
			<div class="Detail_full">
				<div class="area_member">
					<div class="sub_description">
						
						
						<div class="form_tab" id="tab_id">
							<div style="border:1px solid #e1e1e1;padding:40px;margin-bottom:50px;text-align:center;font-size:18px;">
								<%if ViewData("Result") then%>
									<span style="color:#305c92;"><%=Model.Id%></span> 로 임시비밀번호를 발송하였습니다.
								<%else%>
									등록된 내용이 없습니다.
								<%end if%>
							</div>
							
							<center>
								<%if ViewData("Result") then%>
									<button type="button" class="blue" onclick="document.location.href='<%=ViewData("ActionLogin")%>';">로그인</button>
								<%else%>
									<button type="button" class="blue" onclick="history.go(-1);">다시찾기</button>
								<%end if%>
							</center>
						</div>

					</div>
				</div>
			</div>
			
			
			
		</div>
	</div>
</div>
