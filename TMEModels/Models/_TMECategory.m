// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMECategory.m instead.

#import "_TMECategory.h"

const struct TMECategoryAttributes TMECategoryAttributes = {
	.categoryID = @"categoryID",
	.name = @"name",
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
	
	if ([key isEqualToString:@"categoryIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"categoryID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic categoryID;



- (int64_t)categoryIDValue {
	NSNumber *result = [self categoryID];
	return [result longLongValue];
}

- (void)setCategoryIDValue:(int64_t)value_ {
	[self setCategoryID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveCategoryIDValue {
	NSNumber *result = [self primitiveCategoryID];
	return [result longLongValue];
}

- (void)setPrimitiveCategoryIDValue:(int64_t)value_ {
	[self setPrimitiveCategoryID:[NSNumber numberWithLongLong:value_]];
}





@dynamic name;






@dynamic products;

	
- (NSMutableSet*)productsSet {
	[self willAccessValueForKey:@"products"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"products"];
  
	[self didAccessValueForKey:@"products"];
	return result;
}
	






@end
