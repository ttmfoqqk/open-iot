$(function(){
	/**
	 * top menu height
	 * top line move
	 */
	top_height_motion();
	var header               = $('#header');
	var top_menu             = header.find('nav');
	var top_menu_item        = top_menu.find('ul li.item');
	var top_menu_item_active = top_menu_item.find('.active').parent();
	top_menu_item.mouseover(function(){
		top_line_move( $(this) );
	});
	top_menu.mouseout(function(){
		top_line_move( top_menu_item_active );
	});
	top_line_move( top_menu_item_active );
	
	/**
	 * center height setting
	 * 백그라운드 이미지, 백그라운드 색상 적용때문임
	 */
	var middle = $('#middle');
	//middle.height($(document).height()-415);
	$(window).resize(function(){
		//middle.height($(document).height()-415);
	});

	/**
	 * plugins icheck-1.x
	 * checkbox,radio skin
	 */
	$('input').iCheck({
		checkboxClass: 'icheckbox_flat-blue',
		radioClass: 'iradio_flat-blue'
	});
	
	/**
	 * jquery datepicker setting
	 */
	$.datepicker.regional['ko'] = {prevText: '이전달',nextText: '다음달',currentText: '오늘',monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)','7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)'],monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],dayNames: ['일','월','화','수','목','금','토'],dayNamesShort: ['일','월','화','수','목','금','토'],dayNamesMin: ['일','월','화','수','목','금','토'],weekHeader: 'Wk',dateFormat: 'yy-mm-dd',firstDay: 0,isRTL: false,showMonthAfterYear: true,yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$( ".datepicker" ).datepicker({
		beforeShowDay: noBefore
	});
});

/*
 * 상단 높이 조절 scrollTop 50px;
 */
function top_height_motion(){
	var h = $('#header');
	$(window).scroll(function(){
		var d = $(window).scrollTop();
		if(d > 50){
			h.addClass('mini');
			TweenMax.to(h, 0.25, {height:50, ease:Sine.easeOut});
		}else{
			h.removeClass('mini');
			TweenMax.to(h, 0.25, {height:100, ease:Sine.easeOut});
		}
	});
}

/*
 * 상단 메뉴 active bar 모션
 */
function top_line_move(t){
	var t = t;
	var o = $("#top_nav_line");
	if( t.length <= 0 ){
		TweenMax.to(o, 0.25, {width:0, ease:Sine.easeOut});
		return false;
	}
	o.show();
	var w = t.width();
	var p = t.position().left;	
	TweenMax.to(o, 0.25, {width:w, x:p , ease:Sine.easeOut});
}


/*
 * Devices & Apps 선택 등록 팝업
 */
function call_pop_registe(){
	html = ''+
	'<div class="pop_registe">'+
		'<button onclick="location.href=\'?controller=DevicesApps&action=DevicesRegiste\';" class="active marginBottom">Device 등록</button><br>'+
		'<button onclick="location.href=\'?controller=DevicesApps&action=AppsRegiste\';">App 등록</button>'+
	'</div>';
	pop_open(html);
}

/*
 * 달력 팝업 내용 생성
 * plugins fullcalendar-2.5.0
 * events, 클릭 모션 추가 작성요망
 */
function call_pop_calendar(m){
	html = ''+
		'<div class="pop_calendar">'+
			'<div class="tab">'+
				'<button type="button" onclick="call_calendar_data(1)" class="'+(m==1?'active':'')+'">판교</button>'+
				'<button type="button" onclick="call_calendar_data(2)" class="'+(m==2?'active':'')+'">송도</button>'+
			'</div>'+
			'<table class="layout">'+
				'<tr>'+
					'<td class="cell01">'+
						'<div class="calendar_base" id="calendar_base" style="width:692px;"></div>'+
					'</td>'+
					'<td class="cell02">'+
						'<div class="detail_base" id="detail_base">'+
							'<div class="inner">'+
								'<h4 class="title"></h4>'+
								'<ul class="list"></ul>'+
							'</div>'+
						'</div>'+
					'</td>'+
				'</tr>'+
			'</table>'+
		'</div>';
	pop_open(html);
	call_calendar_data(m);
}

function call_calendar_data(m){
	var btn = $('.pop_calendar .tab button');
	btn.removeClass('active');
	btn.filter(':eq('+(m-1)+')').addClass('active');
	
	$('#calendar_base').fullCalendar('destroy');
	$('#calendar_base').fullCalendar({
		header: {
			left  : '',
			center: 'prev title next',
			right : ''
		},
		editable: false,		
		events: {
			url: '?controller=IoTOpenLab&action=AjaxCalendarList&partial=True&Location='+m,
			error: function() {
				alert('error');
			}
		}
	});
	call_calendar_detail(m,'');
}

function call_calendar_detail(m,date){
	
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();

	if(dd<10) {
	    dd='0'+dd;
	} 

	if(mm<10) {
	    mm='0'+mm;
	} 
	InDate = !date? (yyyy+'-'+mm+'-'+dd) : date ;
	
	var detail_base = $('#detail_base');
	var location
	if( m=='1' ){
		location = ' <판교>';
	}else if( m=='2' ){
		location = ' <송도>';
	}
	
	detail_base.find('h4.title').html(InDate+location);
	
	$.ajax({
		url : "?controller=IoTOpenLab&action=AjaxCalendarDetail&partial=True&Location="+m+'&InDate='+InDate,
		type : "GET",
		error : function(jqxhr, status, errorMsg){
			alert("잠시 후 다시 시도해 주세요.");
			console.log(jqxhr);
		},
		success : function(json){
			var json = JSON.parse(json);
			var html = '';

			$.each(json, function(key, value){
				html += '<li>'+value.title+'<br><span>'+value.time+'</span></li>';
			});
			detail_base.find('.list').html(html);
		}
	});
}

/*
 * 팝업 생성
 */
function pop_open(html){
	var base = '<div class="wall"></div> <div class="pop"><a href="#" class="close"><span class="blind">닫기</span></a></div>';
	$('body').append(base).css({'overflow':'hidden'});

	var w = $('.wall');
	var p = $('.pop');
	var d = $(document).height();
	
	w.height(d).fadeIn('fast').click(function(e){
		e.preventDefault();
		pop_close();
	});
	p.append(html).find('a.close').click(function(e){
		e.preventDefault();
		pop_close();
	});
	p.fadeIn('fast').css({
		'margin-left':'-' + p.width()/2  + 'px',
		'margin-top' :'-' + p.height()/2 + 'px'
	});
}

/*
 * 팝업 삭제
 */
function pop_close(){
	var w = $('.wall');
	var p  = $('.pop');
	w.fadeOut('fast',function(){
		$(this).remove();
	});
	p.fadeOut('fast',function(){
		$(this).remove();
	});
	$('body').css({'overflow':'auto'});
}

/*
 * 이전 날짜들은 선택막기
 * datepicker
 */
function noBefore(date){
	if (date < new Date()){
		return [false];
	}else{
		return noWeekendsOrHolidays(date);
	}
}

//주말(토, 일요일) 선택 막기
function noWeekendsOrHolidays(date) {
	var noWeekend = jQuery.datepicker.noWeekends(date);
	return noWeekend[0] ? [true] : noWeekend;
}


function readImage(input,img) {
	if ( input.files && input.files[0] ) {
		var FR= new FileReader();
		FR.onload = function(e) {
			img.attr( "src", e.target.result );
		};       
		FR.readAsDataURL( input.files[0] );
	}
}



function number_filter(str_value){
	return str_value.replace(/[^0-9]/gi, ""); 
}