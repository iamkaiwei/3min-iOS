//
//  TMEPublishProductViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 12/9/13.
//
//

#import "TMEPublishProductViewController.h"
#import "TMEBrowserProductsViewController.h"
#import "PBImageHelper.h"

@interface TMEPublishProductViewController ()
<
AFPhotoEditorControllerDelegate,
UITextFieldDelegate,
TMEPhotoButtonDelegate,
UIPickerViewDataSource,
UIPickerViewDelegate
>

@property (strong, nonatomic) TMEPhotoButton        * currentPhotoButton;
@property (weak, nonatomic) IBOutlet UITextField    * txtProductName;
@property (weak, nonatomic) IBOutlet UITextField    * txtProductPrice;
@property (strong, nonatomic) NSArray               * arrayCategories;
@property (weak, nonatomic) IBOutlet UIPickerView   * pickerCategories;
@property (weak, nonatomic) IBOutlet UIView         * viewPickerWrapper;
@property (weak, nonatomic) IBOutlet UIButton       * pickerCategoryButton;
@property (weak, nonatomic) IBOutlet UIScrollView   * scrollViewContainner;

@property (strong, nonatomic) IBOutletCollection(TMEPhotoButton) NSArray * photoButtons;

@end

@implementation TMEPublishProductViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.title = @"";
  //    self.navigationController.navigationBar.topItem.title = @"Publish Product";
  
  for (TMEPhotoButton *button in self.view.subviews) {
    if ([button isKindOfClass:[TMEPhotoButton class]]) {
      [button addTarget:self action:@selector(photoSaved:) forControlEvents:UIControlEventValueChanged];
      button.viewController = self;
      button.photoSize = CGSizeMake(1000, 1000);
    }
  }
  self.navigationItem.leftBarButtonItem = [self leftNavigationButton];
  self.navigationItem.rightBarButtonItem = [self rightNavigationButton];
  
  //Ask user to take picture
  [self.photoButtons[0] takeOrChoosePhoto:YES];
  
  [[TMECategoryManager sharedInstance] getAllCategoriesOnSuccessBlock:^(NSArray *arrayCategories) {
    self.arrayCategories = arrayCategories;
    [self.pickerCategories reloadAllComponents];
  } andFailureBlock:^(NSInteger statusCode, id obj) {
    [SVProgressHUD showErrorWithStatus:@"Failure to load categories"];
  }];
  
  [self autoAdjustScrollViewContentSize];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [self hideTheKeyboard];
}

- (BOOL)hidesBottomBarWhenPushed
{
  return YES;
}

- (UIBarButtonItem *)leftNavigationButton
{
  UIImage *leftButtonBackgroundNormalImage = [UIImage oneTimeImageWithImageName:@"publish_cancel_btn" isIcon:YES];
  UIImage *leftButtonBackgroundSelectedImage = [UIImage oneTimeImageWithImageName:@"publish_cancel_btn_pressed" isIcon:YES];
  UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 75, 40)];
  [leftButton addTarget:self action:@selector(onCancelButton:) forControlEvents:UIControlEventTouchUpInside];
  [leftButton setBackgroundImage:leftButtonBackgroundNormalImage forState:UIControlStateNormal];
  [leftButton setBackgroundImage:leftButtonBackgroundSelectedImage forState:UIControlStateHighlighted];
  
  return [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (UIBarButtonItem *)rightNavigationButton
{
  UIImage *rightButtonBackgroundNormalImage = [UIImage oneTimeImageWithImageName:@"publish_done_btn" isIcon:YES];
  UIImage *rightButtonBackgroundSelectedImage = [UIImage oneTimeImageWithImageName:@"publish_done_btn_pressed" isIcon:YES];
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

- (IBAction)onPublishButton:(id)sender {

  [self dismissKeyboard];

  if (![self validateInputs])
    return;

  TMEProduct *product = [self getTheInputProductFromForm];
  
  NSDictionary *params = @{@"user_id": product.user.id,
                           @"name": product.name,
                           @"category_id": product.category.id,
                           @"price": product.price,
                           @"sold_out": @NO};
  
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
     
     // reset the forms
     [self resetAllForms];
     
     [SVProgressHUD showSuccessWithStatus:@"Upload successfully."];
     [self.navigationController finishSGProgress];
     
     // move to browser tab if they are another tab
     if(![self.tabBarController.selectedViewController isKindOfClass:[TMEBrowserProductsViewController class]])
       [self.tabBarController setSelectedIndex:0];
     
   } failure:^(NSError *error) {
     
     [SVProgressHUD showErrorWithStatus:@"Fail to upload, try again later"];
     [self.navigationController finishSGProgress];
     
   } progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
     
     // save last 30% for response
     percent = @(((float)totalBytesWritten)/totalBytesExpectedToWrite * 0.7);
     float percentage = [percent floatValue];
     percentage *= 100;
     [self.navigationController setSGProgressPercentage:percentage];
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
  [self hideTheKeyboard];
  
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

#pragma marks - Helper methods

- (void)hideTheKeyboard{
  [self.txtProductName endEditing:YES];
  [self.txtProductPrice endEditing:YES];
}

- (void)resetAllForms
{
  for (id button in self.view.subviews)
    if ([button isKindOfClass:[TMEPhotoButton class]])
      [button resetAttributes];
  
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

@end
