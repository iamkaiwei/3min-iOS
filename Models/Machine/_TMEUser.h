// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEUser.h instead.

#import <CoreData/CoreData.h>


extern const struct TMEUserAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *userID;
} TMEUserAttributes;

extern const struct TMEUserRelationships {
	__unsafe_unretained NSString *products;
} TMEUserRelationships;

extern const struct TMEUserFetchedProperties {
} TMEUserFetchedProperties;

@class TMEProduct;




@interface TMEUserID : NSManagedObjectID {}
@end

@interface _TMEUser : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TMEUserID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* userID;



@property int64_t userIDValue;
- (int64_t)userIDValue;
- (void)setUserIDValue:(int64_t)value_;

//- (BOOL)validateUserID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *products;

- (NSMutableSet*)productsSet;





@end

@interface _TMEUser (CoreDataGeneratedAccessors)

- (void)addProducts:(NSSet*)value_;
- (void)removeProducts:(NSSet*)value_;
- (void)addProductsObject:(TMEProduct*)value_;
- (void)removeProductsObject:(TMEProduct*)value_;

@end

@interface _TMEUser (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveUserID;
- (void)setPrimitiveUserID:(NSNumber*)value;

- (int64_t)primitiveUserIDValue;
- (void)setPrimitiveUserIDValue:(int64_t)value_;





- (NSMutableSet*)primitiveProducts;
- (void)setPrimitiveProducts:(NSMutableSet*)value;


@end
