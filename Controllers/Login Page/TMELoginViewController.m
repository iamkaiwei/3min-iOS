//
//  TMELoginViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 21/9/13.
//
//

#import "TMELoginViewController.h"
#import "AppDelegate.h"

@interface TMELoginViewController () <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;

@end

@implementation TMELoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.loginView.readPermissions = @[@"user_about_me"];
        self.loginView.defaultAudience = FBSessionDefaultAudienceFriends;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBarHidden = YES;
    
    for(UIView *view in self.loginView.subviews)
    {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *loginBtn = (UIButton *)view;
            [loginBtn setBackgroundImage:[UIImage imageNamed:@"bt_fb_signin_normal"] forState:UIControlStateNormal];
            [loginBtn setBackgroundImage:[UIImage imageNamed:@"bt_fb_signin_pressed"] forState:UIControlStateHighlighted];
        }
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *lblName = (UILabel *)view;
            lblName.text = @"";
            lblName.textAlignment = UITextAlignmentCenter;
        }
    }
}

#pragma marks - Facebook delegates
- (IBAction)performLogin:(id)sender
{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
}

- (void)showLoginView
{
    UIViewController *topViewController = [self.navigationController topViewController];
    UIViewController *modalViewController = [topViewController modalViewController];
    
    // If the login screen is not already displayed, display it. If the login screen is
    // displayed, then getting back here means the login in progress did not successfully
    // complete. In that case, notify the login view so it can update its UI appropriately.
    if (![modalViewController isKindOfClass:[TMELoginViewController class]]) {
        TMELoginViewController* loginViewController = [[TMELoginViewController alloc] init];
        [topViewController presentModalViewController:loginViewController animated:NO];
    } else {
        TMELoginViewController* loginViewController = (TMELoginViewController*)modalViewController;
        [loginViewController loginFailed];
    }
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{

}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    DLog(@"logged User: %@", [user description]);
    NSString *token = [[[FBSession activeSession] accessTokenData] accessToken];
    DLog(@"Token = %@", token);
}

@end
