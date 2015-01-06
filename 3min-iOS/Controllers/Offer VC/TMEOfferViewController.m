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

#pragma mark - View Lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setUpView
{
    [self setupNavigationItems];
    
    self.labelDetail.text = [NSString stringWithFormat:NSLocalizedString(@"%@ is selling it for %@ VND", nil), self.product.user.fullName, self.product.price];
    
    self.labelPriceOffer.text = [NSString stringWithFormat:@"%@ VND",self.product.price];
    [self.labelPriceOffer sizeToFitKeepHeight];
    [self.labelPriceOffer alignHorizontalCenterToView:self.view];
    
    self.txtPrice.text = @"";
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.edgesForExtendedLayout = UIRectEdgeBottom;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpView];
}

#pragma mark - Private

- (void)setOfferPriceToConversation
{
    [TMEConversationManager createConversationWithProductID:self.product.id
                                                   toUserID:self.product.user.userID
                                             withOfferPrice:@([self.txtPrice.text integerValue])
                                             onSuccessBlock:^(TMEConversation *conversation)
     {
         if (conversation.conversationID) {
             self.conversation = conversation;
             TMESubmitViewController *submitController = [[TMESubmitViewController alloc] init];
             submitController.product = self.product;
             submitController.conversation = self.conversation;
             [self.navigationController pushViewController:submitController animated:YES];
         }
    }
                                               failureBlock:^(NSError *error) {
        [self failureBlockHandleWithError:error];
    }];
}

- (UIBarButtonItem *)rightNavigationButtonSubmit
{
    UIImage *rightButtonBackgroundNormalImage = [UIImage imageNamed:@"button-submit"];
    UIImage *rightButtonBackgroundSelectedImage = [UIImage imageNamed:@"button-submit-pressed"];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 75, 40)];
    [rightButton addTarget:self action:@selector(onSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:rightButtonBackgroundNormalImage forState:UIControlStateNormal];
    [rightButton setBackgroundImage:rightButtonBackgroundSelectedImage forState:UIControlStateHighlighted];
    
    return [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

#pragma mark - UITextField delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.keyboardShowing = YES;
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.keyboardShowing = NO;
//    [self addNavigationItems];
    self.navigationItem.leftBarButtonItem = nil; // ???
    self.navigationItem.rightBarButtonItem = [self rightNavigationButtonSubmit];
    self.buttonTapToChange.userInteractionEnabled = YES;
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

- (BOOL)invalidateOfferPrice
{
    if ([self.txtPrice.text isEqualToString:@"0"] || [self.txtPrice.text isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (void)sizeToKeepLabelPriceHeightAlignCenter
{
    [self.labelPriceOffer sizeToFitKeepHeight];
    [self.labelPriceOffer alignHorizontalCenterToView:self.view];
}

- (void)showSubmitAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Confirm", nil)
                                                    message:NSLocalizedString(@"Do you want to offer with original price?", nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"No", nil)
                                          otherButtonTitles:NSLocalizedString(@"Yes", nil), nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        self.txtPrice.text = self.product.price;
        [self setOfferPriceToConversation];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(onDoneButton:) withObject:self.navigationItem.rightBarButtonItem];
}

#pragma mark - Action

- (void)setupNavigationItems
{
    self.navigationItem.rightBarButtonItem = [self rightNavigationButtonSubmit];
    self.navigationItem.title = NSLocalizedString(@"You Offer", nil);
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

- (IBAction)onBtnChangePrice:(id)sender
{
    [CAAnimation addAnimationToLayer:self.buttonTapToChange.layer
                         withKeyPath:@"transform.rotation.z"
                            duration:1
                                  to:-2*M_PI
                      easingFunction:CAAnimationEasingFunctionEaseOutBack];
    self.buttonTapToChange.userInteractionEnabled = NO;
    
    [self.txtPrice becomeFirstResponder];
}

- (void)onCancelButton:(id)sender
{
    [self.view endEditing:YES];
    
    self.labelPriceOffer.text = [NSString stringWithFormat:@"%@ VND", self.product.price];
    self.txtPrice.text = @"";
    [self sizeToKeepLabelPriceHeightAlignCenter];
}

- (void)onDoneButton:(id)sender
{
    if (![self invalidateOfferPrice]) {
        self.txtPrice.text = @"";
        self.labelPriceOffer.text = [NSString stringWithFormat:@"%@ VND", self.product.price];
        [self sizeToKeepLabelPriceHeightAlignCenter];
    }
    [self.view findAndResignFirstResponder];
}

- (void)onSubmitButton:(UIButton *)sender
{
    if (![self invalidateOfferPrice]) {
        [self showSubmitAlert];
        return;
    }
    
    [self setOfferPriceToConversation];
}

@end
