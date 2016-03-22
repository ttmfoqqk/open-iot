<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue">회원정보수정</h2>
			<div class="sub_title_description">회원정보 <b>수정하기</b></div>
			<span class="sub_navigation">My Page <span class="bar">></span> <b>회원정보수정</b></span>
			
			<div class="sub_description">
				<h2 class="sub_caption"><label></label>기본정보</h2>
				
				<form name="mForm" id="mForm" method="POST" action="<%=ViewData("ActionForm")%>">
				<input type="hidden" name="State" value="<%=Model.State%>">
				<table class="form">
					<tr>
						<td class="title"><span class="red">＊</span>이름</td>
						<td>
							<%=Model.Name%>
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>Email ID</td>
						<td>
							<%=Model.Id%>
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>비빌번호</td>
						<td>
							<div class="input_wrap"><input type="password" name="Pwd" id="Pwd"></div>
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>비빌번호 확인</td>
						<td>
							<div class="input_wrap"><input type="password" name="PwdConfirm" id="PwdConfirm"></div>
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>핸드폰 뒷자리 번호 4개</td>
						<td>
							<div class="input_wrap"><input type="text" name="Phone3" id="Phone3" maxlength="4" value="<%=Model.Phone3%>" onkeyup="this.value=number_filter(this.value);"></div>
						</td>
					</tr>
				</table>
				<div style="text-align:right;">
					<button type="button" class="white" onclick="reg_fm()">수정</button>
				</div>
				</form>
				

			</div>
			
		</div>
	</div>
</div>
<script type="text/javascript">
function reg_fm(){
	if( !$.trim( $('#Pwd').val() ) ){
		alert('비빌번호를 입력해주세요.');return false;
	}
	if( !$.trim( $('#PwdConfirm').val() ) ){
		alert('비빌번호 확인을 입력해주세요.');return false;
	}
	if( $.trim( $('#Pwd').val() ) != $.trim( $('#PwdConfirm').val() ) ){
		alert('비밀번호를 확인해주세요.');return false;
	}
	if( !$.trim( $('#Phone3').val() ) ){
		alert('핸드폰 뒷자리 번호 4개를 입력해주세요.');return false;
	}
	$('#mForm').submit();
}
</script>