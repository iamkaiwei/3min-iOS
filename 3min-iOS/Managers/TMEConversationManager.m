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

    [[AFHTTPRequestOperationManager tme_manager] GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

         if (successBlock) {
             TMEConversation *conversation = [TMEConversation conversationFromData:responseObject];
             successBlock(conversation);
         }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

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

    [[AFHTTPRequestOperationManager tme_manager] POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

         if (successBlock) {
             successBlock(responseObject[@"status"]);
         }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

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
    [[AFHTTPRequestOperationManager tme_manager] GET:API_CONVERSATIONS parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

         if (successBlock) {
             NSArray *arrayConversation = [TMEConversation arrayConversationFromArrayData:responseObject];
             successBlock(arrayConversation);
         }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

         if (failureBlock)
             failureBlock(error.code ,error);

    }];
}

+ (void)getOfferedConversationWithPage:(NSInteger)page
                        onSuccessBlock:(void (^)(NSArray *))successBlock
                          failureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    NSDictionary *params = @{@"page" : @(page)};
    NSString *path = [NSString stringWithFormat:@"%@%@", API_PRODUCTS, API_OFFER];

    [[AFHTTPRequestOperationManager tme_manager] GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

         if (successBlock) {
             NSArray *arrayConversation = [TMEConversation arrayConversationFromOfferArrayData:responseObject];
             arrayConversation = [arrayConversation sortByAttribute:@"latest_update" ascending:NO];
             successBlock(arrayConversation);
         }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

         if (failureBlock)
             failureBlock(error.code ,error);

    }];
};

+ (void)getListOffersOfProduct:(TMEProduct *)product
                onSuccessBlock:(void (^)(NSArray *))successBlock
                  failureBlock:(TMEJSONRequestFailureBlock)failureBlock{
    NSString *path = [NSString stringWithFormat:@"%@/%@%@", API_PRODUCTS, product.id, API_SHOW_OFFER];

    [[AFHTTPRequestOperationManager tme_manager] GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

         if (successBlock) {
             NSArray *arrayConversation = [TMEConversation arrayConversationFromArrayData:responseObject];
             successBlock(arrayConversation);
         }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

         if (failureBlock) {
             failureBlock(error.code, error);
         }

    }];
};

+ (void)checkConversationExistWithProductID:(NSNumber *)productID
                                   toUserID:(NSNumber *)userID
                             onSuccessBlock:(void (^)(TMEConversation *))successBlock
                               failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSDictionary *params = @{@"product_id" : productID,
                             @"to" : userID};
    NSString *path = [NSString stringWithFormat:@"%@%@", API_CONVERSATIONS, API_CONVERSATIONS_EXIST];

    [[AFHTTPRequestOperationManager tme_manager] GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

         if (successBlock) {
             if (responseObject) {
                 TMEConversation *conversation = [TMEConversation conversationFromData:responseObject];
                 successBlock(conversation);
                 return;
             }
             successBlock(nil);
         }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

         if (failureBlock) {
             failureBlock(error.code, error);
         }

    }];
}

+ (void)createConversationWithProductID:(NSNumber *)productID
                               toUserID:(NSNumber *)userID
                         withOfferPrice:(NSNumber *)offer
                         onSuccessBlock:(void (^)(TMEConversation *))successBlock
                           failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSDictionary *params = @{@"product_id" : productID,
                             @"offer" : offer,
                             @"to" : userID};

    [[AFHTTPRequestOperationManager tme_manager] POST:API_CONVERSATIONS parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

         if (successBlock) {
             TMEConversation *conversation = [TMEConversation conversationFromData:responseObject];
             successBlock(conversation);
         }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

         if (failureBlock) {
             failureBlock(error.code, error);
         }

    }];
}

+ (void)createBulkWithConversationID:(NSNumber *)conversationID
                       arrayMessages:(NSArray *)messages
                      onSuccessBlock:(void(^)())successBlock
                        failureBlock:(TMEJSONRequestFailureBlock)failureBlock
{
    NSDictionary *param = @{@"messages" : messages};
    NSString *path = [NSString stringWithFormat:@"%@/%@%@%@", API_CONVERSATIONS, conversationID, API_CONVERSATION_REPLIES, API_CREATE_BULK];

    [[AFHTTPRequestOperationManager tme_manager] POST:path parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if (successBlock) {
            successBlock();
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

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

    [[AFHTTPRequestOperationManager tme_manager] PUT:path parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {

         if ([responseObject[@"status"] isEqualToString:@"success"]){
             if (successBlock) {
                 successBlock(offerPrice);
             }
         }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        if (failureBlock) {
            failureBlock(error.code, error);
        }

    }];
}

@end
