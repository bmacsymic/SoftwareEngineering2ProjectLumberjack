var target = UIATarget.localTarget();

function test_home()
{
    var testname = "LumberJack - Home Test";
    
    UIALogger.logStart(testname);

    target.frontMostApp().mainWindow().tableViews()["Empty list"].cells()["brad test workout, Mega workout"].scrollToVisible();
	target.frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Kyle's Ultimate Work, Build both size and strength"].tap();
	target.frontMostApp().navigationBar().leftButton().tap();
	target.frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Jeremy's Meh Workout, How would a spy like James Bond stay at his peak? This workout provides you with the specifics to look great and have the athleticism to mat."].tap();
	target.frontMostApp().navigationBar().leftButton().tap();
	target.frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Andy's Soccer Workout, 2 days after Super Bowl 45 AJ Hawk lay on an operating table to repair his wrist. 3 weeks after having the pins removed, A.J. put on a training display."].tap();
	target.frontMostApp().navigationBar().tapWithOptions({tapOffset:{x:0.08, y:0.50}});
	target.frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Shaw's Lazy Workout, You've seen the movie 300, now get the body. This is the intense 300 Spartan workout used by the cast of the movie that delivers results."].tap();
	target.frontMostApp().navigationBar().leftButton().tap();
	
    
    UIALogger.logPass(testname);
}

test_home();
