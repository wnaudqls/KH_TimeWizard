// 사용자가 답변 버튼을 클릭했을 때
// 서버로 바로 데이터가 날라가지 않도록 하는 기능
	var notice_no = document.getElementById("nno").value;

	function showReplyList(){

		//${pageContext.request.contextPath}
		var url = "/timewizard/reply/replylist";
		var paramData = {"notice_no" : notice_no};
		
		console.log(paramData);
		console.log(user_id);
	
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
						var redate = result[i].reply_regdate;
						var uid = result[i].user_id;
						
						console.log(uid);
						
	                    /* htmls += '<div class="media text-muted pt-3" id="reply_no' + this.reply_no + '">';*/
						
						 htmls += '<div class="relist">'
						 htmls += '<div> ';
	                     htmls += '<p>';
	                     htmls += '<span class="d-block">';
	                     htmls += '<strong> ID &nbsp; : '+uid+'</strong>';// 아이디
	                     htmls += '<p>Comment &nbsp; : &nbsp; '+recon +'</p>';
	                     htmls += '<h5>Date &nbsp; : '+ redate+'</h5>';
	                     htmls += '<span style="padding-left: 7px; font-size: 9pt">';
	                     htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + reno + ', \'' + uno + '\', \'' + recon + '\' )" style="padding-right:5px">수정</a>';
	                     htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + reno + ')" >삭제</a>';
	                     htmls += '</span>';
	                     htmls += '</span>';
	                     htmls += '</p>';
	                     htmls += '<br>';    
	                     htmls += '</div>';
	                     htmls += '</div>';
	                     htmls += '<p style="border-top: 1px solid #ccc;"></p>';

	               
					}

			}

			$("#replyList").html(htmls);

                

            }	   // Ajax success end

		});	// Ajax end

	}
	
	
window.onload = function(){

	showReplyList();
}


