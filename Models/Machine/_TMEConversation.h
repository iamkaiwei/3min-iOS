// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEConversation.h instead.

#import <CoreData/CoreData.h>


extern const struct TMEConversationAttributes {
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *lastest_message;
	__unsafe_unretained NSString *lastest_update;
	__unsafe_unretained NSString *user_avatar;
	__unsafe_unretained NSString *user_full_name;
	__unsafe_unretained NSString *user_id;
} TMEConversationAttributes;

extern const struct TMEConversationRelationships {
	__unsafe_unretained NSString *product;
	__unsafe_unretained NSString *replies;
} TMEConversationRelationships;

extern const struct TMEConversationFetchedProperties {
} TMEConversationFetchedProperties;

@class TMEProduct;
@class TMEReply;








@interface TMEConversationID : NSManagedObjectID {}
@end

@interface _TMEConversation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TMEConversationID*)objectID;





@property (nonatomic, strong) NSNumber* id;



@property int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* lastest_message;



//- (BOOL)validateLastest_message:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* lastest_update;



//- (BOOL)validateLastest_update:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* user_avatar;



//- (BOOL)validateUser_avatar:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* user_full_name;



//- (BOOL)validateUser_full_name:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* user_id;



@property int64_t user_idValue;
- (int64_t)user_idValue;
- (void)setUser_idValue:(int64_t)value_;

//- (BOOL)validateUser_id:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) TMEProduct *product;

//- (BOOL)validateProduct:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *replies;

- (NSMutableSet*)repliesSet;





@end

@interface _TMEConversation (CoreDataGeneratedAccessors)

- (void)addReplies:(NSSet*)value_;
- (void)removeReplies:(NSSet*)value_;
- (void)addRepliesObject:(TMEReply*)value_;
- (void)removeRepliesObject:(TMEReply*)value_;

@end

@interface _TMEConversation (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;




- (NSString*)primitiveLastest_message;
- (void)setPrimitiveLastest_message:(NSString*)value;




- (NSDate*)primitiveLastest_update;
- (void)setPrimitiveLastest_update:(NSDate*)value;




- (NSString*)primitiveUser_avatar;
- (void)setPrimitiveUser_avatar:(NSString*)value;




- (NSString*)primitiveUser_full_name;
- (void)setPrimitiveUser_full_name:(NSString*)value;




- (NSNumber*)primitiveUser_id;
- (void)setPrimitiveUser_id:(NSNumber*)value;

- (int64_t)primitiveUser_idValue;
- (void)setPrimitiveUser_idValue:(int64_t)value_;





- (TMEProduct*)primitiveProduct;
- (void)setPrimitiveProduct:(TMEProduct*)value;



- (NSMutableSet*)primitiveReplies;
- (void)setPrimitiveReplies:(NSMutableSet*)value;


@end
