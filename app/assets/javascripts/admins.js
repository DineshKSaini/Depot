var testingdata;
$(document).on("keypress", "#automplete_1", function(){
	var search_value = $(this).val();
	if(search_value.length >= 2){
		window.xhr = $.ajax({
			url: " ",
			data: {searchuser: search_value},
			type: "get",
			dataType: 'json',
			beforeSend: function(){
			 // $('#user_list').html('');
			},
			success: function(retdata){
				//console.log(retdata);
				testingdata = retdata;
				if (retdata.length > 0) {
					$( "#automplete_1" ).autocomplete({
               			source: make_search_result_html(retdata),
               			 messages: {
				         noResults: '',
				         results: function() {}
				    	 },
				    	 select: function( event, retdata ) {
				    	 	document.getElementById("userid").value = retdata.item.value;
				    	 	//var v= document.getElementById('automplete_1');
				    	 	//v.value = retdata.item.label;
				    	 	retdata.item.value=retdata.item.label;
				    	 }
            		});
            		//$( "#automplete_1" ).autocomplete("option", "position", { my : "right-10 top+10", at: "right top" })
				}
			}
		});
	}
});

function make_search_result_html(retdata){
	var data = [];
	$.each(retdata, function(){
		data.push({label :this["first_name"] + " " + this["last_name"] ,value:this['id']})
	});
	return data;
}


// $('#autocomplete').autocomplete({
//     serviceUrl: '',
//     onSelect: function (suggestion) {
//         alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
//     }
// });