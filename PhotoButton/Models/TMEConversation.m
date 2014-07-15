#import "TMEConversation.h"


@interface TMEConversation ()

// Private interface goes here.

@end


@implementation TMEConversation

// Custom logic goes here.

+ (NSArray *)arrayConversationFromArrayData:(NSArray *)arrayData{
    NSMutableArray *arrayConversation = [@[] mutableCopy];
    for (NSDictionary *data in arrayData) {
        TMEConversation *conversation = [TMEConversation conversationFromData:data];
        if (conversation) {
            [arrayConversation addObject:conversation];
        }
    }
    
    NSManagedObjectContext *mainContext  = [NSManagedObjectContext MR_defaultContext];
    [mainContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        DLog(@"Finish save to magical record");
    }];
    
    return arrayConversation;
}

+ (TMEConversation *)conversationFromData:(NSDictionary *)data{
    TMEConversation *conversation = [[TMEConversation MR_findByAttribute:@"id" withValue:data[@"id"]] lastObject];
    
    if (!conversation) {
        conversation = [TMEConversation MR_createEntity];
        conversation.id = data[@"id"];
        
        conversation.user_id = data[@"user"][@"id"];

        if (data[@"product"] && ![data[@"product"] isKindOfClass:[NSNull class]]) {
            NSDictionary *dataProduct = data[@"product"];
            TMEProduct *product = [TMEProduct modelWithDictionary:dataProduct error:nil];
            conversation.product = product;
        }
        else{
#warning NEED CHECKOUT HERE
//            TMEProduct *product = [[TMEProduct MR_findByAttribute:@"id" withValue:data[@"product_id"]] lastObject];
//            conversation.product = product;
        }
    }

    conversation.user_full_name = data[@"user"][@"full_name"];

    if (data[@"channel_name"] && ![data[@"channel_name"] isKindOfClass:[NSNull class]]) {
        conversation.channel_name = data[@"channel_name"];
    }

    if (![data[@"user"][@"facebook_avatar"] isKindOfClass:[NSNull class]]) {
        conversation.user_avatar = data[@"user"][@"facebook_avatar"];
    }
    
    if (data[@"replies"] && ![data[@"replies"] isKindOfClass:[NSNull class]]) {
        NSArray *arrayReplies = [TMEReply arrayRepliesFromArrayData:data[@"replies"] ofConversation:conversation];
        [conversation.repliesSet addObjectsFromArray:arrayReplies];
    }
    
    if (data[@"latest_message"] && ![data[@"latest_message"] isKindOfClass:[NSNull class]]) {
        conversation.latest_message = data[@"latest_message"];
    }
    
    if (data[@"latest_update"] && ![data[@"latest_update"] isKindOfClass:[NSNull class]]) {
        conversation.latest_update = [NSDate dateWithTimeIntervalSince1970:[data[@"latest_update"] doubleValue]];
    }
    
    conversation.offer = @0;
    if (data[@"offer"] && ![data[@"offer"] isKindOfClass:[NSNull class]]) {
        conversation.offer = data[@"offer"];
    }
    
    if (!conversation.user_full_name && !conversation.user_avatar && !conversation.product) {
        return nil;
    }
    
    return conversation;
}

+ (TMEConversation *)aConversationFromData:(NSDictionary *)data{
    TMEConversation *conversation = [TMEConversation conversationFromData:data];
    NSManagedObjectContext *mainContext  = [NSManagedObjectContext MR_defaultContext];
    [mainContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        DLog(@"Finish save to magical record");
    }];
    return conversation;
}

+ (NSArray *)arrayConversationFromOfferArrayData:(NSArray *)arrayData{
    NSMutableArray *arrayConversation = [@[] mutableCopy];
    for (NSDictionary *data in arrayData) {
        TMEConversation *conversation = [TMEConversation conversationFromOfferData:data];
        if (![conversation.offer isEqualToNumber:@0] && ![conversation.offer isEqual:[NSNull null]]) {
            [arrayConversation addObject:conversation];
        }
    }
    
    NSManagedObjectContext *mainContext  = [NSManagedObjectContext MR_defaultContext];
    [mainContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        DLog(@"Finish save to magical record");
    }];
    
    return arrayConversation;
}

+ (TMEConversation *)conversationFromOfferData:(NSDictionary *)data{
    TMEConversation *conversation = [[TMEConversation MR_findByAttribute:@"id" withValue:data[@"conversation_id"]] lastObject];
    
    if (!conversation) {
        conversation = [TMEConversation MR_createEntity];
        conversation.id = data[@"conversation_id"];
        
        conversation.user_id = data[@"owner"][@"id"];
        TMEProduct *product = [TMEProduct modelWithDictionary:data error:nil];
        conversation.product = product;
    }
    
    conversation.user_full_name = data[@"owner"][@"full_name"];
    
    if (![data[@"owner"][@"facebook_avatar"] isKindOfClass:[NSNull class]]) {
        conversation.user_avatar = data[@"owner"][@"facebook_avatar"];
    }
    
    if (data[@"offer"] && ![data[@"offer"] isKindOfClass:[NSNull class]]) {
        conversation.offer = data[@"offer"];
    }

    if (data[@"channel_name"] && ![data[@"channel_name"] isKindOfClass:[NSNull class]]) {
        conversation.channel_name = data[@"channel_name"];
    }

    return conversation;
}

@end

