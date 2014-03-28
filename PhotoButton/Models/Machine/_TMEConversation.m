// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEConversation.m instead.

#import "_TMEConversation.h"

const struct TMEConversationAttributes TMEConversationAttributes = {
	.channel_name = @"channel_name",
	.id = @"id",
	.latest_message = @"latest_message",
	.latest_update = @"latest_update",
	.offer = @"offer",
	.user_avatar = @"user_avatar",
	.user_full_name = @"user_full_name",
	.user_id = @"user_id",
};

const struct TMEConversationRelationships TMEConversationRelationships = {
	.product = @"product",
	.replies = @"replies",
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
	if ([key isEqualToString:@"offerValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"offer"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"user_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"user_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic channel_name;






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





@dynamic latest_message;






@dynamic latest_update;






@dynamic offer;



- (double)offerValue {
	NSNumber *result = [self offer];
	return [result doubleValue];
}

- (void)setOfferValue:(double)value_ {
	[self setOffer:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveOfferValue {
	NSNumber *result = [self primitiveOffer];
	return [result doubleValue];
}

- (void)setPrimitiveOfferValue:(double)value_ {
	[self setPrimitiveOffer:[NSNumber numberWithDouble:value_]];
}





@dynamic user_avatar;






@dynamic user_full_name;






@dynamic user_id;



- (int64_t)user_idValue {
	NSNumber *result = [self user_id];
	return [result longLongValue];
}

- (void)setUser_idValue:(int64_t)value_ {
	[self setUser_id:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveUser_idValue {
	NSNumber *result = [self primitiveUser_id];
	return [result longLongValue];
}

- (void)setPrimitiveUser_idValue:(int64_t)value_ {
	[self setPrimitiveUser_id:[NSNumber numberWithLongLong:value_]];
}





@dynamic product;

	

@dynamic replies;

	
- (NSMutableSet*)repliesSet {
	[self willAccessValueForKey:@"replies"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"replies"];
  
	[self didAccessValueForKey:@"replies"];
	return result;
}
	






@end
