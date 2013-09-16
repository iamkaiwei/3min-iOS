// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TMEProductImages.m instead.

#import "_TMEProductImages.h"

const struct TMEProductImagesAttributes TMEProductImagesAttributes = {
	.imageID = @"imageID",
	.url = @"url",
};

const struct TMEProductImagesRelationships TMEProductImagesRelationships = {
	.userID = @"userID",
};

const struct TMEProductImagesFetchedProperties TMEProductImagesFetchedProperties = {
};

@implementation TMEProductImagesID
@end

@implementation _TMEProductImages

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TMEProductImages" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TMEProductImages";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TMEProductImages" inManagedObjectContext:moc_];
}

- (TMEProductImagesID*)objectID {
	return (TMEProductImagesID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"imageIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"imageID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic imageID;



- (int64_t)imageIDValue {
	NSNumber *result = [self imageID];
	return [result longLongValue];
}

- (void)setImageIDValue:(int64_t)value_ {
	[self setImageID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveImageIDValue {
	NSNumber *result = [self primitiveImageID];
	return [result longLongValue];
}

- (void)setPrimitiveImageIDValue:(int64_t)value_ {
	[self setPrimitiveImageID:[NSNumber numberWithLongLong:value_]];
}





@dynamic url;






@dynamic userID;

	






@end
