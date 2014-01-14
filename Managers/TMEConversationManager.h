//
//  TMEConversationManager.h
//  PhotoButton
//
//  Created by admin on 1/5/14.
//
//

#import "BaseManager.h"

@interface TMEConversationManager : BaseManager

- (void)getRepliesOfConversationWithConversationID:(NSInteger)conversationID
                                andReplyIDLargerID:(NSInteger)largerReplyID
                                       orSmallerID:(NSInteger)smallerReplyID
                                          withPage:(NSInteger)page
                                    onSuccessBlock:(void (^)(TMEConversation *))successBlock
                                   andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

- (void)postReplyToConversation:(NSInteger)conversationID
                    withMessage:(NSString *)messageContent
                 onSuccessBlock:(void (^)(NSString *))successBlock
                andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

- (void)getListConversationWithPage:(NSInteger)page
                     onSuccessBlock:(void (^)(NSArray *))successBlock
                    andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

- (void)createConversationWithProductID:(NSNumber *)productID
                            toUserID:(NSNumber *)userID
                      onSuccessBlock:(void (^)(TMEConversation *))successBlock
                     andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

- (void)putOfferPriceToConversationWithConversationID:(NSNumber *)conversationID
                                        andOfferPrice:(NSNumber *)offerPrice
                                       onSuccessBlock:(void (^)(NSNumber *))successBlock
                                      andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

@end
