//
//  TMEListActiviesViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 24/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEListActiviesViewController.h"
#import "TMEActivitiesCollectionViewCell.h"

static const CGFloat kPaddingBottom = 10.0f;

@interface TMEListActiviesViewController ()
<
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource
>

@property (strong, nonatomic) RZCellSizeManager *sizeManager;
@property (strong, nonatomic) NSArray *arrActivies;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionActivities;

@end

@implementation TMEListActiviesViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

	self.sizeManager = [[RZCellSizeManager alloc] init];

	[self.collectionActivities registerNib:[TMEActivitiesCollectionViewCell defaultNib] forCellWithReuseIdentifier:[TMEActivitiesCollectionViewCell kind]];

	[self.sizeManager registerCellClassName:[TMEActivitiesCollectionViewCell kind]
	                           withNibNamed:[TMEActivitiesCollectionViewCell kind]
	                         forObjectClass:[TMEActivity class]
	                        withHeightBlock: ^CGFloat (TMEActivitiesCollectionViewCell *cell, TMEActivity *ac) {
	    CGFloat height = [cell heightForActivity:ac];
	    return height;
	}];

	[[TMEActivityManager sharedManager] getActivitiesWithSuccess: ^(NSArray *models) {
	    self.arrActivies = models;
	    [self.collectionActivities reloadData];
	} failure: ^(NSError *error) {
	}];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	// Retrieve our object to give to our size manager.
	id object = [self.arrActivies objectAtIndex:indexPath.row];
	CGFloat height = [self.sizeManager cellHeightForObject:object indexPath:indexPath cellReuseIdentifier:[TMEActivitiesCollectionViewCell kind]];
	return CGSizeMake(self.view.width, height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.arrActivies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	TMEActivitiesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TMEActivitiesCollectionViewCell kind] forIndexPath:indexPath];
	[cell configWithData:self.arrActivies[indexPath.item]];
	return cell;
}

@end
