var target = UIATarget.localTarget();

function test_workouthistory()
{
    var testname = "LumberJack - Workout History Test";
    
    UIALogger.logStart(testname);
	
	target.frontMostApp().tabBar().buttons()["Settings"].tap();
	target.frontMostApp().mainWindow().buttons()["Log In"].tap();
	target.frontMostApp().mainWindow().textFields()[0].tap();
	target.frontMostApp().keyboard().typeString("Cameron");
	target.frontMostApp().mainWindow().secureTextFields()[0].tap();
	target.frontMostApp().keyboard().typeString("123");
	target.frontMostApp().mainWindow().buttons()["Log In"].tap();
	target.frontMostApp().mainWindow().textViews()[0].tapWithOptions({tapOffset:{x:0.99, y:0.07}});
	target.frontMostApp().mainWindow().buttons()["Workout History"].tap();
	target.frontMostApp().mainWindow().tableViews()[0].cells()["Jeremy's Meh Workout"].tap();target.tap({x:762.00, y:79.00});
	
	
	target.frontMostApp().mainWindow().buttons()["Profile"].tap();
	target.frontMostApp().tabBar().buttons()["Settings"].tap();
	target.frontMostApp().mainWindow().buttons()["Log Out"].tap();
	target.frontMostApp().tabBar().buttons()["Home"].tap();
	
	
    UIALogger.logPass(testname);
}

function test_AddSession()
{
    var testname = "LumberJack - Add Session Test";
    
    UIALogger.logStart(testname);
	
	target.frontMostApp().tabBar().buttons()["Settings"].tap();
	target.frontMostApp().mainWindow().buttons()["Log In"].tap();
	target.frontMostApp().mainWindow().textFields()[0].tap();
	target.frontMostApp().keyboard().typeString("Cameron");
	target.frontMostApp().mainWindow().secureTextFields()[0].tap();
	target.frontMostApp().keyboard().typeString("123");
	target.frontMostApp().mainWindow().buttons()["Log In"].tap();
	target.frontMostApp().mainWindow().textViews()[0].tapWithOptions({tapOffset:{x:0.99, y:0.02}});
	target.frontMostApp().mainWindow().buttons()["Workout History"].tap();
	target.frontMostApp().mainWindow().tableViews()[0].cells()[0].tap();
	target.frontMostApp().mainWindow().tableViews()[0].cells()[1].tap();
	target.frontMostApp().navigationBar().rightButton().tap();
	target.frontMostApp().mainWindow().textFields()[0].tap();
	target.frontMostApp().keyboard().typeString("Shaw's Lazy Workout");
	target.frontMostApp().mainWindow().textViews()[0].tapWithOptions({tapOffset:{x:0.21, y:1.86}});
	target.frontMostApp().keyboard().typeString("UI Test Case");
	target.frontMostApp().mainWindow().buttons()["Add Session"].tap();
	target.frontMostApp().mainWindow().textViews()[0].tapWithOptions({tapOffset:{x:0.99, y:0.05}});
	target.frontMostApp().mainWindow().buttons()["Workout History"].tap();
	target.frontMostApp().mainWindow().tableViews()[0].cells()[0].tap();
	target.frontMostApp().tabBar().buttons()["Settings"].tap();
	target.frontMostApp().mainWindow().buttons()["Log Out"].tap();
	target.frontMostApp().tabBar().buttons()["Home"].tap();
	
    UIALogger.logPass(testname);
}

test_workouthistory();
test_AddSession();