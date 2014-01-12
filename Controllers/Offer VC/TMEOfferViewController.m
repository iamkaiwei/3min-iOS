//
//  TMEOfferViewController.m
//  PhotoButton
//
//  Created by admin on 1/12/14.
//
//

#import "TMEOfferViewController.h"
#import "TMESubmitViewController.h"

@interface TMEOfferViewController ()

@property (strong, nonatomic) TMEConversation *conversation;
@property (weak, nonatomic) IBOutlet UILabel *labelDetail;
@property (weak, nonatomic) IBOutlet UILabel *labelPriceOffer;

@end

@implementation TMEOfferViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.title = @"You Offer";
  self.navigationItem.rightBarButtonItem = [self rightNavigationButtonSubmit];
  self.labelDetail.text = [NSString stringWithFormat:@"%@ is selling it for $%@", self.product.user.fullname, self.product.price];
  
  self.labelPriceOffer.text = [NSString stringWithFormat:@"$%@",self.product.price];
  [self.labelPriceOffer sizeToFitKeepHeight];
  [self.labelPriceOffer alignHorizontalCenterToView:self.view];
  
  [SVProgressHUD showWithStatus:@"Loading.." maskType:SVProgressHUDMaskTypeGradient];
  [self loadConversationShowBottom];
}

- (void)loadConversationShowBottom{
  [[TMEConversationManager sharedInstance] getConversationWithProductID:self.product.id
                                                               toUserID:self.product.user.id
                                                         onSuccessBlock:^(TMEConversation *conversation){
                                                           self.conversation = conversation;
                                                           [SVProgressHUD dismiss];
                                                         }
                                                        andFailureBlock:^(NSInteger statusCode, id obj){
                                                          DLog(@"%d",statusCode);
                                                          
                                                        }];
}

- (UIBarButtonItem *)rightNavigationButtonSubmit
{
  UIImage *rightButtonBackgroundNormalImage = [UIImage oneTimeImageWithImageName:@"publish_done_btn" isIcon:YES];
  UIImage *rightButtonBackgroundSelectedImage = [UIImage oneTimeImageWithImageName:@"publish_done_btn_pressed" isIcon:YES];
  UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 75, 40)];
  [rightButton addTarget:self action:@selector(onSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
  [rightButton setBackgroundImage:rightButtonBackgroundNormalImage forState:UIControlStateNormal];
  [rightButton setBackgroundImage:rightButtonBackgroundSelectedImage forState:UIControlStateHighlighted];
  
  return [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)onBtnBack{
  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)onSubmitButton:(UIButton *)sender{
  TMESubmitViewController *submitController = [[TMESubmitViewController alloc] init];
  submitController.product = self.product;
  submitController.conversation = self.conversation;
  [self.navigationController pushViewController:submitController animated:YES];
}

@end
