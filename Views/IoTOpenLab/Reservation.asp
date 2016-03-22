<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue">Reservation</h2>
			<div class="sub_title_description"><b>오픈랩 예약하기</b></div>
			<span class="sub_navigation">IoT OpenLab <span class="bar">></span> <b>Reservation</b></span>
			
			<div class="sub_description">
				<h2 class="sub_caption"><label></label>예약하기</h2>
				
				<form id="mForm" method="POST" action="<%=ViewData("ActionForm")%>">
				<table class="form">
					<tr>
						<td class="title">구분</td>
						<td>
							<input type="radio" name="Location" id="Location1" value="1" checked><label for="Location1">판교</label> 
							
							<input type="radio" name="Location" id="Location2" value="2"><label for="Location2">송도</label> 
						</td>
					</tr>
					<tr>
						<td class="title">시설명</td>
						<td>
							<select id="Facilities" name="Facilities">
								<option value="">구분을 선택하세요.</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="title">성명</td>
						<td><%=Model.Name%></td>
					</tr>
					<tr>
						<td class="title">핸드폰</td>
						<td>
							<input type="text" id="Hphone1" name="Hphone1" style="width:100px;min-width:100px;" maxlength="4" onkeyup="this.value=number_filter(this.value);" value="<%=OidModel.Hphone1%>"> - 
							<input type="text" id="Hphone2" name="Hphone2" style="width:100px;min-width:100px;" maxlength="4" onkeyup="this.value=number_filter(this.value);" value="<%=OidModel.Hphone2%>"> - 
							<input type="text" id="Hphone3" name="Hphone3" style="width:100px;min-width:100px;" maxlength="4" onkeyup="this.value=number_filter(this.value);" value="<%=OidModel.Hphone3%>"> 
						</td>
					</tr>
					<tr>
						<td class="title">이메일</td>
						<td><%=Model.Id%></td>
					</tr>
					<tr>
						<td class="title">사용 희망일</td>
						<td>
							<div class="input_wrap"><input type="text" class="datepicker" id="UseDate" name="UseDate" readonly></div>
						</td>
					</tr>
					<tr>
						<td class="title">이용목적</td>
						<td>
							<div class="input_wrap"><textarea rows="10" id="Purpose" name="Purpose"></textarea></div>
						</td>
					</tr>
				</table>
				</form>
				<div style="text-align:right;">
					<button class="white" onclick="reg_fm()">예약신청</button>
				</div>
				

			</div>
			
		</div>
	</div>
</div>

<script type="text/javascript">

$(function(){
	SetFacilities( 1 ,'');
	$('input').on('ifChecked', function(event){
		SetFacilities( $(this).val() ,'');
	});
})

function reg_fm(){
	if( !$.trim( $('#Facilities').val() ) ){
		alert('시설명을 선택해주세요');return false;
	}
	if( !$.trim( $('#Hphone1').val() ) || !$.trim( $('#Hphone2').val() ) || !$.trim( $('#Hphone3').val() ) ){
		alert('핸드폰을 입력해주세요');return false;
	}
	if( !$.trim( $('#UseDate').val() ) ){
		alert('사용 희망일을 입력해주세요');return false;
	}
	$('#mForm').submit();
}


function SetFacilities(Location,Facilities){
	if( !Location ){return false;}
	$.ajax({
		url : "?controller=IoTOpenLab&action=AjaxMenuList&partial=True&Location="+Location,
		type : "GET",
		error : function(jqxhr, status, errorMsg){
			alert("잠시후에 시도해 주세요.");
			console.log(jqxhr);
		},
		success : function(json){
			var json = JSON.parse(json);
			var html = '<option value="">선택</option>';
	
			$.each(json, function(key, value){
				html += '<option value="'+value.No+'" '+(Facilities==value.No?'selected':'')+'>'+value.Name+'</option>';
			});
			$('#Facilities').html(html);
		}
	});
}
</script>
