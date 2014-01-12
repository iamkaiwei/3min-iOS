//
//  TMEProductDetailsViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 21/9/13.
//
//

#import "TMEProductDetailsViewController.h"
#import "TMEOfferViewController.h"
#import "TMESubmitViewController.h"

@interface TMEProductDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIButton     * btnFollow;
@property (weak, nonatomic) IBOutlet UIButton     * btnComment;
@property (weak, nonatomic) IBOutlet UIButton     * btnShare;
@property (weak, nonatomic) IBOutlet UIImageView  * imgUserAvatar;
@property (weak, nonatomic) IBOutlet UILabel      * lblUserName;
@property (weak, nonatomic) IBOutlet UILabel      * lblTimestamp;
@property (weak, nonatomic) IBOutlet UIImageView  * imgProductImage;
@property (weak, nonatomic) IBOutlet UILabel      * lblProductName;
@property (weak, nonatomic) IBOutlet UILabel      * lblProductPrice;
@property (weak, nonatomic) IBOutlet UIView       * viewChatToBuyWrapper;
@property (weak, nonatomic) IBOutlet UIScrollView * scrollViewProductDetail;

@property (assign, nonatomic) BOOL                  firstTimeOffer;

@end

@implementation TMEProductDetailsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    self.edgesForExtendedLayout = UIRectEdgeBottom;
  }
  
  self.title = self.product.name;
  
  [self loadProductDetail:self.product];
  [self setUpView];

  [self checkFirstTimeOffer];
}

- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];

  [self setUpView];
}

- (void)viewWillDisappear:(BOOL)animated{
  [super viewWillDisappear:animated];
  
  [UIView animateWithDuration:0.2 animations:^{
    self.tabBarController.tabBar.alpha = 1;
    self.tabBarController.tabBar.hidden = NO;
  }];
}

- (void)loadProductDetail:(TMEProduct *)product{
  
  self.product = product;
  
  // Follow button
  self.btnFollow.layer.borderWidth = 1;
  self.btnFollow.layer.borderColor = [UIColor grayColor].CGColor;
  self.btnFollow.layer.cornerRadius = 3;
  
  // Comment button
  self.btnComment.layer.borderWidth = 1;
  self.btnComment.layer.borderColor = [UIColor grayColor].CGColor;
  self.btnComment.layer.cornerRadius = 3;
  
  // Share button
  self.btnShare.layer.borderWidth = 1;
  self.btnShare.layer.borderColor = [UIColor grayColor].CGColor;
  self.btnShare.layer.cornerRadius = 3;
  
  // for now when we get product, we get all imformantion about this product like user, category, etc.
  
  // user
  self.imgUserAvatar.image = nil;
  [self.imgUserAvatar setImageWithURL:[NSURL URLWithString:product.user.photo_url] placeholderImage:nil];
  self.lblUserName.text = product.user.fullname;
  self.lblTimestamp.text = [product.created_at relativeDate];
  
  TMEProductImages *img = [product.images anyObject];
  [self.imgProductImage setImageWithURL:[NSURL URLWithString:img.medium] placeholderImage:nil];
  [self.imgProductImage clipsToBounds];
  
  self.lblProductName.text = product.name;
  self.lblProductPrice.text = [NSString stringWithFormat:@"$%@", [product.price stringValue]];
  
  TMEUser *currentLoginUser = [[TMEUserManager sharedInstance] loggedUser];
  [self.scrollViewProductDetail autoAdjustScrollViewContentSize];
  
  //If view chat to buy wrapper is hidden
  if([product.user.id isEqual:currentLoginUser.id])
  {
    self.viewChatToBuyWrapper.hidden = YES;
    self.scrollViewProductDetail.height += 55;
    [self.scrollViewProductDetail autoAdjustScrollViewContentSize];
  }
  
  //If view chat to buy wrapper is not hidden and System version is 7.0 or later
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
    self.scrollViewProductDetail.contentInset = UIEdgeInsetsMake(0, 0, -50, 0);
  }
}

- (void)setUpView
{
  UIScrollView *scrollView = (UIScrollView *)self.view.subviews[0];
  scrollView.bounces = NO;
  scrollView.showsVerticalScrollIndicator = NO;
  
  [UIView animateWithDuration:0.2 animations:^{
      self.tabBarController.tabBar.alpha = 0;
  }
                   completion:^(BOOL finished)
   {
       self.tabBarController.tabBar.hidden = YES;
   }];
}

- (UIViewController *)controllerForNextStep
{

#warning THIS IS FOR TESTING
  self.firstTimeOffer = YES;

  if (self.firstTimeOffer) {
    TMEOfferViewController *offerController = [[TMEOfferViewController alloc] init];
    offerController.product = self.product;
    return offerController;
  }else{
    TMESubmitViewController *submitController = [[TMESubmitViewController alloc] init];
    submitController.product = self.product;
    return submitController;
  }
}

- (IBAction)chatButtonAction:(id)sender {
  UIViewController *viewController = [self controllerForNextStep];
  [self.navigationController pushViewController:viewController animated:YES];
}

- (void)checkFirstTimeOffer
{
  [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
  [[TMEConversationManager sharedInstance] getConversationWithProductID:self.product.id toUserID:self.product.user.id onSuccessBlock:^(TMEConversation *conversation) {
    [SVProgressHUD dismiss];

    if(!conversation.lastest_message)
      self.firstTimeOffer = YES;

  } andFailureBlock:^(NSInteger statusCode, id obj) {

    [SVProgressHUD dismiss];
    self.firstTimeOffer = NO;
  }];
}

@end
