<div class="max_width_wrap">
	
	<div class="sub_contents_full">
		<div class="inner">
			<h2 class="sub_title_black">기업가입</h2>
			<div class="sub_title_img"></div>

			<div class="Detail_full">
				
				<form Id="mForm" action="<%=ViewData("ActionForm")%>" method="POST" enctype="multipart/form-data">
                <input type="hidden" id="GoUrl" name="GoUrl" value="<%=GoUrl%>">
                
                
				<div class="area_registe">
					
					<h2 class="sub_caption"><label></label>가입안내</h2>
					
					<div style="font-size:16px;line-height:160%;padding:20px;margin-bottom:50px;border:1px solid #e1e1e1;">
						본 기업정보는 기업의 판로개척과 개인개발자의 활로 개척에 도움을 주기위해
						해당 제품 및 소프트웨어가 게시될 때 회원들에게 보여줌으로서
						기업 간 협력 증진과 개발자 커뮤니티 활성화하는데 도움이 되고자합니다.
					</div>
					
					<h2 class="sub_caption"><label></label>기업정보</h2>
					
					<table class="form">
						<tr>
							<td class="title"><span class="red">＊</span>기업명</td>
							<td>
								<div class="input_wrap">
									<div style="margin-right:130px;">
										<input type="text" id="Name" name="Name" value="" maxlength="200"> &nbsp;
										<input type="hidden" id="CheckName" name="CheckName" value="">
										<button class="gray" type="button" onclick="check_name();" style="position:absolute;top:0px;right:-20px">중복확인</button>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td class="title"><span class="red">＊</span>담당자 메일</td>
							<td>
								<div class="input_wrap"><input type="text" id="Email" name="Email" value="" maxlength="320"></div>
							</td>
						</tr>
						<tr>
							<td class="title"><span style="color:#ffffff;">＊</span>회사URL</td>
							<td>
								<div class="input_wrap"><input type="text" id="Url" name="Url" value="" maxlength="200"></div>
							</td>
						</tr>
						<tr>
							<td class="title"><span style="color:#ffffff;">＊</span>회사연락처</td>
							<td>
								<input type="text" style="width:110px;min-width:110px;" id="Phone1" name="Phone1" maxlength="4" value="" onkeyup="this.value=number_filter(this.value);"> - 
								<input type="text" style="width:110px;min-width:110px;" id="Phone2" name="Phone2" maxlength="4" value="" onkeyup="this.value=number_filter(this.value);"> - 
								<input type="text" style="width:110px;min-width:110px;" id="Phone3" name="Phone3" maxlength="4" value="" onkeyup="this.value=number_filter(this.value);">
							</td>
						</tr>
						<tr>
							<td class="title"><span style="color:#ffffff;">＊</span>회사로고 </td>
							<td>
								<div class="input_wrap">
									<div style="margin-right:130px;">
										<input type="text" style="background-color:#ffffff;" readonly disabled>
										<label class="files" style="position:absolute;top:0px;right:-40px;">
											파일첨부
											<input type="file" id="ImgLogo" name="ImgLogo" onchange="images_add($(this))">
										</label>
										<div style="font-size:14px;margin-top:10px;color:#010101">권장사이즈 : 148px X 120px</div>
									</div>
								</div>
							</td>
						</tr>
					</table>
					<div style="text-align:right;">
						<button class="white" type="button" onclick="reg_fm()">등록</button>
					</div>
				</div>
				
				</form>
				
				
			</div>
			
			
			
		</div>
	</div>
</div>

<script type="text/javascript">
var _reg_mail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,10}$/i;
function reg_fm(){
	if( !$.trim( $('#Name').val() ) ){
		alert('기업명을 입력해주세요');return false;
	}
	if( $.trim( $('#Name').val() ) != $.trim( $('#CheckName').val() ) ){
		alert('기업명 중복확인을해주세요');return false;
	}
	if( !$.trim( $('#Email').val() ) ){
		alert('담당자 메일을 입력해주세요');return false;
	}
	
	if( !_reg_mail.test( $('#Email').val() ) ){
		alert('잘못된 이메일 형식 입니다.');return false;
	}
	
	/*
	if( !$.trim( $('#Url').val() ) ){
		alert('회사Url을 입력해주세요');return false;
	}

	if( !$.trim( $('#Phone1').val() ) || !$.trim( $('#Phone2').val() ) || !$.trim( $('#Phone3').val() ) ){
		alert('회사연락처를 입력해주세요');return false;
	}
	if( !$.trim( $('#ImgLogo').val() ) ){
		alert('회사로고를 등록해주세요');return false;
	}
	*/
	$('#mForm').submit();
}
function check_name(){
	var name = $('#Name');
	var check = $('#CheckName');
	
	if( !$.trim( name.val() ) ){
		alert('기업명을 입력해주세요');return false;
	}
	
	$.ajax({
		url : "?Controller=Oid&action=AjaxCheckName&Name="+name.val()+"&partial=True",
		type : "GET",
		error : function(jqxhr, status, errorMsg){
			alert("잠시 후 다시 시도해 주세요.");
			console.log(jqxhr);
		},
		success : function(txt){
			if( txt == 'true' ){
				alert('사용할수 있는 기업명 입니다.');
				check.val( name.val() );
			}else{
				alert('이미 사용하고 있는 기업명 입니다.');
				check.val('');
			}
		}
	});	
}
function images_add(obj){
	var parent = obj.parent().parent();
	var text   = parent.find('input[type="text"]');
	text.val( obj.val() );
}
</script>