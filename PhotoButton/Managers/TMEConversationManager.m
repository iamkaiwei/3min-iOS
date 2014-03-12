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

+ (void)getRepliesOfConversationID:(NSInteger)conversationID
                     largerReplyID:(NSInteger)largerReplyID
                    smallerReplyID:(NSInteger)smallerReplyID
                          withPage:(NSInteger)page
                    onSuccessBlock:(void (^)(TMEConversation *))successBlock
                      failureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    
    NSMutableDictionary *params = [@{@"page": @(page)} mutableCopy];
    
    if (largerReplyID) {
        [params setObject:@(largerReplyID) forKey:@"larger"];
    }
    if (smallerReplyID) {
        [params setObject:@(smallerReplyID) forKey:@"smaller"];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%d", API_CONVERSATIONS, conversationID];
    
    [[BaseNetworkManager sharedInstance] sendRequestForPath:path
                                                 parameters:params
                                                     method:GET_METHOD
                                                    success:^(NSHTTPURLResponse *response, id responseObject)
     {
         if (successBlock) {
             TMEConversation *conversation = [TMEConversation aConversationFromData:responseObject];
             successBlock(conversation);
         }
     }
                                                    failure:^(NSError *error)
     {
         if (failureBlock) {
             failureBlock(error.code, error);
         }
     }];
}

+ (void)postReplyToConversation:(NSInteger)conversationID
                    withMessage:(NSString *)messageContent
                 onSuccessBlock:(void (^)(NSString *))successBlock
                   failureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    
    NSDictionary *params = @{@"message" : messageContent};
    
    NSString *path = [NSString stringWithFormat:@"%@/%d%@", API_CONVERSATIONS, conversationID, API_CONVERSATION_REPLIES];
    
    [[BaseNetworkManager sharedInstance] sendRequestForPath:path
                                                 parameters:params
                                                     method:POST_METHOD
                                                    success:^(NSHTTPURLResponse *response, id responseObject)
     {
         if (successBlock) {
             successBlock(responseObject[@"status"]);
         }
     }
                                                    failure:^(NSError *error)
     {
         if (failureBlock) {
             failureBlock(error.code, error);
         }
     }];
}

+ (void)getListConversationWithPage:(NSInteger)page
                     onSuccessBlock:(void (^)(NSArray *))successBlock
                       failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSDictionary *params = @{@"page" : @(page)};
    [[BaseNetworkManager sharedInstance] getServerListForModelClass:[TMEConversation class]
                                                         withParams:params
                                                          methodAPI:GET_METHOD
                                                           parentId:nil
                                                    withParentClass:nil
                                                            success:^(NSMutableArray *objectsArray)
     {
         if (successBlock) {
             NSArray *arrayConversation = [TMEConversation arrayConversationFromArrayData:objectsArray];
             successBlock(arrayConversation);
         }
     }
                                                            failure:^(NSError *error)
     {
         if (failureBlock)
             failureBlock(error.code ,error);
     }];
}

+ (void)getOfferedConversationWithPage:(NSInteger)page
                        onSuccessBlock:(void (^)(NSArray *))successBlock
                          failureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    NSDictionary *params = @{@"page" : @(page)};
    NSString *path = [NSString stringWithFormat:@"%@%@", API_PRODUCTS, API_OFFER];
    
    [[BaseNetworkManager sharedInstance] sendRequestForPath:path
                                                 parameters:params
                                                     method:GET_METHOD
                                                    success:^(NSHTTPURLResponse *response, id responseObject)
     {
         if (successBlock) {
             NSArray *arrayConversation = [TMEConversation arrayConversationFromOfferArrayData:responseObject];
             successBlock(arrayConversation);
         }
     }
                                                    failure:^(NSError *error)
     {
         if (failureBlock) {
             failureBlock(error.code, error);
         }
     }];
};

+ (void)getListOffersOfProduct:(TMEProduct *)product
                onSuccessBlock:(void (^)(NSArray *))successBlock
                  failureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    NSString *path = [NSString stringWithFormat:@"%@/%@%@", API_PRODUCTS, product.id, API_SHOW_OFFER];
    
    [[BaseNetworkManager sharedInstance] sendRequestForPath:path
                                                 parameters:nil
                                                     method:GET_METHOD
                                                    success:^(NSHTTPURLResponse *response, id responseObject)
     {
         if (successBlock) {
             NSArray *arrayConversation = [TMEConversation arrayConversationFromArrayData:responseObject];
             successBlock(arrayConversation);
         }
     }
                                                    failure:^(NSError *error)
     {
         if (failureBlock) {
             failureBlock(error.code, error);
         }
     }];
};

+ (void)createConversationWithProductID:(NSNumber *)productID
                               toUserID:(NSNumber *)userID
                         onSuccessBlock:(void (^)(TMEConversation *))successBlock
                           failureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    NSDictionary *params = @{@"product_id" : productID,
                             @"to" : userID};
    
    [[BaseNetworkManager sharedInstance] sendRequestForPath:API_CONVERSATIONS
                                                 parameters:params
                                                     method:POST_METHOD
                                                    success:^(NSHTTPURLResponse *response, id responseObject)
     {
         if (successBlock) {
             TMEConversation *conversation = [TMEConversation aConversationFromData:responseObject];
             successBlock(conversation);
         }
     }
                                                    failure:^(NSError *error)
     {
         if (failureBlock) {
             failureBlock(error.code, error);
         }
     }];
}

+ (void)putOfferPriceToConversationID:(NSNumber *)conversationID
                           offerPrice:(NSNumber *)offerPrice
                       onSuccessBlock:(void (^)(NSNumber *))successBlock
                         failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSDictionary *param = @{@"offer" : offerPrice};
    NSString *path = [NSString stringWithFormat:@"%@/%@%@", API_CONVERSATIONS, conversationID, API_OFFER];
    
    [[BaseNetworkManager sharedInstance] sendRequestForPath:path
                                                 parameters:param
                                                     method:PUT_METHOD
                                                    success:^(NSHTTPURLResponse *response, id responseObject)
     {
         if ([responseObject[@"status"] isEqualToString:@"success"]){
             if (successBlock) {
                 successBlock(offerPrice);
             }
         }
     }
                                                    failure:^(NSError *error)
     {
         if (failureBlock) {
             failureBlock(error.code, error);
         }
     }];
}

@end
