var testingdata;
$(document).on("keypress", "#search", function(){
	var search_value = $(this).val();
	if(search_value.length >= 3){
		$('#append_list').destroy;
		window.xhr = $.ajax({
			url: "/products",
			data: {search: search_value},
			type: "get",
			 dataType: 'json',
			success: function(retdata){
			$('#append_list').destroy;
			$user_html = $("<div class='user'>" + retdata[0].title + "<!-- etc --!/></div>");
     		$('#append_list').append($user_html);
				console.log(retdata);
				testingdata = retdata;
			}
		});
	}
});