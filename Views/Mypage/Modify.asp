<div class="max_width_wrap">
	<%SidePlaceHolder()%>
	<div class="sub_contents">
		<div class="inner">
			<h2 class="sub_title_blue">회원정보수정</h2>
			<div class="sub_title_description">회원정보 <b>수정하기</b></div>
			<span class="sub_navigation">My Page <span class="bar">></span> <b>회원정보수정</b></span>
			
			<div class="sub_description">
				<h2 class="sub_caption"><label></label>기본정보</h2>
				
				<form name="mForm" id="mForm" method="POST" action="<%=ViewData("ActionForm")%>">
				<table class="form">
					<tr>
						<td class="title"><span class="red">＊</span>이름</td>
						<td>
							<%=Model.Name%>
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>Email ID</td>
						<td>
							<%=Model.Id%>
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>비빌번호</td>
						<td>
							<div class="input_wrap"><input type="password" name="Pwd" id="Pwd"></div>
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>비빌번호 확인</td>
						<td>
							<div class="input_wrap"><input type="password" name="PwdConfirm" id="PwdConfirm"></div>
						</td>
					</tr>
					<tr>
						<td class="title"><span class="red">＊</span>핸드폰 뒷자리 번호 4개</td>
						<td>
							<div class="input_wrap"><input type="text" name="Phone3" id="Phone3" maxlength="4" value="<%=Model.Phone3%>"></div>
						</td>
					</tr>
				</table>
				<div style="text-align:right;">
					<button type="submit" class="white">수정</button>
				</div>
				</form>
				

			</div>
			
		</div>
	</div>
</div>