<div class="max_width_wrap">
	
	<div class="sub_contents_full">
		<div class="inner">
			<h2 class="sub_title_black">회원가입</h2>
			<div class="sub_title_img"></div>
			
			<div class="Detail_full">
				<div class="area_member">
					<div class="sub_description">
						<h2 class="sub_caption"><label></label>Privacy Policy</h2>
						<div style="border:1px solid #e1e1e1;padding:20px;height:315px;overflow-y:auto;overflow-x:hidden;margin-bottom:20px;">
							약관
						</div>
						
						<div style="margin-bottom:50px;">
							<input type="checkbox" name="iCheck" id="iCheck1" style="vertical-align:middle;">
							<label for="iCheck1" style="margin-left:10px;vertical-align:middle;">Open-IoT 개인정보취급방침에 동의합니다.</label>
						</div>
						
						<h2 class="sub_caption"><label></label>기본정보</h2>
						
						<table class="form">
							<tr>
								<td class="title"><span class="red">＊</span>Email ID</td>
								<td>
									<div class="input_wrap"><input type="text"></div>
								</td>
							</tr>
							<tr>
								<td class="title"><span class="red">＊</span>비빌번호</td>
								<td>
									<div class="input_wrap"><input type="text"></div>
								</td>
							</tr>
							<tr>
								<td class="title"><span class="red">＊</span>비빌번호 확인</td>
								<td>
									<div class="input_wrap"><input type="text"></div>
								</td>
							</tr>
							<tr>
								<td class="title"><span class="red">＊</span>이름</td>
								<td>
									<div class="input_wrap"><input type="text"></div>
								</td>
							</tr>
							<tr>
								<td class="title"><span class="red">＊</span>핸드폰 뒷자리 번호 4개</td>
								<td>
									<div class="input_wrap"><input type="text"></div>
								</td>
							</tr>
							<tr>
								<td class="title"><span class="red">＊</span>보안코드</td>
								<td>
									아래 그림에 표시된 문자를 입력하십시오.<br>
									<img src="./Utils/captcha/captcha.asp" id="imgCaptcha" style="border:1px solid #000000;vertical-align:top;"/>
									&nbsp;<a href="javascript:void(0);" onclick="RefreshImage('imgCaptcha');" style="vertical-align:top;"><img src="./images/captcha_RefreshImage.gif"/></a><br />
									<div class="input_wrap" style="width:280px;margin-top:5px;"><input type="text" maxlength="8" style="ime-mode:disabled;" onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');"></div>
								</td>
							</tr>
						</table>
						<div style="text-align:right;">
							<button class="white">회원가입</button>
						</div>
						
						
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
</script>