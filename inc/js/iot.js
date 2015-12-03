$(function(){
	
	/**
	 * test 작성중
	 * 내용 높이 셋팅
	 */
	$('#middle').height($(document).height()-415);
	$(window).resize(function(){
		$('#middle').height($(document).height()-415);
	});
	
	/**
	 * test 작성중
	 * 상단 메뉴 스크롤 높이 셋팅
	 */
	$(window).scroll(function(){
		var d = $(window).scrollTop();
		if(d > 50){
			$('#header').addClass('mini');
			TweenMax.to($("#header"), 0.25, {height:50, ease:Sine.easeOut});
		}else{
			$('#header').removeClass('mini');
			TweenMax.to($("#header"), 0.25, {height:100, ease:Sine.easeOut});
		}
	});
	
	/**
	 * test 작성중
	 * 플러그인 checkbox ,radio box 
	 */
	$('input').iCheck({
		checkboxClass: 'icheckbox_flat-blue',
		radioClass: 'iradio_flat-blue'
	});
	
	
	
	
	/**
	 * test 작성중
	 * line move
	 */
	$('#header ul li.item').hover(
		function(){
			var t = $(this);
			TweenMax.to($("#top_nav_line"), 0.25, {width:t.width(), x:t.position().left , ease:Sine.easeOut});
		},function(){
			//
		}
	);
	$('#header nav').hover(
			function(){
				//
			},function(){
				var t = $('#header ul li .active').parent();
				TweenMax.to($("#top_nav_line"), 0.25, {width:t.width(), x:t.position().left , ease:Sine.easeOut});
			}
		);
	/**
	 * 초기 top line
	 */
	var tt = $('#header ul li .active').parent();
	TweenMax.to($("#top_nav_line"), 0.25, {width:tt.width(), x:tt.position().left , ease:Sine.easeOut});
	
	
	/**
	 * test 작성중
	 * jquery input 달력 셋팅
	 */
	$.datepicker.regional['ko'] = {prevText: '이전달',nextText: '다음달',currentText: '오늘',monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)','7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)'],monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],dayNames: ['일','월','화','수','목','금','토'],dayNamesShort: ['일','월','화','수','목','금','토'],dayNamesMin: ['일','월','화','수','목','금','토'],weekHeader: 'Wk',dateFormat: 'yy-mm-dd',firstDay: 0,isRTL: false,showMonthAfterYear: true,yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$( ".datepicker" ).datepicker({
		beforeShowDay: noBefore
	});
	
});

// 이전 날짜들은 선택막기
function noBefore(date){
	if (date < new Date())
		return [false];
	return [true];
}

