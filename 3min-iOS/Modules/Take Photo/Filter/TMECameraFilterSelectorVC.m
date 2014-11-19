//
//  TMECameraFilterSelectorVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/19/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMECameraFilterSelectorVC.h"
#import "TMESingleSectionDataSource.h"
#import "TMECameraFilterCell.h"
#import "TMECameraFilter.h"

@interface TMECameraFilterSelectorVC ()

@property (nonatomic, strong) TMESingleSectionDataSource *dataSource;
@property (nonatomic, strong) NSArray *filtersTypes;
@property (nonatomic, strong) NSArray *filters;

@end

@implementation TMECameraFilterSelectorVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupCollectionView
{
    self.dataSource = [[TMESingleSectionDataSource alloc] init];
    self.dataSource.cellIdentifier = [TMECameraFilterCell kind];
    self.dataSource.cellConfigureBlock = ^(TMECameraFilterCell *cell, id object) {

    };

    self.collectionView.dataSource = self.dataSource;
}

#pragma mark - Configure
- (void)setupFilters
{
    
}

#pragma mark - Delegate
- (void)didSelectFilter
{
    if ([self.delegate respondsToSelector:@selector(filterSelectorVCDidSelectFilter)]) {
        [self.delegate filterSelectorVCDidSelectFilter];
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - Filter
- (NSArray *)filtersTypes
{
    if (!_filtersTypes) {
        _filtersTypes = @[
                          @(IMGLYFilterTypeNone),
                          @(IMGLYFilterType9EK1),
                          @(IMGLYFilterType9EK2),
                          @(IMGLYFilterType9EK6),
                          @(IMGLYFilterType9EKDynamic),
                          @(IMGLYFilterTypeFridge),
                          @(IMGLYFilterTypeBreeze),
                          @(IMGLYFilterTypeOchrid),
                          @(IMGLYFilterTypeChestnut),
                          @(IMGLYFilterTypeFront),
                          @(IMGLYFilterTypeFixie),
                          @(IMGLYFilterTypeX400),
                          @(IMGLYFilterTypeBW),
                          @(IMGLYFilterTypeBWHard),
                          @(IMGLYFilterTypeLenin),
                          @(IMGLYFilterTypeQouzi),
                          @(IMGLYFilterType669),
                          @(IMGLYFilterTypePola),
                          @(IMGLYFilterTypeFood),
                          @(IMGLYFilterTypeGlam),
                          @(IMGLYFilterTypeLord),
                          @(IMGLYFilterTypeTejas),
                          @(IMGLYFilterTypeEarlyBird),
                          @(IMGLYFilterTypeLomo),
                          @(IMGLYFilterTypeGobblin),
                          @(IMGLYFilterTypeSinCity),
                          @(IMGLYFilterTypeSketch),
                          @(IMGLYFilterTypeMellow),
                          @(IMGLYFilterTypeSunny),
                          @(IMGLYFilterTypeA15),
                          @(IMGLYFilterTypeSemiRed),
                          ];
    }

    return _filtersTypes;
}

- (NSString *)filterNameFromType:(IMGLYFilterType)filterType
{
    switch (filterType) {
        case IMGLYFilterTypeNone:
            return @"None";
        case IMGLYFilterType9EK1:
            return @"K1";
        case IMGLYFilterType9EK2:
            return @"K2";
        case IMGLYFilterType9EK6:
            return @"K6";
        case IMGLYFilterType9EKDynamic:
            return @"Dynamic";
        case IMGLYFilterTypeFridge:
            return @"Fridge";
        case IMGLYFilterTypeBreeze:
            return @"Breeze";
        case IMGLYFilterTypeOchrid:
            return @"Orchrid";
        case IMGLYFilterTypeChestnut:
            return @"Chestnut";
        case IMGLYFilterTypeFront:
            return @"Front";
        case IMGLYFilterTypeFixie:
            return @"Fixie";
        case IMGLYFilterTypeX400:
            return @"X400";
        case IMGLYFilterTypeBW:
            return @"BW";
        case IMGLYFilterTypeBWHard:
            return @"1920";
        case IMGLYFilterTypeLenin:
            return @"Lenin";
        case IMGLYFilterTypeQouzi:
            return @"Qouzi";
        case IMGLYFilterType669:
            return @"Pola 669";
        case IMGLYFilterTypePola:
            return @"Pola SX";
        case IMGLYFilterTypeFood:
            return @"Food";
        case IMGLYFilterTypeGlam:
            return @"Glam";
        case IMGLYFilterTypeLord:
            return @"Lord";
        case IMGLYFilterTypeTejas:
            return @"Tejas";
        case IMGLYFilterTypeEarlyBird:
            return @"Morning";
        case IMGLYFilterTypeLomo:
            return @"Lomo";
        case IMGLYFilterTypeGobblin:
            return @"Gobblin";
        case IMGLYFilterTypeSinCity:
            return @"Sin";
        case IMGLYFilterTypeSketch:
            return @"Sketch";
        case IMGLYFilterTypeMellow:
            return @"Mellow";
        case IMGLYFilterTypeSunny:
            return @"Sunny";
        case IMGLYFilterTypeA15:
            return @"A15";
        case IMGLYFilterTypeSemiRed:
            return @"Semi Red";
        default:
            return nil;
    }
}

@end
