//
//  TMECategoryManager.m
//  PhotoButton
//
//  Created by Hoang Ta on 9/29/13.
//
//

#import "TMECategoryManager.h"

@implementation TMECategoryManager

SINGLETON_MACRO

-(void)getAllCategoriesOnSuccessBlock:(void (^) (NSArray *arrayCategories))successBlock
                      andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
  NSMutableDictionary *params = [@{} mutableCopy];
  [[BaseNetworkManager sharedInstance] getServerListForModelClass:[TMECategory class]
                                                       withParams:params
                                                        methodAPI:GET_METHOD
                                                         parentId:nil
                                                  withParentClass:nil
                                                          success:^(NSMutableArray *objectsArray) {
                                                            NSArray *arrayCategories = [TMECategory arrayCategoriesFromArray:objectsArray];
                                                            if (successBlock)
                                                              successBlock(arrayCategories);
                                                          } failure:^(NSError *error) {
                                                            if (failureBlock)
                                                              failureBlock(error.code ,error);
                                                          }];
}

@end
