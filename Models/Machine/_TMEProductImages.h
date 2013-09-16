// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEProductImages.h instead.

#import <CoreData/CoreData.h>


extern const struct TMEProductImagesAttributes {
	__unsafe_unretained NSString *imageID;
	__unsafe_unretained NSString *url;
} TMEProductImagesAttributes;

extern const struct TMEProductImagesRelationships {
	__unsafe_unretained NSString *userID;
} TMEProductImagesRelationships;

extern const struct TMEProductImagesFetchedProperties {
} TMEProductImagesFetchedProperties;

@class TMEProduct;




@interface TMEProductImagesID : NSManagedObjectID {}
@end

@interface _TMEProductImages : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TMEProductImagesID*)objectID;





@property (nonatomic, strong) NSNumber* imageID;



@property int64_t imageIDValue;
- (int64_t)imageIDValue;
- (void)setImageIDValue:(int64_t)value_;

//- (BOOL)validateImageID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* url;



//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) TMEProduct *userID;

//- (BOOL)validateUserID:(id*)value_ error:(NSError**)error_;





@end

@interface _TMEProductImages (CoreDataGeneratedAccessors)

@end

@interface _TMEProductImages (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveImageID;
- (void)setPrimitiveImageID:(NSNumber*)value;

- (int64_t)primitiveImageIDValue;
- (void)setPrimitiveImageIDValue:(int64_t)value_;




- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;





- (TMEProduct*)primitiveUserID;
- (void)setPrimitiveUserID:(TMEProduct*)value;


@end
