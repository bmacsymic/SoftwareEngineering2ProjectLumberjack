var target = UIATarget.localTarget();

function test_login()
{
    var testname = "LumberJack - Login Test";
    
    UIALogger.logStart(testname);
	target.frontMostApp().tabBar().buttons()["Settings"].tap();
	target.frontMostApp().mainWindow().buttons()["Log In"].tap();
	target.frontMostApp().mainWindow().textFields()[0].tap();
	target.frontMostApp().keyboard().typeString("Cameron");
	target.frontMostApp().mainWindow().secureTextFields()[0].tap();
	target.frontMostApp().keyboard().typeString("123");
	target.frontMostApp().mainWindow().buttons()["Log In"].tap();
	target.frontMostApp().tabBar().buttons()["Settings"].tap();
	target.frontMostApp().mainWindow().buttons()["Log Out"].tap();
	target.frontMostApp().tabBar().buttons()["Home"].tap();
	
	//test pass
    UIALogger.logPass(testname);
}


test_login();
