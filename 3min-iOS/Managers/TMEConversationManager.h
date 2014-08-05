//
//  TMEConversationManager.h
//  PhotoButton
//
//  Created by admin on 1/5/14.
//
//

#import "TMECOnversation.h"

@interface TMEConversationManager : TMEBaseManager

+ (void)getRepliesOfConversationID:(NSInteger)conversationID
                     largerReplyID:(NSInteger)largerReplyID
                    smallerReplyID:(NSInteger)smallerReplyID
                          withPage:(NSInteger)page
                    onSuccessBlock:(void (^)(TMEConversation *))successBlock
                      failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)postReplyToConversation:(NSInteger)conversationID
                    withMessage:(NSString *)messageContent
                 onSuccessBlock:(void (^)(NSString *))successBlock
                   failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)getListConversationWithPage:(NSInteger)page
                     onSuccessBlock:(void (^)(NSArray *))successBlock
                       failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)getListOffersOfProduct:(TMEProduct *)product
                onSuccessBlock:(void (^)(NSArray *))successBlock
                  failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)getOfferedConversationWithPage:(NSInteger)page
                        onSuccessBlock:(void (^)(NSArray *))successBlock
                          failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)checkConversationExistWithProductID:(NSNumber *)productID
                                   toUserID:(NSNumber *)userID
                             onSuccessBlock:(void (^)(TMEConversation *))successBlock
                               failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)createConversationWithProductID:(NSNumber *)productID
                               toUserID:(NSNumber *)userID
                         withOfferPrice:(NSNumber *)offer
                         onSuccessBlock:(void (^)(TMEConversation *))successBlock
                           failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)createBulkWithConversationID:(NSNumber *)conversationID
                       arrayMessages:(NSArray *)messages
                      onSuccessBlock:(void(^)())successBlock
                        failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

+ (void)putOfferPriceToConversationID:(NSNumber *)conversationID
                           offerPrice:(NSNumber *)offerPrice
                       onSuccessBlock:(void (^)(NSNumber *))successBlock
                         failureBlock:(TMENetworkManagerFailureBlock)failureBlock;

@end
