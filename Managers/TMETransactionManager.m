//
//  TMETransactionManager.m
//  PhotoButton
//
//  Created by Toan Slan on 12/23/13.
//
//

#import "TMETransactionManager.h"

@implementation TMETransactionManager

SINGLETON_MACRO

- (void)getListMessageOfProduct:(TMEProduct *)product
                         toUser:(TMEUser *)user
                 onSuccessBlock:(void (^)(NSArray *))successBlock
                andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    NSDictionary *params = @{
                             @"to"     : product.id,
                             @"access_token" : [[TMEUserManager sharedInstance] getAccessToken]
                             };
    
    [[TMEHTTPClient sharedClient] getPath:[NSString stringWithFormat:@"%@%@%@%@",API_PREFIX,API_PRODUCTS,product.id,API_CHATS]
                               parameters:params
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSMutableArray *arrayDic = [@[] mutableCopy];
                                      for (int i = 0; i < [responseObject count]; i++) {
                                          [arrayDic addObject:responseObject[i]];
                                      }
                                      successBlock(arrayDic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        return;
    }];
    
    
}

- (void)postMessageTo:(TMEProduct *)product
          withMessage:(NSString *)message
       onSuccessBlock:(void (^)(TMETransaction*))successBlock
      andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    
    NSDictionary *params = @{
                             @"to"     : product.user.id,
                             @"access_token" : [[TMEUserManager sharedInstance] getAccessToken],
                             @"message" : message
                             };
    NSString *path = [NSString stringWithFormat:@"%@%@%@/%@%@", API_SERVER_HOST,API_PREFIX, API_PRODUCTS, product.id, API_CHATS];
    [[TMEHTTPClient sharedClient] postPath:path
                                parameters:params
                                   success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        TMETransaction *transaction = [TMETransaction MR_createEntity];
        if (responseObject) {
            transaction.chat = message;
            transaction.time_stamp = responseObject[@"timestamp"];
            transaction.product = product;
            transaction.buyer = [[TMEUserManager sharedInstance] loggedUser];
        }
        if (successBlock) {
             successBlock(transaction);
        }
    }
                                   failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        return;
    }];
    
}

@end
