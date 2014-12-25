//
//  TMEListActiviesViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 24/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEListActiviesViewController.h"
#import "TMEActivitiesCollectionViewCell.h"
#import "TMEListActivitiesViewModel.h"
#import "TMESimpleCollectionDatasource.h"

static const CGFloat kPaddingBottom = 10.0f;

@interface TMEListActiviesViewController ()
<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource
>

@property (strong, nonatomic) RZCellSizeManager *sizeManager;
@property (strong, nonatomic) TMEListActivitiesViewModel *viewModel;
@property (strong, nonatomic) NSArray *arrActivies;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionActivities;
@property (strong, nonatomic) TMESimpleCollectionDatasource *datasource;

@end

@implementation TMEListActiviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.sizeManager = [[RZCellSizeManager alloc] init];
    
    [self.collectionActivities registerNib:[TMEActivitiesCollectionViewCell defaultNib]
                forCellWithReuseIdentifier:[TMEActivitiesCollectionViewCell kind]];
    
    [self.sizeManager registerCellClassName:[TMEActivitiesCollectionViewCell kind]
                               withNibNamed:[TMEActivitiesCollectionViewCell kind]
                             forObjectClass:[TMEActivity class]
                     withConfigurationBlock:^(TMEActivitiesCollectionViewCell *cell, id object) {
                         [cell configWithData:object];
                     }];
    
    self.viewModel = [[TMEListActivitiesViewModel alloc] init];
    [self.viewModel reloadWithDoneBlock: ^(NSArray *items, NSError *error) {
        [self.collectionActivities reloadData];
    }];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Retrieve our object to give to our size manager.
    id object = [self.viewModel itemAtIndexPath:indexPath];
    CGFloat height = [self.sizeManager cellHeightForObject:object
                                                 indexPath:indexPath
                                       cellReuseIdentifier:[TMEActivitiesCollectionViewCell kind]];
    return CGSizeMake(self.view.width, height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel numberOfItems];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TMEActivitiesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TMEActivitiesCollectionViewCell kind] forIndexPath:indexPath];
    id object = [self.viewModel itemAtIndexPath:indexPath];
    [cell configWithData:object];
    return cell;
}

@end
