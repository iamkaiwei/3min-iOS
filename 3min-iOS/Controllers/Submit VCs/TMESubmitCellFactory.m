//
//  TMESubmitCellFactory.m
//  ThreeMin
//
//  Created by iSlan on 11/7/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMESubmitCellFactory.h"
#import "TMEMessageCollectionViewCell.h"
#import <KHTableViewController/KHContentLoadingSectionViewModel.h>
#import <KHTableViewController/KHOrderedDataProvider.h>

@implementation TMESubmitCellFactory

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath model:(id<KHTableViewModel>)model
{
    if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHContentLoadingSectionViewModel class]]) {
        return [[[KHCollectionContentLoadingCellFactory alloc] init] collectionView:collectionView sizeForItemAtIndexPath:indexPath model:model];
    }
    
    if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHLoadMoreSection class]]) {
        return CGSizeMake(collectionView.width, 50);
    }
    
    KHOrderedDataProvider *provider = (KHOrderedDataProvider *)[model sectionAtIndex:indexPath.section];
    TMEReply *reply = [provider objectAtIndex:indexPath.item withTriggerPagination:NO];
    return CGSizeMake(collectionView.width, [self _getHeightWithContent:reply.reply]);
}

- (UICollectionViewCell<KHCellProtocol> *)collectionView:(UICollectionView *)collection cellAtIndexPath:(NSIndexPath *)indexPath withModel:(id<KHTableViewModel>)model
{
    if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHContentLoadingSectionViewModel class]]) {
        return [[[KHCollectionContentLoadingCellFactory alloc] init] collectionView:collection cellAtIndexPath:indexPath withModel:model];
    }
    
    if ([[model sectionAtIndex:indexPath.section] isKindOfClass:[KHLoadMoreSection class]]) {
        return [[[KHCollectionContentLoadingCellFactory alloc] init] collectionView:collection cellAtIndexPath:indexPath withModel:model];
    }
    
    TMEReply *reply = [model itemAtIndexpath:indexPath];
    TMEMessageCollectionViewCell<KHCellProtocol> *cell = nil;
    
    NSString *identifier = @"TMEMessageCollectionViewCell";
    
    if ([reply.userID isEqualToNumber:[TMEUserManager sharedManager].loggedUser.userID]) {
        identifier = @"TMEMessageRightCollectionViewCell";
    }
    
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [collection registerNib:nib forCellWithReuseIdentifier:identifier];
    
    cell = [collection dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell configWithData:reply];
    
    return cell;
}

- (CGFloat)_getHeightWithContent:(NSString *)content
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 22)];
    label.numberOfLines = 0;
    label.font = [UIFont openSansRegularFontWithSize:17.0f];
    label.text = content;
    [label sizeToFitKeepWidth];
    return 64 + label.height - 22;
}

@end
