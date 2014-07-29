//
//  TMEConversationManager.h
//  PhotoButton
//
//  Created by admin on 1/5/14.
//
//

#import "BaseManager.h"
#import "TMECOnversation.h"

@interface TMEConversationManager : BaseManager

+ (void)getRepliesOfConversationID:(NSInteger)conversationID
                     largerReplyID:(NSInteger)largerReplyID
                    smallerReplyID:(NSInteger)smallerReplyID
                          withPage:(NSInteger)page
                    onSuccessBlock:(void (^)(TMEConversation *))successBlock
                      failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)postReplyToConversation:(NSInteger)conversationID
                    withMessage:(NSString *)messageContent
                 onSuccessBlock:(void (^)(NSString *))successBlock
                   failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)getListConversationWithPage:(NSInteger)page
                     onSuccessBlock:(void (^)(NSArray *))successBlock
                       failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)getListOffersOfProduct:(TMEProduct *)product
                onSuccessBlock:(void (^)(NSArray *))successBlock
                  failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)getOfferedConversationWithPage:(NSInteger)page
                        onSuccessBlock:(void (^)(NSArray *))successBlock
                          failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)checkConversationExistWithProductID:(NSNumber *)productID
                                   toUserID:(NSNumber *)userID
                             onSuccessBlock:(void (^)(TMEConversation *))successBlock
                               failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)createConversationWithProductID:(NSNumber *)productID
                               toUserID:(NSNumber *)userID
                         withOfferPrice:(NSNumber *)offer
                         onSuccessBlock:(void (^)(TMEConversation *))successBlock
                           failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)createBulkWithConversationID:(NSNumber *)conversationID
                       arrayMessages:(NSArray *)messages
                      onSuccessBlock:(void(^)())successBlock
                        failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

+ (void)putOfferPriceToConversationID:(NSNumber *)conversationID
                           offerPrice:(NSNumber *)offerPrice
                       onSuccessBlock:(void (^)(NSNumber *))successBlock
                         failureBlock:(TMEJSONRequestFailureBlock)failureBlock;

@end