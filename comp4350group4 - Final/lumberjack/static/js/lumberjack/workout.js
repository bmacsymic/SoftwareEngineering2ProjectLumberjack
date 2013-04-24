var htmlOrdering = 1;

function exerciseButtonClick()
{
	var returnVal = "success";
	
	htmlOrdering++;
	var newExerciseItem = $("#SingleExercise").clone();
	$(newExerciseItem).find("#InputOrder").html(htmlOrdering);
	$("#WorkoutDiv").append($(newExerciseItem).html());
	
	bindExerciseTagChange();
	$('.ExerciseType').trigger('change');
	
	return returnVal;
}

function bindExerciseTagChange()
{
	var returnVal = "success";
	
	$('.ExerciseType').bind('change', function()
	{
		var parentDiv = $(this).parent().parent();
		var values = "name=" + $(this).val();
		
		$.ajax({
		    url: "/workouts/getExerciseTagUnit",
		    data: values,
		    success: function(response)
		    {
		    	var unit = response['unit'];
		    	parentDiv.find("#InputUnit").html(unit);
		    },
		    error: function(response)
		    {
		    	returnVal = "failure";
		    }
		});
	});
	
	return returnVal;
}

function disableFields()
{
	var returnVal = "success";
	$(".WorkoutEditableField").attr('disabled', 'disabled');
	
	return returnVal;
}

function enableFields()
{
	var returnVal = "success";
	$(".WorkoutEditableField").removeAttr('disabled');
	
	return returnVal;
}

function checkIfNameIsUnique(name)
{
	var returnVal = "success";
	if(name.length != 0)
	{
		var values = "name=" + name;
		
    	if(name == workoutName)
    	{
    		editWorkout();
    	}
    	else
    	{
			$.ajax({
			    url: "/workouts/checkIfNameIsUnique",
			    data: values,
			    success: function(response)
			    {
			    	var result = response['Result'];
				    if(result == "True")
				    {
				    	$("#ErrorDiv").html("");
				    	submitNewWorkout();
				    }
				    else
				    {
				    	$("#ErrorDiv").html("");
			    		$('#ErrorDiv').fadeIn('slow', function() {
			    			$("#ErrorDiv").html("<FONT COLOR='FF0000'>Error!</FONT> " + "Workout Name is not unique. Please try another name.");
			    		});
				    }
			    },
			    error: function(response)
			    {
			    	returnVal = "failure";
			    }
			});
    	}
	}
	else
	{
    	$("#ErrorDiv").html("");
		$('#ErrorDiv').fadeIn('slow', function() {
			$("#ErrorDiv").html("<FONT COLOR='FF0000'>Error!</FONT> " + "Please enter a workout name.");
		});
		returnVal = "failure";
	}
	
	return returnVal;
}

function editWorkout()
{
	var returnVal = "success";
    var name = $("#InputWorkoutName").val();
    
    if(name != undefined && name.length != 0)
    {
        var description = $("#InputDescription").val();
    	var level = $("#InputIntensityLevel option:selected").val();
        
    	var isPublic = $("#InputIsPublic").is(':checked');
        var isLikeable = $("#InputIsLikeable").is(':checked');
        var isCommentable = $("#InputIsCommentable").is(':checked');
    	
    	var jsonWorkout = {"name": name, "description": description, "level": level,
        		"isPublic": isPublic, "isLikeable": isLikeable, "isCommentable": isCommentable, 
        		"exercises": []};
    	
    	var entries = $("#WorkoutDiv").find(".Exercise");
    	$(entries).each(function()
    	{
    		var order = $(this).find("#InputOrder").html();
    		var type = $(this).find("#InputExerciseType option:selected").val();
    		var unit = $(this).find("#InputUnit").html();
    		var amount = $(this).find("#InputAmount").val();
    		var additionalInfo = $(this).find("#InputAdditionalInfo").val();
    		
    		jsonWorkout.exercises.push( { "order": order, "type": type, "unit": unit, 
    			"amount": amount, "additionalInfo": additionalInfo} );
    	});
    	
    	$.ajax({
    		type: "POST",
    	    contentType: "application/json; charset=utf-8",
    	    url: "/workouts/editWorkout",
    	    data: JSON.stringify(jsonWorkout),
    	    success: function(response)
    	    {
    	    	var result = response['Result'];
    	    	
    	    	if(result == "Success")
    	    	{
        	    	$("#ErrorDiv").html("");
            		$('#ErrorDiv').fadeIn('slow', function()
            		{
            			$("#ErrorDiv").html("<FONT COLOR='00FF00'>Success!</FONT> Successfully updated the workout.");
            		});
            		
        			$("#EditButton").text("Edit");
        			disableFields();
    	    	}
    	    	else
    	    	{
        	    	$("#ErrorDiv").html("");
            		$('#ErrorDiv').fadeIn('slow', function()
            		{
            			$("#ErrorDiv").html("<FONT COLOR='FF0000'>Error!</FONT>  There was a problem updating the workout.");
            		});
            		returnVal = "failure";
    	    	}
    	    },
    	    error: function(response)
    	    {
    	    	$("#ErrorDiv").html("");
        		$('#ErrorDiv').fadeIn('slow', function()
        		{
        			$("#ErrorDiv").html("<FONT COLOR='FF0000'>Error!</FONT>  There was a problem updating the workout.");
        		});
        		returnVal = "failure";
    	    }
    	});
    }
	
    return returnVal;
}

function submitNewWorkout()
{
	var returnVal = "success";
    var name = $("#InputWorkoutName").val();
    
    if(name != undefined && name.length != 0)
    {
	    var description = $("#InputDescription").val();
		var level = $("#InputIntensityLevel option:selected").val();
	    
		var isPublic = $("#InputIsPublic").is(':checked');
	    var isLikeable = $("#InputIsLikeable").is(':checked');
	    var isCommentable = $("#InputIsCommentable").is(':checked');
		
		var jsonWorkout = {"name": name, "description": description, "level": level,
	    		"isPublic": isPublic, "isLikeable": isLikeable, "isCommentable": isCommentable, 
	    		"exercises": []};
		
		var entries = $("#WorkoutDiv").find(".Exercise");
		$(entries).each(function()
		{
			var order = $(this).find("#InputOrder").html();
			var type = $(this).find("#InputExerciseType option:selected").val();
			var unit = $(this).find("#InputUnit").val();
			var amount = $(this).find("#InputAmount").val();
			var additionalInfo = $(this).find("#InputAdditionalInfo").val();
			
			jsonWorkout.exercises.push( { "order": order, "type": type, "unit": unit, 
				"amount": amount, "additionalInfo": additionalInfo} );
		});
		
		$.ajax({
			type: "POST",
		    contentType: "application/json; charset=utf-8",
		    url: "/workouts/submitWorkout",
		    data: JSON.stringify(jsonWorkout),
		    success: function(response)
		    {
		    	var result = response['Result'];
		    	if(result == "Success")
		    	{
			    	$("#ErrorDiv").html("");
		    		$('#ErrorDiv').fadeIn('slow', function()
		    		{
		    			$("#ErrorDiv").html("<FONT COLOR='00FF00'>Success!</FONT> Successfully saved the workout.");
		    		});
		    	}
		    	else
		    	{
			    	$("#ErrorDiv").html("");
		    		$('#ErrorDiv').fadeIn('slow', function()
		    		{
		    			$("#ErrorDiv").html("<FONT COLOR='FF0000'>Error!</FONT> There was a problem saving the workout.");
		    		});
		    		returnVal = "failure";
		    	}

		    },
		    error: function(response)
		    {
		    	$("#ErrorDiv").html("");
	    		$('#ErrorDiv').fadeIn('slow', function()
	    		{
	    			$("#ErrorDiv").html("<FONT COLOR='FF0000'>Error!</FONT> There was a problem saving the workout.");
	    		});
	    		returnVal = "failure";
		    }
		});
    }
    return returnVal;
}

function loadWorkout()
{
	var returnVal = "success";
	if(workoutName != undefined && workoutName.length != 0)
	{
		var data = "name=" + workoutName;
		$.ajax({
		    url: "/workouts/getSingleWorkout",
		    data: data,
		    success: function(response)
		    {
		    	var result = response['Result'];
		    	
		    	if(result == "Success")
		    	{
			    	var name = response.workoutData['name'];
			    	var description = response.workoutData['description'];
			    	var level = response.workoutData['level'];
			    	var isPublic = response.workoutData['is_public'];
			    	var isLikeable = response.workoutData['is_likeable'];
			    	var isCommentable = response.workoutData['is_commentable'];
			    	
			    	$("#LegendWorkoutName").text(name);
			    	$("#InputWorkoutName").val(name);
			    	$("#InputIntensityLevel").val(level);
			    	$("#InputDescription").val(description)
			    	
			    	if(isPublic)
			    	{
			    		$("#InputIsPublic").attr('checked', 'checked');
			    	}
			    	else
			    	{
			    		$("#InputIsPublic").removeAttr('checked');
			    	}
			    	if(isLikeable)
			    	{
			    		$("#InputIsLikeable").attr('checked', 'checked');
			    	}
			    	else
			    	{
			    		$("#InputIsLikeable").removeAttr('checked');
			    	}
			    	if(isCommentable)
			    	{
			    		$("#InputIsCommentable").attr('checked', 'checked');
			    	}
			    	else
			    	{
			    		$("#InputIsCommentable").removeAttr('checked');
			    	}
			    	var newExerciseItem;
			    	
			    	if(response.exerciseData.length != 0)
			    	{
				    	var order = response.exerciseData[0]['order'];
				    	var type = response.exerciseData[0]['eTagName'];
				    	var amount = response.exerciseData[0]['amount'];
				    	var unit = response.exerciseData[0]['eTagUnit'];
				    	var additionalInfo = response.exerciseData[0]['additionalInfo'];
				    	
						$("#SingleExercise #InputOrder").html(order);
						$("#SingleExercise .ExerciseType").val(type);
				    	$("#SingleExercise #InputAmount").val(amount);
				    	$("#SingleExercise #InputUnit").val(unit);
				    	$("#SingleExercise #InputAdditionalInfo").val(additionalInfo);
				    	
				    	for(var i = 1; i < response.exerciseData.length; i++)
				    	{
				    		htmlOrdering = i + 1;
							newExerciseItem = $("#SingleExercise").clone();
							$("#WorkoutDiv").append($(newExerciseItem).html());
							
							var exerciseList = $("#WorkoutDiv").find(".Exercise");
							var currentExercise = exerciseList[i];
					    	type = response.exerciseData[i]['eTagName'];
					    	amount = response.exerciseData[i]['amount'];
					    	unit = response.exerciseData[i]['eTagUnit'];
					    	additionalInfo = response.exerciseData[i]['additionalInfo'];
					    	
							$(currentExercise).find("#InputOrder").html(htmlOrdering);
							$(currentExercise).find(".ExerciseType").val(type);
							$(currentExercise).find("#InputAmount").val(amount);
							$(currentExercise).find("#InputUnit").text(unit);
							$(currentExercise).find("#InputAdditionalInfo").val(additionalInfo);
				    	}
			    	}
			    	
			    	disableFields();
			    	bindExerciseTagChange();
			    	$('.ExerciseType').trigger('change');
		    	}
		    	else
		    	{
			    	$("#ErrorDiv").html("");
		    		$('#ErrorDiv').fadeIn('slow', function() {
		    			$("#ErrorDiv").html("<FONT COLOR='FF0000'>Error!</FONT> " +
		    					" There was a problem loading the workout.");
		    		});
		    		returnVal = "failure";
		    	}
		    }
		});
	}
	
	return returnVal;
}

function loadExerciseTypes()
{
	var returnVal = "success";
	$.ajax({
	    contentType: "application/json",
	    url: "/workouts/getExerciseTypes",
	    success: function(jsonResponse)
	    {
	    	var names = jsonResponse.names.split(",");
	    	for(var i = 0; i < names.length; i++)
	    	{
	    		if(names[i].length > 0)
	    		{
	    			$("#InputExerciseType").append('<option value="' + names[i] + '">' + names[i] + '</option>');
	    		}
	    	}
	    	bindExerciseTagChange();
	    	$('.ExerciseType').trigger('change');
	    },
	});
	
	return returnVal;
}

function setupClickAddExerciseButton()
{
	var returnVal = "success";
	$("#AddExerciseButton").click(function()
	{
		exerciseButtonClick();
	});
	
	return returnVal;
}

function setupClickEditButton()
{
	var returnVal = "success";
	
	$("#EditButton").click(function()
	{
		var buttonName = $("#EditButton").text();
		if(buttonName == "Edit")
		{
			$("#EditButton").text("Submit");
			enableFields();
		}
		else
		{
			var name = $("#InputWorkoutName").val();
			checkIfNameIsUnique(name);
		}
	});
	
	return returnVal;
}

function setupClickSubmitButton()
{
	var returnVal = "success";
	
	$("#SubmitButton").click(function()
	{
		var name = $("#InputWorkoutName").val();
		checkIfNameIsUnique(name);
	});
	
	return returnVal;
}

$(document).ready(function()
{
	setupClickAddExerciseButton();
	setupClickEditButton();
	setupClickSubmitButton();
});
