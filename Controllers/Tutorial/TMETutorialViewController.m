//
//  TMETutorialViewController.m
//  PhotoButton
//
//  Created by Hoang Ta on 9/28/13.
//
//

#import "AppDelegate.h"
#import "TMETutorialViewController.h"

#define PAGE_CONTROL_HEIGHT       44

NSString *const TUTORIAL_HAS_BEEN_PRESENTED = @"tutorial_has_been_presented";

@interface TMETutorialViewController ()

@property (strong, nonatomic) iCarousel *iCarousel;
@property (strong, nonatomic) UIButton *doneButton;
@property (strong, nonatomic) UIButton *skipButton;
@property (strong, nonatomic) UIPageControl *tutorialPageControl;

@property (strong, nonatomic) NSArray       * arrayIntroductionImages;

@end

@implementation TMETutorialViewController

+ (id)hasBeenPresented
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:TUTORIAL_HAS_BEEN_PRESENTED];
}

- (NSArray *)arrayIntroductionImages{
    if (!_arrayIntroductionImages) {
        _arrayIntroductionImages = @[@"Login1", @"Login2", @"Login3"];
    }
    
    return _arrayIntroductionImages;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.iCarousel];
    [self.view addSubview:self.tutorialPageControl];
    [self.view addSubview:self.skipButton];
}

- (iCarousel *)iCarousel
{
    if (!_iCarousel) {
        _iCarousel = [[iCarousel alloc] initWithFrame:self.view.bounds];
        _iCarousel.type = iCarouselTypeLinear;
        _iCarousel.dataSource = self;
        _iCarousel.delegate = self;
        _iCarousel.bounceDistance = 0.2f;
        _iCarousel.decelerationRate = 0.5f;
    }
    return  _iCarousel;
}

- (UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneButton.frame = CGRectMake(90, self.view.height - 64, self.view.bounds.size.width - 180, 44);
        _doneButton.backgroundColor = [UIColor grayColor];
        [_doneButton setTitle:@"Start!" forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(closeTutorial) forControlEvents:UIControlEventTouchDown];
    }
    return _doneButton;
}

- (UIButton *)skipButton
{
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.frame = CGRectMake(55, self.view.height - 84, self.view.bounds.size.width - 110, 44);
        _skipButton.backgroundColor = [UIColor grayColor];
        [_skipButton setTitle:@"I'm genius, just skip this!" forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(closeTutorial) forControlEvents:UIControlEventTouchDown];
    }
    return _skipButton;
}

- (UIPageControl *)tutorialPageControl
{
    if (!_tutorialPageControl) {
        CGRect frame = self.view.bounds;
        frame.origin.y = self.view.height - PAGE_CONTROL_HEIGHT;
        frame.size.height = PAGE_CONTROL_HEIGHT;
        _tutorialPageControl = [[UIPageControl alloc] initWithFrame:frame];
        _tutorialPageControl.currentPage = 0;
        _tutorialPageControl.numberOfPages = self.arrayIntroductionImages.count;
        _tutorialPageControl.enabled = NO;
    }
    return _tutorialPageControl;
}

- (void)closeTutorial
{
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:TUTORIAL_HAS_BEEN_PRESENTED];
    [[AppDelegate sharedDelegate] showLoginView];
}

#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.arrayIntroductionImages.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    NSString *imageName = [self correctedImagesPathWithImageName:[self.arrayIntroductionImages objectAtIndex:index]];
    NSString *thePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:thePath];
    UIImageView *carouselView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    carouselView.image = image;
    
    return carouselView;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    [self.skipButton removeFromSuperview];
    self.tutorialPageControl.currentPage = carousel.currentItemIndex;
}

#pragma mark - Helpers

- (NSString *)correctedImagesPathWithImageName:(NSString *)imageName
{
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f) {
        return [NSString stringWithFormat:@"%@-568h", imageName];
    } else if([UIScreen mainScreen].scale == 2.f) {
        return [NSString stringWithFormat:@"%@@2x", imageName];
    }
    
    return [NSString stringWithFormat:@"%@", imageName];
}

@end
