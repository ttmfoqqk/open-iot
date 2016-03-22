<div class="max_width_wrap login_wrap">
	
	<div class="sub_contents_full">
		<div class="inner">
			<h2 class="sub_title_black">로그인</h2>
			<div class="sub_title_img"></div>
			
			<div class="Detail_full">
				<div class="area_member">
					<div class="sub_description">
						<h2 class="sub_caption"><label></label><b>Open-IoT계정 하나면 충분합니다.</b></h2>
						한 번 가입으로 모든 서비스에 로그인!<br>
						여러분에게 필요한 바로 그 기능!<br><br><br>
						
						<h2 class="sub_caption"><label></label><b>Open-IoT계정이 아직 없으세요?</b></h2>
						<a href="<%=ViewData("ActionRegeste")%>" class="line">회원가입 바로가기</a>
					</div>
					
					<form name="mForm" id="mForm" method="POST" action="<%=ViewData("ActionForm")%>" onsubmit="return reg_fm();">
					<input type="hidden" name="goUrl" value="<%=ViewData("GoUrl")%>">
					<div class="form_box">
						<div class="rows">
							<label class="label">Email ID</label>
							<div class="input"><input type="text" id="Id" name="Id" value="<%=ViewData("SaveId")%>"></div>
						</div>
						
						<div class="rows" style="margin-bottom:10px;">
							<label class="label">비밀번호</label>
							<div class="input"><input type="password" id="Pwd" name="Pwd" ></div>
						</div>
						
						<div style="margin-bottom:30px;">
							<input type="checkbox" name="saveId" id="saveId" style="vertical-align:middle;" <%=ViewData("SaveIdChecked")%>>
							<label for="saveId" style="margin-left:10px;vertical-align:middle;">ID 기억하기</label>
						</div>
						
						<div style="margin-bottom:30px;">
							<a href="<%=ViewData("ActionFind")%>" class="line">ID 또는 비밀번호 찾기</a>
						</div>
						
						<button type="submit" class="blue">로그인</button>
					</div>
					</form>
				</div>
			</div>
			
			
			
		</div>
	</div>
</div>


<script type="text/javascript">
function reg_fm(){
	if( !$.trim( $('#Id').val() ) ){
		alert('아이디를 입력해주세요');return false;
	}
	if( !$.trim( $('#Pwd').val() ) ){
		alert('비밀번호를 입력해주세요');return false;
	}
}
</script>