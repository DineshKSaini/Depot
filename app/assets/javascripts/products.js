var testingdata;
$(document).on("keypress", "#search", function(){
	var search_value = $(this).val();
	if(search_value.length >= 3){
		window.xhr = $.ajax({
			url: "/products",
			data: {search: search_value},
			type: "get",
			dataType: 'json',
			beforeSend: function(){
			  $('#append_list').html('');
			},
			success: function(retdata){
			if (retdata.length > 0) {
				$user_html = $("<div class='user'>" + retdata[0].title + "</div>");
     			$('#append_list').append($user_html);
				console.log(retdata);
				testingdata = retdata;
			}
		}
		});
	}
});