// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEReply.h instead.

#import <CoreData/CoreData.h>


extern const struct TMEReplyAttributes {
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *reply;
	__unsafe_unretained NSString *time_stamp;
	__unsafe_unretained NSString *user_id;
} TMEReplyAttributes;

extern const struct TMEReplyRelationships {
	__unsafe_unretained NSString *conversation;
} TMEReplyRelationships;

extern const struct TMEReplyFetchedProperties {
} TMEReplyFetchedProperties;

@class TMEConversation;






@interface TMEReplyID : NSManagedObjectID {}
@end

@interface _TMEReply : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TMEReplyID*)objectID;





@property (nonatomic, strong) NSNumber* id;



@property int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* reply;



//- (BOOL)validateReply:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* time_stamp;



//- (BOOL)validateTime_stamp:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* user_id;



@property int64_t user_idValue;
- (int64_t)user_idValue;
- (void)setUser_idValue:(int64_t)value_;

//- (BOOL)validateUser_id:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) TMEConversation *conversation;

//- (BOOL)validateConversation:(id*)value_ error:(NSError**)error_;





@end

@interface _TMEReply (CoreDataGeneratedAccessors)

@end

@interface _TMEReply (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;




- (NSString*)primitiveReply;
- (void)setPrimitiveReply:(NSString*)value;




- (NSDate*)primitiveTime_stamp;
- (void)setPrimitiveTime_stamp:(NSDate*)value;




- (NSNumber*)primitiveUser_id;
- (void)setPrimitiveUser_id:(NSNumber*)value;

- (int64_t)primitiveUser_idValue;
- (void)setPrimitiveUser_idValue:(int64_t)value_;





- (TMEConversation*)primitiveConversation;
- (void)setPrimitiveConversation:(TMEConversation*)value;


@end
