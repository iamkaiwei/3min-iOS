//
//  TMECameraVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/19/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMECameraVC.h"

#import "IMGLYCameraBottomBarView.h"
#import "IMGLYCameraController.h"
#import "IMGLYDefaultCameraImageProvider.h"
#import "IMGLYDefines.h"
#import "IMGLYDeviceDetector.h"
#import "IMGLYFilterSelectorView.h"
#import "IMGLYImageProviderChecker.h"
#import "IMGLYShutterView.h"
#import "IMGLYDeviceDetector.h"
#import "IMGLYOrientationOperation.h"
#import "UIImage+IMGLYKitAdditions.h"

#import "UIBarButtonItem+Custom.h"
#import "TMEFilterSelectorVC.h"

static const CGFloat kIMGLYPreviewImageSize = 62.0f;
extern const CGFloat kIMGLYPreviewImageDistance;
extern const CGFloat kIMGLYExtraSpaceForScrollBar;

@interface TMECameraVC () <UIGestureRecognizerDelegate,
IMGLYCameraBottomBarCommandDelegate,
IMGLYFilterSelectorViewDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
TMEFilterSelectorVCDelegate>

@property (nonatomic, strong) IMGLYCameraBottomBarView *cameraBottomBarView;
@property (nonatomic, strong) IMGLYCameraController *cameraController;
@property (nonatomic, strong) IMGLYFilterSelectorView *filterSelectorView;
@property (nonatomic, strong) IMGLYShutterView *shutterView;

@property (nonatomic, strong) id<IMGLYCameraImageProvider> imageProvider;
@property (nonatomic, strong) NSArray *availableFilterList;
@property (weak, nonatomic) IBOutlet UIView *bottomContainerView;
@property (weak, nonatomic) IBOutlet UIView *filterContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterContainerViewBottomConstraint;

@property (nonatomic, strong) TMEFilterSelectorVC *filterSelectorVC;

@end

#pragma mark -

@implementation TMECameraVC

#pragma mark - init

- (instancetype)initWithCameraImageProvider:(id<IMGLYCameraImageProvider>)imageProvider {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    _imageProvider = imageProvider;
    return self;
}


- (instancetype)initWithCameraImageProvider:(id<IMGLYCameraImageProvider>)imageProvider availableFilterList:(NSArray *)list {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    _availableFilterList = list;
    _imageProvider = imageProvider;
    return self;
}


- (instancetype)initWithAvailableFilterList:(NSArray *)list {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    _availableFilterList = list;
    return self;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

    [self setupNavigationItems];

    if (self.imageProvider == nil) {
        self.imageProvider = [[IMGLYDefaultCameraImageProvider alloc] init];
    }
    else {
        [[IMGLYImageProviderChecker sharedInstance] checkCameraImageProvider:self.imageProvider];
    }

    [self configureCameraController];
    [self configureGestureRecognizers];

    //[self configureCameraBottomBarView];
    //[self configureFilterSelectorView];
    [self setupFilterSelectorVC];

    [self configureShutterView];
}

- (void)viewDidAppear:(BOOL)animated  {
    [super viewDidAppear:animated];
    [self.cameraController startCameraCapture];
    [[self shutterView] openShutter];
}

#pragma mark - Setup
- (void)setupNavigationItems
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem cancelItemWithTarget:self action:@selector(cancelTouched:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage originalImageNamed:@"icn_rotate_camera"] style:UIBarButtonItemStylePlain target:self action:@selector(switchFrontBackCameraTouched:)];
}

- (void)setupFilterSelectorVC
{
    self.filterContainerViewBottomConstraint.constant = -200;
    
    self.filterSelectorVC = [TMEFilterSelectorVC tme_instantiateFromStoryboardNamed:@"FilterSelector"];
    [self addChildVC:self.filterSelectorVC containerView:self.filterContainerView];
}

#pragma mark - Action
- (void)cancelTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)switchFrontBackCameraTouched:(id)sender
{
    [self.cameraController removeCameraObservers];
    [self.cameraController removeNotifications];

    [UIView animateWithDuration:0.2 animations:^{
        [self.cameraController setPreviewAlpha:0.0];
    } completion:^(BOOL finished) {
        [self.cameraController flipCamera];
        [self.cameraController hideIndicator];

        [UIView animateWithDuration:0.2 animations:^{
            [self.cameraController setPreviewAlpha:1.0];
        }];
    }];
}

- (IBAction)takePhotoTouched:(id)sender {
    [self takePhoto];
}

- (IBAction)albumTouched:(id)sender {
    [self openImageFromCameraAndProcessIt];
}

- (IBAction)filterTouched:(id)sender {
    [self showFilterView];
}

- (IBAction)filterViewDownTouched:(id)sender {
    [self hideFilterView];
}

#pragma mark - GUI configuration
- (void)configureFilterSelectorView {
    self.filterSelectorView = [[IMGLYFilterSelectorView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 85)
                                                            previewImageSize:kIMGLYPreviewImageSize
                                                         cameraImageProvider:_imageProvider
                                                         availableFilterList:_availableFilterList];
    self.filterSelectorView.delegate = self;
    [self.filterSelectorView generateStaticPreviewsForImage:_imageProvider.filterPreviewImage];

    // TODO:
    [self.filterContainerView addSubview:self.filterSelectorView];
    [self.filterSelectorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.filterContainerView);
    }];
}

- (void)configureCameraBottomBarView {
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat bottomBarY = CGRectGetHeight(screenBounds);
    self.cameraBottomBarView = [[IMGLYCameraBottomBarView alloc] initWithYPosition:bottomBarY imageProvider:self.imageProvider];
    [self.view addSubview:self.cameraBottomBarView];
    self.cameraBottomBarView.delegate = self;
}

- (void)configureCameraController {
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    self.cameraController = [[IMGLYCameraController alloc] initWithRect:screenBounds];
    [self.view insertSubview:self.cameraController.view atIndex:0];
}

// Add a single tap gesture to focus on the point tapped, then lock focus
- (void)configureGestureRecognizers {
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(tapToAutoFocus:)];
    singleTapGestureRecognizer.delegate = self;
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    [self.cameraController addGestureRecogizerToStreamPreview:singleTapGestureRecognizer];

    // Add a double tap gesture to reset the focus mode to continuous auto focus
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(tapToContinuouslyAutoFocus:)];
    doubleTapGestureRecognizer.delegate = self;
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
    [self.cameraController addGestureRecogizerToStreamPreview:doubleTapGestureRecognizer];
}

- (void)configureShutterView {
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGRect layerRect = mainScreen.bounds;
    _shutterView = [[IMGLYShutterView alloc] initWithFrame:layerRect];

    [self.view addSubview:_shutterView];
}

#pragma mark - Filter View
- (void)showFilterView
{
    [self toggleFilterViewVisibility:YES];
}

- (void)hideFilterView
{
    [self toggleFilterViewVisibility:NO];
}

- (void)toggleFilterViewVisibility:(BOOL)visible
{
    [UIView animateWithDuration:0.25 animations:^{
        self.filterContainerViewBottomConstraint.constant = visible ? 0 : -200;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {

    }];
}

#pragma mark - TMEFilterSelectorVCDelegate
- (void)filterSelectorVCDidSelectFilter
{

}

#pragma mark - notification handling
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {

}


#pragma mark - focus handling
- (void)tapToAutoFocus:(UIGestureRecognizer *)gestureRecognizer {
    [self.cameraController onSingleTapFromGestureRecognizer:gestureRecognizer
                                    forInterfaceOrientation:self.interfaceOrientation];
}

- (void)tapToContinuouslyAutoFocus:(UIGestureRecognizer *)gestureRecognizer {
    [self.cameraController onDoubleTapFromGestureRecognizer:gestureRecognizer
                                    forInterfaceOrientation:self.interfaceOrientation];
}

#pragma mark - button tap handling
- (UIImage *)cropImage:(UIImage *)image  width:(CGFloat)width height:(CGFloat)height {
    CGRect bounds = CGRectMake(0,
                               0,
                               width,
                               height);

    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}


- (void)takePhoto {
    [self preparePhotoTaking];
    [self.cameraController pauseCameraCapture];

    __weak TMECameraVC *weakSelf = self;
    [self.cameraController takePhotoWithCompletionHandler:^(UIImage *processedImage, NSError *error) {
        TMECameraVC *strongSelf = weakSelf;
        if (error) {
            DLog(@"%@", error.description);
        }
        else {

            if (processedImage.size.width == 720 && processedImage.size.height == 1280) { // to support the
                processedImage = [strongSelf cropImage:processedImage width:900 height:900];
                [processedImage imgly_rotateImageToMatchOrientation];
                IMGLYOrientationOperation *operation = [[IMGLYOrientationOperation alloc] init ];
                [operation rotateRight];
                processedImage = [operation processImage:processedImage];
            }
            else if (processedImage.size.width == 1280 && processedImage.size.height == 720) { // to support the
                processedImage = [strongSelf cropImage:processedImage width:900 height:900];
            }

            [strongSelf finishPhotoTakingWithImage:processedImage];
        }
    }];
}

- (void)preparePhotoTaking {
    [self.cameraBottomBarView disableAllButtons];
    [self.shutterView closeShutter];

    NSInteger timeUntilOpen = 300;

    if (![IMGLYDeviceDetector isRunningOn4Inch] && ![IMGLYDeviceDetector isRunningOn4S]) {
        timeUntilOpen = 500;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, timeUntilOpen * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        [self.shutterView openShutter];
    });
}

- (void)finishPhotoTakingWithImage:(UIImage *)image {
    [self shutdownCamera];
    [self.cameraBottomBarView enableAllButtons];

    if (![IMGLYDeviceDetector isRunningOn4Inch] && ![IMGLYDeviceDetector isRunningOn4S])
        [SVProgressHUD dismiss];

    [self completeWithResult:TMECameraVCResultDone
                       image:image
                  filterType:self.cameraController.filterType];
}


- (void)completeWithResult:(TMECameraVCResult)result
                     image:(UIImage *)image
                filterType:(IMGLYFilterType)filterType {

    if (self.completionHandler)
        self.completionHandler(result, image, filterType);
}

- (void)filterSelectorView:(IMGLYFilterSelectorView *)filterSelectorView
       didSelectFilterType:(IMGLYFilterType)filterType {
    [self.cameraController selectFilterType:filterType];
}

#pragma mark - image picker handling
- (void)openImageFromCameraAndProcessIt {
    UIImagePickerController *pickerLibrary = [[UIImagePickerController alloc] init];
    pickerLibrary.delegate = self;
    [self.cameraController stopCameraCapture];
    [self presentViewController:pickerLibrary animated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.cameraController startCameraCapture];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {

    [self dismissViewControllerAnimated:NO completion:NULL];
    [self finishPhotoTakingWithImage:image];
}

#pragma mark - layout
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self layoutShutterView];
}

- (void)layoutShutterView {
    [self.shutterView setFrame:self.view.frame];
}


#pragma mark - accept / camera mode switching

-(void)shutdownCamera {
    [self.cameraController stopCameraCapture];
    [self.cameraController hideStreamPreview];
    [self.cameraController removeCameraObservers];
    [self.cameraController removeNotifications];
}

-(void)restartCamera {
    [self.cameraController resumeCameraCapture];
    [self.cameraController showStreamPreview];
    [self.cameraController addCameraObservers];
    [self.cameraController addNotifications];
    [self.filterSelectorView setPreviewImagesToDefault];
    sleep(1); // avoid waitin fence error on ios 5
    [self.cameraController startCameraCapture];

    // we need to delay this due synconisation issues with OpenGL

    __weak TMECameraVC *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 100 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        [weakSelf.cameraController selectFilterType:IMGLYFilterTypeNone];
    });
}



@end
