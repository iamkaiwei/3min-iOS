// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEActivity.m instead.

#import "_TMEActivity.h"

const struct TMEActivityAttributes TMEActivityAttributes = {
	.content = @"content",
	.id = @"id",
	.subject_id = @"subject_id",
	.subject_type = @"subject_type",
	.update_time = @"update_time",
};

const struct TMEActivityRelationships TMEActivityRelationships = {
	.user = @"user",
};

const struct TMEActivityFetchedProperties TMEActivityFetchedProperties = {
};

@implementation TMEActivityID
@end

@implementation _TMEActivity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TMEActivity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TMEActivity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TMEActivity" inManagedObjectContext:moc_];
}

- (TMEActivityID*)objectID {
	return (TMEActivityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"subject_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"subject_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic content;






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





@dynamic subject_id;



- (int64_t)subject_idValue {
	NSNumber *result = [self subject_id];
	return [result longLongValue];
}

- (void)setSubject_idValue:(int64_t)value_ {
	[self setSubject_id:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveSubject_idValue {
	NSNumber *result = [self primitiveSubject_id];
	return [result longLongValue];
}

- (void)setPrimitiveSubject_idValue:(int64_t)value_ {
	[self setPrimitiveSubject_id:[NSNumber numberWithLongLong:value_]];
}





@dynamic subject_type;






@dynamic update_time;






@dynamic user;

	






@end
