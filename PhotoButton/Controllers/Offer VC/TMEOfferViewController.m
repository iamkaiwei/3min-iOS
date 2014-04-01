//
//  TMEOfferViewController.m
//  PhotoButton
//
//  Created by admin on 1/12/14.
//
//

#import "TMEOfferViewController.h"
#import "TMESubmitViewController.h"
#import "AppDelegate.h"

@interface TMEOfferViewController ()
<
UITextFieldDelegate,
UIAlertViewDelegate
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
    self.title = NSLocalizedString(@"You Offer", nil);
    [self setUpView];
}

- (void)setUpView{
    self.navigationItem.rightBarButtonItem = [self rightNavigationButtonSubmit];
    self.labelDetail.text = [NSString stringWithFormat:NSLocalizedString(@"%@ is selling it for %@ VND", nil), self.product.user.fullname, self.product.price];
    
    self.labelPriceOffer.text = [NSString stringWithFormat:@"%@ VND",self.product.price];
    [self.labelPriceOffer sizeToFitKeepHeight];
    [self.labelPriceOffer alignHorizontalCenterToView:self.view];
    
    self.txtPrice.text = @"";
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.edgesForExtendedLayout = UIRectEdgeBottom;
    }
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


- (void)setOfferPriceToConversation{
    [TMEConversationManager createConversationWithProductID:self.product.id
                                                   toUserID:self.product.user.id
                                             withOfferPrice:@([self.txtPrice.text integerValue])
                                             onSuccessBlock:^(TMEConversation *conversation)
     {
         if (conversation.id) {
             self.conversation = conversation;
             TMESubmitViewController *submitController = [[TMESubmitViewController alloc] init];
             submitController.product = self.product;
             submitController.conversation = self.conversation;
             [self.navigationController pushViewController:submitController animated:YES];
         }
    }
                                               failureBlock:^(NSInteger statusCode, id obj) {
        [self failureBlockHandleWithError:obj];
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
    
    self.labelPriceOffer.text = [NSString stringWithFormat:@"%@ VND", self.product.price];
    self.txtPrice.text = @"";
    [self sizeToKeepLabelPriceHeightAlignCenter];
}

- (void)onDoneButton:(id)sender {
    if (![self invalidateOfferPrice]) {
        self.txtPrice.text = @"";
        self.labelPriceOffer.text = [NSString stringWithFormat:@"%@ VND", self.product.price];
        [self sizeToKeepLabelPriceHeightAlignCenter];
    }
    [self.view findAndResignFirstResponder];
}

- (void)onSubmitButton:(UIButton *)sender{
    
    if (![self invalidateOfferPrice]) {
        [self showSubmitAlert];
        return;
    }
    
    [self setOfferPriceToConversation];
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
    
    price = [NSString stringWithFormat:@"%@ VND", price];
    
    if (price.length >= 16) {
        price = NSLocalizedString(@"99999999999 VND", nil);
        self.labelPriceOffer.text = price;
        [self sizeToKeepLabelPriceHeightAlignCenter];
        return NO;
    }
    
    self.labelPriceOffer.text = price;
    [self sizeToKeepLabelPriceHeightAlignCenter];
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

- (BOOL)invalidateOfferPrice{
    if ([self.txtPrice.text isEqualToString:@"0"] || [self.txtPrice.text isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (void)sizeToKeepLabelPriceHeightAlignCenter{
    [self.labelPriceOffer sizeToFitKeepHeight];
    [self.labelPriceOffer alignHorizontalCenterToView:self.view];
}

- (void)showSubmitAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Confirm", nil)
                                                    message:NSLocalizedString(@"Do you want to offer with original price?", nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"No", nil)
                                          otherButtonTitles:NSLocalizedString(@"Yes", nil), nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        self.txtPrice.text = [self.product.price stringValue];
        [self setOfferPriceToConversation];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self performSelector:@selector(onDoneButton:) withObject:self.navigationItem.rightBarButtonItem];
}

@end
