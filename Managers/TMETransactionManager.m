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
                             @"to"     : @4,
                             @"access_token" : [[TMEUserManager sharedInstance] getAccessToken]
                             };
    
    NSString *path = [NSString stringWithFormat:@"%@%@%@/%@%@",API_SERVER_HOST,API_PREFIX,API_PRODUCTS,product.id,API_CHATS];
    
    [[TMEHTTPClient sharedClient] getPath:path
                               parameters:params
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSArray *arrTransaction = [TMETransaction arrayTransactionFromArray:responseObject];
                                      successBlock(arrTransaction);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        return;
    }];
    
    
}

- (void)postMessageTo:(TMEProduct *)product
          withMessage:(NSString *)message
       onSuccessBlock:(void (^)(TMETransaction*))successBlock
      andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    
    NSDictionary *params = @{
                             @"to"     : @4,
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
            transaction.time_stamp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[responseObject[@"timestamp"] doubleValue]];
            transaction.product = product;
            transaction.from = [[TMEUserManager sharedInstance] loggedUser];
            transaction.to = product.user;
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
