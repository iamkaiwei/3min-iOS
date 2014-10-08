//
//  TMEProductCommentViewModel.m
//  ThreeMin
//
//  Created by Khoa Pham on 10/6/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductCommentViewModel.h"
#import "TMEProductCommentNetworkClient.h"

@interface TMEProductCommentViewModel ()

@property (nonatomic, strong) TMEProduct *product;

@end

@implementation TMEProductCommentViewModel

- (instancetype)initWithProduct:(TMEProduct *)product
{
    self = [super init];
    if (self) {
        _product = product;
    }

    return self;
}

- (void)pullProductComments
{
    TMEProductCommentNetworkClient *client = [[TMEProductCommentNetworkClient alloc] init];
    [client getCommentsForProduct:self.product success:^(NSArray *productComments) {
        self.productComments = productComments;
        self.productCommentsCount = productComments.count;
    } failure:^(NSError *error) {

    }];
}

@end
