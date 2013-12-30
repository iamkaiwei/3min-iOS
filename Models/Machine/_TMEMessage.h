// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEMessage.h instead.

#import <CoreData/CoreData.h>


extern const struct TMEMessageAttributes {
	__unsafe_unretained NSString *chat;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *meetup_place;
	__unsafe_unretained NSString *time_stamp;
} TMEMessageAttributes;

extern const struct TMEMessageRelationships {
	__unsafe_unretained NSString *from;
	__unsafe_unretained NSString *product;
	__unsafe_unretained NSString *to;
} TMEMessageRelationships;

extern const struct TMEMessageFetchedProperties {
} TMEMessageFetchedProperties;

@class TMEUser;
@class TMEProduct;
@class TMEUser;






@interface TMEMessageID : NSManagedObjectID {}
@end

@interface _TMEMessage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TMEMessageID*)objectID;





@property (nonatomic, strong) NSString* chat;



//- (BOOL)validateChat:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id;



@property int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* meetup_place;



//- (BOOL)validateMeetup_place:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* time_stamp;



//- (BOOL)validateTime_stamp:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) TMEUser *from;

//- (BOOL)validateFrom:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) TMEProduct *product;

//- (BOOL)validateProduct:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) TMEUser *to;

//- (BOOL)validateTo:(id*)value_ error:(NSError**)error_;





@end

@interface _TMEMessage (CoreDataGeneratedAccessors)

@end

@interface _TMEMessage (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveChat;
- (void)setPrimitiveChat:(NSString*)value;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;




- (NSString*)primitiveMeetup_place;
- (void)setPrimitiveMeetup_place:(NSString*)value;




- (NSDate*)primitiveTime_stamp;
- (void)setPrimitiveTime_stamp:(NSDate*)value;





- (TMEUser*)primitiveFrom;
- (void)setPrimitiveFrom:(TMEUser*)value;



- (TMEProduct*)primitiveProduct;
- (void)setPrimitiveProduct:(TMEProduct*)value;



- (TMEUser*)primitiveTo;
- (void)setPrimitiveTo:(TMEUser*)value;


@end
