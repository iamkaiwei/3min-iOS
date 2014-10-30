#import "MTLModel.h"
#import "TMEConversation.h"

@interface TMEReply : TMEBaseModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber* replyID;
@property (nonatomic, strong) NSString* reply;
@property (nonatomic, strong) NSDate* timeStamp;
@property (nonatomic, strong) NSString* userAvatar;
@property (nonatomic, strong) NSString* userFullName;
@property (nonatomic, strong) NSNumber* userID;
@property (nonatomic, weak) TMEConversation *conversation;

@end
