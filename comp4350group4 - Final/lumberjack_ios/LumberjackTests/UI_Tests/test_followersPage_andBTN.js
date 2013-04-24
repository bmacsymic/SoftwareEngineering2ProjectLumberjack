
var target = UIATarget.localTarget();


function test_viewFollowers_andBTNS()
{
    var testname = "LumberJack - Followers Page and Button tests";
    
    UIALogger.logStart(testname);
    
    target.frontMostApp().tabBar().buttons()["Settings"].tap();
    target.frontMostApp().mainWindow().buttons()["Log In"].tap();
    target.frontMostApp().mainWindow().textFields()[0].tap();
    target.frontMostApp().keyboard().typeString("jeremy");
    target.frontMostApp().mainWindow().secureTextFields()[0].tap();
    target.frontMostApp().keyboard().typeString("123");
    target.frontMostApp().mainWindow().buttons()["Log In"].tap();
    target.frontMostApp().mainWindow().buttons()["Hidden Button"].tap();
    target.frontMostApp().mainWindow().buttons()["Followers"].tap();
    target.frontMostApp().tabBar().buttons()["Explore"].tap();
    target.frontMostApp().mainWindow().buttons()["Username"].tap();
    target.frontMostApp().mainWindow().searchBars()[0].tap();
    target.frontMostApp().keyboard().typeString("andy");
    target.frontMostApp().mainWindow().tableViews()["Search results"].cells()["Andy, uofm"].tap();
    target.frontMostApp().mainWindow().buttons()["Unfollow"].tap();
    target.frontMostApp().tabBar().buttons()["Explore"].tap();
    target.frontMostApp().mainWindow().buttons()["Cancel"].tap();
    target.frontMostApp().mainWindow().buttons()["Username"].tap();
    target.frontMostApp().mainWindow().searchBars()[0].tap();
    target.frontMostApp().keyboard().typeString("shaw");
    target.frontMostApp().mainWindow().tableViews()["Search results"].cells()["Shaw, No Email"].tap();
    target.frontMostApp().mainWindow().buttons()["Unfollow"].tap();
    target.frontMostApp().tabBar().buttons()["Me"].tap();
    target.frontMostApp().mainWindow().buttons()["Hidden Button"].tap();
    target.frontMostApp().mainWindow().buttons()["Followers"].tap();
    target.frontMostApp().tabBar().buttons()["Explore"].tap();
    target.frontMostApp().navigationBar().leftButton().tap();
    target.frontMostApp().mainWindow().buttons()["Cancel"].tap();
    target.frontMostApp().mainWindow().buttons()["Username"].tap();
    target.frontMostApp().mainWindow().searchBars()[0].tap();
    target.frontMostApp().keyboard().typeString("shaw");
    target.frontMostApp().mainWindow().tableViews()["Search results"].cells()["Shaw, No Email"].tap();
    target.frontMostApp().mainWindow().buttons()["Follow"].tap();
    target.frontMostApp().navigationBar().leftButton().tap();
    target.frontMostApp().mainWindow().buttons()["Cancel"].tap();
    target.frontMostApp().mainWindow().searchBars()[0].tap();
    target.frontMostApp().keyboard().typeString("andy");
    target.frontMostApp().mainWindow().tableViews()["Search results"].cells()["Andy, uofm"].tap();
    target.frontMostApp().mainWindow().buttons()["Follow"].tap();
    target.frontMostApp().mainWindow().buttons()["Follow"].tap();
    target.frontMostApp().tabBar().buttons()["Me"].tap();
    target.frontMostApp().mainWindow().buttons()["Hidden Button"].tap();
    target.frontMostApp().mainWindow().buttons()["Followers"].tap();
    target.frontMostApp().tabBar().buttons()["Settings"].tap();
    target.frontMostApp().mainWindow().buttons()["Log Out"].tap();
    target.frontMostApp().tabBar().buttons()["Home"].tap();
    
    UIALogger.logPass(testname);
}

test_viewFollowers_andBTNS() ;
