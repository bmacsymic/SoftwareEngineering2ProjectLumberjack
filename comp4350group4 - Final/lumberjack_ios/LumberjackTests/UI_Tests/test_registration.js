var target = UIATarget.localTarget();
UIATarget.onAlert = function onAlert(alert){
    UIALogger.logMessage("alert Shown");    
}
function test_registration()
{
    var testname = "LumberJack - Registration Test";
    UIALogger.logStart(testname);
	
	target.frontMostApp().tabBar().buttons()["Settings"].tap();
	target.frontMostApp().mainWindow().buttons()["Register"].tap();
	var randomnumber=(Math.random()*9999);
	var username = "UITester"+randomnumber;
	target.frontMostApp().mainWindow().textFields()[0].setValue(username);
	target.frontMostApp().mainWindow().secureTextFields()[0].setValue("123");
	target.frontMostApp().mainWindow().secureTextFields()[1].setValue("123");
	target.frontMostApp().mainWindow().buttons()["Register"].tap();
    UIALogger.logPass(testname);
}

test_registration();