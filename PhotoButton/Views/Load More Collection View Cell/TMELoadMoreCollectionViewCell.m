//
//  TMELoadMoreCollectionViewCell.m
//  PhotoButton
//
//  Created by Toan Slan on 2/26/14.
//
//

#import "TMELoadMoreCollectionViewCell.h"

@interface TMELoadMoreCollectionViewCell()

@property (weak, nonatomic) IBOutlet MTAnimatedLabel *labelLoading;

@end

@implementation TMELoadMoreCollectionViewCell

- (void)startLoading{
    [self.labelLoading startAnimating];
}

+ (CGFloat)getHeight{
    return 44;
}

@end
