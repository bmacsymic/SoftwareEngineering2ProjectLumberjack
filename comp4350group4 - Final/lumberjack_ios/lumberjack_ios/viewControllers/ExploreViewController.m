//
//  ExploreViewController.m
//  LumberJack
//
//  Created by Kyle Andrew Pollock on 2013-03-09.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "ExploreViewController.h"
#import "ServerRequests.h"
#import "SearchCell.h"
#import "User.h"
#import <CommonCrypto/CommonDigest.h>
#import "EditProfileViewController.h"
#import "WorkoutViewController.h"

@interface ExploreViewController ()

@end

@implementation ExploreViewController


NSMutableArray *tableData;
BOOL isWorkoutSearch;
User * user;
NSString * workoutId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//Do any additional setup after loading the view.
    
    UIImage *blackButtonImage = [UIImage imageNamed:@"blackButton.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self.workoutAuthorBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    [self.workoutExerciseBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    [self.peopleUsernameBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    [self.peopleBioBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    [self.workoutNameBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    [self.workoutDescriptionBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    
    
    //[self.workoutNameBtn setBackgroundColor:[UIColor blueColor]];
    UIImage *buttonBack = [UIImage imageNamed:@"ButtonBack.png"];
    stretchable = [buttonBack stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self.workoutNameBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    
    self.workoutNameBtn.selected = YES;
    isWorkoutSearch = YES;
    
    [self isServerAccessable];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


////////////////
///TABLE
////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    SearchCell * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if (isWorkoutSearch)
    {
        cell.nameLabel.text = [[tableData objectAtIndex:indexPath.row ] objectForKey:@"name"];
        cell.otherLabel.text = [[tableData objectAtIndex:indexPath.row ] objectForKey:@"description"];
        NSString * level = [[tableData objectAtIndex:indexPath.row ] objectForKey:@"level"];
        if ([level isEqualToString:@"Easy"])
        {
            cell.thumbnailImageView.image = [UIImage imageNamed:@"green.png"];
        }
        else if ([level isEqualToString:@"Medium"])
        {
            cell.thumbnailImageView.image = [UIImage imageNamed:@"yellow.png"];
        }
        else if ([level isEqualToString:@"Hard"])
        {
            cell.thumbnailImageView.image = [UIImage imageNamed:@"red.png"];
        }
        
    }
    
    else
    {
        //display username
        cell.nameLabel.text = [[tableData objectAtIndex:indexPath.row ] objectForKey:@"username"];
        
        //default profile pic
        NSString * gravatar = nil;
        
        NSString * email = [[tableData objectAtIndex:indexPath.row] objectForKey:@"email"];
        NSString * avatar = [[tableData objectAtIndex:indexPath.row] objectForKey:@"avatar"];
        
        //if user has email
        if (![email isEqual:[NSNull null]])
        {
            //display email
            cell.otherLabel.text = email;
        }
        else
        {
            cell.otherLabel.text = @"No Email";
        }
        
        //if user has gravatar
        if (![avatar isEqual:[NSNull null]])
        {
            NSString * hash = [self md5:avatar];
            gravatar = [[NSString alloc] initWithFormat:@"http://www.gravatar.com/avatar/%@?s=78", hash];
        }
        //default gravatar
        else
        {
            gravatar = [[NSString alloc] initWithFormat:@"http://www.gravatar.com/avatar/d41d8cd98f00b204e9800998ecf8427e?d=mm&amp;s=78"];
        }
        
        UIImage* myImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: gravatar]]];
        cell.thumbnailImageView.image = myImage;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

////////////////
///ROW SELECTION
////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    user = [[User alloc] init];
    
    if (isWorkoutSearch)
    {
        workoutId = [[tableData objectAtIndex:indexPath.row] objectForKey:@"id"];
        [self performSegueWithIdentifier:@"pushWorkout" sender:self];
    }
    else
    {
            
        NSString *username = [NSString stringWithFormat:@"%@%@", @"user/", [[tableData objectAtIndex:indexPath.row] objectForKey:@"username"]];
            
        NSDictionary *dictionary = [ServerRequests serverGetRequest:username data:nil];
            
        if (dictionary)
        {
            
            NSString *avatar = [dictionary objectForKey: @"avatar"];
            [user setAvatar:avatar];
            
            [user setUserId:[([dictionary objectForKey: @"id"]) intValue]];
            
            if (![[dictionary objectForKey: @"lastname"] isEqual:[NSNull null]] && ![[dictionary objectForKey: @"firstname"] isEqual:[NSNull null]]) {
                [user setLastName:[dictionary objectForKey: @"lastname"]];
                [user setFirstName:[dictionary objectForKey: @"firstname"]];
            }
            
            if (![[dictionary objectForKey: @"gender"] isEqual:[NSNull null]]) {
                NSString *gender = [dictionary objectForKey: @"gender"];
                if ([gender isEqualToString:@"M"]) {
                    [user setGender:@"Male"];
                } else if ([gender isEqualToString:@"F"]) {
                    [user setGender:@"Female"];
                }
                [user setGender:[dictionary objectForKey: @"gender"]];
            }
            
            if (![[dictionary objectForKey: @"location"] isEqual:[NSNull null]]) {
                NSString *location = [dictionary objectForKey: @"location"];
                if (![location isEqualToString:@""]) {
                    [user setLocation:location];
                }

            }
            
            NSString *registration = [dictionary objectForKey: @"registration_date"];
            [user setRegistrationDate:registration];
            
            
            if (![[dictionary objectForKey: @"email"] isEqual:[NSNull null]]) {
                [user setEmail:[dictionary objectForKey: @"email"]];
            }
            
            if (![[dictionary objectForKey: @"gravatar"] isEqual:[NSNull null]]) {
                [user setAvatar:[dictionary objectForKey: @"avatar"]];
            }
            
            if (![[dictionary objectForKey: @"birth"] isEqual:[NSNull null]]) {
                [user setBirthDate:[dictionary objectForKey: @"birth"]];
            }
            
            if (![[dictionary objectForKey: @"about_me"] isEqual:[NSNull null]]) {
                NSString *about = [dictionary objectForKey: @"about_me"];
                if (![about isEqualToString:@""] && ![about isEqual:[NSNull null]]) {
                    [user setAbout:[dictionary objectForKey: @"about_me"]];
                }
            }
            
            if (![[dictionary objectForKey: @"username"] isEqual:[NSNull null]]) {
                
                [user setUsername:[dictionary objectForKey: @"username"]];
            }
            
            NSString *age = [dictionary objectForKey: @"age"];
            if (![age isEqualToString:@""]) {
                [user setAge:[dictionary objectForKey:@"age"]];
            }
            
        }
        [self performSegueWithIdentifier:@"pushUser" sender:self];
    }
    
}

////////////
//SEARCH BAR
////////////
-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{

    NSDictionary * searchTextQuery = nil;
    NSDictionary * result = nil;
    
    if (self.workoutNameBtn.selected)
    {
        searchTextQuery = [[NSDictionary alloc] initWithObjectsAndKeys: text, @"workout", nil];
        isWorkoutSearch = YES;
        
    }
    else if (self.workoutDescriptionBtn.selected)
    {
        searchTextQuery = [[NSDictionary alloc] initWithObjectsAndKeys: text, @"description", nil];
        isWorkoutSearch = YES;
        
    }
    else if (self.workoutAuthorBtn.selected)
    {
        searchTextQuery = [[NSDictionary alloc] initWithObjectsAndKeys: text, @"author", nil];
        isWorkoutSearch = YES;
        
    }
    
    else if (self.workoutExerciseBtn.selected)
    {
        searchTextQuery = [[NSDictionary alloc] initWithObjectsAndKeys: text, @"tag_auto", nil];
        isWorkoutSearch = YES;
        
    }
    else if (self.peopleUsernameBtn.selected)
    {
        searchTextQuery = [[NSDictionary alloc] initWithObjectsAndKeys: text, @"username", nil];
        isWorkoutSearch = NO;
        
    }
    else if (self.peopleBioBtn.selected)
    {
        searchTextQuery = [[NSDictionary alloc] initWithObjectsAndKeys: text, @"email", nil];
        isWorkoutSearch = NO;
        
    }
    
    //workout search
    if (isWorkoutSearch)
    {
        result = [ServerRequests serverFormPost:(@"workouts/getWorkouts") data:(searchTextQuery)];
    }
    else
    {
        result = [ServerRequests serverFormPost:(@"users/getUsers") data:(searchTextQuery)];
    }
        
    //update table whenever the text changes
    if (result != nil && [[result objectForKey:@"Result"] isEqual: @"OK"])
    {
        tableData = [NSMutableArray array]; //create a brand new array
            
        NSArray * objs = [result objectForKey:@"Records"];
        for (id obj in objs)
        {
            [tableData addObject:obj];
        }
    }
}


/////////////////
// Button logic
/////////////////
- (void)clearButtons
{
    UIImage *blackButtonImage = [UIImage imageNamed:@"blackButton.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    //workout btns
    [self.workoutNameBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    self.workoutNameBtn.selected = NO;
    
    [self.workoutDescriptionBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    self.workoutDescriptionBtn.selected = NO;
    
    [self.workoutAuthorBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    self.workoutAuthorBtn.selected = NO;
    
    [self.workoutExerciseBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    self.workoutExerciseBtn.selected = NO;
    
    
    //people buttons
    [self.peopleUsernameBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    self.peopleUsernameBtn.selected = NO;
    [self.peopleBioBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    self.peopleBioBtn.selected = NO;

}

- (IBAction)workoutNameSelect:(id)sender
{
    UIImage *blackButtonImage = [UIImage imageNamed:@"ButtonBack.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self clearButtons];
    
    [self.workoutNameBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    self.workoutNameBtn.selected = YES;
    if ([self isServerAccessable])
    {
        [self.searchDisplayController.searchBar becomeFirstResponder];
    }

}

- (IBAction)peopleBioSelect:(id)sender
{
    UIImage *blackButtonImage = [UIImage imageNamed:@"ButtonBack.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self clearButtons];
    
    [self.peopleBioBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    self.peopleBioBtn.selected = YES;
    
    if ([self isServerAccessable])
    {
        [self.searchDisplayController.searchBar becomeFirstResponder];
    }
}

- (IBAction)peopleUsernameSelect:(id)sender
{
    UIImage *blackButtonImage = [UIImage imageNamed:@"ButtonBack.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self clearButtons];
    
    [self.peopleUsernameBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    self.peopleUsernameBtn.selected = YES;
    if ([self isServerAccessable])
    {
        [self.searchDisplayController.searchBar becomeFirstResponder];
    }
}

- (IBAction)workoutExerciseSelect:(id)sender
{
    UIImage *blackButtonImage = [UIImage imageNamed:@"ButtonBack.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self clearButtons];
    
    [self.workoutExerciseBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    self.workoutExerciseBtn.selected = YES;
    if ([self isServerAccessable])
    {
        [self.searchDisplayController.searchBar becomeFirstResponder];
    }
}

- (IBAction)workoutAuthorSelect:(id)sender
{
    UIImage *blackButtonImage = [UIImage imageNamed:@"ButtonBack.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self clearButtons];
    
    [self.workoutAuthorBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    self.workoutAuthorBtn.selected = YES;
    if ([self isServerAccessable])
    {
        [self.searchDisplayController.searchBar becomeFirstResponder];
    }
}

- (IBAction)workoutDescriptionSelect:(id)sender
{
    UIImage *blackButtonImage = [UIImage imageNamed:@"ButtonBack.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self clearButtons];
    
    [self.workoutDescriptionBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    self.workoutDescriptionBtn.selected = YES;
    if ([self isServerAccessable])
    {
        [self.searchDisplayController.searchBar becomeFirstResponder];
    }
}


///////////////
//gravatar md5
///////////////
- (NSString*) md5:(NSString *)str
{
    const char *const_string = [str UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(const_string, strlen(const_string), result);
    
    NSString * end_result = @"";
    
    for (int i = 0; i < 16; i++)
    {
        end_result = [end_result stringByAppendingString:[NSString stringWithFormat:@"%02X",result[i]]];
    }
    
    return [end_result lowercaseString];

}

- (BOOL) isServerAccessable
{
    //switch to ping google (way faster)
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"] encoding:NSASCIIStringEncoding error:nil];
    BOOL isAccessable = ( URLString != NULL ) ? YES : NO;
    
    if (!isAccessable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Sorry, but you must have an internet connection to use this feature"
                                                       delegate:self cancelButtonTitle:@"Exit" otherButtonTitles:nil];
        [alert show];
    }
    return isAccessable;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushUser"]) {
        EditProfileViewController *controller = (EditProfileViewController *) segue.destinationViewController;
        controller.user = user;
    }
    else if ([segue.identifier isEqualToString:@"pushWorkout"])
    {
        WorkoutViewController *controller = (WorkoutViewController *) segue.destinationViewController;
        controller.workoutSearchId = workoutId;
    }
}

@end
