//댓글 저장 버튼 클릭 이벤트

	$(document).on('click', '#insertReplyBtn', function(){

		var reply_content = $('#reply_content').val();
		var user_no = $('#user_no').val();
		var reply_no = $('#reply_no').val();



		var paramData = JSON.stringify({
				
				 "reply_no" : reply_no
				,"reply_content": reply_content

				, "user_no": user_no

				, "notice_no":'${notice_detail.notice_no}'

		});

		

		var headers = {"Content-Type" : "application/json"

				, "X-HTTP-Method-Override" : "POST"};

		

		$.ajax({

			url: "reply/insertreply"

			, headers : headers
			, data : paramData
			, type : 'POST'
			, dataType : 'text'
				
			, success: function(result){

				showReplyList();

				
				$('#reply_content').val('');
				$('#user_no').val('');

			}

			, error: function(error){

				console.log("에러 : " + error);

			}

		});

	});

