//
//  TMEPublishProductViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 12/9/13.
//
//

#import "TMEPublishProductViewController.h"
#import "PBImageHelper.h"

@interface TMEPublishProductViewController ()
<
AFPhotoEditorControllerDelegate,
UITextFieldDelegate
>

@property (strong, nonatomic) TMEPhotoButton     * currentPhotoButton;
@property (weak, nonatomic) IBOutlet UITextField *txtProductName;


@end

@implementation TMEPublishProductViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Publish Product";
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

# pragma marks - Actions
- (IBAction)onPublishButton:(id)sender {
    
    // create dummy user
    TMEUser *user = [TMEUser MR_createEntity];
    user.name = @"Trieu Khang";
    user.userID = @1;
    
    // create dummy category
    TMECategory *category = [TMECategory MR_createEntity];
    category.name = @"Dummy category";
    category.categoryID = @1;
    
    // create product
    TMEProduct *product = [TMEProduct MR_createEntity];
    product.name = @"";
    product.productID = @1;
    product.details = @"";
    product.category = category;
    product.user = user;
    
    // create product images
    NSMutableArray *arrImages = [@[] mutableCopy];
    for (TMEPhotoButton *view in self.view.subviews) {
        if ([view isKindOfClass:[TMEPhotoButton class]] && view.photoName) {
            [arrImages addObject:view.photoName];
        }
    }
    
    NSSet *setImages = [NSSet setWithArray:arrImages];
    product.images = setImages;
    
    NSManagedObjectContext *mainContext  = [NSManagedObjectContext MR_defaultContext];
    [mainContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        DLog(@"Finish save to magical record");
    }];
    
    NSArray *arrProduct = [TMEProduct MR_findAll];
}


@end
