//
//  TMESubmitLoadingOperation.h
//  ThreeMin
//
//  Created by iSlan on 11/7/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMESubmitLoadingOperation : NSObject <KHLoadingOperationProtocol>

- (instancetype)initWithConversationID:(NSInteger)conversationID largerReplyID:(NSInteger)largerReplyID smallerReplyID:(NSInteger)smallerReplyID withPage:(NSInteger)page;

@end
