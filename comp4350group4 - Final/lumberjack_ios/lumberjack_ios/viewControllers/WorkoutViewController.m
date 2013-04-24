//
//  WorkoutViewController.m
//  LumberJack
//
//  Created by Bradley Macsymic on 2013-03-11.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MeMenuViewController.h"
#import "WorkoutViewController.h"
#import "ASIHTTPRequest.h"
#import "ServerRequests.h"
#import "DialogBox.h"

@interface WorkoutViewController ()

@end

@implementation WorkoutViewController
{
    bool removedSelectAValueIntensity;
    bool removedSelectAValueExercise;
    bool addingMoreThanOneExercise;
    int yLocation;
    int numExercisesOnScreen;
    int exerciseTableYCoordinate;
    int exerciseOtherYCoordinate;
    int maxNumberOfExercises;
    bool editingWorkout;
    NSString *originalWorkoutName;
}
@synthesize MainUIView;
@synthesize ExerciseOtherUIView;
@synthesize ButtonUIView;
@synthesize IntensityPicker;
@synthesize ExercisePicker;
@synthesize scroller;
@synthesize intensityLevelData;
@synthesize exerciseTagData;
@synthesize selectedValueIndexIntensity;
@synthesize selectedValueIndexExercise;
@synthesize isShowingListIntensity;
@synthesize isShowingListExercise;
@synthesize submitButton;
@synthesize workoutNameTextField;
@synthesize publicButton;
@synthesize commentableButton;
@synthesize likeableButton;

@synthesize descriptionTextField;
@synthesize amountTextField;
@synthesize unitsTextField;
@synthesize additionalInfoTextField;

@synthesize workoutSearchId;
@synthesize navigationBar;

@synthesize selectedPublic;
@synthesize selectedLikeable;
@synthesize selectedCommentable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void) addGesture
{
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MeMenuViewController class]])
    {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *blackButtonImage = [UIImage imageNamed:@"blackButton.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self.submitButton setBackgroundImage:stretchable forState:UIControlStateNormal];
    [self.publicButton setBackgroundImage:stretchable forState:UIControlStateNormal];
    [self.commentableButton setBackgroundImage:stretchable forState:UIControlStateNormal];
    [self.likeableButton setBackgroundImage:stretchable forState:UIControlStateNormal];
    
    if(workoutSearchId != nil)
    {
        editingWorkout = YES;
        navigationBar.hidden = YES;
        [submitButton setTitle:@"Update" forState:UIControlStateNormal];
        [submitButton setTitle:@"Update" forState:UIControlStateSelected];
    }
    else
    {
        [self addGesture];
    }
    
    self.view.autoresizesSubviews=NO;
    
    removedSelectAValueIntensity = true;
    removedSelectAValueExercise = true;
    
    addingMoreThanOneExercise = false;
    
    yLocation = 0;
    numExercisesOnScreen = 1;
    maxNumberOfExercises = 1;

    intensityLevelData = [[NSMutableArray alloc] init];
    [intensityLevelData addObject:@"Easy"];
    [intensityLevelData addObject:@"Medium"];
    [intensityLevelData addObject:@"Hard"];
    
    selectedPublic = NO;
    selectedLikeable = NO;
    selectedCommentable = NO;
    
    isShowingListIntensity = NO;
    isShowingListExercise= NO;
    selectedValueIndexIntensity = 0;
    selectedValueIndexExercise = 0;
    
    CGRect frameRect = self.descriptionTextField.frame;
    frameRect.size.height = 300;
    self.descriptionTextField.frame = frameRect;
    
    [self populateExerciseTags];
    
    if(editingWorkout)
    {
        [self populateWorkout];
    }
}

- (void)populateWorkout
{
    int workoutIdNumber = [workoutSearchId intValue];
    NSString *strFromInt = [NSString stringWithFormat:@"%d",workoutIdNumber];
    
    NSString* encodedUrl =[strFromInt stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    NSDictionary *request = [[NSDictionary alloc] initWithObjectsAndKeys: encodedUrl, @"id", nil];
    NSDictionary *result = [ServerRequests serverGetRequest:@"workouts/getSingleWorkout" data:request];
    if (result != nil)
    {
        NSString *resultString = [result objectForKey:@"Result"];
        if([resultString isEqual: @"Success"])
        {
            NSDictionary *exerciseData = [result objectForKey:@"exerciseData"];
            NSDictionary *workoutData = [result objectForKey:@"workoutData"];
            
            NSString *workoutName = [workoutData objectForKey:@"name"];
            NSString *description = [workoutData objectForKey:@"description"];
            NSString *level = [workoutData objectForKey:@"level"];
            selectedCommentable = [[workoutData objectForKey:@"is_commentable"] boolValue];
            selectedPublic = [[workoutData objectForKey:@"is_public"] boolValue];
            selectedLikeable = [[workoutData objectForKey:@"is_likeable"] boolValue];
            
            self.workoutNameTextField.text = workoutName;
            self.descriptionTextField.text = description;
            
            originalWorkoutName = workoutName;
            
            int pos = 0;
            int rowIntensity = 0;
            for(id name in intensityLevelData)
            {
                if([name isEqual: level])
                {
                    rowIntensity = pos;
                }
                pos++;
            }
            [IntensityPicker selectRow:rowIntensity inComponent:0 animated:false];
            
            if(selectedCommentable)
            {
                [self triggerCommentable];
            }
            if(selectedPublic)
            {
                [self triggerPublic];
            }
            if(selectedLikeable)
            {
                [self triggerLikeable];
            }
            
            //int numExercises = [exercise count];
            NSDictionary *exercise;
            for(exercise in exerciseData)
            {
                NSString *eTagName = [exercise objectForKey:@"eTagName"];
                NSString *amount = [exercise objectForKey:@"amount"];
                NSString *eTagUnit = [exercise objectForKey:@"eTagUnit"];
                NSString *additionalInfo = [exercise objectForKey:@"additionalInfo"];
                
                int amountNumber = [amount intValue];
                NSString *amountString = [NSString stringWithFormat:@"%d",amountNumber];
                
                pos = 0;
                rowIntensity = 0;
                for(id name in exerciseTagData)
                {
                    if([name isEqual: eTagName])
                    {
                        rowIntensity = pos;
                    }
                    pos++;
                }
                [ExercisePicker selectRow:rowIntensity inComponent:0 animated:false];
                
                self.amountTextField.text = amountString;
                self.unitsTextField.text = eTagUnit;
                self.additionalInfoTextField.text = additionalInfo;
                return;
            }
        }
    }
    else
    {
        [DialogBox alertTitle: @"Error" alertMessage: @"There was an error in sending your request to the server."];
    }
}

- (void)populateExerciseTags
{
	NSDictionary * result = [ServerRequests serverGetRequest:@"workouts/getExerciseTypes" data:nil];
    
    if (result != nil)
    {
        NSString *names = [result objectForKey:@"names"];
        NSArray *tokens = [names componentsSeparatedByString:@","];
        
        exerciseTagData = [[NSMutableArray alloc] init];
        for (id name in tokens)
        {
            if([name length] != 0)
            {
                [exerciseTagData addObject:name];
            }
        }
        [self populateUnitsBasedOnExercisePicker];
    }
    else
    {
        [DialogBox alertTitle: @"Error" alertMessage: @"There was an error in sending your request to the server."];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == ExercisePicker)
    {
        [self populateUnitsBasedOnExercisePicker];
    }
}

- (void)populateUnitsBasedOnExercisePicker
{
    
    int rowExercise = [ExercisePicker selectedRowInComponent:0];
    NSString *exerciseTagString = [[NSString alloc] initWithFormat:@"%@", [exerciseTagData objectAtIndex:rowExercise]];
    
    NSString* encodedUrl =[exerciseTagString stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    
    NSDictionary *request = [[NSDictionary alloc] initWithObjectsAndKeys: encodedUrl, @"name", nil];
    NSDictionary *result = [ServerRequests serverGetRequest:@"workouts/getExerciseTagUnit" data:request];
    if (result != nil)
    {
        NSString *unit = [result objectForKey:@"unit"];
        unitsTextField.text = unit;
    }
    else
    {
        [DialogBox alertTitle: @"Error" alertMessage: @"There was an error in sending your request to the server."];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == unitsTextField)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView == IntensityPicker)
    {
        int count = [intensityLevelData count];
        return count;
    }
    else if(pickerView == ExercisePicker)
    {
        int count = [exerciseTagData count];
        return count;
    }
    else
    {
        return 1;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView == IntensityPicker)
    {
        return (NSString*) [intensityLevelData objectAtIndex: row];
    }
    else if (pickerView == ExercisePicker)
    {
        return (NSString*) [exerciseTagData objectAtIndex: row];
    }
    else
    {
        return @"";
    }
}

- (IBAction)AddExercise:(id)sender
{
    if(maxNumberOfExercises < 1)
    {
        maxNumberOfExercises++;
        //NSData *tempArchiveTable = [NSKeyedArchiver archivedDataWithRootObject:ExerciseTableView];
        id copyOfPicker = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:ExercisePicker]];
        id copyOfView = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:ExerciseOtherUIView]];
        //NSData *tempArchiveExercise = [NSKeyedArchiver archivedDataWithRootObject:ExercisePicker];
        //NSData *tempArchiveOther = [NSKeyedArchiver archivedDataWithRootObject:ExerciseOtherUIView];
        
        UIPickerView *newExercisePicker = copyOfPicker;
        UIView *newExerciseOtherView = copyOfView;
        
        //UITableView *newExerciseTableView = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchiveTable];
        //UIPickerView *newExercisePicker = [[UIPickerView alloc] init];
        //newExercisePicker = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchiveExercise];
        //UIView *newExerciseOtherView = [[UIView alloc] init];
        //newExerciseOtherView = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchiveOther];
        
        //[ExerciseTableView.superview addSubview:newExerciseTableView];
        [ExercisePicker.superview addSubview:newExercisePicker];
        [ExerciseOtherUIView.superview addSubview:newExerciseOtherView];
        
        //CGRect eFrame = [newExerciseTableView frame];
        CGRect eFrame = [newExercisePicker frame];
        CGRect cFrame = [newExerciseOtherView frame];
        if(addingMoreThanOneExercise)
        {
            exerciseTableYCoordinate = exerciseTableYCoordinate + eFrame.size.height + cFrame.size.height;
            exerciseOtherYCoordinate = exerciseOtherYCoordinate + eFrame.size.height + cFrame.size.height;
        }
        else
        {
            addingMoreThanOneExercise = true;
            exerciseTableYCoordinate = eFrame.origin.y + eFrame.size.height + cFrame.size.height;
            exerciseOtherYCoordinate = cFrame.origin.y + eFrame.size.height + cFrame.size.height;
        }
        
        [newExercisePicker setFrame:CGRectMake(eFrame.origin.x,
                                               exerciseTableYCoordinate,
                                               eFrame.size.width,
                                               eFrame.size.height)];
        [newExerciseOtherView setFrame:CGRectMake(cFrame.origin.x - (cFrame.size.width/2),
                                                  exerciseOtherYCoordinate,
                                                  cFrame.size.width,
                                                  cFrame.size.height)];
        
        CGRect sFrame = [scroller frame];
        [scroller setContentSize:CGSizeMake(sFrame.size.width, sFrame.size.height + eFrame.size.height + cFrame.size.height)];
    }
}

- (BOOL)workoutIsValidInput
{
    if([workoutNameTextField.text length] == 0)
    {
        [DialogBox alertTitle:@"Workout Name" alertMessage:@"The workout name cannot be empty."];
        return NO;
    }
    else
    {
        NSString *workoutNameString = self.workoutNameTextField.text;
        
        if([originalWorkoutName isEqual: workoutNameString])
        {
            [self editWorkout];
            return NO;
        }
        else
        {
            NSString* encodedUrl =[workoutNameString stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
            
            NSDictionary *request = [[NSDictionary alloc] initWithObjectsAndKeys: encodedUrl, @"name", nil];
            NSDictionary *result = [ServerRequests serverGetRequest:@"workouts/checkIfNameIsUnique" data:request];
            if (result != nil)
            {
                NSString *resultString = [result objectForKey:@"Result"];
                if([resultString isEqual: @"True"])
                {
                    return YES;
                }
                else
                {
                    [DialogBox alertTitle:@"Workout Name" alertMessage:@"Your workout name is not unique."];
                    return NO;
                }
            }
            else
            {
                [DialogBox alertTitle: @"Error" alertMessage: @"There was an error in sending your request to the server."];
                return NO;
            }
        }
    }
}

- (IBAction)SubmitExercise:(id)sender
{
    if([self workoutIsValidInput])
    {
        [self submitWorkout];
    }
}

- (void)editWorkout
{
    NSString *workoutNameString = self.workoutNameTextField.text;
    int rowIntensity = [IntensityPicker selectedRowInComponent:0];
    NSString *intensityLevelString = [[NSString alloc] initWithFormat:@"%@", [intensityLevelData objectAtIndex:rowIntensity]];
    NSString *isPublic;
    NSString *isLikable;
    NSString *isCommentable;
    
    if(selectedPublic)
    {
        isPublic = @"true";
    }
    else
    {
        isPublic = @"false";
    }
    
    if(selectedLikeable)
    {
        isLikable = @"true";
    }
    else
    {
        isLikable = @"false";
    }
    
    if(selectedCommentable)
    {
        isCommentable = @"true";
    }
    else
    {
        isCommentable = @"false";
    }
    
    NSString  *descriptionString = self.descriptionTextField.text;
    
    NSMutableArray *exercises = [[NSMutableArray alloc] init];
    for(int i = 0; i < numExercisesOnScreen; i++)
    {
        NSMutableDictionary *currentExercise = [NSMutableDictionary dictionary];
        
        int rowExercise = [ExercisePicker selectedRowInComponent:0];
        NSString *exerciseTagString = [[NSString alloc] initWithFormat:@"%@", [exerciseTagData objectAtIndex:rowExercise]];
        NSString *amountString = self.amountTextField.text;
        NSString *unitsString = self.unitsTextField.text;
        NSString *additionalInfoString = self.additionalInfoTextField.text;
        
        [currentExercise setObject:[NSNumber numberWithInt:(i + 1)] forKey:@"order"];
        [currentExercise setObject: exerciseTagString forKey:@"type"];
        [currentExercise setObject:unitsString forKey:@"unit"];
        [currentExercise setObject:amountString forKey:@"amount"];
        [currentExercise setObject:additionalInfoString forKey:@"additionalInfo"];
        
        [exercises addObject:currentExercise];
    }
    
    NSDictionary *workout = [[NSDictionary alloc] initWithObjectsAndKeys: workoutNameString, @"name", descriptionString, @"description", intensityLevelString, @"level", isPublic, @"isPublic", isLikable, @"isLikeable", isCommentable, @"isCommentable", exercises, @"exercises", nil];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:workout options:kNilOptions error:&error];
    ASIHTTPRequest *request = [ServerRequests serverJSONPost:@"workouts/editWorkout" json:jsonData];
    error = [request error];
    if(!error)
    {
        NSData * responseData = [request responseData];
        NSLog(@"%@", [request responseString] );
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        NSString *resultString = [json objectForKey:@"Result"];
        if([resultString isEqual: @"Success"])
        {
            [DialogBox alertTitle:@"Success" alertMessage:@"Your workout has been updated."];
        }
    }
    else
    {
        [DialogBox alertTitle: @"Error" alertMessage: @"There was an error in sending your request to the server."];
    }
}

- (void)submitWorkout
{
    NSString *workoutNameString = self.workoutNameTextField.text;
    int rowIntensity = [IntensityPicker selectedRowInComponent:0];
    NSString *intensityLevelString = [[NSString alloc] initWithFormat:@"%@", [intensityLevelData objectAtIndex:rowIntensity]];
    NSString *isPublic;
    NSString *isLikable;
    NSString *isCommentable;
    
    if(selectedPublic)
    {
        isPublic = @"true";
    }
    else
    {
        isPublic = @"false";
    }
    
    if(selectedLikeable)
    {
        isLikable = @"true";
    }
    else
    {
        isLikable = @"false";
    }
    
    if(selectedCommentable)
    {
        isCommentable = @"true";
    }
    else
    {
        isCommentable = @"false";
    }
    
    NSString  *descriptionString = self.descriptionTextField.text;
    
    NSMutableArray *exercises = [[NSMutableArray alloc] init];
    for(int i = 0; i < numExercisesOnScreen; i++)
    {
        NSMutableDictionary *currentExercise = [NSMutableDictionary dictionary];
        
        int rowExercise = [ExercisePicker selectedRowInComponent:0];
        NSString *exerciseTagString = [[NSString alloc] initWithFormat:@"%@", [exerciseTagData objectAtIndex:rowExercise]];
        NSString *amountString = self.amountTextField.text;
        NSString *unitsString = self.unitsTextField.text;
        NSString *additionalInfoString = self.additionalInfoTextField.text;
        
        [currentExercise setObject:[NSNumber numberWithInt:(i + 1)] forKey:@"order"];
        [currentExercise setObject: exerciseTagString forKey:@"type"];
        [currentExercise setObject:unitsString forKey:@"unit"];
        [currentExercise setObject:amountString forKey:@"amount"];
        [currentExercise setObject:additionalInfoString forKey:@"additionalInfo"];
        
        [exercises addObject:currentExercise];
    }
    
    NSDictionary *workout = [[NSDictionary alloc] initWithObjectsAndKeys: workoutNameString, @"name", descriptionString, @"description", intensityLevelString, @"level", isPublic, @"isPublic", isLikable, @"isLikeable", isCommentable, @"isCommentable", exercises, @"exercises", nil];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:workout options:kNilOptions error:&error];
    ASIHTTPRequest *request = [ServerRequests serverJSONPost:@"workouts/submitWorkout" json:jsonData];
    error = [request error];
    if(!error)
    {
        NSData * responseData = [request responseData];
        NSLog(@"%@", [request responseString] );
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        NSString *resultString = [json objectForKey:@"Result"];
        if([resultString isEqual: @"Success"])
        {
            [DialogBox alertTitle:@"Success" alertMessage:@"Your workout has been submitted."];
        }
    }
    else
    {
        [DialogBox alertTitle: @"Error" alertMessage: @"There was an error in sending your request to the server."];
    }
}

- (IBAction)menuOpen:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)pushedPublic:(id)sender
{
    selectedPublic = !selectedPublic;
    [self triggerPublic];
}

- (NSString *)triggerPublic
{
    if(selectedPublic)
    {
        publicButton.selected = YES;
        [publicButton setBackgroundImage:[UIImage imageNamed:@"ButtonBack.png"] forState:UIControlStateSelected];
        [publicButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        return @"SelectedPublic";
    }
    else
    {
        publicButton.selected = NO;
        [publicButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [publicButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        return @"UnselectedPublic";
    }
}

- (IBAction)pushedLikeable:(id)sender
{
    selectedLikeable = !selectedLikeable;
    [self triggerLikeable];
}

- (NSString *)triggerLikeable
{
    if(selectedLikeable)
    {
        likeableButton.selected = YES;
        [likeableButton setBackgroundImage:[UIImage imageNamed:@"ButtonBack.png"] forState:UIControlStateSelected];
        [likeableButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        return @"SelectedLikeable";
    }
    else
    {
        likeableButton.selected = NO;
        [likeableButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [likeableButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        return @"UnselectedLikeable";
    }
}

- (IBAction)pushedCommentable:(id)sender
{
    selectedCommentable = !selectedCommentable;
    [self triggerCommentable];
}

- (NSString *)triggerCommentable
{
    if(selectedCommentable)
    {
        commentableButton.selected = YES;
        [commentableButton setBackgroundImage:[UIImage imageNamed:@"ButtonBack.png"] forState:UIControlStateSelected];
        [commentableButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        return @"SelectedCommentable";
    }
    else
    {
        commentableButton.selected = NO;
        [commentableButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [commentableButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        return @"UnselectedCommentable";
    }
}

- (IBAction)goToNav:(id)sender {
    UIViewController *newTopController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavButtons"];
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
}

@end
