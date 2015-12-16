<div class="max_width_wrap">
	
	<div class="sub_contents_full">
		<div class="inner">
			<h2 class="sub_title_black">ID / 비밀번호 찾기</h2>
			<div class="sub_title_img"></div>
			
			<div class="Detail_full">
				<div class="area_member">
					<div class="sub_description">
						<div class="tab" id="find_tabs">
							<a href="#tab_id" class="item active">ID 찾기</a>
							<a href="#tab_pwd" class="item">비밀번호 찾기</a>
						</div>
						
						<div class="form_tab" id="tab_id">
							<div style="border:1px solid #e1e1e1;padding:40px;margin-bottom:50px;text-align:center;font-size:18px;">
								ID를 잊으셨나요?<br>
								아래의 정보를 입력하고 [확인]을 누르십시오.
							</div>
							
							<form name="mForm" id="mForm" method="POST" action="<%=ViewData("ActionForm")%>">
							<input type="hidden" name="Mode" value="findId">
							<table class="form">
								<tr>
									<td class="title"><span class="red">＊</span>이름</td>
									<td>
										<div class="input_wrap"><input type="text" name="Name" id="Name"></div>
									</td>
								</tr>
								<tr>
									<td class="title"><span class="red">＊</span>핸드폰 뒷자리 번호 4개</td>
									<td>
										<div class="input_wrap"><input type="text" name="Phone3" id="Phone3" maxlength="4"></div>
									</td>
								</tr>
							</table>
							<center>
								<button type="button" class="white" onclick="history.go(-1);">취소</button>&nbsp;
								<button type="submit" class="blue">확인</button>
							</center>
							</form>
						</div>
						
						
						
						
						<div class="form_tab" id="tab_pwd" style="display:none;">
							<div style="border:1px solid #e1e1e1;padding:40px;margin-bottom:50px;text-align:center;font-size:18px;">
								비밀번호를 잃어버리셨나요?<br>
								아래의 정보를 입력하고 [확인]을 누르십시오.
							</div>
							
							<form name="mForm" id="mForm" method="POST" action="<%=ViewData("ActionForm")%>">
							<input type="hidden" name="Mode" value="findPwd">
							<table class="form">
								<tr>
									<td class="title"><span class="red">＊</span>Email ID</td>
									<td>
										<div class="input_wrap"><input type="text" name="Id" id="Id"></div>
									</td>
								</tr>
								<tr>
									<td class="title"><span class="red">＊</span>이름</td>
									<td>
										<div class="input_wrap"><input type="text" name="Name" id="Name"></div>
									</td>
								</tr>
								<tr>
									<td class="title"><span class="red">＊</span>핸드폰 뒷자리 번호 4개</td>
									<td>
										<div class="input_wrap"><input type="text" name="Phone3" id="Phone3" maxlength="4"></div>
									</td>
								</tr>
							</table>
							<center>
								<button type="button" class="white" onclick="history.go(-1);">취소</button>&nbsp;
								<button type="submit" class="blue">확인</button>
							</center>
							</form>
						</div>
						
						
						
					</div>
				</div>
			</div>
			
			
			
		</div>
	</div>
</div>
<script type="text/javascript">
	$tab = $('#find_tabs').find('a');
	$form = $('.form_tab');
	$tab.click(function(e){
		e.preventDefault();
		$tab.removeClass('active');
		$(this).addClass('active');
		
		var target = $(this).attr('href');
		$form.hide();
		$(target).show();
	});
</script>
