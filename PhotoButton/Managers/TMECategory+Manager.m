//
//  TMECategory+Manager.m
//  ThreeMin
//
//  Created by Triệu Khang on 26/4/14.
//
//

#import "TMECategory+Manager.h"

@implementation TMECategory (Manager)

+ (void)getAllCategoriesOnSuccessBlock:(void (^) (NSArray *))successBlock
                          failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    [[AFHTTPRequestOperationManager tme_manager] GET:API_CATEGORY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

         if (successBlock){
             NSArray *arrayCategories = [TMECategory arrayCategoriesFromArray:responseObject];
             successBlock(arrayCategories);
         }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failureBlock){
             failureBlock(error.code ,error);
         }
    }];
}

+ (void)getAllCategoriesTaggableOnSuccessBlock:(void (^) (NSArray *))successBlock
                                  failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSString *path = [API_CATEGORY stringByAppendingString:API_CATEGORY_TAGGABLE];

    [[AFHTTPRequestOperationManager tme_manager] GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

         if (successBlock){
             NSArray *arrayCategories = [TMECategory arrayCategoriesFromArray:responseObject];
             successBlock(arrayCategories);
         }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failureBlock){
             failureBlock(error.code ,error);
         }
    }];
}

@end
