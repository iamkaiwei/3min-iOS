// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEProductImages.h instead.

#import <CoreData/CoreData.h>


extern const struct TMEProductImagesAttributes {
	__unsafe_unretained NSString *imageID;
	__unsafe_unretained NSString *medium;
	__unsafe_unretained NSString *origin;
	__unsafe_unretained NSString *small;
	__unsafe_unretained NSString *thumb;
	__unsafe_unretained NSString *update_at;
} TMEProductImagesAttributes;

extern const struct TMEProductImagesRelationships {
	__unsafe_unretained NSString *product;
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





@property (nonatomic, strong) NSString* medium;



//- (BOOL)validateMedium:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* origin;



//- (BOOL)validateOrigin:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* small;



//- (BOOL)validateSmall:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* thumb;



//- (BOOL)validateThumb:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* update_at;



//- (BOOL)validateUpdate_at:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) TMEProduct *product;

//- (BOOL)validateProduct:(id*)value_ error:(NSError**)error_;





@end

@interface _TMEProductImages (CoreDataGeneratedAccessors)

@end

@interface _TMEProductImages (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveImageID;
- (void)setPrimitiveImageID:(NSNumber*)value;

- (int64_t)primitiveImageIDValue;
- (void)setPrimitiveImageIDValue:(int64_t)value_;




- (NSString*)primitiveMedium;
- (void)setPrimitiveMedium:(NSString*)value;




- (NSString*)primitiveOrigin;
- (void)setPrimitiveOrigin:(NSString*)value;




- (NSString*)primitiveSmall;
- (void)setPrimitiveSmall:(NSString*)value;




- (NSString*)primitiveThumb;
- (void)setPrimitiveThumb:(NSString*)value;




- (NSDate*)primitiveUpdate_at;
- (void)setPrimitiveUpdate_at:(NSDate*)value;





- (TMEProduct*)primitiveProduct;
- (void)setPrimitiveProduct:(TMEProduct*)value;


@end
