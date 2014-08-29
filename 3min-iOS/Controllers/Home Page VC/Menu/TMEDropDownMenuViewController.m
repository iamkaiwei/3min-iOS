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
@property (nonatomic, strong, readwrite) TMECategory *selectedCategory;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintCollectionViewHeight;

@end

@implementation TMEDropDownMenuViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithHexString:@"#000" alpha:0.4];
    self.collectionView.delegate = self;
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

	    UITapGestureRecognizer *tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self.delegate action:@selector(tongleMenu:)];
	    tapToDismiss.numberOfTouchesRequired = 1;
        tapToDismiss.delegate = self;
	    [self.view addGestureRecognizer:tapToDismiss];
	});

	[self.viewModel getCategories:nil];
}


/**
 *  Weird, i added gesture for the parent view but the child view also response for it
 */

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch view] == self.view){
        return YES;
    }
    return NO;
}

#pragma mark - 

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TMECategory *category = (TMECategory *)[self.viewModel itemAtIndexPath:indexPath];
    [[NSNotificationCenter defaultCenter] postNotificationName:TMEHomeCategoryDidChangedNotification object:self];
    self.selectedCategory = category;
    [self.delegate tongleMenu:nil];
}

@end
