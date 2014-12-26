//
//  TMEProductDetailVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 9/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductDetailVC.h"
#import "TMEProduct.h"
#import "TMEOfferViewController.h"
#import "TMEProductDetailOnlyTableVC.h"
#import "UIViewController+Additions.h"

@interface TMEProductDetailVC () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *chatToBuyBottomGradient;
@property (weak, nonatomic) IBOutlet UIButton *chatToBuyButton;
@property (assign, nonatomic, getter=isFirstTimeOffer) BOOL firstTimeOffer;
@property (strong, nonatomic) TMEConversation *conversation;
@property (strong, nonatomic) TMEProductDetailOnlyTableVC *productDetailOnlyTableVC;

@end

@implementation TMEProductDetailVC

#pragma mark - View Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupBackBarButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupChildVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)setupChildVC
{
    // Product Detail Only
    self.productDetailOnlyTableVC = [TMEProductDetailOnlyTableVC
                                     tme_instantiateFromStoryboardNamed:@"ProductDetail"];
    self.productDetailOnlyTableVC.product = self.product;
    [self addChildVC:self.productDetailOnlyTableVC containerView:self.view];
    [self.view sendSubviewToBack:self.productDetailOnlyTableVC.view];
}

#pragma mark - Product

- (void)setProduct:(TMEProduct *)product
{
    _product = product;
    self.title = product.name;
}

- (void)checkFirstTimeOffer
{
    if (!self.product.user) {
        UIAlertView *invalidUserAlertView = [[UIAlertView alloc] initWithTitle:@""
                                                                       message:NSLocalizedString(@"We are sorry, something went wrong.", nil)
                                                                      delegate:self
                                                             cancelButtonTitle:NSLocalizedString(@"Back", nil)
                                                             otherButtonTitles:nil];
        [invalidUserAlertView show];
        return;
    }
    
    self.chatToBuyButton.userInteractionEnabled = NO;
    [TMEConversationManager checkConversationExistWithProductID:self.product.productID
                                                       toUserID:self.product.user.userID
                                                 onSuccessBlock: ^(TMEConversation *conversation) {
                                                     self.firstTimeOffer = YES;
                                                     if (conversation.conversationID) {
                                                         self.firstTimeOffer = NO;
                                                         self.conversation = conversation;
                                                     }
                                                     self.chatToBuyButton.userInteractionEnabled = YES;
                                                     UIViewController *viewController = [self controllerForNextStep];
                                                     self.hidesBottomBarWhenPushed = NO;
                                                     [self.navigationController pushViewController:viewController animated:YES];
                                                 } failureBlock: ^(NSError *error) {
                                                     self.chatToBuyButton.userInteractionEnabled = YES;
                                                 }];
}

- (UIViewController *)controllerForNextStep
{
    if (self.firstTimeOffer) {
        TMEOfferViewController *offerController = [[TMEOfferViewController alloc] init];
        offerController.product = self.product;
        offerController.conversation = self.conversation;
        return offerController;
    }
    else {
        TMESubmitViewController *submitController = [[TMESubmitViewController alloc] init];
        submitController.product = self.product;
        submitController.conversation = self.conversation;
        return submitController;
    }
}

#pragma mark - Action

- (IBAction)chatToBuyButtonTouched:(id)sender
{
    [self checkFirstTimeOffer];
}

#pragma mark - Private

- (BOOL)isCurrentUser
{
    return [self.product.user.userID isEqual:[TMEUserManager sharedManager].loggedUser.userID];
}

- (void)setupBackBarButton
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(didPressBackBarButton:)];
    backButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)didPressBackBarButton:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: {
            [self onBtnBack:nil];
            break;
        }
        default:
            break;
    }

}


@end
