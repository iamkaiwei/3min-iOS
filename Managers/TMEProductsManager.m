//
//  TMEProductsManager.m
//  PhotoButton
//
//  Created by Triệu Khang on 23/9/13.
//
//

#import "TMEProductsManager.h"

@implementation TMEProductsManager

SINGLETON_MACRO

-(void)getAllProductsOnSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSMutableDictionary *params = [@{} mutableCopy];
    [[BaseNetworkManager sharedInstance] getServerListForModelClass:[TMEProduct class]
                                                         withParams:params
                                                          methodAPI:GET_METHOD
                                                           parentId:nil
                                                    withParentClass:nil
                                                            success:^(NSMutableArray *objectsArray) {
                                                                if (successBlock)
                                                                    successBlock(objectsArray);
    } failure:^(NSError *error) {
        if (failureBlock)
            failureBlock(error.code ,error);
    }];
}

#pragma marks - Fake functions to handle products.
- (NSArray *)fakeGetAllStoredProducts
{
    return [TMEProduct MR_findAll];
}

- (NSArray *)fakeGetAllStoredProductsSellByUser:(TMEUser *)user
{
    return [TMEProduct MR_findByAttribute:@"user = " withValue:user];
}

- (NSArray *)fakeGetAllStoredProductsInCategory:(TMECategory *)category
{
    return [TMEProduct MR_findByAttribute:@"category = " withValue:category];
}

#pragma marks - Helper Methods


@end
