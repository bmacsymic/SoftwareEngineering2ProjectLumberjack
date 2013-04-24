//
//  FollowersViewController.m
//  LumberJack
//
//  Re-Created by Jeremy Randy Turcotte on 2013-03-09.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "FollowersViewController.h"
#import "ECSlidingViewController.h"
#import "MeMenuViewController.h"
#import "ASIHTTPRequest.h"
#import "ServerRequests.h"
#import "DialogBox.h"
#import "User.h"
#import "ProfileViewController.h"
#import "Session.h"

@interface FollowersViewController ()
@end

@implementation FollowersViewController

@synthesize followersTableData ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
    [self addGesture];
    
    [self postToServer: Nil] ;
    
    User *luser = [[Session getSession] loggedIn];  
    if (luser)
    {
        NSString *username = [NSString stringWithFormat:@"%@%@", @"user/", luser.getUsername];
        
        NSDictionary *dictionary = [ServerRequests serverGetRequest:username data:nil];
        
        if (dictionary) {
            
            user = [[User alloc] init];
            user = [self parseUser:dictionary];
            
            UIImage* myImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: [dictionary objectForKey: @"avatar"]]]];
            [_avatarVIew setImage:myImage];
        }
    }
 
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self postToServer: Nil] ;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//following table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [followersTableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"followersTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [followersTableData objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:40.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)postToServer: (NSData *) json
{
    ASIHTTPRequest * request = [ServerRequests serverJSONPost:@"followers/get_followers" json:json];
    NSError * error = [request error];
    
    if(!error)
    {
        
        NSData * responseData = [request responseData];
        NSLog(@"%@", [request responseString] );
        NSDictionary * json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        
        if([json objectForKey:@"errors"] == nil)
        {
            followersTableData = [[NSMutableArray alloc] init] ;
            for(NSDictionary * user in json[@"Records"])
            {
                NSLog(@"%@\n", user[@"username"]);
                [followersTableData addObject: user[@"username"]];
            }
        }
        else
        {
            NSString * errorKey;
            NSDictionary * errorDescriptions = [json objectForKey:@"errors"];
            for(errorKey in errorDescriptions)
            {
                NSString * errorMessage = [errorDescriptions objectForKey:errorKey][0];
                
                NSLog(@"%@\n", [errorDescriptions objectForKey:errorKey]);
                NSLog(@"%@\n", errorMessage);
            }
            [DialogBox alertTitle:@"Error" alertMessage:@"Error getting followers"];
        }
    }
    else
    {
        [DialogBox alertTitle: @"Error" alertMessage: @"There was an error in sending your request to the server"];
    }
}

-(User *) parseUser: (NSDictionary *) dict
{
    User * pUser = [[User alloc] init];
    
    [pUser setUserId:[([dict objectForKey: @"id"]) intValue]];
    [pUser setLastName:[dict objectForKey: @"lastname"]];
    [pUser setFirstName:[dict objectForKey: @"firstname"]];
    [pUser setLocation:[dict objectForKey: @"location"]];
    [pUser setEmail:[dict objectForKey: @"email"]];
    [pUser setAvatar:[dict objectForKey: @"gravatar"]];
    [pUser setBirthDate:[dict objectForKey: @"birth"]];
    [pUser setAbout:[dict objectForKey: @"about_me"]];
    [pUser setAge:[dict objectForKey: @"age"]];
    [pUser setGender:[dict objectForKey: @"gender"]];
    [pUser setRegistrationDate:[dict objectForKey: @"registration_date"]];
    
    return pUser;
}

- (IBAction)menuOpen:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)goToNav:(id)sender {
    UIViewController *newTopController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavButtons"];
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
}
@end