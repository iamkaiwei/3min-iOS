//
//  TMETakePhotoButtonViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 30/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMETakePhotoButtonViewController.h"
#import "TMEEditProductVC.h"

@interface TMETakePhotoButtonViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTakePhotoButtonTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UIButton *btnTakePhoto;

@property (assign, nonatomic, getter = isVisible) BOOL visible;

@end

@implementation TMETakePhotoButtonViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
    self.visible = YES;
}

- (IBAction)onTapTakePhoto:(id)sender {
    TMEEditProductVC *editProductVC = [TMEEditProductVC tme_instantiateFromStoryboardNamed:@"EditProduct"];
    [self.navigationController pushViewController:editProductVC animated:YES];
}

- (void)toggleButton {
    [self animationButton:!self.visible];
}

- (void)animationButton:(BOOL)show {
	if (!show) {
		self.constraintTakePhotoButtonTop.constant = 70;
	}
	else {
		self.constraintTakePhotoButtonTop.constant = -2;
	}

    self.visible = show;

	[self.btnTakePhoto setNeedsUpdateConstraints];
	[UIView animateWithDuration:0.3 animations: ^{
	    [self.btnTakePhoto layoutIfNeeded];
	}];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

    CGFloat velocityPoint = 0.8;

    if(velocity.y > velocityPoint) {
        [self animationButton:YES];
    }

    if (velocity.y < -velocityPoint) {
        [self animationButton:NO];
    }
}

@end
