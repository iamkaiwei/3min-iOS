//
//  TMETutorialViewController.m
//  PhotoButton
//
//  Created by Hoang Ta on 9/28/13.
//
//

#import "AppDelegate.h"
#import "TMETutorialViewController.h"

#define NUMBER_OF_TUTORIAL_PAGES  3
#define PAGE_CONTROL_HEIGHT       44

NSString *const TUTORIAL_HAS_BEEN_PRESENTED = @"tutorial_has_been_presented";

@interface TMETutorialViewController ()

@property (strong, nonatomic) iCarousel *iCarousel;
@property (strong, nonatomic) UIButton *doneButton;
@property (strong, nonatomic) UIButton *skipButton;
@property (strong, nonatomic) UIPageControl *tutorialPageControl;

@end

@implementation TMETutorialViewController

+ (id)hasBeenPresented
{
  return [[NSUserDefaults standardUserDefaults] objectForKey:TUTORIAL_HAS_BEEN_PRESENTED];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    _tutorialPageControl.numberOfPages = NUMBER_OF_TUTORIAL_PAGES;
    _tutorialPageControl.enabled = NO;
  }
  return _tutorialPageControl;
}

- (void)closeTutorial
{
  [[AppDelegate sharedDelegate] showHomeViewController];
  [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:TUTORIAL_HAS_BEEN_PRESENTED];
    [[AppDelegate sharedDelegate] showLoginView];
}

#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
  return NUMBER_OF_TUTORIAL_PAGES;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
  UIView *carouselView = [[UIView alloc] initWithFrame:self.view.bounds];
  carouselView.backgroundColor = [UIColor colorWithRed:getrandom(0, 255)/255.0 green:getrandom(0, 255)/255.0 blue:getrandom(0, 255)/255.0 alpha:1];
  
  //Add Start Button if this is the last page.
  if (index == NUMBER_OF_TUTORIAL_PAGES - 1) {
    [carouselView addSubview:self.doneButton];
  }
  return carouselView;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
  [self.skipButton removeFromSuperview];
  self.tutorialPageControl.currentPage = carousel.currentItemIndex;
}
@end
