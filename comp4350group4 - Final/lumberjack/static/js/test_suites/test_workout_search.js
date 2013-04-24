module("Workout Search Page");

test('Test createWorkoutTableContainer', function()
{
    strictEqual(createWorkoutTableContainer(), 0);
});

test('Test setUpWorkoutSearchBar', function()
{
    strictEqual(setUpWorkoutSearchBar(), 0);
});

test('Test setUpExerciseSearchBar', function()
{
    strictEqual(setUpExerciseSearchBar(), 0);
});

test('Test setUpDescriptionSearchBar', function()
{
    strictEqual(setUpDescriptionSearchBar(), 0);
});

test('Test setUpAuthorSearchBar', function()
{
    strictEqual(setUpAuthorSearchBar(), 0);
});

asyncTest("Ajax Test /workouts/autocompleteWorkouts", function()
{
	$.ajax({
		url: '/workouts/autocompleteWorkouts',
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

asyncTest("Ajax Test /workouts/getWorkouts", function()
{
	$.ajax({
		url: '/workouts/getWorkouts',
        type: 'POST',
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
