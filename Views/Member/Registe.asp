<div class="max_width_wrap">
	
	<div class="sub_contents_full">
		<div class="inner">
			<h2 class="sub_title_black">회원가입</h2>
			<div class="sub_title_img"></div>
			
			<div class="Detail_full">
				<div class="area_member">
					<div class="sub_description">
						
						<form name="mForm" id="mForm" method="POST" action="<%=ViewData("ActionForm")%>" onsubmit="return reg_fm();">
						
							<h2 class="sub_caption"><label></label>Privacy Policy</h2>
							<div style="border:1px solid #e1e1e1;padding:20px;height:315px;overflow-y:auto;overflow-x:hidden;margin-bottom:20px;">
								 <%=Model.Policy1%>
							</div>
							
							<div style="margin-bottom:50px;">
								<input type="checkbox" name="agree" id="agree" value="1" style="vertical-align:middle;">
								<label for="agree" style="margin-left:10px;vertical-align:middle;">Open-IoT 개인정보취급방침에 동의합니다.</label>
							</div>
							
							<h2 class="sub_caption"><label></label>기본정보</h2>
							
							<table class="form">
								<tr>
									<td class="title"><span class="red">＊</span>Email ID</td>
									<td>
										<div class="input_wrap"><input type="text" id="Id" name="Id" maxlength="320"></div>
									</td>
								</tr>
								<tr>
									<td class="title"><span class="red">＊</span>비밀번호</td>
									<td>
										<div class="input_wrap"><input type="password" id="Pwd" name="Pwd" maxlength="50"></div>
									</td>
								</tr>
								<tr>
									<td class="title"><span class="red">＊</span>비밀번호 확인</td>
									<td>
										<div class="input_wrap"><input type="password" id="PwdConfirm" name="PwdConfirm" maxlength="50"></div>
									</td>
								</tr>
								<tr>
									<td class="title"><span class="red">＊</span>이름</td>
									<td>
										<div class="input_wrap"><input type="text" id="Name" name="Name" maxlength="50"></div>
									</td>
								</tr>
								<tr>
									<td class="title"><span class="red">＊</span>핸드폰 뒷자리 번호 4개</td>
									<td>
										<div class="input_wrap"><input type="text" id="Phone3" name="Phone3" maxlength="4" onkeyup="this.value=number_filter(this.value);"></div>
									</td>
								</tr>
								<tr>
									<td class="title"><span class="red">＊</span>보안코드</td>
									<td>
										아래 그림에 표시된 문자를 입력하십시오.<br>
										<img src="./Utils/captcha/captcha.asp?<%=date()%>" id="imgCaptcha" style="border:1px solid #000000;vertical-align:top;"/>
										&nbsp;<a href="javascript:void(0);" onclick="RefreshImage('imgCaptcha');" style="vertical-align:top;"><img src="./images/captcha_RefreshImage.gif"/></a><br />
										<div class="input_wrap" style="width:280px;margin-top:5px;"><input type="text" id="txtCaptcha" name="txtCaptcha" maxlength="8" style="ime-mode:disabled;"></div>
									</td>
								</tr>
							</table>
							<div style="text-align:right;">
								<button type="submit" class="white">회원가입</button>
							</div>
							
						</form>
						
					</div>
				</div>
			</div>
			
			
			
		</div>
	</div>
</div>


<script type="text/javascript" language="javascript">
function RefreshImage(valImageId) {
	var objImage = document.getElementById(valImageId)
	if (objImage == undefined) {
		return;
	}
	var now = new Date();
	objImage.src = objImage.src.split('?')[0] + '?x=' + now.toUTCString();
}

var _reg_mail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,10}$/i;

function reg_fm(){
	if( !$("input:checkbox[id='agree']").is(":checked") ){
		alert('Open-IoT 개인정보취급방침에 동의해주세요.');return false;
	}
	if( !$.trim( $('#Id').val() ) ){
		alert('아이디를 입력해주세요.');return false;
	}
	
	if( !_reg_mail.test( $('#Id').val() ) ){
		alert('잘못된 이메일 형식 입니다.');return false;
	}
	
	if( !$.trim( $('#Pwd').val() ) ){
		alert('비밀번호를 입력해주세요.');return false;
	}
	if( !$.trim( $('#PwdConfirm').val() ) ){
		alert('비밀번호 확인을 입력해주세요.');return false;
	}
	if( $.trim( $('#Pwd').val() ) != $.trim( $('#PwdConfirm').val() ) ){
		alert('비밀번호를 확인해주세요.');return false;
	}
	if( !$.trim( $('#Name').val() ) ){
		alert('이름을 입력해주세요.');return false;
	}
	if( !$.trim( $('#Phone3').val() ) ){
		alert('핸드폰 뒷자리 번호 4개를 입력해주세요.');return false;
	}
	if( !$.trim( $('#txtCaptcha').val() ) ){
		alert('보안코드를 입력해주세요.');return false;
	}
}
</script>