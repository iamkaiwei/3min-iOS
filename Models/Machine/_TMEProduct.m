// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEProduct.m instead.

#import "_TMEProduct.h"

const struct TMEProductAttributes TMEProductAttributes = {
	.details = @"details",
	.lastModify = @"lastModify",
	.name = @"name",
	.price = @"price",
	.productID = @"productID",
	.publishDate = @"publishDate",
};

const struct TMEProductRelationships TMEProductRelationships = {
	.category = @"category",
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
	
	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"productIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"productID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic details;






@dynamic lastModify;






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





@dynamic productID;



- (int64_t)productIDValue {
	NSNumber *result = [self productID];
	return [result longLongValue];
}

- (void)setProductIDValue:(int64_t)value_ {
	[self setProductID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveProductIDValue {
	NSNumber *result = [self primitiveProductID];
	return [result longLongValue];
}

- (void)setPrimitiveProductIDValue:(int64_t)value_ {
	[self setPrimitiveProductID:[NSNumber numberWithLongLong:value_]];
}





@dynamic publishDate;






@dynamic category;

	

@dynamic images;

	
- (NSMutableSet*)imagesSet {
	[self willAccessValueForKey:@"images"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"images"];
  
	[self didAccessValueForKey:@"images"];
	return result;
}
	

@dynamic user;

	






@end
