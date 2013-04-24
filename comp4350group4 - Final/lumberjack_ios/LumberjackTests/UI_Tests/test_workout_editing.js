
var target = UIATarget.localTarget();

function test_workout_editing()
{
    var testname = "LumberJack - Workout Editing";
    
    UIALogger.logStart(testname);
    
    target.frontMostApp().tabBar().buttons()["Explore"].tap();
    target.frontMostApp().mainWindow().buttons()["Name"].tap();
    target.frontMostApp().mainWindow().searchBars()[0].tap();
    target.frontMostApp().keyboard().typeString("ky");
    target.frontMostApp().mainWindow().tableViews()["Search results"].cells()["Kyle's Ultimate Work, Build both size and strength"].tap();
    target.frontMostApp().statusBar().tapWithOptions({tapOffset:{x:0.70, y:0.50}});
    target.frontMostApp().mainWindow().scrollViews()[0].buttons()["Commentable"].tap();
    target.frontMostApp().mainWindow().scrollViews()[0].buttons()["Likeable"].tap();
    target.frontMostApp().mainWindow().scrollViews()[0].buttons()["Public"].tap();
    target.frontMostApp().mainWindow().scrollViews()[0].textFields()[1].tap();
    target.tap({x:720.00, y:977.00});
    target.tap({x:727.00, y:973.00});
    target.tap({x:739.00, y:972.00});
    target.tap({x:723.00, y:973.00});
    target.tap({x:729.00, y:986.00});
    target.frontMostApp().mainWindow().scrollViews()[0].pickers()[1].wheels()[0].scrollToVisible();
    target.frontMostApp().mainWindow().scrollViews()[0].pickers()[1].wheels()[0].scrollToVisible();
    target.frontMostApp().mainWindow().scrollViews()[0].buttons()[3].tap();
    // Alert detected. Expressions for handling alerts should be moved into the UIATarget.onAlert function definition.
    target.frontMostApp().tabBar().buttons()["Home"].tap();
    
    //test pass
    UIALogger.logPass(testname);
    
}

test_workout_editing();
