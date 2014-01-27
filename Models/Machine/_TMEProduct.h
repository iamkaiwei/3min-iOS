// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEProduct.h instead.

#import <CoreData/CoreData.h>


extern const struct TMEProductAttributes {
	__unsafe_unretained NSString *comments;
	__unsafe_unretained NSString *created_at;
	__unsafe_unretained NSString *details;
	__unsafe_unretained NSString *dislikes;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *liked;
	__unsafe_unretained NSString *likes;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *sold_out;
	__unsafe_unretained NSString *updated_at;
} TMEProductAttributes;

extern const struct TMEProductRelationships {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *conversation;
	__unsafe_unretained NSString *images;
	__unsafe_unretained NSString *user;
} TMEProductRelationships;

extern const struct TMEProductFetchedProperties {
} TMEProductFetchedProperties;

@class TMECategory;
@class TMEConversation;
@class TMEProductImages;
@class TMEUser;













@interface TMEProductID : NSManagedObjectID {}
@end

@interface _TMEProduct : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TMEProductID*)objectID;





@property (nonatomic, strong) NSString* comments;



//- (BOOL)validateComments:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* created_at;



//- (BOOL)validateCreated_at:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* details;



//- (BOOL)validateDetails:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* dislikes;



@property int64_t dislikesValue;
- (int64_t)dislikesValue;
- (void)setDislikesValue:(int64_t)value_;

//- (BOOL)validateDislikes:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id;



@property int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* liked;



@property BOOL likedValue;
- (BOOL)likedValue;
- (void)setLikedValue:(BOOL)value_;

//- (BOOL)validateLiked:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* likes;



@property int64_t likesValue;
- (int64_t)likesValue;
- (void)setLikesValue:(int64_t)value_;

//- (BOOL)validateLikes:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* price;



@property double priceValue;
- (double)priceValue;
- (void)setPriceValue:(double)value_;

//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* sold_out;



@property BOOL sold_outValue;
- (BOOL)sold_outValue;
- (void)setSold_outValue:(BOOL)value_;

//- (BOOL)validateSold_out:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* updated_at;



//- (BOOL)validateUpdated_at:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) TMECategory *category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *conversation;

- (NSMutableSet*)conversationSet;




@property (nonatomic, strong) NSSet *images;

- (NSMutableSet*)imagesSet;




@property (nonatomic, strong) TMEUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _TMEProduct (CoreDataGeneratedAccessors)

- (void)addConversation:(NSSet*)value_;
- (void)removeConversation:(NSSet*)value_;
- (void)addConversationObject:(TMEConversation*)value_;
- (void)removeConversationObject:(TMEConversation*)value_;

- (void)addImages:(NSSet*)value_;
- (void)removeImages:(NSSet*)value_;
- (void)addImagesObject:(TMEProductImages*)value_;
- (void)removeImagesObject:(TMEProductImages*)value_;

@end

@interface _TMEProduct (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveComments;
- (void)setPrimitiveComments:(NSString*)value;




- (NSDate*)primitiveCreated_at;
- (void)setPrimitiveCreated_at:(NSDate*)value;




- (NSString*)primitiveDetails;
- (void)setPrimitiveDetails:(NSString*)value;




- (NSNumber*)primitiveDislikes;
- (void)setPrimitiveDislikes:(NSNumber*)value;

- (int64_t)primitiveDislikesValue;
- (void)setPrimitiveDislikesValue:(int64_t)value_;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;




- (NSNumber*)primitiveLiked;
- (void)setPrimitiveLiked:(NSNumber*)value;

- (BOOL)primitiveLikedValue;
- (void)setPrimitiveLikedValue:(BOOL)value_;




- (NSNumber*)primitiveLikes;
- (void)setPrimitiveLikes:(NSNumber*)value;

- (int64_t)primitiveLikesValue;
- (void)setPrimitiveLikesValue:(int64_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSNumber*)value;

- (double)primitivePriceValue;
- (void)setPrimitivePriceValue:(double)value_;




- (NSNumber*)primitiveSold_out;
- (void)setPrimitiveSold_out:(NSNumber*)value;

- (BOOL)primitiveSold_outValue;
- (void)setPrimitiveSold_outValue:(BOOL)value_;




- (NSDate*)primitiveUpdated_at;
- (void)setPrimitiveUpdated_at:(NSDate*)value;





- (TMECategory*)primitiveCategory;
- (void)setPrimitiveCategory:(TMECategory*)value;



- (NSMutableSet*)primitiveConversation;
- (void)setPrimitiveConversation:(NSMutableSet*)value;



- (NSMutableSet*)primitiveImages;
- (void)setPrimitiveImages:(NSMutableSet*)value;



- (TMEUser*)primitiveUser;
- (void)setPrimitiveUser:(TMEUser*)value;


@end
