var target = UIATarget.localTarget();

function test_workout_description_search()
{
    var testname = "LumberJack - Workout Description Search";
    
    UIALogger.logStart(testname);
    target.frontMostApp().tabBar().buttons()["Explore"].tap();
    target.frontMostApp().mainWindow().buttons()["Description"].tap();
    target.frontMostApp().mainWindow().searchBars()[0].tap();
    target.frontMostApp().keyboard().typeString("s");
    target.frontMostApp().keyboard().typeString("py");
    target.frontMostApp().mainWindow().tableViews()["Search results"].cells()["Jeremy's Meh Workout, How would a spy like James Bond stay at his peak? This workout provides you with the specifics to look great and have the athleticism to mat."].tap();
    target.frontMostApp().tabBar().buttons()["Home"].tap();



    //test pass
    UIALogger.logPass(testname);

}

test_workout_description_search();