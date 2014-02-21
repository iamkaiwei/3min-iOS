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
@property (weak, nonatomic) IBOutlet UIButton     * btnShare;
@property (weak, nonatomic) IBOutlet UIImageView  * imgUserAvatar;
@property (weak, nonatomic) IBOutlet UILabel      * lblUserName;
@property (weak, nonatomic) IBOutlet UILabel      * lblTimestamp;
@property (weak, nonatomic) IBOutlet UIImageView  * imgProductImage1;
@property (weak, nonatomic) IBOutlet UIImageView  * imgProductImage2;
@property (weak, nonatomic) IBOutlet UIImageView  * imgProductImage3;
@property (weak, nonatomic) IBOutlet UIImageView  * imgProductImage4;
@property (weak, nonatomic) IBOutlet UILabel      * lblProductName;
@property (weak, nonatomic) IBOutlet UILabel      * lblProductPrice;
@property (weak, nonatomic) IBOutlet UIView       * viewChatToBuyWrapper;
@property (weak, nonatomic) IBOutlet UIScrollView * scrollViewProductDetail;
@property (weak, nonatomic) IBOutlet UIView       * viewBottomDetail;
@property (strong, nonatomic) TMEConversation     * conversation;

@property (assign, nonatomic) BOOL                  firstTimeOffer;
@property (weak, nonatomic) IBOutlet UILabel *labelLikes;

@end

@implementation TMEProductDetailsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  self.title = self.product.name;
  
  [self loadProductDetail];
  [self setUpView];
}

- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  [self setUpView];
}

- (void)loadProductDetail{
  NSArray *arrayImageView = @[self.imgProductImage1, self.imgProductImage2, self.imgProductImage3, self.imgProductImage4];
  
  // Follow button
//  self.btnFollow.layer.borderWidth = 1;
//  self.btnFollow.layer.borderColor = [UIColor grayColor].CGColor;
//  self.btnFollow.layer.cornerRadius = 3;
//  
//  // Share button
//  self.btnShare.layer.borderWidth = 1;
//  self.btnShare.layer.borderColor = [UIColor grayColor].CGColor;
//  self.btnShare.layer.cornerRadius = 3;
  
  // for now when we get product, we get all imformantion about this product like user, category, etc.
  
  // user
  self.imgUserAvatar.image = nil;
  [self.imgUserAvatar setImageWithURL:[NSURL URLWithString:self.product.user.photo_url] placeholderImage:nil];
  self.lblUserName.text = self.product.user.fullname;
  self.lblTimestamp.text = [self.product.created_at relativeDate];
  
  NSArray *arrayImageOfProduct = [self.product.images allObjects];
  [self.imgProductImage1 setImageWithProgressIndicatorAndURL:nil
                                            placeholderImage:[UIImage imageNamed:@"photo-placeholder"]];
  self.imgProductImage1.hidden = NO;
  
  for (int i = 0; i < arrayImageOfProduct.count; i++) {
    TMEProductImages *img = arrayImageOfProduct[i];
    [arrayImageView[i] setHidden:NO];
    [arrayImageView[i] setImageWithProgressIndicatorAndURL:[NSURL URLWithString:img.origin]
                                          placeholderImage:[UIImage imageNamed:@"photo-placeholder"]];
  }
  
  [self.viewBottomDetail alignBelowView:arrayImageView[(arrayImageOfProduct.count == 0 ? 0 : arrayImageOfProduct.count - 1)] offsetY:0 sameWidth:NO];
  
  [[XLCircleProgressIndicator appearance] setStrokeProgressColor:[UIColor orangeMainColor]];
  [[XLCircleProgressIndicator appearance] setStrokeRemainingColor:[UIColor whiteColor]];
  [[XLCircleProgressIndicator appearance] setStrokeWidth:3.0f];
  
  self.lblProductName.text = self.product.name;
  self.lblProductPrice.text = [NSString stringWithFormat:@"$%@", self.product.price];
  
  [self.lblProductPrice sizeToFitKeepHeightAlignRight];
  
  self.labelLikes.text = self.product.likes.stringValue;
  self.btnFollow.selected = self.product.likedValue;
  
  [self.scrollViewProductDetail autoAdjustScrollViewContentSize];
  
  //If view chat to buy wrapper is hidden
  if([self.product.user.id isEqual:[[TMEUserManager sharedInstance] loggedUser].id])
  {
    self.viewChatToBuyWrapper.hidden = YES;
    self.scrollViewProductDetail.height += 55;
    [self.scrollViewProductDetail autoAdjustScrollViewContentSize];
  }
}

- (void)setUpView
{
  UIScrollView *scrollView = (UIScrollView *)self.view.subviews[0];
  scrollView.bounces = NO;
  scrollView.showsVerticalScrollIndicator = NO;
  
  if ([self respondsToSelector:@selector(setExtendedLayoutIncludesOpaqueBars:)]) {
      [self setExtendedLayoutIncludesOpaqueBars:YES];
  }
}

- (UIViewController *)controllerForNextStep
{
  if (self.firstTimeOffer) {
    TMEOfferViewController *offerController = [[TMEOfferViewController alloc] init];
    offerController.product = self.product;
    offerController.conversation = self.conversation;
    return offerController;
  }else{
    TMESubmitViewController *submitController = [[TMESubmitViewController alloc] init];
    submitController.product = self.product;
    submitController.conversation = self.conversation;
    return submitController;
  }
}

- (IBAction)chatButtonAction:(id)sender {
  if (![TMEReachabilityManager isReachable]) {
    [SVProgressHUD showErrorWithStatus:@"No connection!"];
    return;
  }
  [self checkFirstTimeOffer];
}

- (void)checkFirstTimeOffer
{
  [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
  
  [[TMEConversationManager sharedInstance] createConversationWithProductID:self.product.id
                                                               toUserID:self.product.user.id
                                                         onSuccessBlock:^(TMEConversation *conversation) {
                                                           [SVProgressHUD dismiss];
                                                           
                                                           self.conversation = conversation;
                                                           self.firstTimeOffer = NO;
                                                           
                                                           if([conversation.offer isEqualToNumber:@0])
                                                             self.firstTimeOffer = YES;
                                                           
                                                           UIViewController *viewController = [self controllerForNextStep];
                                                           self.hidesBottomBarWhenPushed = NO;
                                                           [self.navigationController pushViewController:viewController animated:YES];
                                                         } andFailureBlock:^(NSInteger statusCode, id obj) {
                                                           [SVProgressHUD dismiss];
                                                           self.firstTimeOffer = NO;
                                                         }];
}

- (IBAction)onBtnLike:(id)sender {
  self.btnFollow.selected = !self.product.likedValue;
  
  if (!self.product.likedValue) {
    [[TMEProductsManager sharedInstance] likeProductWithProductID:self.product.id
                                                   onSuccessBlock:nil
                                                  andFailureBlock:nil];
    self.product.likedValue = YES;
    self.product.likesValue++;
    self.labelLikes.text = [@(self.labelLikes.text.integerValue + 1) stringValue];
    return;
  }
  
  [[TMEProductsManager sharedInstance] unlikeProductWithProductID:self.product.id
                                                   onSuccessBlock:nil
                                                  andFailureBlock:nil];
  self.product.likedValue = NO;
  self.product.likesValue--;
  self.labelLikes.text = [@(self.labelLikes.text.integerValue - 1) stringValue];
}


@end
