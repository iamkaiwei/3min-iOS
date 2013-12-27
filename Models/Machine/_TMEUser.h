// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEUser.h instead.

#import <CoreData/CoreData.h>


extern const struct TMEUserAttributes {
	__unsafe_unretained NSString *access_token;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *facebook_id;
	__unsafe_unretained NSString *fullname;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *password;
	__unsafe_unretained NSString *photo_url;
	__unsafe_unretained NSString *udid;
	__unsafe_unretained NSString *username;
} TMEUserAttributes;

extern const struct TMEUserRelationships {
	__unsafe_unretained NSString *fromTransactions;
	__unsafe_unretained NSString *products;
	__unsafe_unretained NSString *toTransactions;
} TMEUserRelationships;

extern const struct TMEUserFetchedProperties {
} TMEUserFetchedProperties;

@class TMEMessage;
@class TMEProduct;
@class TMEMessage;












@interface TMEUserID : NSManagedObjectID {}
@end

@interface _TMEUser : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TMEUserID*)objectID;





@property (nonatomic, strong) NSString* access_token;



//- (BOOL)validateAccess_token:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* email;



//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* facebook_id;



//- (BOOL)validateFacebook_id:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* fullname;



//- (BOOL)validateFullname:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id;



@property int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* password;



//- (BOOL)validatePassword:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* photo_url;



//- (BOOL)validatePhoto_url:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* udid;



//- (BOOL)validateUdid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* username;



//- (BOOL)validateUsername:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *fromTransactions;

- (NSMutableSet*)fromTransactionsSet;




@property (nonatomic, strong) NSSet *products;

- (NSMutableSet*)productsSet;




@property (nonatomic, strong) NSSet *toTransactions;

- (NSMutableSet*)toTransactionsSet;





@end

@interface _TMEUser (CoreDataGeneratedAccessors)

- (void)addFromTransactions:(NSSet*)value_;
- (void)removeFromTransactions:(NSSet*)value_;
- (void)addFromTransactionsObject:(TMEMessage*)value_;
- (void)removeFromTransactionsObject:(TMEMessage*)value_;

- (void)addProducts:(NSSet*)value_;
- (void)removeProducts:(NSSet*)value_;
- (void)addProductsObject:(TMEProduct*)value_;
- (void)removeProductsObject:(TMEProduct*)value_;

- (void)addToTransactions:(NSSet*)value_;
- (void)removeToTransactions:(NSSet*)value_;
- (void)addToTransactionsObject:(TMEMessage*)value_;
- (void)removeToTransactionsObject:(TMEMessage*)value_;

@end

@interface _TMEUser (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAccess_token;
- (void)setPrimitiveAccess_token:(NSString*)value;




- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveFacebook_id;
- (void)setPrimitiveFacebook_id:(NSString*)value;




- (NSString*)primitiveFullname;
- (void)setPrimitiveFullname:(NSString*)value;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitivePassword;
- (void)setPrimitivePassword:(NSString*)value;




- (NSString*)primitivePhoto_url;
- (void)setPrimitivePhoto_url:(NSString*)value;




- (NSString*)primitiveUdid;
- (void)setPrimitiveUdid:(NSString*)value;




- (NSString*)primitiveUsername;
- (void)setPrimitiveUsername:(NSString*)value;





- (NSMutableSet*)primitiveFromTransactions;
- (void)setPrimitiveFromTransactions:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProducts;
- (void)setPrimitiveProducts:(NSMutableSet*)value;



- (NSMutableSet*)primitiveToTransactions;
- (void)setPrimitiveToTransactions:(NSMutableSet*)value;


@end
