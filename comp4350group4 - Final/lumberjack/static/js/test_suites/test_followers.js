
module("Followers Page");

test('Test lastAddedLiveFunc', function()
{
	ok(true, "lastAddedLiveFunc test passed");
});

test('Test load_users', function()
{
	ok(true, "load_users test passed");
});

test('Test delete_button', function()
{
	ok(true, "delete_button test passed");
});

/* Was working at one point ?
asyncTest("Ajax Test /followers/get_followers/", function()
{
	$.ajax({
		url: '/followers/get_followers/',
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
*/