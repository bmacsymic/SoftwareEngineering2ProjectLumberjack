//create collapsable
function populateWorkouHistory(name)
{
	$.ajax({
		
	    contentType: "application/json",
	    url: "/workouts/getWorkoutHistory?name="+name,
	    success: function(jsonResponse)
	    {
	    	var results = jsonResponse.Contents
	    	if(results != undefined || results != null)
	    	{
		    	for(var i = 0; i < results.length; i++)
		    	{
		    		var heading = results[i].date+" - "+jsonResponse.User+"'s completed "+results[i].name
		    		var content = results[i].comments
		    		
		    		$(".accordion").append('<div class="accordion-group"><div class="accordion-heading"><a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse'+i+'">'+heading+'</a></div><div id="collapse'+i+'" class="accordion-body collapse"><div class="accordion-inner">'+content+'</div></div></div">');
		    	}
	    	}
	    },
	    error: function(o, e_status, e_text){
	        console.log(e_status);
	        console.log(e_text);
	    }
	});
	return 0;
};