<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<%-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<link href="resources/css/write.css" rel="stylesheet" type="text/css">

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>

<link	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.css"	rel="stylesheet">
<script	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.js"></script> --%>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet">
<%-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css"> --%>
<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link href="resources/css/write.css" rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.js"></script>

<script type="text/javascript">
            $(document).ready(function(){
                var objDragAndDrop = $(".dragAndDropDiv");

                $(document).on("dragenter",".dragAndDropDiv",function(e){
                    e.stopPropagation();
                    e.preventDefault();
                    $(this).css('border', '2px solid #0B85A1');
                });
                $(document).on("dragover",".dragAndDropDiv",function(e){
                    e.stopPropagation();
                    e.preventDefault();
                });
                $(document).on("drop",".dragAndDropDiv",function(e){

                    $(this).css('border', '2px dotted #0B85A1');
                    e.preventDefault();
                    var files = e.originalEvent.dataTransfer.files;

                    handleFileUpload(files,objDragAndDrop);
                });

                $(document).on('dragenter', function (e){
                    e.stopPropagation();
                    e.preventDefault();
                });
                $(document).on('dragover', function (e){
                  e.stopPropagation();
                  e.preventDefault();
                  objDragAndDrop.css('border', '2px dotted #0B85A1');
                });
                $(document).on('drop', function (e){
                    e.stopPropagation();
                    e.preventDefault();
                });


                var fileArray=new Array();
                function handleFileUpload(files,obj)
                {
                   alength=files.length;
                   for (var i = 0; i < files.length; i++)
                   {
                        var fd = new FormData();
                        fd.append('file', files[i]);

                        var status = new createStatusbar(obj); //Using this we can set progress.
                        status.setFileNameSize(files[i].name,files[i].size);

                     	 var fileData=new Object();
	                     	fileData.form=fd;
	                     	fileData.stat=status;

	                     	fileArray.push(fileData);
                   }

                }

                var j=1;
                var alength=0;
                $('#wr').click(function(){

                	var board=new Object();
           	 		board.bcode=$('input[name=bcode]').val();
           	 		board.title=$('input[name=title]').val();
           		 	board.content=$('textArea[name=content]').val().slice(3,-4);
      	    		board.distinguish=$('select[name=distinguish]').val();
          		 	board.writerid=$('input[name=writerid]').val();

          		 	if(board.title == ''){
          				alert("제목이 비어있습니다.");
          				return;
          			}

                	$.ajax({
                        type : "POST",
                        url : "write.do",
                        data : board,
                        success : function() {
                        	if(fileArray.length==0)
                        	{
                        		window.location.href="boardOne.do?bcode=${bcode}";
                        	}

                        	for(var i=0;i<fileArray.length;i++)
                        	{
                        		sendFileToServer(fileArray[i].form,fileArray[i].stat,j,fileArray.length);
                        	}


                        },
                        error:function(request,status,error){
                            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                           }
               		 });
                });

                var rowCount=0;
                function createStatusbar(obj){

                    rowCount++;
                    var row="odd";
                    if(rowCount %2 ==0) row ="even";
                    this.statusbar = $("<div class='statusbar "+row+"'></div>");
                    this.filename = $("<div class='filename'></div>").appendTo(this.statusbar);
                    this.size = $("<div class='filesize'></div>").appendTo(this.statusbar);
                    this.progressBar = $("<div class='progressBar'><div></div></div>").appendTo(this.statusbar);
                    this.abort = $("<div class='abort'>중지</div>").appendTo(this.statusbar);

                    obj.after(this.statusbar);

                    this.setFileNameSize = function(name,size){
                        var sizeStr="";
                        var sizeKB = size/1024;
                        if(parseInt(sizeKB) > 1024){
                            var sizeMB = sizeKB/1024;
                            sizeStr = sizeMB.toFixed(2)+" MB";
                        }else{
                            sizeStr = sizeKB.toFixed(2)+" KB";
                        }

                        this.filename.html(name);
                        this.size.html(sizeStr);
                    }

                    this.setProgress = function(progress){
                        var progressBarWidth =progress*this.progressBar.width()/ 100;
                        this.progressBar.find('div').animate({ width: progressBarWidth }, 10).html(progress + "% ");
                        if(parseInt(progress) >= 100)
                        {
                            this.abort.hide();
                        }
                    }

                    this.setAbort = function(jqxhr){
                        var sb = this.statusbar;
                        this.abort.click(function()
                        {
                            jqxhr.abort();
                            sb.hide();
                        });
                    }
                }

                function sendFileToServer(formData,status)
                {
                    var uploadURL = "fileUp.do?bcode="+$('input[name=bcode]').val(); //Upload URL
                    var extraData ={}; //Extra Data.
                    var jqXHR=$.ajax({
                            xhr: function() {
                            var xhrobj = $.ajaxSettings.xhr();
                            if (xhrobj.upload) {
                                    xhrobj.upload.addEventListener('progress', function(event) {
                                        var percent = 0;
                                        var position = event.loaded || event.position;
                                        var total = event.total;
                                        if (event.lengthComputable) {
                                            percent = Math.ceil(position / total * 100);
                                        }
                                        //Set progress
                                        status.setProgress(percent);
                                    }, false);
                                }
                            return xhrobj;
                        },
                        url: uploadURL,
                        type: "POST",
                        contentType:false,
                        processData: false,
                        cache: false,
                        data: formData,
                        success: function(data){
                            status.setProgress(100);

                  			if(alength==j++)
                  			{
                  				window.location.href="boardOne.do?bcode=${bcode}";
                  			}
                            //$("#status1").append("File upload Done<br>");
                        }
                    });

                    status.setAbort(jqXHR);
                }

            });
        </script>


	<script>
		$(function(){
			$('#summernote').summernote({
		  	  height: 500,                 // set editor height
		  	  width: '100%',
		  	  focus: true,                  // set focus to editable area after initializing summernote
		  	  placeholder: "이미지를 삽입 하시려면 Picture 버튼을 클릭 후 사진을 드래그 또는 찾아보기 하시오.",
		  	  minHeight: null,      // 최소 높이값(null은 제한 없음)
		  	  maxHeight: null,      // 최대 높이값(null은 제한 없음)
		  	  toolbar: [
		  		    // [groupName, [list of button]]
		  		    ['style', ['bold', 'italic', 'underline', 'clear']],
		  		    ['font', ['strikethrough', 'superscript', 'subscript']],
		  		    ['fontsize', ['fontsize']],
		  		    ['color', ['color']],
		  		    ['para', ['ul', 'ol', 'paragraph']],
		  		    ['height', ['height']]
		  		  ]

				});
		});
	</script>
</head>
<body>
<%-- <%@ include file="/header.jsp"%> --%>
	<div class="container">
	<div class="post">

	<input type="hidden" name="bcode" value="${bcode }">
	<input type="hidden" name="content">
	<input type="hidden" name="writerid" value="${member.id }">

	<h3 id="the_post_title">제목&nbsp;&nbsp;&nbsp;&nbsp;<input id="post_title" type="text" name="title"></input></h3>
	<%-- 글쓴이 아이디 숨김 --%>
	<span style="display:none">${sessionScope.member.id }</span>
	<br>
	<div id="post_categories">
	<c:if test="${dis ne null }">
				<select id="area" name="distinguish" style="display:none;">
					<option value="${dis }" selected></option>
				</select>
				${dname } &nbsp;게시판
			</c:if>

			<c:if test="${dis eq null }">
				<h4>게시글 카테고리 선택 :
					<select id="area" name="distinguish">
						<option value="4" selected>아무말대잔치</option>
						<option value="5">프로젝트&소스</option>
						<option value="1">기업게시판</option>
						<option value="3">신기술게시판</option>
						<option value="2">Q&A</option>
					</select>
				</h4>
			</c:if>
		</div>
<br>
	<div id="fileUpload" class="dragAndDropDiv">이 곳에 파일을 끌어다 놓으세요</div>
<br>
	<!-- 섬머노트 부분 -->
	<div class="sn">
		<div class="content">
			<textarea id="summernote" name="content" cols="80" rows="8" style="resize: none"></textarea>
		</div>
	</div>

	<div class="buttons">
		<button type="button" id="wr">글 등록</button>
		&nbsp;&nbsp;&nbsp; <a href="javascript:history.go(-2)"><button
				type="reset">등록 취소</button></a>
	</div>
	</div>
</div>
</body>
</html>