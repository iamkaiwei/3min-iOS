//
//  TMEConversation+BackwardSupport.h
//  ThreeMin
//
//  Created by Triệu Khang on 20/7/14.
//  Copyright (c) 2014 3min. All rights reserved.
//



@interface TMEConversation (BackwardSupport)

- (NSNumber *)user_id;

+ (NSArray *)arrayConversationFromArrayData:(NSArray *)arrayData;
+ (NSArray *)arrayConversationFromOfferArrayData:(NSArray *)arrayData;
+ (TMEConversation *)conversationFromData:(NSDictionary *)data;

@end
