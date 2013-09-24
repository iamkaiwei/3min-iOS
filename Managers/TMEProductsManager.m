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

-(void)getAllProductsOnSuccessBlock:(TMEJSONRequestSuccessBlock)successBlock andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock
{

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
