<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue">탈퇴신청</h2>
			<div class="sub_title_description">그동안 OPEN IOT를 이용해 주셔서 감사 드립니다.</div>
			<span class="sub_navigation">My Page <span class="bar">></span> <b>탈퇴신청</b></span>
			
			<div class="sub_description">
				
				
				<div style="padding:5px;background-color:#e2e2e2;margin-bottom:30px;">
					<div style="padding:10px;background-color:#f4f4f4;">
						<div style="padding:0px 14px 0px 14px;background-color:#ffffff;">
							<div style="border-bottom:1px dotted #d3d3db;padding:20px 0px 20px 0px;">
								<h3 style="font-size:18px;">탈퇴일로부터 해당 아이디 재사용 불가능</h3><br>
								탈퇴일로부터 1주일 후 회원가입 가능 / 해당 아이디 재사용 불가능<br>
								탈퇴한 아이디는 본인과 타인 모두 재사용할 수 없습니다.
							</div>
							<div style="border-bottom:1px dotted #d3d3db;padding:20px 0px 20px 0px">
								<h3 style="font-size:18px;">탈퇴 후 삭제 내역</h3><br>

								탈퇴 후 회원정보와 개인형 서비스가 아래와 같이 삭제되며 삭제된 데이터는 복구되지 않습니다.<br>
								<table>
									<tr>
										<td style="width:143px;">· 예약정보</td>
										<td>: 예약여부</td>
									</tr>
									<tr>
										<td>· 기타</td>
										<td>: 기타 모든 서비스삭제</td>
									</tr>
								</table>
							</div>
							<div style="padding:20px 0px 20px 0px">
								<h3 style="font-size:18px;">탈퇴 후 유지 내역</h3><br>
								
								탈퇴 후 게시판형 서비스에 등록한 게시물은 삭제되지 않고 아래와 같이 유지됩니다.<br>
								게시물 삭제 등을 원하는 경우 반드시 삭제 또는 비공개 처리 후 탈퇴를 신청해 주세요.<br>
								<table>
									<tr>
										<td style="width:143px;">· 심사위원Pool</td>
										<td>: 심사위원Pool 등록정보</td>
									</tr>
									<tr>
										<td>· 질문과답변</td>
										<td>: 질문과답변 게시글</td>
									</tr>
									<tr>
										<td>· 기타</td>
										<td>: 기타 게시글</td>
									</tr>
								</table>
								
								<br>
								※ 불량이용 및 이용제한에 관한 기록은 개인정보취급방침에 따라 1년 간 보관됩니다.<br>
							</div>
						</div>
					</div>
				</div>
				
				<center>탈퇴하시려면 비밀번호를 한번 더 입력한 후 [탈퇴하기]를 선택해 주시기 바랍니다.</center>
				<br>
				
				<form name="mForm" id="mForm" method="POST" action="<%=ViewData("ActionForm")%>">
				<table class="form">
					<tr>
						<td class="title">아이디(ID)</td>
						<td>
							<%=Model.Id%>
						</td>
					</tr>
					<tr>
						<td class="title">비빌번호</td>
						<td>
							<div class="input_wrap"><input type="password" name="Pwd" id="Pwd"></div>
						</td>
					</tr>
				</table>
				<div style="text-align:center;">
					<button type="button" class="blue" onclick="reg_fm()">탈퇴신청</button>
				</div>
				</form>
				

			</div>
			
		</div>
	</div>
</div>
<script type="text/javascript">
function reg_fm(){
	if( !$.trim( $('#Pwd').val() ) ){
		alert('비빌번호를 입력해주세요');return false;
	}
	$('#mForm').submit();
}
</script>