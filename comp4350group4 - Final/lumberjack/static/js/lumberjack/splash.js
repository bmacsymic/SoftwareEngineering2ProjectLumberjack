function setUpCarousel()
{
    $('#myCarousel').carousel();
    return 0;
}

function setUpDateTimePicker()
{
	$('#dtp1').datetimepicker({
    	language: 'en',
    	pick12HourFormat: true
    });
	return 0;
}

function fillCarouselContents() 
{
	$.ajax({
		contentType: "application/json",
  		url: "/user/splash/contents",
  		success: function(jsonResponse)
  		{		    	
  		 	console.log(jsonResponse)
  		    	
  		   	//apend newest user
  		   	$(".carousel-inner").append('<div class="item active"><img src="'+jsonResponse.nuPic+'"><div class="container"><div class="carousel-caption"><h1>Our Newest Member</h1><p class="lead">'+jsonResponse.nUser.username+' join on '+jsonResponse.nUser.date+'</p><a class="btn btn-large btn-primary" href="#">View Profile</a></div></div></div>');
  		    	
  		   	//our newest workout
  		   	$(".carousel-inner").append('<div class="item"><div class="container"><div class="carousel-caption"><h1>Newest Workout</h1><h3>'+jsonResponse.nWorkout.name+'</h3><p class="lead">'+jsonResponse.nWorkout.description+'</p><a class="btn btn-large btn-primary" href="/workouts/workout?name='+jsonResponse.nWorkout.name+'">View Wokrout</a></div></div></div>');

  		   	//most followed user
  		   	$(".carousel-inner").append('<div class="item"><img src="'+jsonResponse.mfPic+'"><div class="container"><div class="carousel-caption"><h1>Most Popular User</h1><p class="lead">'+jsonResponse.mostFollowed.username+'</p><a class="btn btn-large btn-primary" href="#">View Profile</a></div></div></div>');

  		},
  		error: function(o, e_status, e_text){
  			console.log(e_status);
  		    console.log(e_text);
  		}
	});
	return 0;
}
  	
function submitWorkoutSession(current_user) {
  	console.log('button pressed')
  	$.post($SCRIPT_ROOT + "/submit_workout_history", {
  		wName: document.getElementsByName("wName")[0].value,
  		date: document.getElementsByName("dateCompleted")[0].value,
  		desc: document.getElementsByName("description")[0].value,
  		user: current_user
  	}, function(data) {
  		if (data.result == "success") {
  			formReset();
  			$("#myModal").modal('hide');
  		}
  		else
  		{
  			if(data.result == "errorName")
  			{
  				$("#alert-section").append('<div class="alert fade in"><button type="button" class="close" data-dismiss="alert">x</button><strong>Excuse me,</strong>'+data.content+'</div>');
  				
  			}
  			else if(data.result == "errorDate")
  			{
  				$("#alert-section").append('<div class="alert fade in"><button type="button" class="close" data-dismiss="alert">x</button><strong>Excuse me,</strong>'+data.content+'</div>');
  			}
  		}
  	});
  	return 0;
}
  	
function formReset() 
{
	document.getElementById("publish_form").reset()
	return 0;
}

$(document).ready(function()
{
	setUpCarousel();
	setUpDateTimePicker();
	fillCarouselContents();
});