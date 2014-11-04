//
//  TMEContainBrowserProductViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 4/11/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEContainBrowserProductViewController.h"
#import "TMEBrowserPageContentViewController.h"
#import "TMETakePhotoButtonViewController.h"

@interface TMEContainBrowserProductViewController ()

@property (strong, nonatomic) TMEBrowserPageContentViewController *childVC;
@property (strong, nonatomic) TMETakePhotoButtonViewController *takePhotoVC;

@property (strong, nonatomic) LBDelegateMatrioska *chainDelegate;

@end

@implementation TMEContainBrowserProductViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self _addBrowserProductContentVC];
	[self _addTakePhotoButton];
}

- (TMEBrowserPageContentViewController *)childVC {
	if (!_childVC) {
		_childVC = [[UIStoryboard storyboardWithName:@"TMEBrowserPageContentViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"TMEBrowserPageContentViewController"];
	}

	return _childVC;
}

- (TMETakePhotoButtonViewController *)takePhotoVC {
    if (!_takePhotoVC) {
        _takePhotoVC = [[TMETakePhotoButtonViewController alloc] init];
    }

    return _takePhotoVC;
}

- (void)_addBrowserProductContentVC {
	[self.childVC willMoveToParentViewController:self];
	[self addChildViewController:self.childVC];
	[self.view addSubview:self.childVC.view];
	[self.childVC didMoveToParentViewController:self];
	[self.view layoutIfNeeded];

    [self _hideAndShowTakePhotoButtonViewControllerWhenScrolling];
}

- (void)_hideAndShowTakePhotoButtonViewControllerWhenScrolling {
	self.chainDelegate = [[LBDelegateMatrioska alloc] initWithDelegates:@[self.childVC.collectionView.delegate, self.takePhotoVC]];
	self.childVC.collectionView.delegate = (id) self.chainDelegate;
}

- (void)_addTakePhotoButton {
	[self.takePhotoVC willMoveToParentViewController:self];
	[self.view addSubview:self.takePhotoVC.view];
	[self.takePhotoVC.view mas_makeConstraints: ^(MASConstraintMaker *make) {
	    make.bottom.equalTo(self.view);
	    make.trailing.equalTo(self.view);
	    make.leading.equalTo(self.view);
	    make.height.equalTo(@70);
	}];

	[self.takePhotoVC didMoveToParentViewController:self];
	[self.view setNeedsUpdateConstraints];
	[self.view layoutIfNeeded];
}

@end
