
var target = UIATarget.localTarget();

function test_workout_creation()
{
    var testname = "LumberJack - Workout Creation";
    var randomNumber = Math.floor(Math.random()*1001)
    
    UIALogger.logStart(testname);
	target.frontMostApp().tabBar().buttons()["Settings"].tap();
	target.frontMostApp().mainWindow().buttons()["Log In"].tap();
	target.frontMostApp().mainWindow().textFields()[0].tap();
	target.frontMostApp().keyboard().typeString("Bradley");
	target.frontMostApp().mainWindow().secureTextFields()[0].tap();
	target.frontMostApp().keyboard().typeString("123");
	target.frontMostApp().mainWindow().buttons()["Log In"].tap();
	target.frontMostApp().mainWindow().buttons()["Hidden Button"].tap();
	target.frontMostApp().mainWindow().buttons()["Workout"].tap();
	target.frontMostApp().mainWindow().scrollViews()[0].textFields()[0].tap();
	target.frontMostApp().keyboard().typeString("Brad's Test Workout - " + randomNumber);
	target.frontMostApp().mainWindow().scrollViews()[0].pickers()[0].wheels()[0].scrollToVisible();
	target.frontMostApp().mainWindow().scrollViews()[0].buttons()["Public"].tap();
	target.frontMostApp().mainWindow().scrollViews()[0].buttons()["Likeable"].tap();
	target.frontMostApp().mainWindow().scrollViews()[0].buttons()["Commentable"].tap();
	target.frontMostApp().mainWindow().scrollViews()[0].textFields()[1].tap();
	target.frontMostApp().keyboard().typeString("This is the description");
	target.frontMostApp().mainWindow().scrollViews()[0].pickers()[1].wheels()[0].scrollToVisible();
	target.tap({x:724.00, y:979.00});
    target.tap({x:724.00, y:979.00});
	target.delay(1);
	target.frontMostApp().mainWindow().scrollViews()[0].textFields()[2].tap();
	target.frontMostApp().keyboard().typeString("100");
	target.tap({x:724.00, y:979.00});
    target.tap({x:724.00, y:979.00});
    target.delay(1);
	target.frontMostApp().mainWindow().scrollViews()[0].buttons()[3].tap();
	// Alert detected. Expressions for handling alerts should be moved into the UIATarget.onAlert function definition.
	//target.frontMostApp().alert().cancelButton().tap();
	target.frontMostApp().tabBar().buttons()["Settings"].tap();
	target.frontMostApp().mainWindow().buttons()["Log Out"].tap();
	target.frontMostApp().tabBar().buttons()["Home"].tap();
    
    //test pass
    UIALogger.logPass(testname);
}

test_workout_creation();
