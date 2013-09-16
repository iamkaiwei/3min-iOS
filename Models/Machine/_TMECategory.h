// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMECategory.h instead.

#import <CoreData/CoreData.h>


extern const struct TMECategoryAttributes {
	__unsafe_unretained NSString *categoryID;
	__unsafe_unretained NSString *name;
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





@property (nonatomic, strong) NSNumber* categoryID;



@property int64_t categoryIDValue;
- (int64_t)categoryIDValue;
- (void)setCategoryIDValue:(int64_t)value_;

//- (BOOL)validateCategoryID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





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


- (NSNumber*)primitiveCategoryID;
- (void)setPrimitiveCategoryID:(NSNumber*)value;

- (int64_t)primitiveCategoryIDValue;
- (void)setPrimitiveCategoryIDValue:(int64_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveProducts;
- (void)setPrimitiveProducts:(NSMutableSet*)value;


@end
