var testName = ("Testing User Profile");
var target = UIATarget.localTarget();

UIALogger.logStart( testName );
target.frontMostApp().tabBar().buttons()["Me"].tap();
target.frontMostApp().mainWindow().buttons()["Log In"].tap();
target.frontMostApp().mainWindow().textFields()[0].tap();
target.frontMostApp().keyboard().typeString("Andy");
target.frontMostApp().mainWindow().secureTextFields()[0].tap();
target.frontMostApp().keyboard().typeString("123");
target.frontMostApp().mainWindow().buttons()["Log In"].tap();
target.frontMostApp().tabBar().buttons()["Settings"].tap();
target.frontMostApp().mainWindow().buttons()["Log Out"].tap();
target.frontMostApp().tabBar().buttons()["Me"].tap();
target.frontMostApp().tabBar().buttons()["Home"].tap();

target.frontMostApp().tabBar().buttons()["Me"].tap();
target.frontMostApp().mainWindow().buttons()["Log In"].tap();
target.frontMostApp().mainWindow().textFields()[0].tap();
target.frontMostApp().keyboard().typeString("Shaw");
target.frontMostApp().mainWindow().secureTextFields()[0].tap();
target.frontMostApp().keyboard().typeString("123");
target.frontMostApp().mainWindow().buttons()["Log In"].tap();
target.frontMostApp().tabBar().buttons()["Settings"].tap();
target.frontMostApp().mainWindow().buttons()["Log Out"].tap();
target.frontMostApp().tabBar().buttons()["Me"].tap();
target.frontMostApp().tabBar().buttons()["Home"].tap();
UIALogger.logPass( testName );