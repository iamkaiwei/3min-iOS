//
//  TMEDropDownMenuViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 28/8/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEDropDownMenuViewController.h"
#import "TMEDropDownViewModel.h"

@interface TMEDropDownMenuViewController ()

@property (strong, nonatomic) FBKVOController *kvoController;
@property (strong, nonatomic) TMEDropDownViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintCollectionViewHeight;

@end

@implementation TMEDropDownMenuViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

	[self.viewModel.datasource setCellAndFooterClasses:self.collectionView];

	self.collectionView.hidden = YES;

	self.kvoController = [[FBKVOController alloc] initWithObserver:self];
	[self.kvoController observe:self.viewModel keyPath:@"arrCategories" options:NSKeyValueObservingOptionNew block: ^(id observer, id object, NSDictionary *change) {
	    typeof(self) innerSelf = observer;
	    [innerSelf.collectionView reloadData];
	    innerSelf.constraintCollectionViewHeight.constant = [innerSelf.viewModel.datasource totalCellHeight];
	    [innerSelf.collectionView setNeedsLayout];
	    [innerSelf.collectionView layoutIfNeeded];
	    innerSelf.collectionView.hidden = NO;
	}];

	[self.viewModel getCategories:nil];
}

- (TMEDropDownViewModel *)viewModel {
	if (!_viewModel) {
		_viewModel = [[TMEDropDownViewModel alloc] initWithCollectionView:self.collectionView];
	}

	return _viewModel;
}

@end
