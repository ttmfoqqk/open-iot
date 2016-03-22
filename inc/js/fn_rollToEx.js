function fn_rollToEx(containerID,slideID,controlID,stepNum,autoStart){

	// 롤링할 객체를 변수에 담아둔다.
	var el = $('#'+containerID).find('#'+slideID);
	var lastChild;
	var speed = 3000;
	var timer = 0;
	var autoplay = false;

	el.data('prev', $('#'+containerID).find('.prev'));	//이전버튼을 data()메서드를 사용하여 저장한다.
	el.data('next', $('#'+containerID).find('.next'));	//다음버튼을 data()메서드를 사용하여 저장한다.
	el.data('size', el.children().outerWidth());		//롤링객체의 자식요소의 넓이를 저장한다.
	el.data('len', el.children().length);				//롤링객체의 전체요소 개수
	el.data('animating',false);
	el.data('step', stepNum);								//매개변수로 받은 step을 저장한다.
	el.data('autoStart', false);								//매개변수로 받은 step을 저장한다.
	el.data('play', null);
	el.data('stop', null);

	el.css('width',el.data('size')*el.data('len'));		//롤링객체의 전체넓이 지정한다.

	if(arguments[4]==true){
		el.data('autoStart', autoStart);
	}

	if(arguments[2]!= undefined){
		el.data('play', $('#'+controlID).find('.bStart'));
		el.data('stop', $('#'+controlID).find('.bStop'));
	}

	if(el.data('autoStart')){
		if(timer==0){
			timer = setInterval(moveNextSlide, speed);
			autoplay = true;
		}
	}

	el.bind({
		mouseenter:function(){
			if(!autoplay) return false;

			if(timer!=0 && el.data('autoStart')){
				clearInterval(timer);
				timer=0;
			}
		},
		mouseleave:function(){
			if(!autoplay) return false;

			if(timer==0 && el.data('autoStart')){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});


	//el에 첨부된 prev 데이타를 클릭이벤트에 바인드한다.
	el.data('prev').bind({
		click:function(e){
			e.preventDefault();
			movePrevSlide();
		},
		mouseenter:function(){
			if(!autoplay) return false;

			if(timer!=0 && el.data('autoStart')){
				clearInterval(timer);
				timer=0;
			}
		},
		mouseleave:function(){
			if(!autoplay) return false;

			if(timer==0 && el.data('autoStart')){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});

	//el에 첨부된 next 데이타를 클릭이벤트에 바인드한다.
	el.data('next').bind({
		click:function(e){
			e.preventDefault();
			moveNextSlide();
		},
		mouseenter:function(){
			if(!autoplay) return false;

			if(timer!=0 && el.data('autoStart')){
				clearInterval(timer);
				timer=0;
			}
		},
		mouseleave:function(){
			if(!autoplay) return false;

			if(timer==0 && el.data('autoStart')){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});

	if(arguments[4]!= undefined){
		el.data('play').bind({
			click:function(){
				if(timer==0 && el.data('autoStart')){
					timer = setInterval(moveNextSlide, speed);
					autoplay = true;
				}
			}
		});

		el.data('stop').bind({
			click:function(){
				if(timer!=0 && el.data('autoStart')){
					clearInterval(timer);
					timer=0;
					autoplay = false;
				}
			}
		});
	}

	function movePrevSlide(){
		if(!el.data('animating')){
			//전달된 step개수 만큼 롤링객체의 끝에서 요소를 선택하여 복사한후 변수에 저장한다.
			var lastItem = el.children().eq(-(el.data('step')+1)).nextAll().clone(true);
			lastItem.prependTo(el);		//복사된 요소를 롤링객체의 앞에 붙여놓는다.
			el.children().eq(-(el.data('step')+1)).nextAll().remove();	//step개수만큼 선택된 요소를 끝에서 제거한다
			el.css('left','-'+(el.data('size')*el.data('step'))+'px');	//롤링객체의 left위치값을 재설정한다.
		
			el.data('animating',true);	//애니메이션 중복을 막기 위해 첨부된 animating 데이타를 true로 설정한다.

			el.animate({'left': '0px'},'normal',function(){		//롤링객체를 left:0만큼 애니메이션 시킨다.
				el.data('animating',false);
			});
		}
		return false;
	}

	function moveNextSlide(){
		if(!el.data('animating')){
			el.data('animating',true);

			el.animate({'left':'-'+(el.data('size')*el.data('step'))+'px'},'normal',function(){	//롤링객체를 첨부된 size와 step을 곱한 만큼 애니메이션 시킨다.
				//전달된 step개수 만큼 롤링객체의 앞에서 요소를 선택하여 복사한후 변수에 저장한다.
				var firstChild = el.children().filter(':lt('+el.data('step')+')').clone(true);
				firstChild.appendTo(el);	//복사된 요소를 롤링객체의 끝에 붙여놓는다.
				el.children().filter(':lt('+el.data('step')+')').remove();	//step개수만큼 선택된 요소를 앞에서 제거한다
				el.css('left','0px');	////롤링객체의 left위치값을 재설정한다.

				el.data('animating',false);
			});
		}
		return false;
	}

}