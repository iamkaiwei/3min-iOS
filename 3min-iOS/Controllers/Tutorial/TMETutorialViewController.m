//
//  TMETutorialViewController.m
//  PhotoButton
//
//  Created by Hoang Ta on 9/28/13.
//
//

#import "AppDelegate.h"
#import "TMETutorialViewController.h"
#import "TMEGooglePlusManager.h"
#import "TMEFacebookManager.h"


NSString *const TUTORIAL_HAS_BEEN_PRESENTED = @"tutorial_has_been_presented";
NSUInteger const kNumberOfPages = 3;

@interface TMETutorialViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollViewContentView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation TMETutorialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureScrollView];
}

#pragma mark - ScrollView
- (void)configureScrollView
{
    self.scrollView.delegate = self;

    [self.scrollViewContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.view.mas_height);
        make.width.equalTo(self.view.mas_width).multipliedBy(kNumberOfPages);
    }];

    for (int i=0; i<kNumberOfPages; ++i) {
        UIImageView *imageView = [[UIImageView alloc] init];

        NSString *imageName = [NSString stringWithFormat:@"bg_login_%d", i+1];
        imageView.image = [UIImage imageNamed:imageName];

        [self.scrollViewContentView addSubview:imageView];

        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.view.mas_height);
            make.width.equalTo(self.view.mas_width);
            make.top.equalTo(self.scrollViewContentView.mas_top);
            make.left.equalTo(self.scrollViewContentView.mas_left).mas_offset(self.view.width * i);
        }];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

#pragma mark - Action
- (IBAction)googleButtonAction:(id)sender
{
    [SVProgressHUD showWithStatus:LS(@"Logging in")];
    self.view.userInteractionEnabled = NO;

    [[TMEUserNetworkClient sharedClient] loginWithGooglePlusWithSuccess:^(NSError *error) {
        [self notifyUserDidLogin];
        [SVProgressHUD dismiss];
        self.view.userInteractionEnabled = YES;
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        self.view.userInteractionEnabled = YES;
    }];
}

- (IBAction)facebookButtonAction:(id)sender
{
    [SVProgressHUD showWithStatus:LS(@"Logging in")];
    self.view.userInteractionEnabled = NO;

    [[TMEUserNetworkClient sharedClient] loginWithFacebookWithSuccess:^{
        [self notifyUserDidLogin];
        [SVProgressHUD dismiss];
        self.view.userInteractionEnabled = YES;
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        self.view.userInteractionEnabled = YES;
    }];
}

#pragma mark - Helper
- (void)notifyUserDidLogin
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TMEUserDidLoginNotification object:nil];
}


@end
