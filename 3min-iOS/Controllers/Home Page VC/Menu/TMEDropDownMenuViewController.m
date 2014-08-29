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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
	}

	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.collectionView.hidden = YES;

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    self.kvoController = [[FBKVOController alloc] initWithObserver:self];
	    self.viewModel = [[TMEDropDownViewModel alloc] initWithCollectionView:self.collectionView];
	    [self.viewModel.datasource setCellAndFooterClasses:self.collectionView];
	    [self.kvoController observe:self.viewModel keyPath:@"arrCategories" options:NSKeyValueObservingOptionNew block: ^(id observer, id object, NSDictionary *change) {
	        typeof(self) innerSelf = observer;
	        innerSelf.collectionView.dataSource = self.viewModel.datasource;
	        [innerSelf.collectionView reloadData];
	        innerSelf.constraintCollectionViewHeight.constant = [innerSelf.viewModel.datasource totalCellHeight];
	        [innerSelf.collectionView setNeedsLayout];
	        [innerSelf.collectionView layoutIfNeeded];
	        innerSelf.collectionView.hidden = NO;
		}];
	});
	[self.viewModel getCategories:nil];
}

@end
