//
//  TMEConversationManager.m
//  PhotoButton
//
//  Created by admin on 1/5/14.
//
//

#import "TMEConversationManager.h"

@implementation TMEConversationManager

SINGLETON_MACRO

- (void)getRepliesOfConversationWithConversationID:(NSInteger)conversationID
                                andReplyIDLargerID:(NSInteger)largerReplyID
                                       orSmallerID:(NSInteger)smallerReplyID
                                          withPage:(NSInteger)page
                                    onSuccessBlock:(void (^)(TMEConversation *))successBlock
                                   andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{
  
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
  params = [@{
             @"access_token" : [[TMEUserManager sharedInstance] getAccessToken]
             } mutableCopy];
  
  if (largerReplyID) {
    [params setObject:@(largerReplyID) forKey:@"larger"];
  }
  if (smallerReplyID) {
    [params setObject:@(smallerReplyID) forKey:@"smaller"];
  }
  if (page) {
    [params setObject:@(page) forKey:@"page"];
  }
  
  NSString *path = [NSString stringWithFormat:@"%@%@%@/%d",API_SERVER_HOST,API_PREFIX,API_CONVERSATIONS, conversationID];
  
  [[TMEHTTPClient sharedClient] getPath:path
                             parameters:params
                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  TMEConversation *conversation = [TMEConversation conversationFromData:responseObject];
                                  
                                  NSManagedObjectContext *mainContext = [NSManagedObjectContext MR_defaultContext];
                                  [mainContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                                    DLog(@"Finish save to magical record");
                                    
                                    successBlock(conversation);
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
                           @"message" : messageContent,
                           @"product_id" : product.id
                           };
  NSString *path = [NSString stringWithFormat:@"%@%@%@", API_SERVER_HOST, API_PREFIX, API_CONVERSATIONS];
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

- (void)getListConversationWithPage:(NSInteger)page
                     onSuccessBlock:(void (^)(NSArray *))successBlock
                    andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{
  NSMutableDictionary *params = [@{@"access_token" : [[TMEUserManager sharedInstance] getAccessToken]} mutableCopy];
  if (page) {
    [params setObject:@(page) forKey:@"page"];
  }
  
  NSString *path = [NSString stringWithFormat:@"%@%@%@", API_SERVER_HOST, API_PREFIX, API_CONVERSATIONS];
  [[TMEHTTPClient sharedClient] getPath:path
                             parameters:params
                                success:^(AFHTTPRequestOperation *operation, id responseObject){
                                  NSArray *arrayConversation = [TMEConversation arrayConversationFromArrayData:responseObject];
                                  successBlock(arrayConversation);
                                }
                                failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                  failureBlock(error.code, error);
                                }];
}

@end
