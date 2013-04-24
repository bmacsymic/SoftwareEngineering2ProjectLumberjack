//
//  WorkoutViewController.h
//  LumberJack
//
//  Created by Bradley Macsymic on 2013-03-11.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIView *MainUIView;
    IBOutlet UIView *ExerciseOtherUIView;
    IBOutlet UIView *ButtonUIView;
    IBOutlet UIPickerView *IntensityPicker;
    IBOutlet UIPickerView *ExercisePicker;
    IBOutlet UIScrollView *scroller;
    IBOutlet UIButton *submitButton;
    NSMutableArray *intensityLevelData;
    NSMutableArray *exerciseTagData;
    int selectedValueIndexIntensity;
    int selectedValueIndexExercise;
    bool isShowingListIntensity;
    bool isShowingListExercise;
    bool selectedPublic;
    bool selectedLikeable;
    bool selectedCommentable;
    IBOutlet UITextField *workoutNameTextField;
    IBOutlet UIButton *publicButton;
    IBOutlet UIButton *commentableButton;
    IBOutlet UIButton *likeableButton;
    IBOutlet UITextField *descriptionTextField;
    IBOutlet UITextField *amountTextField;
    IBOutlet UITextField *unitsTextField;
    IBOutlet UITextField *additionalInfoTextField;
    IBOutlet UINavigationBar *navigationBar;
}

@property (retain, nonatomic) IBOutlet UIView *MainUIView;
@property (retain, nonatomic) IBOutlet UIView *ExerciseOtherUIView;
@property (retain, nonatomic) IBOutlet UIView *ButtonUIView;
@property (retain, nonatomic) IBOutlet UIPickerView *IntensityPicker;
@property (retain, nonatomic) IBOutlet UIPickerView *ExercisePicker;
@property (retain, nonatomic) IBOutlet UIScrollView *scroller;
@property (retain, nonatomic) NSMutableArray *intensityLevelData;
@property (retain, nonatomic) NSMutableArray *exerciseTagData;
@property (retain, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic) int selectedValueIndexIntensity;
@property (nonatomic) int selectedValueIndexExercise;
@property (nonatomic) bool isShowingListIntensity;
@property (nonatomic) bool isShowingListExercise;
@property (nonatomic) bool selectedPublic;
@property (nonatomic) bool selectedLikeable;
@property (nonatomic) bool selectedCommentable;
@property (retain, nonatomic) IBOutlet UITextField *workoutNameTextField;
@property (retain, nonatomic) IBOutlet UIButton *publicButton;
@property (retain, nonatomic) IBOutlet UIButton *commentableButton;
@property (retain, nonatomic) IBOutlet UIButton *likeableButton;
@property (retain, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (retain, nonatomic) IBOutlet UITextField *amountTextField;
@property (retain, nonatomic) IBOutlet UITextField *unitsTextField;
@property (retain, nonatomic) IBOutlet UITextField *additionalInfoTextField;
@property (retain, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property(retain, nonatomic) NSString *workoutSearchId;

- (IBAction)SubmitExercise:(id)sender;
- (IBAction)menuOpen:(id)sender;
- (IBAction)pushedPublic:(id)sender;
- (IBAction)pushedLikeable:(id)sender;
- (IBAction)pushedCommentable:(id)sender;

- (BOOL)workoutIsValidInput;
- (NSString *)triggerPublic;
- (NSString *)triggerLikeable;
- (NSString *)triggerCommentable;

- (IBAction)goToNav:(id)sender;

@end
