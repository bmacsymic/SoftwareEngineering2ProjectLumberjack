var target = UIATarget.localTarget();

function test_username_search()
{
    var testname = "LumberJack - Username Search";
    
    UIALogger.logStart(testname);
    
    target.frontMostApp().tabBar().buttons()["Explore"].tap();
    target.frontMostApp().mainWindow().buttons()["Username"].tap();
    target.frontMostApp().mainWindow().searchBars()[0].tap();
    target.frontMostApp().keyboard().typeString("ky");
    target.frontMostApp().mainWindow().tableViews()["Search results"].cells()["Kyle, kpollock9@hotmail.com"].tap();
	target.frontMostApp().tabBar().buttons()["Home"].tap();
    //test pass
    UIALogger.logPass(testname);
}

test_username_search();
