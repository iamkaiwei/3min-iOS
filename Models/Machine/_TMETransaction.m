// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMETransaction.m instead.

#import "_TMETransaction.h"

const struct TMETransactionAttributes TMETransactionAttributes = {
	.chat = @"chat",
	.id = @"id",
	.meetup_place = @"meetup_place",
	.time_stamp = @"time_stamp",
};

const struct TMETransactionRelationships TMETransactionRelationships = {
	.buyer = @"buyer",
	.product = @"product",
};

const struct TMETransactionFetchedProperties TMETransactionFetchedProperties = {
};

@implementation TMETransactionID
@end

@implementation _TMETransaction

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TMETransaction" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TMETransaction";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TMETransaction" inManagedObjectContext:moc_];
}

- (TMETransactionID*)objectID {
	return (TMETransactionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"time_stampValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"time_stamp"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic chat;






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





@dynamic meetup_place;






@dynamic time_stamp;



- (int64_t)time_stampValue {
	NSNumber *result = [self time_stamp];
	return [result longLongValue];
}

- (void)setTime_stampValue:(int64_t)value_ {
	[self setTime_stamp:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveTime_stampValue {
	NSNumber *result = [self primitiveTime_stamp];
	return [result longLongValue];
}

- (void)setPrimitiveTime_stampValue:(int64_t)value_ {
	[self setPrimitiveTime_stamp:[NSNumber numberWithLongLong:value_]];
}





@dynamic buyer;

	

@dynamic product;

	






@end
