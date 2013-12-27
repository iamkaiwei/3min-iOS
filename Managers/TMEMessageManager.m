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
                      fromBuyer:(TMEUser *)fromBuyer
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
        return;
    }];
    
}

- (void)postMessageTo:(TMEUser *)user
           forProduct:(TMEProduct *)product
          withMessage:(NSString *)message
       onSuccessBlock:(void (^)(TMEMessage*))successBlock
      andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    
    NSDictionary *params = @{
                             @"to"     : user.id,
                             @"access_token" : [[TMEUserManager sharedInstance] getAccessToken],
                             @"message" : message
                             };
    NSString *path = [NSString stringWithFormat:@"%@%@%@/%@%@", API_SERVER_HOST,API_PREFIX, API_PRODUCTS, product.id, API_CHATS];
    [[TMEHTTPClient sharedClient] postPath:path
                                parameters:params
                                   success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        TMEMessage *message = [TMEMessage alloc];
        if (responseObject && [responseObject[@"status"] isEqual: @"success"]) {
            message = [TMEMessage messageWithContent:message andProduct:product atTimestamp:[responseObject[@"timestamp"] doubleValue] toUser:user];
            
            NSManagedObjectContext *mainContext  = [NSManagedObjectContext MR_defaultContext];
            [mainContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                DLog(@"Finish save to magical record");
                successBlock(message);
            }];
        
        }
    }
                                   failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        return;
    }];
    
}

@end
