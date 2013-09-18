// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEUser.m instead.

#import "_TMEUser.h"

const struct TMEUserAttributes TMEUserAttributes = {
	.name = @"name",
	.userID = @"userID",
};

const struct TMEUserRelationships TMEUserRelationships = {
	.products = @"products",
};

const struct TMEUserFetchedProperties TMEUserFetchedProperties = {
};

@implementation TMEUserID
@end

@implementation _TMEUser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TMEUser" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TMEUser";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TMEUser" inManagedObjectContext:moc_];
}

- (TMEUserID*)objectID {
	return (TMEUserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"userIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"userID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic name;






@dynamic userID;



- (int64_t)userIDValue {
	NSNumber *result = [self userID];
	return [result longLongValue];
}

- (void)setUserIDValue:(int64_t)value_ {
	[self setUserID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveUserIDValue {
	NSNumber *result = [self primitiveUserID];
	return [result longLongValue];
}

- (void)setPrimitiveUserIDValue:(int64_t)value_ {
	[self setPrimitiveUserID:[NSNumber numberWithLongLong:value_]];
}





@dynamic products;

	
- (NSMutableSet*)productsSet {
	[self willAccessValueForKey:@"products"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"products"];
  
	[self didAccessValueForKey:@"products"];
	return result;
}
	






@end
