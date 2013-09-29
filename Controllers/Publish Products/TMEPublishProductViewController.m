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

@property (assign, nonatomic) BOOL                  isEditing;
@property (strong, nonatomic) TMEPhotoButton     * currentPhotoButton;
@property (weak, nonatomic) IBOutlet UITextField *txtProductName;
@property (strong, nonatomic) IBOutlet UITextField *txtCategoryName;
@property (weak, nonatomic) IBOutlet UITextField *txtProductDetails;
@property (weak, nonatomic) IBOutlet UITextField *txtProductPrice;


@end

@implementation TMEPublishProductViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title = @"Publish Product";
    self.isEditing = YES;
    
    for (TMEPhotoButton *button in self.view.subviews) {
        if ([button isKindOfClass:[TMEPhotoButton class]]) {
            [button addTarget:self action:@selector(photoSaved:) forControlEvents:UIControlEventValueChanged];            
            button.viewController = self;
            button.photoSize = CGSizeMake(1000, 1000);
        }
    }
}

#pragma mark - Rotation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    }else{
        return YES;
    }
}

- (BOOL) shouldAutorotate
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

# pragma mark - selectors
- (IBAction)photoSaved:(id)sender {
    TMEPhotoButton *btnPhoto = (TMEPhotoButton *)sender;
    self.currentPhotoButton = btnPhoto;
    UIImage *image = [PBImageHelper loadImageFromDocuments:btnPhoto.photoName];
    [self displayEditorForImage:image];
}

# pragma mark - AFPhotoController delegate
- (void)displayEditorForImage:(UIImage *)imageToEdit
{
    TMEBasePhotoEditorViewController *editorController = [[TMEBasePhotoEditorViewController alloc] initWithImage:imageToEdit];
    [editorController setDelegate:self];
    [self.navigationController pushViewController:editorController animated:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)photoEditor:(TMEBasePhotoEditorViewController *)editor finishedWithImage:(UIImage *)image
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
    [self.currentPhotoButton setBackgroundImage:image forState:UIControlStateNormal];
    self.currentPhotoButton = nil;
}

#pragma marks - TMEPhotoButton delegate
- (void)beforeGetImageWithPhotoButton:(TMEPhotoButton *)photoButton
{
    photoButton.photoName = [@([[NSDate date] timeIntervalSince1970]) stringValue];
}

- (void)didFinishGetImageWithImageUrl:(NSString *)localURL
{
    
}

# pragma marks - Actions
- (IBAction)onPublishButton:(id)sender {
    
    [self dismissKeyboard];
    
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
    
    NSManagedObjectContext *mainContext  = [NSManagedObjectContext MR_defaultContext];
    [mainContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        DLog(@"Finish save to magical record");
    }];
    
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
        for (TMEProductImages *image in [setImages allObjects]) {
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

- (void)showProgressWithPercent:(NSNumber *)percent
{
    float percentage = [percent floatValue];
    percentage *= 100;
	
	while (percentage <= 200.0)
	{
		[self.navigationController setSGProgressPercentage:percentage];
		if(percentage >= 100.0)
		{
            [self.navigationController finishSGProgress];
			return;
		}
	}
}

- (TMEPhotoButton *)getFirstPhotoButton
{
    for (TMEPhotoButton *button in self.view.subviews) {
        if ([button isKindOfClass:[TMEPhotoButton class]]) {
            return button;
        }
    }
    
    return nil;
}

- (BOOL)getStatusEditing
{
    return self.isEditing;
}

- (void)resetAllForms
{
    self.isEditing = NO;
    
    for (TMEPhotoButton *button in self.view.subviews) {
        if ([button isKindOfClass:[TMEPhotoButton class]]) {
            [button addTarget:self action:@selector(photoSaved:) forControlEvents:UIControlEventValueChanged];
            button.viewController = self;
            button.photoSize = CGSizeMake(1000, 1000);
            button.photoName = nil;
            button.imageView.image = nil;
        }
    }
    
    self.txtProductName.text = @"";
    self.txtCategoryName.text = @"";
    self.txtProductDetails.text = @"";
    self.txtProductPrice.text = @"";
}

@end
