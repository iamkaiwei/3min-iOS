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
                                    
                                    if (successBlock) {
                                      successBlock(conversation);
                                    }
                                  }];
                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  if (failureBlock) {
                                    failureBlock(error.code, error);
                                  }
                                }];
}

- (void)postReplyToConversation:(NSInteger)conversationID
                    withMessage:(NSString *)messageContent
                 onSuccessBlock:(void (^)(NSString *))successBlock
                andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{
  
  NSDictionary *params = @{
                           @"access_token" : [[TMEUserManager sharedInstance] getAccessToken],
                           @"message" : messageContent,
                           };
  NSString *path = [NSString stringWithFormat:@"%@%@%@/%d%@", API_SERVER_HOST, API_PREFIX, API_CONVERSATIONS, conversationID, API_CONVERSATION_REPLIES];
  [[TMEHTTPClient sharedClient] postPath:path
                              parameters:params
                                 success:^(AFHTTPRequestOperation *operation, id responseObject)
   {
     if (successBlock) {
       successBlock(responseObject[@"status"]);
     }
   }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error)
   {
     if (failureBlock) {
       failureBlock(error.code, error);
     }
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
                                  
                                  if (successBlock) {
                                    successBlock(arrayConversation);
                                  }

                                }
                                failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                  
                                  if (failureBlock) {
                                    failureBlock(error.code, error);
                                  }

                                }];
}

- (void)getOfferedConversationWithPage:(NSInteger)page
                        onSuccessBlock:(void (^)(NSArray *))successBlock
                       andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{
  NSMutableDictionary *params = [@{@"access_token" : [[TMEUserManager sharedInstance] getAccessToken]} mutableCopy];
  if (page) {
    [params setObject:@(page) forKey:@"page"];
  }
  
  NSString *path = [NSString stringWithFormat:@"%@%@%@%@", API_SERVER_HOST, API_PREFIX, API_PRODUCTS, API_OFFER];
  [[TMEHTTPClient sharedClient] getPath:path
                             parameters:params
                                success:^(AFHTTPRequestOperation *operation, id responseObject){
                                  NSArray *arrayConversation = [TMEConversation arrayConversationFromOfferArrayData:responseObject];
                                  
                                  if (successBlock) {
                                    successBlock(arrayConversation);
                                  }
                                  
                                }
                                failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                  
                                  if (failureBlock) {
                                    failureBlock(error.code, error);
                                  }
                                  
                                }];


};

- (void)createConversationWithProductID:(NSNumber *)productID
                            toUserID:(NSNumber *)userID
                     onSuccessBlock:(void (^)(TMEConversation *))successBlock
                    andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock{
  NSMutableDictionary *params = [@{@"access_token" : [[TMEUserManager sharedInstance] getAccessToken],
                                   @"product_id" : productID,
                                   @"to" : userID
                                   } mutableCopy];
  
  NSString *path = [NSString stringWithFormat:@"%@%@%@", API_SERVER_HOST, API_PREFIX, API_CONVERSATIONS];
  [[TMEHTTPClient sharedClient] postPath:path
                              parameters:params
                                 success:^(AFHTTPRequestOperation *operation, id responseObject){
                                   TMEConversation *conversation = [TMEConversation conversationFromData:responseObject];
                                   if (successBlock) {
                                     successBlock(conversation);
                                   }
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                   if (failureBlock) {
                                     failureBlock(error.code, error);
                                   }
                                 }];
}

- (void)putOfferPriceToConversationWithConversationID:(NSNumber *)conversationID
                                        andOfferPrice:(NSNumber *)offerPrice
                                       onSuccessBlock:(void (^)(NSNumber *))successBlock
                                      andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
  NSMutableDictionary *param = [@{@"access_token" : [[TMEUserManager sharedInstance] getAccessToken],
                                  @"offer" : offerPrice
                                  } mutableCopy];
  NSString *path = [NSString stringWithFormat:@"%@%@%@/%@%@", API_SERVER_HOST, API_PREFIX, API_CONVERSATIONS, conversationID, API_OFFER];
  [[TMEHTTPClient sharedClient] putPath:path
                             parameters:param
                                success:^(AFHTTPRequestOperation *operation, id responseObject){
                                  if ([responseObject[@"status"] isEqualToString:@"success"]){
                                    if (successBlock) {
                                      successBlock(offerPrice);
                                    }
                                  }
                                }
                                failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                  if (failureBlock) {
                                    failureBlock(error.code, error);
                                  }
                                }];
}

@end
