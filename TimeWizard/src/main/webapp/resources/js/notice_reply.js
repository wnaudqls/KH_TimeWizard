// 사용자가 답변 버튼을 클릭했을 때
// 서버로 바로 데이터가 날라가지 않도록 하는 기능
	var notice_no = document.getElementById("nno").value;

	function showReplyList(){

		//${pageContext.request.contextPath}
		var url = "/timewizard/reply/replylist";
		var paramData = {"notice_no" : notice_no};
		console.log(paramData);
		$.ajax({

            type: 'POST',

            url: url,

            data: paramData,

            dataType: 'json',

            success: function(result) {

               	var htmls = "";
               	
              

			if(result.length < 1){

				htmls = "등록된 댓글이 없습니다.";

			} else {

					for(i in result){
						var uno = result[i].user_no;
						var reno = result[i].reply_no;
						var recon = result[i].reply_content;
	                    /* htmls += '<div class="media text-muted pt-3" id="reply_no' + this.reply_no + '">';*/
	                     htmls += '<svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder:32x32">';
	                     htmls += '<title>Placeholder</title>';
	                     htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';
	                     htmls += '<text x="50%" fill="#007bff" dy=".3em">32x32</text>';
	                     htmls += '</svg>';
	                     htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
	                     htmls += '<span class="d-block">';
	                     htmls += '<strong class="text-gray-dark">' + uno + '</strong>';
	                     htmls += '<span style="padding-left: 7px; font-size: 9pt">';
	                     htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + reno + ', \'' + uno + '\', \'' + recon + '\' )" style="padding-right:5px">수정</a>';
	                     htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + reno + ')" >삭제</a>';
	                     htmls += '</span>';
	                     htmls += '</span>';
	                     htmls += recon;
	                     htmls += '</p>';
	                     htmls += '</div>';

	               
					}

			}

			$("#replyList").html(htmls);

                

            }	   // Ajax success end

		});	// Ajax end

	}
	
	
window.onload = function(){

	showReplyList();
}


