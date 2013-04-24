//
//  NewsFeedViewController.m
//  LumberJack
//
//  Created by Lianfeng Luo on 2013-03-09.
//  Copyright (c) 2013 lumberjack_ios. All rights reserved.
//

#import "NewsFeedViewController.h"
#import "ECSlidingViewController.h"
#import "MeMenuViewController.h"
#import "ASIHTTPRequest.h"
#import "FeedCell.h"
#import "ServerRequests.h"
#import "Session.h"
#import "DialogBox.h"

@interface NewsFeedViewController ()
@end

@implementation NewsFeedViewController

NSMutableArray *tableData;

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

-(void)dismissKeyboard {
    [_statusText resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *blackButtonImage = [UIImage imageNamed:@"blackButton.png"];
    UIImage *stretchable = [blackButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [self.btnPost setBackgroundImage:stretchable forState:UIControlStateNormal];
    
	[self addGesture];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    _feedsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    User *luser = [[Session getSession] loggedIn];    
    
    NSString *url = [NSString stringWithFormat:@"%@%d", @"all_user_feeds/", luser.getUserId];
    
    NSDictionary *dictionary = [ServerRequests serverGetRequest:url data:nil];
    
    if (dictionary) {
        tableData = [NSMutableArray array];
        NSArray * feeds = [dictionary objectForKey:@"feed"];
        for (id feed in feeds)
        {
            for(NSString *key in [feed allKeys]) {
                NSLog(@"%@, %@",[feed objectForKey:key], key);
            }
            [tableData addObject:feed];
        }
    }
    
    NSLog(@"%d", [tableData count]);
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
 return 1;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 return [tableData count];
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0;
}
 
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
          
     static NSString *cellIdentifier = @"CellIdentifier";
     
     FeedCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
     
     if (cell == nil)
     {         
         NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FeedCell" owner:self options:nil];
         cell = [nib objectAtIndex:0];
     }
     
     // Set up the cell...
     UIImage* myImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: [[tableData objectAtIndex:indexPath.row ] objectForKey:@"avatar"]]]];
     cell.imageView.image = myImage;
     cell.authorLabel.text = [[tableData objectAtIndex:indexPath.row ] objectForKey:@"username"];
     cell.dateLabel.text = [[tableData objectAtIndex:indexPath.row ] objectForKey:@"time"];
     cell.postText.text = [[tableData objectAtIndex:indexPath.row ] objectForKey:@"body"];
      
 return cell;
 }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuOpen:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)postStatus:(id)sender {
    if ([self isValidInput]) {
        NSString *time;
        User *luser = [[Session getSession] loggedIn];
        NSString *username = luser.getUsername;
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSSSS"];
        time = [dateFormatter stringFromDate:now];
        NSString *avatar = [NSString stringWithFormat:@"%@80",[luser.getAvatar substringToIndex:[luser.getAvatar length]-3]];
    
        NSDictionary *statusInfo = [[NSDictionary alloc] initWithObjectsAndKeys: [NSString stringWithFormat:@"%d",luser.getUserId], @"uid", _statusText.text, @"body", nil];
    
        [ServerRequests serverFormPost:@"post-status/" data:statusInfo];
    
        NSDictionary *feed = [[NSDictionary alloc] initWithObjectsAndKeys:_statusText.text, @"body", time, @"time", username, @"username", avatar, @"avatar", nil];
    
        [tableData insertObject:feed atIndex:0];
    
        NSLog(@"%d", [tableData count]);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_feedsTableView beginUpdates];
        [_feedsTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [_feedsTableView endUpdates];
    
        _statusText.text = @"";
    } else {
        [DialogBox alertTitle:@"No Message" alertMessage:@"Message must be between 1 - 140 characters."];
    }
    
}

-(BOOL)isValidInput
{
    if ([_statusText.text length] > 0 && [_statusText.text length] <= 140) {
        return YES;
    }
    return NO;
}

- (IBAction)goToNav:(id)sender {
    UIViewController *newTopController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavButtons"];
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
}
@end
