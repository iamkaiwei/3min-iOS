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
AFPhotoEditorControllerDelegate
>

@property (strong, nonatomic) TMEPhotoButton     * currentPhotoButton;

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

#pragma mark - AFPhotoController delegate
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

@end
