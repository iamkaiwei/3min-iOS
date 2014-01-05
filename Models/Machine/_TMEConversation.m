// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEConversation.m instead.

#import "_TMEConversation.h"

const struct TMEConversationAttributes TMEConversationAttributes = {
	.id = @"id",
	.lastest_message = @"lastest_message",
};

const struct TMEConversationRelationships TMEConversationRelationships = {
	.product = @"product",
	.replies = @"replies",
	.user = @"user",
};

const struct TMEConversationFetchedProperties TMEConversationFetchedProperties = {
};

@implementation TMEConversationID
@end

@implementation _TMEConversation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TMEConversation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TMEConversation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TMEConversation" inManagedObjectContext:moc_];
}

- (TMEConversationID*)objectID {
	return (TMEConversationID*)[super objectID];
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





@dynamic lastest_message;






@dynamic product;

	

@dynamic replies;

	
- (NSMutableSet*)repliesSet {
	[self willAccessValueForKey:@"replies"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"replies"];
  
	[self didAccessValueForKey:@"replies"];
	return result;
}
	

@dynamic user;

	






@end
