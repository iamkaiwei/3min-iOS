//
//  TMEProductManager.m
//  PhotoButton
//
//  Created by Triệu Khang on 19/9/13.
//
//

#import "TMEProductManager.h"

@implementation TMEProductManager

SINGLETON_MACRO

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
