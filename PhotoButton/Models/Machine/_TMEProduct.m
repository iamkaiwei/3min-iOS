// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEProduct.m instead.

#import "_TMEProduct.h"

const struct TMEProductAttributes TMEProductAttributes = {
	.comments = @"comments",
	.created_at = @"created_at",
	.description_product = @"description_product",
	.details = @"details",
	.dislikes = @"dislikes",
	.id = @"id",
	.liked = @"liked",
	.likes = @"likes",
	.name = @"name",
	.price = @"price",
	.sold_out = @"sold_out",
	.updated_at = @"updated_at",
	.venue_id = @"venue_id",
	.venue_lat = @"venue_lat",
	.venue_long = @"venue_long",
	.venue_name = @"venue_name",
};

const struct TMEProductRelationships TMEProductRelationships = {
	.category = @"category",
	.conversation = @"conversation",
	.images = @"images",
	.user = @"user",
};

const struct TMEProductFetchedProperties TMEProductFetchedProperties = {
};

@implementation TMEProductID
@end

@implementation _TMEProduct

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TMEProduct" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TMEProduct";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TMEProduct" inManagedObjectContext:moc_];
}

- (TMEProductID*)objectID {
	return (TMEProductID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"dislikesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"dislikes"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"likedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"liked"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"likesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"likes"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"sold_outValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sold_out"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"venue_latValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"venue_lat"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"venue_longValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"venue_long"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic comments;






@dynamic created_at;






@dynamic description_product;






@dynamic details;






@dynamic dislikes;



- (int64_t)dislikesValue {
	NSNumber *result = [self dislikes];
	return [result longLongValue];
}

- (void)setDislikesValue:(int64_t)value_ {
	[self setDislikes:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveDislikesValue {
	NSNumber *result = [self primitiveDislikes];
	return [result longLongValue];
}

- (void)setPrimitiveDislikesValue:(int64_t)value_ {
	[self setPrimitiveDislikes:[NSNumber numberWithLongLong:value_]];
}





@dynamic id;



- (int64_t)idValue {
	NSNumber *result = [self id];
	return [result longLongValue];
}

- (void)setIdValue:(int64_t)value_ {
	[self setId:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result longLongValue];
}

- (void)setPrimitiveIdValue:(int64_t)value_ {
	[self setPrimitiveId:[NSNumber numberWithLongLong:value_]];
}





@dynamic liked;



- (BOOL)likedValue {
	NSNumber *result = [self liked];
	return [result boolValue];
}

- (void)setLikedValue:(BOOL)value_ {
	[self setLiked:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveLikedValue {
	NSNumber *result = [self primitiveLiked];
	return [result boolValue];
}

- (void)setPrimitiveLikedValue:(BOOL)value_ {
	[self setPrimitiveLiked:[NSNumber numberWithBool:value_]];
}





@dynamic likes;



- (int64_t)likesValue {
	NSNumber *result = [self likes];
	return [result longLongValue];
}

- (void)setLikesValue:(int64_t)value_ {
	[self setLikes:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveLikesValue {
	NSNumber *result = [self primitiveLikes];
	return [result longLongValue];
}

- (void)setPrimitiveLikesValue:(int64_t)value_ {
	[self setPrimitiveLikes:[NSNumber numberWithLongLong:value_]];
}





@dynamic name;






@dynamic price;



- (double)priceValue {
	NSNumber *result = [self price];
	return [result doubleValue];
}

- (void)setPriceValue:(double)value_ {
	[self setPrice:[NSNumber numberWithDouble:value_]];
}

- (double)primitivePriceValue {
	NSNumber *result = [self primitivePrice];
	return [result doubleValue];
}

- (void)setPrimitivePriceValue:(double)value_ {
	[self setPrimitivePrice:[NSNumber numberWithDouble:value_]];
}





@dynamic sold_out;



- (BOOL)sold_outValue {
	NSNumber *result = [self sold_out];
	return [result boolValue];
}

- (void)setSold_outValue:(BOOL)value_ {
	[self setSold_out:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveSold_outValue {
	NSNumber *result = [self primitiveSold_out];
	return [result boolValue];
}

- (void)setPrimitiveSold_outValue:(BOOL)value_ {
	[self setPrimitiveSold_out:[NSNumber numberWithBool:value_]];
}





@dynamic updated_at;






@dynamic venue_id;






@dynamic venue_lat;



- (double)venue_latValue {
	NSNumber *result = [self venue_lat];
	return [result doubleValue];
}

- (void)setVenue_latValue:(double)value_ {
	[self setVenue_lat:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveVenue_latValue {
	NSNumber *result = [self primitiveVenue_lat];
	return [result doubleValue];
}

- (void)setPrimitiveVenue_latValue:(double)value_ {
	[self setPrimitiveVenue_lat:[NSNumber numberWithDouble:value_]];
}





@dynamic venue_long;



- (double)venue_longValue {
	NSNumber *result = [self venue_long];
	return [result doubleValue];
}

- (void)setVenue_longValue:(double)value_ {
	[self setVenue_long:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveVenue_longValue {
	NSNumber *result = [self primitiveVenue_long];
	return [result doubleValue];
}

- (void)setPrimitiveVenue_longValue:(double)value_ {
	[self setPrimitiveVenue_long:[NSNumber numberWithDouble:value_]];
}





@dynamic venue_name;






@dynamic category;

	

@dynamic conversation;

	
- (NSMutableSet*)conversationSet {
	[self willAccessValueForKey:@"conversation"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"conversation"];
  
	[self didAccessValueForKey:@"conversation"];
	return result;
}
	

@dynamic images;

	
- (NSMutableSet*)imagesSet {
	[self willAccessValueForKey:@"images"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"images"];
  
	[self didAccessValueForKey:@"images"];
	return result;
}
	

@dynamic user;

	






@end
