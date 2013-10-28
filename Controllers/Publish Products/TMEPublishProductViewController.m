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
TMEPhotoButtonDelegate
>

@property (strong, nonatomic) TMEPhotoButton        * currentPhotoButton;
@property (weak, nonatomic) IBOutlet UITextField    * txtProductName;
@property (weak, nonatomic) IBOutlet UITextField  * txtCategoryName;
@property (weak, nonatomic) IBOutlet UITextField    * txtProductDetails;
@property (weak, nonatomic) IBOutlet UITextField    * txtProductPrice;
@property (weak, nonatomic) IBOutlet TMEPhotoButton    * onePhotoButton;

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
    
    // Expand self.view
    UIView *detailsWrapperView = [self.txtCategoryName superview];
    [(UIScrollView *)self.view setContentSize:CGSizeMake(self.view.frame.size.width,
                                                         CGRectGetMaxY(detailsWrapperView.frame) + 20)];
    
    self.navigationItem.leftBarButtonItem = [self leftNavigationButton];
    self.navigationItem.rightBarButtonItem = [self rightNavigationButton];
  
  //Ask user to take picture
  [self.onePhotoButton takeOrChoosePhoto:YES];
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
  UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
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
    TMEUser *user = [TMEUser MR_createEntity];
    user.name = @"Trieu Khang";
    user.id = @1;
    
    // create dummy category
    TMECategory *category = [TMECategory MR_createEntity];
    category.name = self.txtCategoryName.text;
    category.id = @1;
    
    // create product
    TMEProduct *product = [TMEProduct MR_createEntity];
    product.name = self.txtProductName.text;
    product.id = @1;
    product.details = self.txtProductDetails.text;
    product.price = @([self.txtProductPrice.text doubleValue]);
    product.category = category;
    product.user = user;
    
    // create product images
    NSMutableArray *arrImages = [@[] mutableCopy];
    for (TMEPhotoButton *view in self.view.subviews) {
        if ([view isKindOfClass:[TMEPhotoButton class]] && view.photoName) {
            TMEProductImages *image = [TMEProductImages MR_createEntity];
            image.url = view.photoName;
            [arrImages addObject:image];
        }
    }
    NSSet *setImages = [NSSet setWithArray:arrImages];
    product.images = setImages;
    
    return product;
}

- (void)onCancelButton:(id)sender {
    self.tabBarController.selectedIndex = 0;
}

- (IBAction)onPublishButton:(id)sender {
    
    [self dismissKeyboard];
    
    TMEProduct *product = [self getTheInputProductFromForm];
    
    NSDictionary *params = @{@"user_id": @1,
                             @"name": @"Product 1",
                             @"category_id": @1,
                             @"description": @"Product 1 description",
                             @"price": @1,
                             @"sold_out": @YES};
    
    __block NSNumber *percent = @(0.0f);
    [[BaseNetworkManager sharedInstance] sendMultipartFormRequestForPath:API_PRODUCTS
                                                              parameters:params
                                                                  method:POST_METHOD
                                               constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        for (TMEProductImages *image in [product.images allObjects]) {
            UIImage *img = [PBImageHelper loadImageFromDocuments:image.url];
            NSData *imageData = UIImageJPEGRepresentation(img, 0.5);
            [formData appendPartWithFileData:imageData name:@"images[]" fileName:image.url mimeType:@"image/jpeg"];
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

#pragma marks - Helper methods

- (void)resetAllForms
{
  for (id button in self.view.subviews)
    if ([button isKindOfClass:[TMEPhotoButton class]])
      [button resetAttributes];
  
  self.txtProductName.text = @"";
  self.txtCategoryName.text = @"";
  self.txtProductDetails.text = @"";
  self.txtProductPrice.text = @"";
}

@end
