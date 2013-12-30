// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEMessage.m instead.

#import "_TMEMessage.h"

const struct TMEMessageAttributes TMEMessageAttributes = {
	.chat = @"chat",
	.id = @"id",
	.meetup_place = @"meetup_place",
	.time_stamp = @"time_stamp",
};

const struct TMEMessageRelationships TMEMessageRelationships = {
	.from = @"from",
	.product = @"product",
	.to = @"to",
};

const struct TMEMessageFetchedProperties TMEMessageFetchedProperties = {
};

@implementation TMEMessageID
@end

@implementation _TMEMessage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TMEMessage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TMEMessage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TMEMessage" inManagedObjectContext:moc_];
}

- (TMEMessageID*)objectID {
	return (TMEMessageID*)[super objectID];
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






@dynamic from;

	

@dynamic product;

	

@dynamic to;

	






@end
