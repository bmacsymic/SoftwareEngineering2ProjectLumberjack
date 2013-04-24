module("Workout Page");

test('Test submitNewWorkout', function()
{
	strictEqual(exerciseButtonClick(), "success");
});

test('Test bindExerciseTagChange', function()
{
	strictEqual(bindExerciseTagChange(), "success");
});

test('Test disableFields', function()
{
	strictEqual(disableFields(), "success");
});

test('Test enableFields', function()
{
	strictEqual(enableFields(), "success");
});

test('Test checkIfNameIsUnique', function()
{
	name = "TestNewWorkoutName";
	workoutName = "TestOldWorkoutName";
	strictEqual(checkIfNameIsUnique(name), "success");
});

test('Test editWorkout', function()
{
	strictEqual(editWorkout(), "success");
});

test('Test submitNewWorkout', function()
{
	strictEqual(submitNewWorkout(), "success");
});

test('Test loadWorkout', function()
{
	strictEqual(loadWorkout(), "success");
});

test('Test loadExerciseTypes', function()
{
	strictEqual(loadExerciseTypes(), "success");
});

test('Test setupClickAddExerciseButton', function()
{
	strictEqual(setupClickAddExerciseButton(), "success");
});

test('Test setupClickEditButton', function()
{
	strictEqual(setupClickEditButton(), "success");
});

test('Test setupClickSubmitButton', function()
{
	strictEqual(setupClickSubmitButton(), "success");
});

asyncTest("Ajax Test /workouts/getExerciseTagUnit", function()
{
	$.ajax({
		url: '/workouts/getExerciseTagUnit',
		success: function(response)
		{
			ok(true);
			start();
		},
		failure: function(response)
		{
			ok(false)
			start();
		}
	});
});

asyncTest("Ajax Test /workouts/checkIfNameIsUnique", function()
{
	$.ajax({
		url: '/workouts/checkIfNameIsUnique',
		success: function(response)
		{
			ok(true);
			start();
		},
		failure: function(response)
		{
			ok(false)
			start();
		}
	});
});

asyncTest("Ajax Test /workouts/editWorkout", function()
{
	$.ajax({
		url: '/workouts/editWorkout',
		success: function(response)
		{
			ok(true);
			start();
		},
		failure: function(response)
		{
			ok(false)
			start();
		}
	});
});

asyncTest("Ajax Test /workouts/submitWorkout", function()
{
	$.ajax({
		url: '/workouts/submitWorkout',
		success: function(response)
		{
			ok(true);
			start();
		},
		failure: function(response)
		{
			ok(false)
			start();
		}
	});
});

asyncTest("Ajax Test /workouts/getSingleWorkout", function()
{
	$.ajax({
		url: '/workouts/getSingleWorkout',
		success: function(response)
		{
			ok(true);
			start();
		},
		failure: function(response)
		{
			ok(false)
			start();
		}
	});
});

asyncTest("Ajax Test /workouts/getExerciseTypes", function()
{
	$.ajax({
		url: '/workouts/getExerciseTypes',
		success: function(response)
		{
			ok(true);
			start();
		},
		failure: function(response)
		{
			ok(false)
			start();
		}
	});
});
