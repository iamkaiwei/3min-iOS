//
//  TMEConversationManager.m
//  PhotoButton
//
//  Created by admin on 1/5/14.
//
//

#import "TMEConversationManager.h"

@implementation TMEConversationManager

+ (void)getRepliesOfConversationID:(NSInteger)conversationID
                     largerReplyID:(NSInteger)largerReplyID
                    smallerReplyID:(NSInteger)smallerReplyID
                          withPage:(NSInteger)page
                    onSuccessBlock:(void (^)(TMEConversation *))successBlock
                      failureBlock:(TMENetworkManagerFailureBlock)failureBlock{
    
    NSMutableDictionary *params = [@{@"page": @(page)} mutableCopy];
    
    if (largerReplyID) {
        [params setObject:@(largerReplyID) forKey:@"larger"];
    }
    if (smallerReplyID) {
        [params setObject:@(smallerReplyID) forKey:@"smaller"];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%d", API_CONVERSATIONS, conversationID];

    [[TMENetworkManager sharedManager] getModel:TMEConversation.class
                                           path:path
                                         params:params
                                        success:successBlock
                                        failure:failureBlock];

}

+ (void)postReplyToConversation:(NSInteger)conversationID
                    withMessage:(NSString *)messageContent
                 onSuccessBlock:(void (^)(NSString *))successBlock
                   failureBlock:(TMENetworkManagerFailureBlock)failureBlock{
    
    NSDictionary *params = @{@"message" : messageContent};
    
    NSString *path = [NSString stringWithFormat:@"%@/%d%@", API_CONVERSATIONS, conversationID, API_CONVERSATION_REPLIES];

    [[TMENetworkManager sharedManager] post:path
                                     params:params
                                    success:^(id responseObject)
    {
        if (successBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                successBlock(responseObject[@"status"]);
            });
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock(error);
            });
        }
    }];
}

+ (void)getListConversationWithPage:(NSInteger)page
                     onSuccessBlock:(void (^)(NSArray *))successBlock
                       failureBlock:(TMENetworkManagerFailureBlock)failureBlock
{
    NSDictionary *params = @{@"page" : @(page)};

    [[TMENetworkManager sharedManager] getModels:[TMEConversation class]
                                            path:API_CONVERSATIONS
                                          params:params
                                         success:successBlock
                                         failure:failureBlock];
}

+ (void)getOfferedConversationWithPage:(NSInteger)page
                        onSuccessBlock:(void (^)(NSArray *))successBlock
                          failureBlock:(TMENetworkManagerFailureBlock)failureBlock{
    NSDictionary *params = @{@"page" : @(page)};
    NSString *path = [NSString stringWithFormat:@"%@%@", API_PRODUCTS, API_OFFER];

    [[TMENetworkManager sharedManager] getModels:[TMEConversation class]
                                            path:path
                                          params:params
                                         success:^(NSArray *conversations)
    {
        NSArray *filteredConversations = [conversations filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(TMEConversation *conversation, NSDictionary *bindings) {
            return ![conversation.offer isEqual:NSNull.null] && ![conversation.offer isEqualToNumber:@(0)];
        }]];

        NSArray *sortedConversations = [filteredConversations sortByAttribute:@"latestUpdate"
                                                            ascending:NO];
        if (successBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                successBlock(sortedConversations);
            });
        }

    } failure:failureBlock];
};

+ (void)getListOffersOfProduct:(TMEProduct *)product
                onSuccessBlock:(void (^)(NSArray *))successBlock
                  failureBlock:(TMENetworkManagerFailureBlock)failureBlock{
    NSString *path = [NSString stringWithFormat:@"%@/%@%@", API_PRODUCTS, product.id, API_SHOW_OFFER];

    [[TMENetworkManager sharedManager] getModels:[TMEConversation class]
                                            path:path
                                          params:nil
                                         success:successBlock
                                         failure:failureBlock];
};

+ (void)checkConversationExistWithProductID:(NSNumber *)productID
                                   toUserID:(NSNumber *)userID
                             onSuccessBlock:(void (^)(TMEConversation *))successBlock
                               failureBlock:(TMENetworkManagerFailureBlock)failureBlock
{
    NSDictionary *params = @{@"product_id" : productID,
                             @"to" : userID};
    NSString *path = [NSString stringWithFormat:@"%@%@", API_CONVERSATIONS, API_CONVERSATIONS_EXIST];

    [[TMENetworkManager sharedManager] getModel:[TMEConversation class]
                                           path:path
                                         params:params
                                        success:successBlock
                                        failure:failureBlock];

}

+ (void)createConversationWithProductID:(NSNumber *)productID
                               toUserID:(NSNumber *)userID
                         withOfferPrice:(NSNumber *)offer
                         onSuccessBlock:(void (^)(TMEConversation *))successBlock
                           failureBlock:(TMENetworkManagerFailureBlock)failureBlock
{
    NSDictionary *params = @{@"product_id" : productID,
                             @"offer" : offer,
                             @"to" : userID};

    [[TMENetworkManager sharedManager] post:API_CONVERSATIONS
                                     params:params
                                    success:^(id responseObject)
    {
        if (successBlock) {
            TMEConversation *conversation = [TMEConversation tme_modelFromJSONResponse:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                successBlock(conversation);
            });
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock(error);
            });
        }
    }];
}

+ (void)createBulkWithConversationID:(NSNumber *)conversationID
                       arrayMessages:(NSArray *)messages
                      onSuccessBlock:(void(^)())successBlock
                        failureBlock:(TMENetworkManagerFailureBlock)failureBlock
{
    NSDictionary *param = @{@"messages" : messages};
    NSString *path = [NSString stringWithFormat:@"%@/%@%@%@", API_CONVERSATIONS, conversationID, API_CONVERSATION_REPLIES, API_CREATE_BULK];

    [[TMENetworkManager sharedManager] post:path params:param success:^(id responseObject) {
        if (successBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                successBlock();
            });
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock(error);
            });
        }
    }];
}

+ (void)putOfferPriceToConversationID:(NSNumber *)conversationID
                           offerPrice:(NSNumber *)offerPrice
                       onSuccessBlock:(void (^)(NSNumber *))successBlock
                         failureBlock:(TMENetworkManagerFailureBlock)failureBlock
{
    NSDictionary *param = @{@"offer" : offerPrice};
    NSString *path = [NSString stringWithFormat:@"%@/%@%@", API_CONVERSATIONS, conversationID, API_OFFER];

    [[TMENetworkManager sharedManager] put:path
                                    params:param
                                   success:^(id responseObject)
    {
        if ([responseObject[@"status"] isEqualToString:@"success"]){
            if (successBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    successBlock(offerPrice);
                });
            }
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock(error);
            });
        }
    }];

}

@end
