//
//  ProfileViewController.m
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-09.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "ASIHTTPRequest.h"
#import "ServerRequests.h"
#import "Session.h"
#import "ECSlidingViewController.h"
#import "MeMenuViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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

- (IBAction)openMenu:(id)sender {
    printf("open menu profile");
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addGesture];
    [self resetFields];
    
    UIImage *blackButtonImage = [UIImage imageNamed:@"blackButton.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self.btnEditProfile setBackgroundImage:stretchable forState:UIControlStateNormal];
    
    User *luser = [[Session getSession] loggedIn];    
    
    if (luser)
    {
        NSString *username = [NSString stringWithFormat:@"%@%@", @"user/", luser.getUsername];
    
        NSDictionary *dictionary = [ServerRequests serverGetRequest:username data:nil];
    
        if (dictionary) {
        
            user = [[User alloc] init];
            user = [self parseUser:dictionary];
            
            UIImage* myImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: [dictionary objectForKey: @"avatar"]]]];
            [_avatarView setImage:myImage];
                  
            if (![self isNullOrEmptyValue:user.getLastName] && ![self isNullOrEmptyValue:user.getFirstName]) {
                _userName.text = [NSString stringWithFormat:@"%@, %@", user.getLastName, user.getFirstName];
            }
         
            if (![self isNullOrEmptyValue:user.getGender]) {
                if ([user.getGender isEqualToString:@"M"]) {
                    _gender.text = @"Male";
                } else if ([user.getGender isEqualToString:@"F"]) {
                    _gender.text = @"Female";
                }
            }
         
            if (![self isNullOrEmptyValue:user.getAge]) {
                _age.text = user.getAge;
            }
         
            if (![self isNullOrEmptyValue:user.getLocation]) {
                _location.text = [NSString stringWithFormat:@"%@ %@", _location.text, user.getLocation];
            } else {
                _location.text = @"";
            }
         
            _registration.text = [NSString stringWithFormat:@"%@ %@", _registration.text, user.getRegistrationDate];
            
            if (![self isNullOrEmptyValue:user.getAbout]) {
                _about.text = [NSString stringWithFormat:@"\"%@\"", user.getAbout];
            }
        }

    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //Your code here
    NSLog(@"View will appear");
    [self addGesture];
    [self resetFields];
    
    User *luser = [[Session getSession] loggedIn];
    
    if (luser)
    {
        NSString *username = [NSString stringWithFormat:@"%@%@", @"user/", luser.getUsername];
        
        NSDictionary *dictionary = [ServerRequests serverGetRequest:username data:nil];
        
        if (dictionary) {
            
            user = [[User alloc] init];
            user = [self parseUser:dictionary];
            
            UIImage* myImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: [dictionary objectForKey: @"avatar"]]]];
            [_avatarView setImage:myImage];
            
            if (![self isNullOrEmptyValue:user.getLastName] && ![self isNullOrEmptyValue:user.getFirstName]) {
                _userName.text = [NSString stringWithFormat:@"%@, %@", user.getLastName, user.getFirstName];
            }
            
            if (![self isNullOrEmptyValue:user.getGender]) {
                if ([user.getGender isEqualToString:@"M"]) {
                    _gender.text = @"Male";
                } else if ([user.getGender isEqualToString:@"F"]) {
                    _gender.text = @"Female";
                }
            }
            
            if (![self isNullOrEmptyValue:user.getAge]) {
                _age.text = user.getAge;
            }
            
            if (![self isNullOrEmptyValue:user.getLocation]) {
                _location.text = [NSString stringWithFormat:@"%@ %@", _location.text, user.getLocation];
            } else {
                _location.text = @"";
            }
            
            _registration.text = [NSString stringWithFormat:@"%@ %@", _registration.text, user.getRegistrationDate];
            
            if (![self isNullOrEmptyValue:user.getAbout]) {
                _about.text = [NSString stringWithFormat:@"\"%@\"", user.getAbout];
            }
        }        
    }    
}


-(void) resetFields
{
    _avatarView.image = nil;
    _userName.text = nil;
    _gender.text = nil;
    _age.text = nil;
    _registration.text = @"Join on ";
    _location.text = @"Lives in ";
    _about.text = nil;
}

-(User *) parseUser: (NSDictionary *) dict
{
    User * pUser = [[User alloc] init];
    
    [pUser setUserId:[([dict objectForKey: @"id"]) intValue]];
    if ([self isNullOrEmptyValue:[dict objectForKey: @"lastname"]]) {
        [pUser setLastName:@""];
    } else {
        [pUser setLastName:[dict objectForKey: @"lastname"]];
    }
    if ([self isNullOrEmptyValue:[dict objectForKey: @"firstname"]]) {
        [pUser setFirstName:@""];
    } else {
        [pUser setFirstName:[dict objectForKey: @"firstname"]];
    }
    if ([self isNullOrEmptyValue:[dict objectForKey: @"location"]]) {
        [pUser setLocation:@""];
    } else {
        [pUser setLocation:[dict objectForKey: @"location"]];
    }
    if ([self isNullOrEmptyValue:[dict objectForKey: @"email"]]) {
        [pUser setEmail:@""];
    } else {
        [pUser setEmail:[dict objectForKey: @"email"]];
    }
    if ([self isNullOrEmptyValue:[dict objectForKey: @"gravatar"]]) {
        [pUser setAvatar:@""];
    } else {
        [pUser setAvatar:[dict objectForKey: @"gravatar"]];
    }
    if ([self isNullOrEmptyValue:[dict objectForKey: @"birth"]]) {
        [pUser setBirthDate:@""];
    } else {
        [pUser setBirthDate:[dict objectForKey: @"birth"]];
    }
    if ([self isNullOrEmptyValue:[dict objectForKey: @"about_me"]]) {
        [pUser setAbout:@""];
    } else {
        [pUser setAbout:[dict objectForKey: @"about_me"]];
    }
    if ([self isNullOrEmptyValue:[dict objectForKey: @"age"]]) {
        [pUser setAge:@""];
    } else {
        [pUser setAge:[dict objectForKey: @"age"]];
    }
    if ([self isNullOrEmptyValue:[dict objectForKey: @"gender"]]) {
        [pUser setGender:@""];
    } else {
        [pUser setGender:[dict objectForKey: @"gender"]];
    }
    [pUser setRegistrationDate:[dict objectForKey: @"registration_date"]];
    
    return pUser;
}

- (IBAction)goToNav:(id)sender {
    UIViewController *newTopController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavButtons"];
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
}

-(BOOL) isNullOrEmptyValue:(NSString *)val
{
    if ([val isEqual:[NSNull null]] || [val isEqual:@""] || [val isEqual:nil])
    {
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"passData"]) {
        EditProfileViewController *controller = (EditProfileViewController *) segue.destinationViewController;        
        controller.user = user;
    }
}

- (IBAction)menuOpen:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}
@end
