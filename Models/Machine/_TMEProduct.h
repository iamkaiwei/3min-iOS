// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEProduct.h instead.

#import <CoreData/CoreData.h>


extern const struct TMEProductAttributes {
	__unsafe_unretained NSString *details;
	__unsafe_unretained NSString *lastModify;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *productID;
	__unsafe_unretained NSString *publishDate;
} TMEProductAttributes;

extern const struct TMEProductRelationships {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *images;
	__unsafe_unretained NSString *user;
} TMEProductRelationships;

extern const struct TMEProductFetchedProperties {
} TMEProductFetchedProperties;

@class TMECategory;
@class TMEProductImages;
@class TMEUser;








@interface TMEProductID : NSManagedObjectID {}
@end

@interface _TMEProduct : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TMEProductID*)objectID;





@property (nonatomic, strong) NSString* details;



//- (BOOL)validateDetails:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* lastModify;



//- (BOOL)validateLastModify:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* price;



@property double priceValue;
- (double)priceValue;
- (void)setPriceValue:(double)value_;

//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* productID;



@property int64_t productIDValue;
- (int64_t)productIDValue;
- (void)setProductIDValue:(int64_t)value_;

//- (BOOL)validateProductID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* publishDate;



//- (BOOL)validatePublishDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) TMECategory *category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *images;

- (NSMutableSet*)imagesSet;




@property (nonatomic, strong) TMEUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _TMEProduct (CoreDataGeneratedAccessors)

- (void)addImages:(NSSet*)value_;
- (void)removeImages:(NSSet*)value_;
- (void)addImagesObject:(TMEProductImages*)value_;
- (void)removeImagesObject:(TMEProductImages*)value_;

@end

@interface _TMEProduct (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveDetails;
- (void)setPrimitiveDetails:(NSString*)value;




- (NSDate*)primitiveLastModify;
- (void)setPrimitiveLastModify:(NSDate*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSNumber*)value;

- (double)primitivePriceValue;
- (void)setPrimitivePriceValue:(double)value_;




- (NSNumber*)primitiveProductID;
- (void)setPrimitiveProductID:(NSNumber*)value;

- (int64_t)primitiveProductIDValue;
- (void)setPrimitiveProductIDValue:(int64_t)value_;




- (NSDate*)primitivePublishDate;
- (void)setPrimitivePublishDate:(NSDate*)value;





- (TMECategory*)primitiveCategory;
- (void)setPrimitiveCategory:(TMECategory*)value;



- (NSMutableSet*)primitiveImages;
- (void)setPrimitiveImages:(NSMutableSet*)value;



- (TMEUser*)primitiveUser;
- (void)setPrimitiveUser:(TMEUser*)value;


@end
