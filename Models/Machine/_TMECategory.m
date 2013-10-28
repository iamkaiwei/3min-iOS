// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMECategory.m instead.

#import "_TMECategory.h"

const struct TMECategoryAttributes TMECategoryAttributes = {
	.details = @"details",
	.id = @"id",
	.name = @"name",
	.photo_url = @"photo_url",
};

const struct TMECategoryRelationships TMECategoryRelationships = {
	.products = @"products",
};

const struct TMECategoryFetchedProperties TMECategoryFetchedProperties = {
};

@implementation TMECategoryID
@end

@implementation _TMECategory

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TMECategory" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TMECategory";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TMECategory" inManagedObjectContext:moc_];
}

- (TMECategoryID*)objectID {
	return (TMECategoryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic details;






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





@dynamic name;






@dynamic photo_url;






@dynamic products;

	
- (NSMutableSet*)productsSet {
	[self willAccessValueForKey:@"products"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"products"];
  
	[self didAccessValueForKey:@"products"];
	return result;
}
	






@end
