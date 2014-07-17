// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMECategory.h instead.

#import <CoreData/CoreData.h>


extern const struct TMECategoryAttributes {
	__unsafe_unretained NSString *details;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *photo_url;
} TMECategoryAttributes;

extern const struct TMECategoryRelationships {
	__unsafe_unretained NSString *products;
} TMECategoryRelationships;

extern const struct TMECategoryFetchedProperties {
} TMECategoryFetchedProperties;

@class TMEProduct;






@interface TMECategoryID : NSManagedObjectID {}
@end

@interface _TMECategory : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TMECategoryID*)objectID;





@property (nonatomic, strong) NSString* details;



//- (BOOL)validateDetails:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id;



@property int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* photo_url;



//- (BOOL)validatePhoto_url:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *products;

- (NSMutableSet*)productsSet;





@end

@interface _TMECategory (CoreDataGeneratedAccessors)

- (void)addProducts:(NSSet*)value_;
- (void)removeProducts:(NSSet*)value_;
- (void)addProductsObject:(TMEProduct*)value_;
- (void)removeProductsObject:(TMEProduct*)value_;

@end

@interface _TMECategory (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveDetails;
- (void)setPrimitiveDetails:(NSString*)value;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitivePhoto_url;
- (void)setPrimitivePhoto_url:(NSString*)value;





- (NSMutableSet*)primitiveProducts;
- (void)setPrimitiveProducts:(NSMutableSet*)value;


@end
