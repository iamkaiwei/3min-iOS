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
    
    for(UIView *view in self.loginView.subviews)
    {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *loginBtn = (UIButton *)view;
            [loginBtn setBackgroundImage:[UIImage oneTimeImageWithImageName:@"bt_fb_signin_normal" isIcon:YES] forState:UIControlStateNormal];
            [loginBtn setBackgroundImage:[UIImage oneTimeImageWithImageName:@"bt_fb_signin_pressed" isIcon:YES] forState:UIControlStateHighlighted];
        }
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *lblName = (UILabel *)view;
            lblName.text = @"";
            lblName.textAlignment = NSTextAlignmentCenter;
        }
    }
}
@end
