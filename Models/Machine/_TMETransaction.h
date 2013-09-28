// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMETransaction.h instead.

#import <CoreData/CoreData.h>


extern const struct TMETransactionAttributes {
	__unsafe_unretained NSString *chat;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *meetup_place;
} TMETransactionAttributes;

extern const struct TMETransactionRelationships {
	__unsafe_unretained NSString *buyer;
	__unsafe_unretained NSString *product;
	__unsafe_unretained NSString *seller;
} TMETransactionRelationships;

extern const struct TMETransactionFetchedProperties {
} TMETransactionFetchedProperties;

@class TMEUser;
@class TMEProduct;
@class TMEUser;





@interface TMETransactionID : NSManagedObjectID {}
@end

@interface _TMETransaction : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TMETransactionID*)objectID;





@property (nonatomic, strong) NSString* chat;



//- (BOOL)validateChat:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id;



@property int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* meetup_place;



//- (BOOL)validateMeetup_place:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) TMEUser *buyer;

//- (BOOL)validateBuyer:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) TMEProduct *product;

//- (BOOL)validateProduct:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) TMEUser *seller;

//- (BOOL)validateSeller:(id*)value_ error:(NSError**)error_;





@end

@interface _TMETransaction (CoreDataGeneratedAccessors)

@end

@interface _TMETransaction (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveChat;
- (void)setPrimitiveChat:(NSString*)value;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;




- (NSString*)primitiveMeetup_place;
- (void)setPrimitiveMeetup_place:(NSString*)value;





- (TMEUser*)primitiveBuyer;
- (void)setPrimitiveBuyer:(TMEUser*)value;



- (TMEProduct*)primitiveProduct;
- (void)setPrimitiveProduct:(TMEProduct*)value;



- (TMEUser*)primitiveSeller;
- (void)setPrimitiveSeller:(TMEUser*)value;


@end