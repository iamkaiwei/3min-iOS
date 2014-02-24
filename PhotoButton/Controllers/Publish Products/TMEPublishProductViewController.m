//
//  TMEPublishProductViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 12/9/13.
//
//

#import "TMEPublishProductViewController.h"
#import "TMEBrowserProductsViewController.h"
#import "TMEBrowserCollectionViewController.h"
#import "HTKContainerViewController.h"
#import "TMESwitch.h"
#import "PBImageHelper.h"
#import "PublishLocationPickerViewController.h"
#import "UIPlaceHolderTextView.h"

@interface TMEPublishProductViewController ()
<
AFPhotoEditorControllerDelegate,
UIAlertViewDelegate,
UITextFieldDelegate,
TMEPhotoButtonDelegate,
UIPickerViewDataSource,
UIPickerViewDelegate,
UITextViewDelegate
>

@property (assign, nonatomic) BOOL                    postingInProgress;
@property (strong, nonatomic) TMEPhotoButton        * currentPhotoButton;
@property (strong, nonatomic) TMEProduct            * product;
@property (weak, nonatomic) IBOutlet TMESwitch      * switchFacebookShare;

@property (weak, nonatomic) IBOutlet UITextField    * txtProductName;
@property (weak, nonatomic) IBOutlet UITextField    * txtProductPrice;
@property (strong, nonatomic) NSArray               * arrayCategories;
@property (weak, nonatomic) IBOutlet UIPickerView   * pickerCategories;
@property (weak, nonatomic) IBOutlet UIView         * viewPickerWrapper;
@property (weak, nonatomic) IBOutlet UIButton       * pickerCategoryButton;

@property (strong, nonatomic) FSVenue               * selectVenue;
@property (weak, nonatomic) IBOutlet UILabel        * lblLocationName;

@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *txtProductDescription;

@property (strong, nonatomic) IBOutletCollection(TMEPhotoButton) NSArray * photoButtons;

@end

@implementation TMEPublishProductViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"";
    self.txtProductDescription.placeholder = @"Enter product description";

    self.txtProductName.delegate = self;
    self.txtProductPrice.delegate = self;

    if ([self.txtProductName respondsToSelector:@selector(setTintColor:)]) {
        [self.txtProductName setTintColor:[UIColor orangeMainColor]];
        [self.txtProductPrice setTintColor:[UIColor orangeMainColor]];
    }
    //    self.navigationController.navigationBar.topItem.title = @"Publish Product";

    for (TMEPhotoButton *button in self.view.subviews) {
        if ([button isKindOfClass:[TMEPhotoButton class]]) {
            [button addTarget:self action:@selector(photoSaved:) forControlEvents:UIControlEventValueChanged];
            button.viewController = self;
            button.photoSize = CGSizeMake(1000, 1000);
        }
    }
    [self disableNavigationTranslucent];
    self.navigationItem.leftBarButtonItem = [self leftNavigationButtonCancel];
    self.navigationItem.rightBarButtonItem = [self rightNavigationButton];

    ((UIScrollView *)self.view).showsHorizontalScrollIndicator = NO;
    ((UIScrollView *)self.view).showsVerticalScrollIndicator = NO;

    [[TMECategoryManager sharedInstance] getAllCategoriesOnSuccessBlock:^(NSArray *arrayCategories) {
        self.arrayCategories = arrayCategories;
        [self.pickerCategories reloadAllComponents];
    } andFailureBlock:^(NSInteger statusCode, id obj) {
        [SVProgressHUD showErrorWithStatus:@"Failure to load categories"];
    }];

    [self autoAdjustScrollViewContentSize];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //Ask user to take picture
    if ([self hasNoImages]) {
        [self.photoButtons[0] takeOrChoosePhoto:YES];
    }

    if (self.selectVenue) {
        self.lblLocationName.text = self.selectVenue.name;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self dismissKeyboard];
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

- (UIBarButtonItem *)rightNavigationButton
{
    UIImage *rightButtonBackgroundNormalImage = [UIImage oneTimeImageWithImageName:@"button-submit" isIcon:YES];
    UIImage *rightButtonBackgroundSelectedImage = [UIImage oneTimeImageWithImageName:@"button-submit-pressed" isIcon:YES];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 75, 40)];
    [rightButton addTarget:self action:@selector(onPublishButton:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:rightButtonBackgroundNormalImage forState:UIControlStateNormal];
    [rightButton setBackgroundImage:rightButtonBackgroundSelectedImage forState:UIControlStateHighlighted];

    return [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

# pragma mark - AFPhotoController delegate

- (void)photoEditor:(TMEBasePhotoEditorViewController *)editor finishedWithImage:(UIImage *)image
{
    [self dismissModalViewControllerWithFadeDuration:0.2];
    [self.currentPhotoButton setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)photoEditorCanceled:(AFPhotoEditorController *)editor
{
    [self.currentPhotoButton resetAttributes];
    [editor dismissViewControllerAnimated:YES completion:nil];
}

# pragma marks - Actions

- (void)photoSaved:(TMEPhotoButton *)button
{
    self.currentPhotoButton = button;

    UIImage *image = [button backgroundImageForState:UIControlStateNormal];
    TMEBasePhotoEditorViewController *editorController = [[TMEBasePhotoEditorViewController alloc] initWithImage:image];
    editorController.delegate = self;

    [AFPhotoEditorCustomization setToolOrder:@[kAFEffects]];
    [self presentModalViewController:editorController withPushDirection:@"left"];
}

- (TMEProduct *)getTheInputProductFromForm
{
    // create dummy user
    TMEUser *user = [[TMEUserManager sharedInstance] loggedUser];

    // category
    NSInteger pickerIndex = [self.pickerCategories selectedRowInComponent:0];
    TMECategory *cat = [self.arrayCategories objectAtIndex:pickerIndex];
    TMECategory *category = cat;

    // create product
    TMEProduct *product = [TMEProduct MR_createEntity];
    product.name = self.txtProductName.text;
    product.id = @1;
    product.price = @([self.txtProductPrice.text doubleValue]);
    product.category = category;
    product.user = user;

    return product;
}

- (void)onCancelButton:(id)sender {
    if (self.activeTextField) {
        self.activeTextField.text = @"";
    }

    if (self.isKeyboardShowing) {
        [self dismissKeyboard];
        return;
    }

    if ([self hasChoseCategory] || [self hasProductName] || [self hasProductPrice] || ![self hasNoImages]) {
        [self showAlertViewOnCancel];
        return;
    }

    self.tabBarController.selectedIndex = 0;
}

- (BOOL)hasNoImages
{
    for (TMEPhotoButton *photoButton in self.photoButtons) {
        if ([photoButton hasPhoto]) {
            return NO;
        }
    }

    return YES;
}

- (BOOL)validateInputs
{
    if (![self hasChoseCategory]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You haven't chose any category yet" delegate:nil cancelButtonTitle:@"Okie" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }

    if (![self hasProductName]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You haven't chose any name yet" delegate:nil cancelButtonTitle:@"Okie" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }

    if (![self hasProductPrice]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You haven't chose any price yet" delegate:nil cancelButtonTitle:@"Okie" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }

    if ([self hasNoImages]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There is no images in your product, try to add one" delegate:nil cancelButtonTitle:@"Okie" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }

    return YES;
}

- (void)onPublishButton:(id)sender {
    [self dismissKeyboard];

    if (![self validateInputs])
        return;

    self.product = [self getTheInputProductFromForm];

    // move to browser tab if they are another tab
    if(![self.tabBarController.selectedViewController isKindOfClass:[TMEBrowserProductsViewController class]]){
        [self.tabBarController setSelectedIndex:0];
    }

    NSMutableDictionary *params = [@{@"user_id": self.product.user.id,
                                     @"name": self.product.name,
                                     @"category_id": self.product.category.id,
                                     @"price": self.product.price,
                                     @"sold_out": @NO} mutableCopy];

    if (self.selectVenue) {
        params[@"venue_id"] = self.selectVenue.venueId;
        params[@"venue_name"] = self.selectVenue.name;
        params[@"venue_long"] = @(self.selectVenue.location.coordinate.longitude);
        params[@"venue_lat"] = @(self.selectVenue.location.coordinate.latitude);
    }

    if (self.txtProductDescription.text) {
        params[@"description"] = self.txtProductDescription.text;
    }

    __block NSNumber *percent = @(0.0f);

    NSString *path = [API_PREFIX stringByAppendingString:API_PRODUCTS];
    [[BaseNetworkManager sharedInstance] sendMultipartFormRequestForPath:path
                                                              parameters:params
                                                                  method:POST_METHOD
                                               constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         for (TMEPhotoButton *photoButton in self.photoButtons) {
             if ([photoButton hasPhoto]) {
                 NSData *imageData = UIImageJPEGRepresentation([photoButton backgroundImageForState:UIControlStateNormal], 0.5);
                 NSString *imageName = [@([[NSDate date] timeIntervalSince1970]) stringValue];
                 [formData appendPartWithFileData:imageData name:@"images[]" fileName:imageName mimeType:@"image/jpeg"];
             }
         }

     } success:^(NSHTTPURLResponse *response, id responseObject) {
         [SVProgressHUD dismiss];

         NSError* error;

         NSDictionary* json = responseObject;

         if ([responseObject isKindOfClass:[NSData class]]) {
             json = [NSJSONSerialization
                     JSONObjectWithData:responseObject

                     options:kNilOptions
                     error:&error];
         }
         // reset the form
         if ([self.switchFacebookShare isOn]) {
             [self prepareMyBatchRequest];
         }

         [self resetAllForms];

         if ([((TMENavigationViewController *)self.tabBarController.selectedViewController).topViewController isKindOfClass:[HTKContainerViewController class]]) {
             HTKContainerViewController *containerVC = (HTKContainerViewController *)((TMENavigationViewController *)self.tabBarController.selectedViewController).topViewController;

             if ([containerVC.currentViewController isKindOfClass:[TMEBrowserProductsViewController class]]) {
                 [((TMEBrowserProductsViewController *)containerVC.currentViewController) loadProducts];
             }

             if ([containerVC.currentViewController isKindOfClass:[TMEBrowserCollectionViewController class]]) {
                 [((TMEBrowserCollectionViewController *)containerVC.currentViewController) loadProducts];
             }
         }
         [TSMessage showNotificationWithTitle:@"Your product has been uploaded successfully." type:TSMessageNotificationTypeSuccess];

         [((TMENavigationViewController *)self.tabBarController.selectedViewController) finishSGProgress];

     } failure:^(NSError *error) {

         [SVProgressHUD showErrorWithStatus:@"Fail to upload, try again later"];
         [((TMENavigationViewController *)self.tabBarController.selectedViewController) finishSGProgress];

     } progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {

         // save last 30% for response
         percent = @(((float)totalBytesWritten)/totalBytesExpectedToWrite * 0.7);
         float percentage = [percent floatValue];
         percentage *= 100;
         [((TMENavigationViewController *)self.tabBarController.selectedViewController) setSGProgressPercentage:percentage];
     }];
}

#pragma mark - UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.arrayCategories.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    TMECategory *cat = [self.arrayCategories objectAtIndex:row];
    return cat.name;
}

- (IBAction)onButtonPicker:(id)sender {
    [self dismissKeyboard];

    UIScrollView *scrollView = (UIScrollView *)self.view;
    scrollView.scrollEnabled = NO;

    CGFloat originY = scrollView.contentOffset.y + self.view.height - self.viewPickerWrapper.height;

    CGRect pickerFrame = self.viewPickerWrapper.frame;
    pickerFrame.origin.y = originY;
    self.viewPickerWrapper.frame = pickerFrame;

    self.viewPickerWrapper.hidden = NO;
}

- (IBAction)onButtonPickerDone:(id)sender {

    NSInteger row = [self.pickerCategories selectedRowInComponent:0];
    TMECategory *cat = [self.arrayCategories objectAtIndex:row];
    [self.pickerCategoryButton setTitle:cat.name forState:UIControlStateNormal];
    self.viewPickerWrapper.hidden = YES;

    UIScrollView *scrollView = (UIScrollView *)self.view;
    scrollView.scrollEnabled = YES;
}

- (IBAction)onButtonPickerCancel:(id)sender {
    self.viewPickerWrapper.hidden = YES;

    UIScrollView *scrollView = (UIScrollView *)self.view;
    scrollView.scrollEnabled = YES;
}

- (void)prepareMyBatchRequest{
    NSString *message = [NSString stringWithFormat:@"Hi! I want to sell %@ for $%@. Let's take a look!", [self.product.name capitalizedString], self.product.price];

    NSString *jsonRequestsArray = @"[";
    NSString *jsonRequest = @"";
    NSInteger count = 1;
    NSMutableDictionary *params = [NSMutableDictionary new];

    for (TMEPhotoButton *photoButton in self.photoButtons) {
        if ([photoButton hasPhoto]) {
            NSString *imageName = [NSString stringWithFormat:@"file%d", count];
            [params setObject:[photoButton backgroundImageForState:UIControlStateNormal] forKey:imageName];

            jsonRequest = [NSString stringWithFormat:@"{ \"method\": \"POST\", \"relative_url\": \"me/photos\" , \"body\": \"message=%@\", \"attached_files\": \"%@\" }", message, imageName];

            jsonRequestsArray = [jsonRequestsArray stringByAppendingString:[NSString stringWithFormat:@"%@,",jsonRequest]];
            count++;
        }
    }

    jsonRequestsArray = [jsonRequestsArray substringToIndex:[jsonRequestsArray length] - 1];
    jsonRequestsArray = [jsonRequestsArray stringByAppendingString:@"]"];


    [params setObject:jsonRequestsArray forKey:@"batch"];
    __block FBRequest *request;
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound)
    {
        // No permissions found in session, ask for it
        [FBSession.activeSession requestNewPublishPermissions: [NSArray arrayWithObject:@"publish_actions"]
                                              defaultAudience: FBSessionDefaultAudienceFriends
                                            completionHandler: ^(FBSession *session, NSError *error)
         {
             if (!error)
             {
                 // If permissions granted and not already posting then publish the story
                 if (!self.postingInProgress)
                 {
                     request = [FBRequest requestWithGraphPath:@"me" parameters:params HTTPMethod:@"POST"];
                 }
             }
         }];
        return;
    }
    // If permissions present and not already posting then publish the story
    if (!self.postingInProgress)
    {
        request = [FBRequest requestWithGraphPath:@"me" parameters:params HTTPMethod:@"POST"];
    }

    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error){
        NSArray *allResponses = result;
        for (int i=0; i < [allResponses count]; i++) {
            NSDictionary *response = [allResponses objectAtIndex:i];
            int httpCode = [[response objectForKey:@"code"] intValue];
            NSString *jsonResponse = [response objectForKey:@"body"];
            if (httpCode != 200) {
                NSLog(@"Facebook request error: code: %d  message: %@", httpCode, jsonResponse);
            } else {
                NSLog(@"Facebook response: %@", jsonResponse);
            }
        }
    }];
}

#pragma mark - Helper methods

- (void)resetAllForms
{
    for (id button in self.view.subviews)
        if ([button isKindOfClass:[TMEPhotoButton class]])
            [button resetAttributes];

    self.pickerCategoryButton.titleLabel.text = @"Choose one";
    self.txtProductName.text = @"";
    self.txtProductPrice.text = @"";
}

- (void)checkProductName
{
    if ([self hasProductName])
        return;

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You haven't choice any name yet" delegate:nil cancelButtonTitle:@"Okie" otherButtonTitles:nil];
    [alertView show];
}

- (BOOL)hasChoseCategory
{
    if ([self.pickerCategoryButton.titleLabel.text isEqualToString:@"Choose one"]) {
        return NO;
    }
    return YES;
}

- (BOOL)hasProductName
{
    if (self.txtProductName.text.length) {
        return YES;
    }
    return NO;
}

- (BOOL)hasProductPrice
{
    if (self.txtProductPrice.text.length) {
        return YES;
    }
    return NO;
}

- (void)showAlertViewOnCancel{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Do you want to save this item for later?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (!buttonIndex) {
        [self resetAllForms];
    }
    self.tabBarController.selectedIndex = 0;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.activeTextField = (id)textView;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([self.activeTextField isEqual:textView])
    {
        self.navigationItem.rightBarButtonItem = [self rightNavigationButton];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.activeTextField isEqual:textField])
    {
        self.navigationItem.rightBarButtonItem = [self rightNavigationButton];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField isEqual:self.txtProductPrice]) {
        if (self.txtProductPrice.text.length >= 11 && ![string isEqualToString:@""]) {
            self.txtProductPrice.text = @"99999999999";
            return NO;
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
        return NO;
    }
    // Not found, so remove keyboard.
    [self dismissKeyboard];
    return NO; // We do not want UITextField to insert line-breaks.
}

#pragma mark - Actions

- (IBAction)onBtnShowLocation:(id)sender
{
    PublishLocationPickerViewController *locationVC = [[PublishLocationPickerViewController alloc] initWithSelectedVenueBlock:^(FSVenue *venue) {
        self.selectVenue = venue;
    }];
    [self.navigationController pushViewController:locationVC animated:YES];
}

@end
