var testName = ("Testing Post Status");
var target = UIATarget.localTarget();

UIALogger.logStart( testName );

target.frontMostApp().tabBar().buttons()["Settings"].tap();
target.frontMostApp().mainWindow().buttons()["Log In"].tap();
target.frontMostApp().mainWindow().textFields()[0].tap();
target.frontMostApp().keyboard().typeString("Andy");
target.frontMostApp().mainWindow().secureTextFields()[0].tap();
target.frontMostApp().keyboard().typeString("123");
target.frontMostApp().mainWindow().buttons()["Log In"].tap();
target.frontMostApp().mainWindow().buttons()["Hidden Button"].tap();
target.frontMostApp().mainWindow().buttons()["News Feed"].tap();
target.frontMostApp().mainWindow().textFields()[0].tap();
target.frontMostApp().keyboard().typeString("This is a test");
target.frontMostApp().mainWindow().buttons()["Post"].tap();
target.tap({x:754.00, y:475.00});
target.frontMostApp().tabBar().buttons()["Settings"].tap();
target.frontMostApp().mainWindow().buttons()["Log Out"].tap();
target.frontMostApp().tabBar().buttons()["Home"].tap();
UIALogger.logPass( testName );