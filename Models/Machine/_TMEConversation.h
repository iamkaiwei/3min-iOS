// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEConversation.h instead.

#import <CoreData/CoreData.h>


extern const struct TMEConversationAttributes {
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *lastest_message;
} TMEConversationAttributes;

extern const struct TMEConversationRelationships {
	__unsafe_unretained NSString *product;
	__unsafe_unretained NSString *replies;
	__unsafe_unretained NSString *user;
} TMEConversationRelationships;

extern const struct TMEConversationFetchedProperties {
} TMEConversationFetchedProperties;

@class TMEProduct;
@class TMEReply;
@class TMEUser;




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





@property (nonatomic, strong) TMEProduct *product;

//- (BOOL)validateProduct:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *replies;

- (NSMutableSet*)repliesSet;




@property (nonatomic, strong) TMEUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





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





- (TMEProduct*)primitiveProduct;
- (void)setPrimitiveProduct:(TMEProduct*)value;



- (NSMutableSet*)primitiveReplies;
- (void)setPrimitiveReplies:(NSMutableSet*)value;



- (TMEUser*)primitiveUser;
- (void)setPrimitiveUser:(TMEUser*)value;


@end
