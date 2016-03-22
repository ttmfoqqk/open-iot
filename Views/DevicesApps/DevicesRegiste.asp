<div class="max_width_wrap">
	
	<div class="sub_contents_full">
		<div class="inner">
			<h2 class="sub_title_black">Device Update</h2>
			<div class="sub_title_img"></div>

			<div class="Detail_full">
				
				
				
				<form Id="mForm" action="<%=ViewData("ActionForm")%>" method="POST" enctype="multipart/form-data">
                <input type="hidden" id="ActionType" name="ActionType" value="<%=ViewData("ActionType")%>">
                <input type="hidden" id="No" name="No" value="<%=Model.No%>">
                
                
				<div class="area_registe">
					<h2 class="sub_caption"><label></label>등록하기</h2>
					<table class="form">
						<tr>
							<td class="title">분류 선택</td>
							<td>
								<select id="MenuNo" name="MenuNo">
									<option value="">선택해주세요.</option>
									<%if Not(IsNothing(MenuModel)) then
										For each MenuItem in MenuModel.Items
									%>
			                    	<option value="<%=MenuItem.No%>" <%=iif(Model.MenuNo=MenuItem.No,"selected","")%>><%=MenuItem.Name%></option>
			                    	<%
										Next
									end if%>
								</select>
							</td>
						</tr>
						<tr>
							<td class="title">디바이스명</td>
							<td>
								<div class="input_wrap"><input type="text" id="Name" name="Name" value="<%=Model.Name%>"></div>
							</td>
						</tr>
						<tr>
							<td class="title">디바이스 요약설명</td>
							<td>
								<textarea name="Contents1" id="Contents1" rows="5" style="width:85%;"><%=Model.Contents1%></textarea>
							</td>
						</tr>
						<tr>
							<td class="title">리스트 이미지 <!--div style="font-size:12px;margin-top:5px;">권장사이즈 : 600px X 483px</div--></td>
							<td>
								<div class="upload_img">
									<div class="mask">
										<img class="trick"><img src="<%=iif(IsNothing(Model.ImagesList) or Model.ImagesList="","/images/bg_no_image.png","/upload/Devices/" &Model.ImagesList)%>" class="images">
									</div>
									
									<label class="files" style="margin:0px;padding:0px;">
										사진등록
										<input type="file" id="ImagesList" name="ImagesList" onchange="images_add(this)">
									</label>
	                                <input id="ImagesList_old" name="ImagesList_old" type="hidden" value="<%=Model.ImagesList%>">
	                                <%if Not(IsNothing(Model.ImagesList)) then%>
	                                <div style="margin-top:10px;">
										<input type="checkbox" id="Del_ImagesList" name="Del_ImagesList" style="vertical-align:middle;" value="1">
										<label for="Del_ImagesList" style="margin-left:10px;vertical-align:middle;">파일 삭제</label>
									</div>
									<%end if%>
								</div>
								
								<div style="font-size:14px;padding-top:10px;color:#010101;clear:both;">권장사이즈 : 600px X 483px</div>
							</td>
						</tr>
						<tr>
							<td class="title">상세 이미지 <!--div style="font-size:12px;margin-top:5px;">권장사이즈 : 600px X 483px</div--></td>
							<td>
								<div class="upload_img">
									<div class="mask">
										<img class="trick"><img src="<%=iif(IsNothing(Model.Images1) or Model.Images1="","/images/bg_no_image.png","/upload/Devices/" &Model.Images1)%>" class="images">
									</div>
									
									<label class="files" style="margin:0px;padding:0px;">
										사진등록
										<input type="file" id="images_files1" name="images_files1" onchange="images_add(this)">
									</label>
	                                <input id="images_files1_old" name="images_files1_old" type="hidden" value="<%=Model.Images1%>">
	                                
	                                <%if Not(IsNothing(Model.Images1)) then%>
	                                <div style="margin-top:10px;">
										<input type="checkbox" id="Del_images_files1" name="Del_images_files1" style="vertical-align:middle;" value="1">
										<label for="Del_images_files1" style="margin-left:10px;vertical-align:middle;">파일 삭제</label>
									</div>
									<%end if%>
								</div>
								
								<div class="upload_img">
									<div class="mask">
										<img class="trick"><img src="<%=iif(IsNothing(Model.Images2) or Model.Images2="","/images/bg_no_image.png","/upload/Devices/" &Model.Images2)%>" class="images">
									</div>
									
									<label class="files" style="margin:0px;padding:0px;">
										사진등록
										<input type="file" id="images_files2" name="images_files2" onchange="images_add(this)">
									</label>
	                                <input id="images_files2_old" name="images_files2_old" type="hidden" value="<%=Model.Images2%>">
	                                
	                                <%if Not(IsNothing(Model.Images2)) then%>
	                                <div style="margin-top:10px;">
										<input type="checkbox" id="Del_images_files2" name="Del_images_files2" style="vertical-align:middle;" value="1">
										<label for="Del_images_files2" style="margin-left:10px;vertical-align:middle;">파일 삭제</label>
									</div>
									<%end if%>
								</div>
								
								<div class="upload_img">
									<div class="mask">
										<img class="trick"><img src="<%=iif(IsNothing(Model.Images3) or Model.Images3="","/images/bg_no_image.png","/upload/Devices/" &Model.Images3)%>" class="images">
									</div>
									
									<label class="files" style="margin:0px;padding:0px;">
										사진등록
										<input type="file" id="images_files3" name="images_files3" onchange="images_add(this)">
									</label>
	                                <input id="images_files3_old" name="images_files3_old" type="hidden" value="<%=Model.Images3%>">
	                                
	                                <%if Not(IsNothing(Model.Images3)) then%>
	                                <div style="margin-top:10px;">
										<input type="checkbox" id="Del_images_files3" name="Del_images_files3" style="vertical-align:middle;" value="1">
										<label for="Del_images_files3" style="margin-left:10px;vertical-align:middle;">파일 삭제</label>
									</div>
									<%end if%>
								</div>
								
								<div class="upload_img no_margin">
									<div class="mask">
										<img class="trick"><img src="<%=iif(IsNothing(Model.Images4) or Model.Images4="","/images/bg_no_image.png","/upload/Devices/" &Model.Images4)%>" class="images">
									</div>
									<label class="files" style="margin:0px;padding:0px;">
										사진등록
										<input type="file" id="images_files4" name="images_files4" onchange="images_add(this)">
									</label>
	                                <input id="images_files4_old" name="images_files4_old" type="hidden" value="<%=Model.Images4%>">
	                                
	                                <%if Not(IsNothing(Model.Images4)) then%>
	                                <div style="margin-top:10px;">
										<input type="checkbox" id="Del_images_files4" name="Del_images_files4" style="vertical-align:middle;" value="1">
										<label for="Del_images_files4" style="margin-left:10px;vertical-align:middle;">파일 삭제</label>
									</div>
									<%end if%>
								</div>
									
								<div style="font-size:14px;padding-top:10px;color:#010101;clear:both;">권장사이즈 : 600px X 483px</div>
							</td>
						</tr>
						<tr>
							<td class="title">디바이스 상세설명</td>
							<td>
								<textarea name="Contents2" id="Contents2" rows="15" style="width:85%;"><%=Model.Contents2%></textarea>
							</td>
						</tr>
						<tr>
							<td class="title">API설명</td>
							<td>
								<textarea name="Contents3" id="Contents3" rows="15" style="width:85%;"><%=Model.Contents3%></textarea>
							</td>
						</tr>
						<tr>
							<td class="title">파일</td>
							<td>
								<%if Not( IsNothing(FilesModel) ) then%>
								<%For each files in FilesModel.Items%>
								<div style="margin-bottom:10px;">
									<span style="margin-right:10px;"><a href="/Utils/download.asp?pach=/upload/Devices/&file=<%=files.Name%>"><%=files.Name%></a></span>
									<button type="button" class="white" style="width:50px;height:20px;border:2px solid #007acc;font-size:12px;" onclick="del_file($(this),<%=files.No%>)">삭제</button>
								</div>
								<%next%>
								<%end if%>
								<div class="input_wrap" id="file_area">
									<div class="file_item" style="position:relative;margin-bottom:10px;margin-right:230px;">
										<input type="text" style="background-color:#ffffff;" readonly disabled>
										
										
										<div style="position:absolute;top:0px;right:-250px;">
											<label class="files" style="margin-right:10px;">
												파일첨부
												<input type="file" id="files" name="files" onchange="files_add($(this))">
											</label>
											<button class="gray" type="button" style="width:40px;" onclick="row_controll($(this),'add')">+</button>
											<button class="gray" type="button" style="width:40px;" onclick="row_controll($(this),'remove')">-</button>
										</div>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td class="title">관련 어플리케이션</td>
							<td>
								<%if Not( IsNothing(RelationModel) ) then%>
								<%For each Relation in RelationModel.Items%>
								<div style="margin-bottom:10px;">
									<span style="margin-right:10px;"><%=Relation.ProductName%></span>
									<button type="button" class="white" style="width:50px;height:20px;border:2px solid #007acc;font-size:12px;" onclick="del_relation($(this),<%=Relation.No%>)">삭제</button>
								</div>
								<%next%>
								<%end if%>
								<div class="input_wrap" id="relation_area">
									<div class="relation_item" style="position:relative;margin-bottom:10px;">
										<div style="position:absolute;top:0px;left:0px;width:120px;">
											<select style="width:100%;margin-top:1px;" name="RelationMenu" onchange="call_relation($(this))">
												<option value="">선택해주세요</option>
												<%if Not(IsNothing(ProductMenuModel)) then
													For each MenuItem in ProductMenuModel.Items
												%>
                                            	<option value="<%=MenuItem.No%>"><%=MenuItem.Name%></option>
                                            	<%
													Next
												end if%>
											</select>
										</div>
										
										<div style="margin-left:210px;margin-right:80px;">
											<select style="width:100%;margin-top:1px;" name="Relation" >
												<option value="">선택해주세요</option>
											</select>
										</div>
										
										<div style="position:absolute;top:0px;right:-20px;">
											<button class="gray" type="button" style="width:40px;" onclick="row_relation_controll($(this),'add')">+</button>
											<button class="gray" type="button" style="width:40px;" onclick="row_relation_controll($(this),'remove')">-</button>
										</div>
									</div>
								</div>
								
							</td>
						</tr>
					</table>
					<div style="text-align:right;">
						<button class="white" type="button" onclick="reg_fm()">디바이스 등록</button>
					</div>
				</div>
				
				</form>
				
				
			</div>
			
			
			
		</div>
	</div>
</div>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Contents1",
	sSkinURI: "/Utils/SE2.8.2.O12056/SmartEditor2Skin.html",	
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		fOnBeforeUnload : function(){
			//alert("완료!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//
	},
	fCreator: "createSEditor2"
});

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Contents2",
	sSkinURI: "/Utils/SE2.8.2.O12056/SmartEditor2Skin.html",	
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		fOnBeforeUnload : function(){
			//alert("완료!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//
	},
	fCreator: "createSEditor2"
});

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Contents3",
	sSkinURI: "/Utils/SE2.8.2.O12056/SmartEditor2Skin.html",	
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		fOnBeforeUnload : function(){
			//alert("완료!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//
	},
	fCreator: "createSEditor2"
});


function reg_fm(){
	oEditors.getById["Contents1"].exec("UPDATE_CONTENTS_FIELD", []);
	oEditors.getById["Contents2"].exec("UPDATE_CONTENTS_FIELD", []);
	oEditors.getById["Contents3"].exec("UPDATE_CONTENTS_FIELD", []);
	
	var sContent1 = oEditors.getById["Contents1"].getIR(); 
	sContent1 = sContent1.replace(/\r/g, ''); 
	sContent1 = sContent1.replace(/[\n|\t]/g, ''); 
	sContent1 = sContent1.replace(/[\v|\f]/g, ''); 
	sContent1 = sContent1.replace(/<p><br><\/p>/gi, ''); 
	sContent1 = sContent1.replace(/<P>&nbsp;<\/P>/gi, ''); 
	sContent1 = sContent1.replace(/<br(\s)*\/?>/gi, ''); 
	sContent1 = sContent1.replace(/<br(\s[^\/]*)?>/gi, ''); 
	sContent1 = sContent1.replace(/<\/p(\s[^\/]*)?>/gi, ''); 
	sContent1 = sContent1.replace(/<\/li(\s[^\/]*)?>/gi, ''); 
	sContent1 = sContent1.replace(/<\/tr(\s[^\/]*)?>/gi, ''); 
	sContent1 = sContent1.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/g,""); 
	sContent1 = sContent1.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	
	var sContent2 = oEditors.getById["Contents2"].getIR(); 
	sContent2 = sContent2.replace(/\r/g, ''); 
	sContent2 = sContent2.replace(/[\n|\t]/g, ''); 
	sContent2 = sContent2.replace(/[\v|\f]/g, ''); 
	sContent2 = sContent2.replace(/<p><br><\/p>/gi, ''); 
	sContent2 = sContent2.replace(/<P>&nbsp;<\/P>/gi, ''); 
	sContent2 = sContent2.replace(/<br(\s)*\/?>/gi, ''); 
	sContent2 = sContent2.replace(/<br(\s[^\/]*)?>/gi, ''); 
	sContent2 = sContent2.replace(/<\/p(\s[^\/]*)?>/gi, ''); 
	sContent2 = sContent2.replace(/<\/li(\s[^\/]*)?>/gi, ''); 
	sContent2 = sContent2.replace(/<\/tr(\s[^\/]*)?>/gi, ''); 
	sContent2 = sContent2.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/g,""); 
	sContent2 = sContent2.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	
	var sContent3 = oEditors.getById["Contents3"].getIR(); 
	sContent3 = sContent3.replace(/\r/g, ''); 
	sContent3 = sContent3.replace(/[\n|\t]/g, ''); 
	sContent3 = sContent3.replace(/[\v|\f]/g, ''); 
	sContent3 = sContent3.replace(/<p><br><\/p>/gi, ''); 
	sContent3 = sContent3.replace(/<P>&nbsp;<\/P>/gi, ''); 
	sContent3 = sContent3.replace(/<br(\s)*\/?>/gi, ''); 
	sContent3 = sContent3.replace(/<br(\s[^\/]*)?>/gi, ''); 
	sContent3 = sContent3.replace(/<\/p(\s[^\/]*)?>/gi, ''); 
	sContent3 = sContent3.replace(/<\/li(\s[^\/]*)?>/gi, ''); 
	sContent3 = sContent3.replace(/<\/tr(\s[^\/]*)?>/gi, ''); 
	sContent3 = sContent3.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/g,""); 
	sContent3 = sContent3.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	
	if( !$.trim( $('#MenuNo').val() ) ){
		alert('분류를 선택해주세요');return false;
	}
	if( !$.trim( $('#Name').val() ) ){
		alert('디바이스명을 입력해주세요');return false;
	}
	if( sContent1.length <= 0 ){
		alert('디바이스 요약설명을 입력해주세요');return false;
	}
	
	if( !$('#ImagesList').val() && !$('#ImagesList_old').val() ){
		alert('디바이스 리스트 이미지를 선택해주세요');return false;
	}
	
	if( (!$('#images_files1').val() && !$('#images_files1_old').val()) && (!$('#images_files2').val() && !$('#images_files2_old').val()) && (!$('#images_files3').val() && !$('#images_files3_old').val()) && (!$('#images_files4').val() && !$('#images_files4_old').val()) ){
		alert('디바이스 상세 이미지를 선택해주세요');return false;
	}
	
	if( sContent2.length <= 0 ){
		alert('디바이스 상세설명을 입력해주세요');return false;
	}
	if( sContent3.length <= 0 ){
		alert('API설명을 입력해주세요');return false;
	}
	
	$('#mForm').submit();
}


var $new_row = $('#file_area .file_item').clone();
function row_controll(obj,mode){
	var len     = $('#file_area .file_item').length;
	var parent  = obj.parent().parent();
	var new_row = $new_row.clone();
	
	if( mode == 'add' ){
		$(new_row).insertAfter(parent);
	}else if( mode == 'remove' ){
		if(len <= 1){
			alert('삭제할수 없습니다.');
			return false;
		}else{
			parent.remove();
		}
	}
}


var $new_row_relation = $('#relation_area .relation_item').clone();
function row_relation_controll(obj,mode){
	var len     = $('#relation_area .relation_item').length;
	var parent  = obj.parent().parent();
	var new_row = $new_row_relation.clone();
	
	if( mode == 'add' ){
		$(new_row).insertAfter(parent);
	}else if( mode == 'remove' ){
		if(len <= 1){
			alert('삭제할수 없습니다.');
			return false;
		}else{
			parent.remove();
		}
	}
}


function files_add(obj){
	var parent = obj.parent().parent().parent();
	var text   = parent.find('input[type="text"]');
	text.val( obj.val() );
}

function images_add(obj){
	var parent = $(obj).parent().parent();
	var input  = parent.find('input[type="file"]');
	var img    = parent.find('img.images');
	readImage(obj,img);
}

function call_relation(obj){
	var parent = $(obj).parent().parent();
	var input  = parent.find('select[name=Relation]');
	var menuNo = $(obj).val();
	
	if(!menuNo){
		input.html('<option value="">선택해주세요</option>');
		return false;
	}
	
	$.ajax({
		url : "?controller=DevicesApps&action=AjaxAppsList&MenuNo="+menuNo+"&partial=True",
		type : "GET",
		error : function(jqxhr, status, errorMsg){
			alert("실패");
			console.log(jqxhr);
		},
		success : function(json){
			var json = JSON.parse(json);
			var html = '<option value="">선택해주세요</option>';
			$.each(json.LIST, function(key, value){
				html += '<option value="'+value.No+'">'+value.Name+'</option>';
			});
			input.html(html);
		}
	});
}



function del_file(obj,No){
	if( !confirm('첨부파일을 삭제 하시겠습니까?') ){
		return false;
	}
	$.ajax({
		url : "?controller=DevicesApps&action=DelFile",
		type : "POST",
		data : {
			No : No,
			partial:'True',
			mode:'Devices'
		},
		error : function(jqxhr, status, errorMsg){
			alert("실패");
			console.log(jqxhr);
		},
		success : function(res){
			obj.parent().remove()
		}
	});	
}

function del_relation(obj,No){
	if( !confirm('관련 어플리케이션을 삭제 하시겠습니까?') ){
		return false;
	}
	$.ajax({
		url : "?controller=DevicesApps&action=DelRelation",
		type : "POST",
		data : {
			No : No,
			partial:'True',
			mode:'Devices'
		},
		error : function(jqxhr, status, errorMsg){
			alert("실패");
			console.log(jqxhr);
		},
		success : function(res){
			obj.parent().remove()
		}
	});	
}
</script>