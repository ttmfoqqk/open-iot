$(function(){
	
	$('#middle').height($(document).height()-415);
	$(window).resize(function(){
		$('#middle').height($(document).height()-415);
	});
	
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
	
});