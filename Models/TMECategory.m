#import "TMECategory.h"


@interface TMECategory ()

// Private interface goes here.

@end


@implementation TMECategory

// Custom logic goes here.
+ (NSArray *)arrayCategoriesFromArray:(NSArray *)arrData
{
  NSMutableArray *arrProducts = [@[] mutableCopy];
  for (NSDictionary *data in arrData) {
    TMECategory *cat = [TMECategory categoryWithDictionary:data];
    [arrProducts addObject:cat];
  }
  
  return arrProducts;
}

+ (TMECategory *)categoryWithDictionary:(NSDictionary *)data
{
  TMECategory *cat = [TMECategory MR_createEntity];
  
  cat.id = data[@"id"];
  
  if ([data[@"name"] isEqual:[NSNull null]])
    cat.name = @"";
  else cat.name = data[@"name"];
  
  if ([data[@"description"] isEqual:[NSNull null]])
    cat.details = @"";
  else cat.details = data[@"description"];
  
  // category
  if (data[@"image"]) {
    NSDictionary *image = data[@"image"];
    cat.photo_url = image[@"url"];
  }
  
  return cat;
}

@end
