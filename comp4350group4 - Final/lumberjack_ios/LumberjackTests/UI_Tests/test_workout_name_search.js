var target = UIATarget.localTarget();

function test_workout_name_search()
{
    var testname = "LumberJack - Workout name Search";
    
    UIALogger.logStart(testname);
    
    target.frontMostApp().tabBar().buttons()["Home"].tap();
    target.frontMostApp().tabBar().buttons()["Explore"].tap();
    target.frontMostApp().mainWindow().buttons()["Name"].tap();
    target.frontMostApp().mainWindow().searchBars()[0].tap();
    target.frontMostApp().keyboard().typeString("k");
    target.frontMostApp().keyboard().typeString("y");
    target.frontMostApp().mainWindow().tableViews()["Search results"].cells()["Kyle's Ultimate Work, Build both size and st"].tap();
    target.frontMostApp().tabBar().buttons()["Home"].tap();
    
    //test pass
    UIALogger.logPass(testname);
}

test_workout_name_search();