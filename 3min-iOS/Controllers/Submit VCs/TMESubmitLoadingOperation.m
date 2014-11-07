//
//  TMESubmitLoadingOperation.m
//  ThreeMin
//
//  Created by iSlan on 11/7/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMESubmitLoadingOperation.h"

@interface TMESubmitLoadingOperation ()

@property (assign, nonatomic) NSInteger conversationID;
@property (assign, nonatomic) NSInteger largerReplyID;
@property (assign, nonatomic) NSInteger smallerReplyID;
@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSArray *dataPage;

@end

@implementation TMESubmitLoadingOperation

- (instancetype)initWithConversationID:(NSInteger)conversationID largerReplyID:(NSInteger)largerReplyID smallerReplyID:(NSInteger)smallerReplyID withPage:(NSInteger)page {
    if (self = [super init]) {
        _conversationID = conversationID;
        _largerReplyID = largerReplyID;
        _smallerReplyID = smallerReplyID;
        _page = page;
    }
    return self;
}

- (void)loadData:(void (^)(NSArray *, NSError *))finishBlock
{
    __weak __typeof (self) weakSelf = self;
    [TMEConversationManager getRepliesOfConversationID:self.conversationID
                                         largerReplyID:self.largerReplyID
                                        smallerReplyID:self.smallerReplyID
                                              withPage:self.page
                                        onSuccessBlock:^(TMEConversation *conversation)
     {
         weakSelf.dataPage = conversation.replies;
         if (finishBlock) {
             finishBlock(weakSelf.dataPage, nil);
         }
     }
                                          failureBlock:^(NSError *error)
     {
         if (finishBlock) {
             finishBlock(nil, error);
         }
     }];
}

@end
