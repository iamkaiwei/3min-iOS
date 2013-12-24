// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEUser.m instead.

#import "_TMEUser.h"

const struct TMEUserAttributes TMEUserAttributes = {
	.access_token = @"access_token",
	.email = @"email",
	.facebook_id = @"facebook_id",
	.fullname = @"fullname",
	.id = @"id",
	.name = @"name",
	.password = @"password",
	.photo_url = @"photo_url",
	.udid = @"udid",
	.username = @"username",
};

const struct TMEUserRelationships TMEUserRelationships = {
	.fromTransactions = @"fromTransactions",
	.products = @"products",
	.toTransactions = @"toTransactions",
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
	
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic access_token;






@dynamic email;






@dynamic facebook_id;






@dynamic fullname;






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






@dynamic password;






@dynamic photo_url;






@dynamic udid;






@dynamic username;






@dynamic fromTransactions;

	
- (NSMutableSet*)fromTransactionsSet {
	[self willAccessValueForKey:@"fromTransactions"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"fromTransactions"];
  
	[self didAccessValueForKey:@"fromTransactions"];
	return result;
}
	

@dynamic products;

	
- (NSMutableSet*)productsSet {
	[self willAccessValueForKey:@"products"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"products"];
  
	[self didAccessValueForKey:@"products"];
	return result;
}
	

@dynamic toTransactions;

	
- (NSMutableSet*)toTransactionsSet {
	[self willAccessValueForKey:@"toTransactions"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"toTransactions"];
  
	[self didAccessValueForKey:@"toTransactions"];
	return result;
}
	






@end
