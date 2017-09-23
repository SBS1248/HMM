<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글작성</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.js"></script>
    
<style type="text/css">
  .sn{
	width: 60%;
	
	text-align: left;
	margin: 0 auto;
}

body{
	text-align: center;
	background-image: ${pageContext.request.contextPath}/resources/img/bw/background.jpg;
}

.dragAndDropDiv {
                border: 2px dashed #92AAB0;
                width: 650px;
                height: 200px;
                color: #92AAB0;
                text-align: center;
                vertical-align: middle;
                padding: 10px 0px 10px 10px;
                font-size:200%;
                display: table-cell;
            }
            .progressBar {
                width: 200px;
                height: 22px;
                border: 1px solid #ddd;
                border-radius: 5px;
                overflow: hidden;
                display:inline-block;
                margin:0px 10px 5px 5px;
                vertical-align:top;
            }
              
            .progressBar div {
                height: 100%;
                color: #fff;
                text-align: right;
                line-height: 22px; /* same as #progressBar height if we want text middle aligned */
                width: 0;
                background-color: #0ba1b5; border-radius: 3px;
            }
            .statusbar{
                border-top:1px solid #A9CCD1;
                min-height:25px;
                width:99%;
                padding:10px 10px 0px 10px;
                vertical-align:top;
            }
            .statusbar:nth-child(odd){
                background:#EBEFF0;
            }
            .filename{
                display:inline-block;
                vertical-align:top;
                width:250px;
            }
            .filesize{
                display:inline-block;
                vertical-align:top;
                color:#30693D;
                width:100px;
                margin-left:10px;
                margin-right:5px;
            }
            .abort{
                background-color:#A8352F;
                -moz-border-radius:4px;
                -webkit-border-radius:4px;
                border-radius:4px;display:inline-block;
                color:#fff;
                font-family:arial;font-size:13px;font-weight:normal;
                padding:4px 15px;
                cursor:pointer;
                vertical-align:top
            }
</style>
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
           		 	board.content=$('input[name=content]').val();
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
                  				alert(alength+","+j);
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

		<header><h1 style="text-align: center;">글쓰기</h1></header>
		<input type="hidden" name="bcode" value="${bcode }">
		<input type="hidden" name="content">
		<input type="hidden" name="writerid" value="${member.id }">
		<input type="text" style="width: 60%" name="title"></input>
		<br><br>
		<p>아이디 : ${sessionScope.member.id }</p>
		<div class="categorys">
		<select id="area" name="distinguish" style="">
			<option value="4" selected>아무말대잔치</option>
				<option value="5">프로젝트게시판</option>
				<option value="1">기업게시판</option>
				<option value="3">신기술게시판</option>
				<option value="2">Q&A</option>
		</select>
		</div>
		<div id="fileUpload" class="dragAndDropDiv">Drag & Drop Files Here</div>
	<!-- 섬머노트 부분 -->
		<div class="sn">
		<div class="content">
		<textarea id="summernote" name="summer"></textarea>
		</div>
		</div>
	
	
    <div class="buttons">
    <button type="button" id="wr">작 성</button>
 	 &nbsp;&nbsp;&nbsp;
  	<a href="javascript:history.go(-2)"><button type="reset">취 소</button></a>
  	</div><!-- buttons -->
  
</body>
</html>