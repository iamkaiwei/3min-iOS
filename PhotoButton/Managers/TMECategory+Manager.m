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
    [[BaseNetworkManager sharedInstance] getServerListForModelClass:[TMECategory class]
                                                         withParams:nil
                                                          methodAPI:GET_METHOD
                                                           parentId:nil
                                                    withParentClass:nil
                                                            success:^(NSMutableArray *objectsArray)
     {
         if (successBlock){
             NSArray *arrayCategories = [TMECategory arrayCategoriesFromArray:objectsArray];
             successBlock(arrayCategories);
         }
     }
                                                            failure:^(NSError *error)
     {
         if (failureBlock){
             failureBlock(error.code ,error);
         }
     }];
}

+ (void)getAllCategoriesTaggableOnSuccessBlock:(void (^) (NSArray *))successBlock
                                  failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSString *path = [API_CATEGORY stringByAppendingString:API_CATEGORY_TAGGABLE];
    
    [[BaseNetworkManager sharedInstance] sendRequestForPath:path
                                                 parameters:nil
                                                     method:GET_METHOD
                                                    success:^(NSHTTPURLResponse *response, id responseObject)
     {
         if (successBlock){
             NSArray *arrayCategories = [TMECategory arrayCategoriesFromArray:responseObject];
             successBlock(arrayCategories);
         }
     }
                                                    failure:^(NSError *error)
     {
         if (failureBlock){
             failureBlock(error.code ,error);
         }
     }];
}

@end
