<div class="max_width_wrap">
	
	<div class="sub_contents_full">
		<div class="inner">
			<h2 class="sub_title_black">회원가입</h2>
			<div class="sub_title_img"></div>
			
			<div class="Detail_full">
				<div class="area_member">
					<div class="sub_description">
						<h2 class="sub_caption"><label></label><%=iif(ViewData("Result"),"가입 완료","이메일 인증 실패")%></h2>
						<div style="border:1px solid #e1e1e1;padding:40px;margin-bottom:50px;text-align:center;font-size:18px;">
						<%if ViewData("Result") then%>
							Open-IoT 가입이 완료되었습니다.<br>
							새 계정으로 로그인하시어 Open-IoT서비스를 마음껏 이용해 보세요!
						<%else%>
							이메일 인증 실패<br>
							다시 시도해 주세요.
						<%end if%>
						</div>
						
						<%if ViewData("Result") then%>
						<center>
							<button class="blue" onclick="document.location.href='<%=ViewData("ActionUrl")%>';">시작하기</button>
						</center>
						<%end if%>
						
						
						
					</div>
				</div>
			</div>
			
			
			
		</div>
	</div>
</div>