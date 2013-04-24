var testName = ("Testing Edit Profile");
var target = UIATarget.localTarget();

UIALogger.logStart( testName );


target.frontMostApp().tabBar().tapWithOptions({tapOffset:{x:0.98, y:0.65}});
target.frontMostApp().tabBar().buttons()["Settings"].tap();
target.frontMostApp().mainWindow().buttons()["Log In"].tap();
target.frontMostApp().mainWindow().textFields()[0].tap();
target.frontMostApp().keyboard().typeString("Andy");
target.frontMostApp().mainWindow().secureTextFields()[0].tap();
target.frontMostApp().keyboard().typeString("123");
target.frontMostApp().mainWindow().buttons()["Log In"].tap();
target.frontMostApp().mainWindow().buttons()["Edit Profile"].tap();
target.frontMostApp().mainWindow().textFields()[0].tap();
target.frontMostApp().mainWindow().textFields()[1].tap();
target.frontMostApp().mainWindow().textFields()[2].tap();
target.frontMostApp().mainWindow().textFields()[3].tap();
target.frontMostApp().mainWindow().textFields()[4].tap();
target.frontMostApp().mainWindow().segmentedControls()[0].buttons()["F"].tap();
target.frontMostApp().mainWindow().segmentedControls()[0].buttons()["M"].tap();
target.frontMostApp().mainWindow().textFields()[5].tap();
target.frontMostApp().mainWindow().textViews()[0].tapWithOptions({tapOffset:{x:0.53, y:1.36}});
target.tap({x:731.00, y:661.00});
target.frontMostApp().mainWindow().buttons()["Save"].tap();
// Alert detected. Expressions for handling alerts should be moved into the UIATarget.onAlert function definition.
//target.frontMostApp().alert().cancelButton().tap();
target.frontMostApp().tabBar().buttons()["Settings"].tap();
target.frontMostApp().mainWindow().buttons()["Log Out"].tap();
target.frontMostApp().tabBar().buttons()["Home"].tap();
UIALogger.logPass( testName );
