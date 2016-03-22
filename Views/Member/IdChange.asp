<div class="max_width_wrap">
	
	<div class="sub_contents_full">
		<div class="inner">
			<h2 class="sub_title_black">회원가입</h2>
			<div class="sub_title_img"></div>
			
			<div class="Detail_full">
				<div class="area_member">
					<div class="sub_description">
						<h2 class="sub_caption"><label></label>ID 변경</h2>
						<div style="border:1px solid #e1e1e1;padding:40px;margin-bottom:50px;text-align:center;font-size:18px;">
							ID로 사용하실 이메일 주소를 입력해주세요.<br>
							ID를 변경하시면 기존에 로그인되어 있는 서비스에서 자동으로 로그아웃됩니다.
						</div>
						
						<h2 class="sub_caption"><label></label>변경내용</h2>
						
						<form name="mForm" id="mForm" method="POST" action="<%=ViewData("ActionForm")%>" onsubmit="return reg_fm();">
						<table class="form">
							<tr>
								<td class="title"><span class="red">＊</span>Email ID</td>
								<td>
									<div class="input_wrap"><input type="text" name="Id" id="Id" maxlength="320"></div>
								</td>
							</tr>
							<tr>
								<td class="title"><span class="red">＊</span>Email 확인</td>
								<td>
									<div class="input_wrap"><input type="text" name="IdConfirm" id="IdConfirm" maxlength="320"></div>
								</td>
							</tr>
						</table>
						<center>
							<button class="white" type="button" onclick="history.go(-1);">취소</button> &nbsp;
							<button class="blue" type="submit">확인</button>
						</center>
						</form>
						
						
						
					</div>
				</div>
			</div>
			
			
			
		</div>
	</div>
</div>

<script type="text/javascript" language="javascript">
var _reg_mail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,10}$/i;

function reg_fm(){
	if( !$.trim( $('#Id').val() ) ){
		alert('아이디를 입력해주세요.');return false;
	}
	
	if( !_reg_mail.test( $('#Id').val() ) ){
		alert('잘못된 이메일 형식 입니다.');return false;
	}
}
</script>