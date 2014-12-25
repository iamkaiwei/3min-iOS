//
//  TMEUserItemsLoadingOperation.m
//  ThreeMin
//
//  Created by Vinh Nguyen on 22/12/2014.
//  Copyright (c) Năm 2014 3min. All rights reserved.
//

#import "TMEUserItemsLoadingOperation.h"
#import "TMEUserNetworkClient.h"

@interface TMEUserItemsLoadingOperation ()
@property (assign, nonatomic) NSUInteger page;
@property (assign, nonatomic) NSUInteger userID;
@property (strong, nonatomic) NSArray *dataPage;
@end

@implementation TMEUserItemsLoadingOperation

- (instancetype)initWithUserID:(NSUInteger)userID page:(NSUInteger)page
{
    self = [super init];
    if (self) {
        _page = page;
        _userID = userID;
    }
    
    return self;
}

- (void)loadData:(void (^)(NSArray *, NSError *))finishBlock
{
    __weak typeof(self)weakSelf = self;
    [TMEProductsManager getProductsFromUserID:@(self.userID)
                               onSuccessBlock:^(NSArray *products) {
        weakSelf.dataPage = products;
        if (finishBlock) {
            finishBlock(products, nil);
        }
    } failureBlock:^(NSError *error) {
        if (finishBlock) {
            finishBlock(nil, error);
        }
    }];
}

@end
