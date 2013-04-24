var target = UIATarget.localTarget();

function test_workout_author_search()
{
    var testname = "LumberJack - Workout Author Search";
    
    target.frontMostApp().tabBar().buttons()["Explore"].tap();
    target.frontMostApp().mainWindow().buttons()["Author"].tap();
    target.frontMostApp().mainWindow().searchBars()[0].tap();
    target.frontMostApp().keyboard().typeString("ky");
    target.frontMostApp().mainWindow().tableViews()["Search results"].cells()["Kyle's Ultimate Work, Build both size and st"].tap();
    target.frontMostApp().tabBar().buttons()["Home"].tap();
    
    
    //test pass
    UIALogger.logPass(testname);
}

test_workout_author_search();