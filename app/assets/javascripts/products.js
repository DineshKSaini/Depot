var testingdata;
$(document).on("keypress", "#search", function(){
	var search_value = $(this).val();
	if(search_value.length >= 2){
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
				// $user_html = $("<div class='user'>" + retdata[0].title + "</div>");
    			//$('#append_list').append($user_html);
				// console.log(retdata);
				// testingdata = retdata;
				$( "#search" ).autocomplete({
               			source: make_search_result_html(retdata),
               			 messages: {
				         noResults: '',
				         results: function() {}
				    	 },
				    	 select: function( event, retdata ) {
				    	 	
				    	 	var v =retdata.item.value;
				    	 	retdata.item.value=retdata.item.label;
				    	 	
				    	 	window.location = 'products/'+v;
				    	 }
            		});
			}
		}
		});
	}
});

function make_search_result_html(retdata){
	var data = [];
	$.each(retdata, function(){
		data.push({label :this["title"]  ,value:this['id']})
	});
	return data;
}