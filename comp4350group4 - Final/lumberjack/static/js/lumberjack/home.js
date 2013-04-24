function setUpCarousel()
{
	$('#myCarousel').carousel();
	return 0;
}

function fillCarousel()
{
	$.ajax({
	    contentType: "application/json",
	    url: "/workouts/get_most_recent",
	    success: function(jsonResponse)
	    {	
	    	console.log(jsonResponse)
	    	var result = jsonResponse.Content
	    	for (var i=0;i<result.length;i++)
	    	{ 
	    		var obj = result[i]
		    	$(".carousel-inner").append('<div class="item"><img src='+obj.image+'><div class="container"><div class="carousel-caption"><h1>'+obj.name+'</h1><p class="lead">'+obj.description+'</p><a class="btn btn-large btn-primary" href="/workouts/workout?name='+result[i].name+'">View Workout</a></div></div></div>');
	    	}
	    },
	    error: function(o, e_status, e_text){
               console.log(e_status);
               console.log(e_text);
        }
	});
	return 0;
}

$(document).ready(function() 
{
	setUpCarousel();
	fillCarousel();
});