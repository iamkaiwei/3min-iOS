//
//  TMEProfilePageContentViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProfilePageContentViewController.h"
#import "TMEMyTopProfileViewController.h"
#import "TMEOtherTopProfileViewController.h"
#import "TMEListActiviesViewController.h"
#import "TMEUserItemsViewController.h"
#import "TMEFeedbacksVC.h"
#import "TMEFeedback.h"

@interface TMEProfilePageContentViewController ()

@property (strong, nonatomic) UIViewController *topVC;
@property (strong, nonatomic) UIViewController *activitiesVC;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *viewFeedbackButton;
@property (weak, nonatomic) IBOutlet UIView *feedbackView;
@property (weak, nonatomic) IBOutlet KHRoundAvatar *feedbackUserAvatar;
@property (weak, nonatomic) IBOutlet UILabel *feedbackUserName;
@property (weak, nonatomic) IBOutlet UILabel *feedbackTime;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (nonatomic, strong) TMEUserItemsViewController *userItemsViewController;
@end

@implementation TMEProfilePageContentViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupFeedbackButton];
    [self setupNavigationBar];
    [self setupContainerControllers];
    
    // -- Need to handle feedbacks
    // [self handleFeedbacks];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    [self.topVC.view mas_remakeConstraints: ^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(0);
        make.height.equalTo([self _isLoggedInUserProfile] ? @160: @114);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
    }];
    [self.view layoutIfNeeded];
    
    [self.activitiesVC.view mas_remakeConstraints: ^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset([self _isLoggedInUserProfile] ? 160: 114);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
    }];
    [self.view layoutIfNeeded];
}

#pragma mark - private

- (void)setupContainerControllers
{
    UIViewController *topVC = [self _getTopViewController];
    [self addChildViewController:topVC];
    [topVC willMoveToParentViewController:self];
    [self.view addSubview:topVC.view];
    [topVC didMoveToParentViewController:self];
    self.topVC = topVC;
    
    UIViewController *activitiesVC = [self _getBottomController];
    [self addChildViewController:activitiesVC];
    [activitiesVC willMoveToParentViewController:self];
    [self.view addSubview:activitiesVC.view];
    [activitiesVC didMoveToParentViewController:self];
    self.activitiesVC = activitiesVC;
    [self.view layoutIfNeeded];
}

- (void)handleFeedbacks
{
    [self.view bringSubviewToFront:self.viewFeedbackButton];
    [self.view bringSubviewToFront:self.lineView];
    [TMEFeedbackClient getFeedbacksForUser:self.user success:^(NSArray *array) {
        NSUInteger feedbackCount = array.count;
        if (feedbackCount > 0) {
            [self.view bringSubviewToFront:self.feedbackView];
            [self.viewFeedbackButton setTitle:[NSString stringWithFormat:@"View %@ feedbacks", @(feedbackCount)]
                                     forState:UIControlStateNormal];
            TMEFeedback *feedback = [array firstObject];
            [self.feedbackUserAvatar setImageWithURL:[NSURL URLWithString:feedback.user.avatar]
                                    placeholderImage:[UIImage imageNamed:@"avatar_holding"]];
            self.feedbackUserName.text = feedback.user.fullName;
            self.feedbackTime.text = feedback.updatedAt.agoString;
            self.feedbackLabel.text = feedback.content;
        }
    } failure:^(NSError *error) {
        DLog(@"%@", error);
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

- (void)setupFeedbackButton
{
    self.viewFeedbackButton.layer.borderColor = [UIColor orangeMainColor].CGColor;
    self.viewFeedbackButton.layer.borderWidth = 1.f;
    self.viewFeedbackButton.layer.cornerRadius = 14.f;
    self.viewFeedbackButton.titleLabel.textColor = [UIColor orangeMainColor];
}

- (void)setupNavigationBar
{
    self.navigationItem.title = self.user.fullName ?: @"Profile";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self setupBackBarButton];
}

- (void)setupBackBarButton
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(didPressBackBarButton:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (BOOL)_isLoggedInUserProfile
{
    if ([self.user.userID isEqual:[[[TMEUserManager sharedManager] loggedUser] userID]]) {
        return YES;
    }
    
    return NO;
}

- (UIViewController *)_getTopViewController
{
    if ([self _isLoggedInUserProfile]) {
        // show my own profile
        TMEMyTopProfileViewController *topVC = [[TMEMyTopProfileViewController alloc] init];
        topVC.user = self.user;
        return topVC;
    }
    
    // and the orther
    TMEOtherTopProfileViewController *topVC = [[TMEOtherTopProfileViewController alloc] init];
    topVC.user = self.user;
    return topVC;
}

- (UIViewController *)_getBottomController
{
    if ([self _isLoggedInUserProfile]) {
        TMEListActiviesViewController *activitiesVC = [[TMEListActiviesViewController alloc] init];
        return activitiesVC;
    }
    
    return self.userItemsViewController;
}

- (TMEUserItemsViewController *)userItemsViewController
{
    if (!_userItemsViewController) {
        _userItemsViewController = [TMEUserItemsViewController
                                    tme_instantiateFromStoryboardNamed:NSStringFromClass([TMEUserItemsViewController class])];
        _userItemsViewController.userID = self.user.userID;
    }

    return _userItemsViewController;
}

#pragma mark - Action

- (IBAction)viewFeedbackTouched:(id)sender
{
    TMEFeedbacksVC *vc = [TMEFeedbacksVC tme_instantiateFromStoryboardNamed:@"Feedback"];
    vc.user = self.user;
    
    if (IS_IOS8_OR_ABOVE) {
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    } else {
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
    }
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didPressBackBarButton:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
