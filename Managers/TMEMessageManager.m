//
//  TMEMessageManager.m
//  PhotoButton
//
//  Created by Toan Slan on 12/23/13.
//
//

#import "TMEMessageManager.h"

@implementation TMEMessageManager

SINGLETON_MACRO

- (void)getListMessageOfProduct:(TMEProduct *)product
                      withBuyer:(TMEUser *)fromBuyer
                         toUser:(TMEUser *)toUser
                 onSuccessBlock:(void (^)(NSArray *))successBlock
                andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{

    NSDictionary *params = [[NSDictionary alloc] init];
    if (toUser) {
        params = @{
                   @"to" : toUser.id,
                   @"access_token" : [[TMEUserManager sharedInstance] getAccessToken]
                   };
    }
    else{
       params = @{
                  @"access_token" : [[TMEUserManager sharedInstance] getAccessToken]
                  };
    }
    
    NSString *path = [NSString stringWithFormat:@"%@%@%@/%@%@",API_SERVER_HOST,API_PREFIX,API_PRODUCTS,product.id,API_CHATS];
    
    [[TMEHTTPClient sharedClient] getPath:path
                               parameters:params
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSArray *arrMessage = [TMEMessage arrayMessageFromArray:responseObject andProduct:product withBuyer:fromBuyer];
                                      NSManagedObjectContext *mainContext  = [NSManagedObjectContext MR_defaultContext];
                                      [mainContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                                          DLog(@"Finish save to magical record");
                                          successBlock(arrMessage);
                                      }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.code, error);
    }];
    
}

- (void)postMessageTo:(TMEUser *)user
           forProduct:(TMEProduct *)product
          withMessage:(NSString *)messageContent
       onSuccessBlock:(void (^)(NSString *))successBlock
      andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    
    NSDictionary *params = @{
                             @"to"     : user.id,
                             @"access_token" : [[TMEUserManager sharedInstance] getAccessToken],
                             @"message" : messageContent
                             };
    NSString *path = [NSString stringWithFormat:@"%@%@%@/%@%@", API_SERVER_HOST,API_PREFIX, API_PRODUCTS, product.id, API_CHATS];
    [[TMEHTTPClient sharedClient] postPath:path
                                parameters:params
                                   success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        successBlock(responseObject[@"status"]);
    }
                                   failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failureBlock(error.code, error);
    }];
    
}

@end
