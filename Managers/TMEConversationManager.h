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

- (void)postMessageTo:(TMEUser *)user
           forProduct:(TMEProduct *)product
          withMessage:(NSString *)messageContent
       onSuccessBlock:(void (^)(NSString *))successBlock
      andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

- (void)getListConversationWithPage:(NSInteger)page
                     onSuccessBlock:(void (^)(NSArray *))successBlock
                    andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

@end
