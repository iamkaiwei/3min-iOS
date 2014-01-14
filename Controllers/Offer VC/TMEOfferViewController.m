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
<
UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UILabel *labelDetail;
@property (weak, nonatomic) IBOutlet UILabel *labelPriceOffer;
@property (weak, nonatomic) IBOutlet UITextField *txtPrice;
@property (weak, nonatomic) IBOutlet UIButton *buttonTapToChange;

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
  
//  [SVProgressHUD showWithStatus:@"Loading.." maskType:SVProgressHUDMaskTypeGradient];
//  [self loadConversation];

  self.txtPrice.text = @"";
}

- (IBAction)onBtnChangePrice:(id)sender {
  [CAAnimation addAnimationToLayer:self.buttonTapToChange.layer
                       withKeyPath:@"transform.rotation.z"
                          duration:1
                                to:-2*M_PI
                    easingFunction:CAAnimationEasingFunctionEaseOutBack];
  self.buttonTapToChange.userInteractionEnabled = NO;
  
  [self.txtPrice becomeFirstResponder];
}


- (void)loadConversation{
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
  UIImage *rightButtonBackgroundNormalImage = [UIImage oneTimeImageWithImageName:@"button-submit" isIcon:YES];
  UIImage *rightButtonBackgroundSelectedImage = [UIImage oneTimeImageWithImageName:@"button-submit-pressed" isIcon:YES];
  UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 75, 40)];
  [rightButton addTarget:self action:@selector(onSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
  [rightButton setBackgroundImage:rightButtonBackgroundNormalImage forState:UIControlStateNormal];
  [rightButton setBackgroundImage:rightButtonBackgroundSelectedImage forState:UIControlStateHighlighted];
  
  return [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)onBtnBack{
  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)onCancelButton:(id)sender {
  [self dismissKeyboard];
  
  self.labelPriceOffer.text = [NSString stringWithFormat:@"$%@", self.product.price];
  self.txtPrice.text = @"";
  [self.labelPriceOffer sizeToFitKeepHeight];
  [self.labelPriceOffer alignHorizontalCenterToView:self.view];
}

- (void)onSubmitButton:(UIButton *)sender{
  TMESubmitViewController *submitController = [[TMESubmitViewController alloc] init];
  submitController.product = self.product;
  submitController.conversation = self.conversation;
  [self.navigationController pushViewController:submitController animated:YES];
}

#pragma mark - UITextField delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
  self.isKeyboardShowing = YES;
  return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
  self.isKeyboardShowing = NO;
  return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  NSString * price = [NSString stringWithFormat:@"%@%@", self.txtPrice.text, string];
  if (1 == range.length) {
    price = [price stringByReplacingCharactersInRange:range withString:@""];
  }

  price = [NSString stringWithFormat:@"$%@", price];

  self.labelPriceOffer.text = price;
  [self.labelPriceOffer sizeToFitKeepHeight];
  [self.labelPriceOffer alignHorizontalCenterToView:self.view];
  return YES;
}

#pragma UIKeyboardNotification
- (void)onKeyboardWillShowNotification:(NSNotification *)sender
{
}

- (void)onKeyboardWillHideNotification:(NSNotification *)sender
{
  [self addNavigationItems];
  self.navigationItem.rightBarButtonItem = [self rightNavigationButtonSubmit];
  [self dismissKeyboard];
  self.buttonTapToChange.userInteractionEnabled = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  [self.view endEditing:YES];
}

@end
