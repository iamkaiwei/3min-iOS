//
//  TMEProductCommentsVC.h
//  ThreeMin
//
//  Created by Khoa Pham on 9/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMEProduct;
@class TMEProductCommentsVC;
@class TMEProductCommentViewModel;

@protocol TMEProductCommentsVCDelegate <NSObject>

- (void)productCommentsVC:(TMEProductCommentsVC *)commentsVC didChangeHeight:(CGFloat)height;

@end

@interface TMEProductCommentsVC : UIViewController

@property (nonatomic, strong) TMEProduct *product;
@property (nonatomic, assign) BOOL displayedInBrief;
@property (nonatomic, strong) TMEProductCommentViewModel *viewModel;
@property (nonatomic, weak) id<TMEProductCommentsVCDelegate> delegate;
@property (nonatomic, assign) NSInteger maxCommentCountInBrief;

@end
