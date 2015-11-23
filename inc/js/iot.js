$(function(){
	
	$('#middle').height($(document).height()-415);
	$(window).resize(function(){
		$('#middle').height($(document).height()-415);
	});
	
	$(window).scroll(function(){
		var d = $(window).scrollTop();
		if(d > 50){
			$('#header').addClass('mini').stop().animate({'height':'50px'},150);
		}else{
			$('#header').removeClass('mini').stop().animate({'height':'100px'},150);
		}
	});
	
});