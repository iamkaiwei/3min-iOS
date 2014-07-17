// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEActivity.h instead.

#import <CoreData/CoreData.h>


extern const struct TMEActivityAttributes {
	__unsafe_unretained NSString *content;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *subject_id;
	__unsafe_unretained NSString *subject_type;
	__unsafe_unretained NSString *update_time;
} TMEActivityAttributes;

extern const struct TMEActivityRelationships {
	__unsafe_unretained NSString *user;
} TMEActivityRelationships;

extern const struct TMEActivityFetchedProperties {
} TMEActivityFetchedProperties;

@class TMEUser;







@interface TMEActivityID : NSManagedObjectID {}
@end

@interface _TMEActivity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TMEActivityID*)objectID;





@property (nonatomic, strong) NSString* content;



//- (BOOL)validateContent:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id;



@property int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* subject_id;



@property int64_t subject_idValue;
- (int64_t)subject_idValue;
- (void)setSubject_idValue:(int64_t)value_;

//- (BOOL)validateSubject_id:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* subject_type;



//- (BOOL)validateSubject_type:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* update_time;



//- (BOOL)validateUpdate_time:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) TMEUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _TMEActivity (CoreDataGeneratedAccessors)

@end

@interface _TMEActivity (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveContent;
- (void)setPrimitiveContent:(NSString*)value;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;




- (NSNumber*)primitiveSubject_id;
- (void)setPrimitiveSubject_id:(NSNumber*)value;

- (int64_t)primitiveSubject_idValue;
- (void)setPrimitiveSubject_idValue:(int64_t)value_;




- (NSString*)primitiveSubject_type;
- (void)setPrimitiveSubject_type:(NSString*)value;




- (NSDate*)primitiveUpdate_time;
- (void)setPrimitiveUpdate_time:(NSDate*)value;





- (TMEUser*)primitiveUser;
- (void)setPrimitiveUser:(TMEUser*)value;


@end
