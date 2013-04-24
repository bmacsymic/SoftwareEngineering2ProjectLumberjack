//
//  UserProfile.m
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-19.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "UserProfile.h"
#import "ServerRequests.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "DialogBox.h"
#import "User.h"
#import "Session.h"

@interface UserProfile ()

@end

@implementation UserProfile
@synthesize user;

BOOL follow_state = NO ;
NSString *st = nil;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImage *blackButtonImage = [UIImage imageNamed:@"blackButton.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self.followBtn setBackgroundImage:stretchable forState:UIControlStateNormal];
    
    _username.text = user.getFirstName;
    UIImage * myImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: user.getAvatar]]];
    [_avatarVIew setImage:myImage];
    _gender.text = user.getGender;
    _age.text = user.getAge;
    _registrationDate.text = user.getRegistrationDate;
    _location.text = user.getLocation;
    _about.text = user.getAbout;
 
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    
    User *luser = [[Session getSession] loggedIn];
    self.followBtn.hidden = YES ;
    
    //check if user is logged in -- if not don't call postServerMethod
    if (luser)
    {
        if([luser.getUsername isEqualToString:user.getUsername])
        {
            self.followBtn.hidden = YES ;
        } else // if not on own page then call for followers
        {
            [self postToServer: Nil] ;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//check if global user is following the user whose page they are on
- (void)postToServer: (NSData *) json
{
    ASIHTTPRequest * request = [ServerRequests serverJSONPost:@"followers/get_followers" json:json];
    NSError * error = [request error];
    BOOL found = NO ;
    NSString * checkName = user.getUsername ;
        
    if(!error)
    {
        NSData * responseData = [request responseData];
        NSLog(@"%@", [request responseString] );
        NSDictionary * json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        
        if([json objectForKey:@"errors"] == nil)
        {
            for(NSDictionary * fuser in json[@"Records"])
            {
                //scan through the followers list and if we find a match set BOOL=yes
                NSString *uName = fuser[@"username"];
                
                if([checkName isEqualToString:uName])
                {
                    found = YES ;
                    follow_state = YES ;
                } 
            }
            
            //show button and edit label accordingly
            if(found)
            {
                self.followBtn.hidden = NO ;
                [self.followBtn setTitle:@"Unfollow" forState:UIControlStateNormal] ;
                
            }
            else
            {
                self.followBtn.hidden = NO ;
                [self.followBtn setTitle:@"Follow" forState:UIControlStateNormal] ;
                
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

//Button handler -- server call to follow_btn()
- (IBAction)followBTN_action:(id)sender
{
    if(follow_state == NO) {
        st = @"Follow" ;
        follow_state = YES ;
    } else {
        st = @"Unfollow" ;
        follow_state = NO ;
    }
    
    NSString *strFromInt = [NSString stringWithFormat:@"%d",user.getUserId];
    NSString *follow_call = [NSString stringWithFormat:@"%@", @"follow_btn"];
    NSDictionary *request = [[NSDictionary alloc] initWithObjectsAndKeys:  strFromInt, @"followee", st , @"state", nil] ;
    NSDictionary *result = [ServerRequests serverGetRequest:follow_call data:request];
    
    if(result)
    {
        for(NSString *key in [result allKeys])
        {
            NSLog(@"%@",[result objectForKey:key]);
            
            if([[result objectForKey:key] isEqualToString: @"Unfollow"])
            {
                [self.followBtn setTitle:@"Unfollow" forState:UIControlStateNormal] ;
                               
            }else if([[result objectForKey:key] isEqualToString: @"Follow"])
            {
                [self.followBtn setTitle:@"Follow" forState:UIControlStateNormal] ;
            }  
        }
    }
}
@end