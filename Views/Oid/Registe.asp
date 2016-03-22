<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue">Get OID</h2>
			<div class="sub_title_description"><b>오픈OID 신청</b></div>
			<span class="sub_navigation">OID <span class="bar">></span> <b>Get OID</b></span>
			
			<div class="sub_description">
				<h2 class="sub_caption"><label></label><%=PageTitle%></h2>
				
				<form id="mForm" method="POST" action="<%=ViewData("ActionForm")%>" enctype="multipart/form-data">
				<input type="hidden" name="ActionType" value="<%=ViewData("ActionType")%>">
				<input type="hidden" id="No" name="No" value="<%=Model.No%>">
				<input type="hidden" id="oldImgLogo" name="oldImgLogo" value="<%=Model.ImgLogo%>">
				<input type="hidden" id="oldImgBusiness" name="oldImgBusiness" value="<%=Model.ImgBusiness%>">
				<input type="hidden" id="Oid" name="Oid" value="<%=Model.Oid%>">
				<input type="hidden" id="State" name="State" value="<%=Model.State%>">
                                        
				<table class="form">
					<%if ViewData("ActionType") = "UPDATE" then %>
					<tr>
						<td class="title">진행상황</td>
						<td>
						<%
						if Model.State = "0" then
							response.write "<span style=""color:#007acc;"">발급완료</span>"
						elseif Model.State = "1" then
							response.write "미발급"
						elseif Model.State = "2" then
							response.write "미발급"
						end if
						%>
						</td>
					</tr>
					<tr>
						<td class="title">발급아이디</td>
						<td style="color:#007acc;">
						<%
						if Model.State = "0" then
							response.write Model.Oid
						elseif Model.State = "1" then
							response.write "미발급"
						elseif Model.State = "2" then
							response.write "미발급"
						end if
						%>
						</td>
					</tr>
					<%end if%>
					<tr>
						<td class="title">이름</td>
						<td><%=UserModel.Name%></td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>핸드폰</td>
						<td>
							<%if Model.State = "0" then %>
								<%=Model.Hphone1%> - <%=Model.Hphone2%> - <%=Model.Hphone3%>
							<%else%>
							<input type="text" style="width:110px;min-width:110px;" id="Hphone1" name="Hphone1" maxlength="4" value="<%=Model.Hphone1%>" onkeyup="this.value=number_filter(this.value);"> - 
							<input type="text" style="width:110px;min-width:110px;" id="Hphone2" name="Hphone2" maxlength="4" value="<%=Model.Hphone2%>" onkeyup="this.value=number_filter(this.value);"> - 
							<input type="text" style="width:110px;min-width:110px;" id="Hphone3" name="Hphone3" maxlength="4" value="<%=Model.Hphone3%>" onkeyup="this.value=number_filter(this.value);">
							<%end if%> 
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>기업명</td>
						<td>
						<%if Model.State = "0" then %>
							<%=Model.Name%>
						<%else%>
							<div class="input_wrap">
								<div style="margin-right:130px;">
									<input type="text" id="Name" name="Name" value="<%=Model.Name%>"> &nbsp;
									<input type="hidden" id="CheckName" name="CheckName" value="<%=Model.Name%>">
									<button class="gray" type="button" onclick="check_name();" style="position:absolute;top:0px;right:-20px">중복확인</button>
								</div>
							</div>
						<%end if%>
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>담당자 메일</td>
						<td>
						<%if Model.State = "0" then %>
							<%=Model.Email%>
						<%else%>
							<div class="input_wrap"><input type="text" id="Email" name="Email" value="<%=Model.Email%>"></div>
						<%end if%>
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>회사URL</td>
						<td>
						<%if Model.State = "0" then %>
							<%=Model.Url%>
						<%else%>
							<div class="input_wrap"><input type="text" id="Url" name="Url" value="<%=Model.Url%>"></div>
						<%end if%>
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>주소</td>
						<td>
						<%if Model.State = "0" then %>
							<%=Model.Addr%>
						<%else%>
							<div class="input_wrap"><input type="text" id="Addr" name="Addr" value="<%=Model.Addr%>"></div>
						<%end if%>
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>회사연락처</td>
						<td>
						<%if Model.State = "0" then %>
							<%=Model.Phone1%> - <%=Model.Phone2%> - <%=Model.Phone3%>
						<%else%>
							<input type="text" style="width:110px;min-width:110px;" id="Phone1" name="Phone1" maxlength="4" value="<%=Model.Phone1%>" onkeyup="this.value=number_filter(this.value);"> - 
							<input type="text" style="width:110px;min-width:110px;" id="Phone2" name="Phone2" maxlength="4" value="<%=Model.Phone2%>" onkeyup="this.value=number_filter(this.value);"> - 
							<input type="text" style="width:110px;min-width:110px;" id="Phone3" name="Phone3" maxlength="4" value="<%=Model.Phone3%>" onkeyup="this.value=number_filter(this.value);">
						<%end if%> 
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>회사로고  <!--div style="font-size:12px;margin-top:5px;">권장사이즈 : 148px X 120px</div--></td>
						<td>
						<%if Model.State = "0" then %>
							<%if Model.ImgLogo <> "" then %>
								<a href="/Utils/download.asp?pach=/upload/Oid/&file=<%=Model.ImgLogo%>"><%=Model.ImgLogo%></a>
							<%end if%>
						<%else%>
							<div class="input_wrap">
								<div style="margin-right:130px;">
									<input type="text" style="background-color:#ffffff;" readonly disabled>
									<label class="files" style="position:absolute;top:0px;right:-40px;">
										파일첨부
										<input type="file" id="ImgLogo" name="ImgLogo" onchange="images_add($(this))">
									</label>
									
									<div style="font-size:14px;margin-top:10px;color:#010101">권장사이즈 : 148px X 120px</div>
								</div>

								<%if Model.ImgLogo <> "" then %>
								<div style="margin-top:10px;"><a href="/Utils/download.asp?pach=/upload/Oid/&file=<%=Model.ImgLogo%>"><%=Model.ImgLogo%></a></div>
								<%end if%>
							</div>
							
							
						<%end if%> 
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>사업자 등록증</td>
						<td>
						<%if Model.State = "0" then %>
							<%if Model.ImgBusiness <> "" then %>
								<a href="/Utils/download.asp?pach=/upload/Oid/&file=<%=Model.ImgBusiness%>"><%=Model.ImgBusiness%></a>
							<%end if%>
						<%else%>
							<div class="input_wrap">
								<div style="margin-right:130px;">
									<input type="text" style="background-color:#ffffff;" readonly disabled>
									<label class="files" style="position:absolute;top:0px;right:-40px;">
										파일첨부
										<input type="file" id="ImgBusiness" name="ImgBusiness" onchange="images_add($(this))">
									</label>
								</div>

								<%if Model.ImgBusiness <> "" then %>
								<div style="margin-top:10px;"><a href="/Utils/download.asp?pach=/upload/Oid/&file=<%=Model.ImgBusiness%>"><%=Model.ImgBusiness%></a></div>
								<%end if%>
							</div>
						<%end if%>
						</td>
					</tr>
				</table>
				</form>
				<div style="text-align:right;">
				<%if Model.State<>"0" or IsNothing(Model.State) then%>
					<%if ViewData("ActionType") = "INSERT" then %>
					<button class="white" onclick="reg_fm()">발급신청</button>
					<%else%>
					<button class="white" onclick="reg_fm()">수정신청</button>
					<%end if%>
				<%end if%>
				</div>
				

			</div>
			
		</div>
	</div>
</div>
<script type="text/javascript">
var _reg_mail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,10}$/i;
function reg_fm(){
	if( !$.trim( $('#Hphone1').val() ) || !$.trim( $('#Hphone2').val() ) || !$.trim( $('#Hphone3').val() ) ){
		alert('핸드폰 번호를 입력해주세요');return false;
	}
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
	if( !$.trim( $('#Url').val() ) ){
		alert('회사Url을 입력해주세요');return false;
	}
	
	if( !$.trim( $('#Addr').val() ) ){
		alert('주소를 입력해주세요');return false;
	}
	if( !$.trim( $('#Phone1').val() ) || !$.trim( $('#Phone2').val() ) || !$.trim( $('#Phone3').val() ) ){
		alert('회사연락처를 입력해주세요');return false;
	}
	if( !$.trim( $('#oldImgLogo').val() ) && !$.trim( $('#ImgLogo').val() ) ){
		alert('회사로고를 등록해주세요');return false;
	}
	if( !$.trim( $('#oldImgBusiness').val() ) && !$.trim( $('#ImgBusiness').val() ) ){
		alert('사업자 등록증을 등록해주세요');return false;
	}
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