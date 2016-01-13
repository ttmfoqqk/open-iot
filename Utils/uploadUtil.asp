<%
' ========================================================================
' Function명 : DextFileUpload
' 목      적 : 첨부파일 업로드 및 데이타 처리
' 입      력 : 
' ========================================================================
Function DextFileUpload(ByVal ControlName,ByVal sFolderName,ByVal thumb)

	set objImage = Server.CreateObject("DEXT.ImageProc") '//-- 이미지 리사이즈를 위해 필요한 객체
	Dim f,i
	Dim returnFileName,strFilePath_new

	' 썸네일 사이즈
	Dim m_width  : m_width = 300
	Dim s_width  : s_width = 80
	
	Set f = UPLOAD__FORM(ControlName)
	if f <> "" then
		Dim file_ext : file_ext = mid(f.FileName, InStrRev(f.FileName, ".") + 1)	'파일명에서 확장자만 분리
		'중복검사
		strFilePath_new = chkFileDup(sFolderName, f.FileName )
		'원본 저장
		f.SaveAs strFilePath_new
		' 이미지 파일 일때 썸네일 저장
		If LCase(file_ext) = "jpg" Or LCase(file_ext) = "jpeg" Or LCase(file_ext) = "gif" Or LCase(file_ext) = "bmp" Or LCase(file_ext) = "png" Then 
			'원본 사이즈 구하기
			ImageWidth = f.ImageWidth
			ImageHeight = f.ImageHeight
			
			' 업로드된 이미지가 썸네일 설정 크기보다 클때만 생성하기.
			If s_width < ImageWidth and thumb = True Then 
				If objImage.SetSourceFile(strFilePath_new) Then '-- 업로드한 파일을 지정해서 있다면
					If LCase(file_ext) = "jpg" Or LCase(file_ext) = "jpeg" then
						objImage.Quality = 100
					End If

					Dim m_size : m_size = get_ImgResizeValue(ImageWidth,ImageHeight, m_width )
					Dim s_size : s_size = get_ImgResizeValue(ImageWidth,ImageHeight, s_width )
					
					m_strFilePath_new = chkFileDup(sFolderName, "m_" & f.FileName )
					m_imagesPath = objImage.SaveAsThumbnail(m_strFilePath_new , m_size(0), m_size(1), false)
					
					s_strFilePath_new = chkFileDup(sFolderName, "s_" & f.FileName )
					s_imagesPath = objImage.SaveAsThumbnail(s_strFilePath_new , s_size(0), s_size(1), false)
				end If

			End If

		End If

		returnFileName = Right(strFilePath_new, len(strFilePath_new) - instrRev(strFilePath_new, "/"))

	Else
		returnFileName = ""
	End If
	DextFileUpload = returnFileName

	set objImage = Nothing ''객체소멸
	if err <> 0 then
		alert("에러발생")
	end if
End Function

' ==================================================================
' Function명 : 중복된 파일명 처리
' 목      적 : 중복된 파일명이 있는지 검사해서 다른이름으로 대체
' 입      력 : FileNameWithoutExt(확장자를 제외한 파일명), FileExt(확장자)
' 리  턴  값 : chkFileDup(파일경로를 포함한 파일명)
' ===================================================================
Function chkFileDup(sFolderName,sFileName)
	Dim strFilePath,f_exist, count
	Dim file_ext, file_name_without_ext
	Dim FSO : Set FSO = Server.CreateObject("Scripting.FileSystemObject")
	f_exist = true
	count = 0
	
	strFilePath=sFolderName & sFileName
	file_ext = mid(sFileName, InStrRev(sFileName, ".") + 1)				'파일명에서 확장자만 분리
	file_name_without_ext = mid(sFileName, 1, InStrRev(sFileName,".")-1)'파일명에서 이름만 분리
	
	Do while f_exist
		If(fso.fileExists(strFilePath)) Then
			sFileName = file_name_without_ext & "(" & count & ")." & file_ext
			strFilePath = sFolderName & sFileName
			count = count + 1
		Else
			f_exist = false
		End If
	Loop

	chkFileDup = strFilePath
End Function

Function get_ImgResizeValue(ByVal ImageWidth,ByVal ImageHeight, ByVal fixWidth )
	Dim Size(1)
	If ImageWidth > fixWidth then
		Size(0) = fixWidth
		Size(1) = ImageHeight * fixWidth / ImageWidth
	Else
		Size(0)  = ImageWidth
		Size(1) = ImageHeight
	End If
	
	get_ImgResizeValue = Size
End Function
%>