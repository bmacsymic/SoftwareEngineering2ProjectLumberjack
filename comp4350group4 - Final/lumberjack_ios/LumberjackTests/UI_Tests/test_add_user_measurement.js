var testname = "Testing Add Measurement";
var target = UIATarget.localTarget();

UIALogger.logStart(testname);
target.frontMostApp().tabBar().buttons()["Settings"].tap();
target.frontMostApp().mainWindow().buttons()["Log In"].tap();
target.frontMostApp().mainWindow().textFields()[0].tap();
target.frontMostApp().keyboard().typeString("Andy");
target.frontMostApp().mainWindow().secureTextFields()[0].tap();
target.frontMostApp().keyboard().typeString("123");
target.frontMostApp().mainWindow().buttons()["Log In"].tap();
target.frontMostApp().mainWindow().buttons()["Hidden Button"].tap();
target.frontMostApp().mainWindow().buttons()["Measurement"].tap();
target.frontMostApp().mainWindow().buttons()["Add"].tap();
target.frontMostApp().mainWindow().textFields()[0].tap();
target.frontMostApp().keyboard().typeString("Weight");
target.frontMostApp().mainWindow().textFields()[1].tap();
target.frontMostApp().keyboard().typeString("lbs");
target.frontMostApp().mainWindow().textFields()[2].tap();
target.frontMostApp().keyboard().typeString("174");
target.frontMostApp().mainWindow().buttons()["Add "].tap();
// Alert detected. Expressions for handling alerts should be moved into the UIATarget.onAlert function definition.
//target.frontMostApp().alert().cancelButton().tap();
target.frontMostApp().tabBar().buttons()["Settings"].tap();
target.frontMostApp().mainWindow().buttons()["Log Out"].tap();
target.frontMostApp().tabBar().buttons()["Home"].tap();
UIALogger.logPass(testname);