//
//  TMEProduct+Additions.m
//  PhotoButton
//
//  Created by Triệu Khang on 25/9/13.
//
//

#import "TMEProduct+Additions.h"

@implementation TMEProduct (Additions)

+ (TMEProduct *)productWithDictionary:(NSDictionary *)data
{
  TMEProduct *product = [[TMEProduct MR_findByAttribute:@"id" withValue:data[@"id"]] lastObject];
  
  if (!product) {
    product = [TMEProduct MR_createEntity];
    product.id = data[@"id"];
    
    if ([data[@"name"] isEqual:[NSNull null]])
      product.name = @"";
    else product.name = data[@"name"];
    
    NSInteger timeStamp = [data[@"create_time"] integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSLog(@"%@", date);
    product.created_at = date;
    
    if ([data[@"description"] isEqual:[NSNull null]])
      product.details = @"";
    else product.details = data[@"description"];
    
    if ([data[@"price"] isEqual:[NSNull null]])
      product.price = @0;
    else product.price = @([data[@"price"] floatValue]);
    
    // category
    if (data[@"category"]) {
      NSDictionary *categoryData = data[@"category"];
      TMECategory *category = [[TMECategory MR_findByAttribute:@"name" withValue:categoryData[@"name"]] lastObject];
      
      if (!category) {
        category = [TMECategory MR_createEntity];
        category.name = categoryData[@"name"];
        if (categoryData[@"image"]) {
          NSDictionary *image = categoryData[@"image"];
          category.photo_url = image[@"url"];
        }
      }
      product.category = category;
    }
    
    // user
    if (data[@"owner"]) {
      NSDictionary *userData = data[@"owner"];
      TMEUser *user = [TMEUser userWithData:userData];
      product.user = user;
    }
    else{
      product.user = [[TMEUserManager sharedInstance] loggedUser];
    }
    
    NSSet *setImages = [[NSSet alloc] init];
    if ([data[@"images"] isKindOfClass:[NSArray class]])
      setImages = [TMEProductImages productImagesSetFromArray:data[@"images"]];
    
    if (setImages.count > 0)
      product.images = setImages;
    
  }
  
  if (![data[@"likes"] isEqual:[NSNull null]] && data[@"likes"])
    product.likes = @([data[@"likes"] floatValue]);
  
  if (![data[@"liked"] isEqual:[NSNull null]] && data[@"liked"])
    product.liked = data[@"liked"];
  
  product.sold_out = data[@"sold_out"];
  product.updated_at = data[@"update_at"];

  return product;
}

+ (NSArray *)arrayProductsFromArray:(NSArray *)arrData
{
  NSMutableArray *arrProducts = [@[] mutableCopy];
  for (NSDictionary *data in arrData) {
    TMEProduct *product = [TMEProduct MR_createEntity];
    product = [TMEProduct productWithDictionary:data];
    [arrProducts addObject:product];
  }
  NSManagedObjectContext *mainContext  = [NSManagedObjectContext MR_defaultContext];
  [mainContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
    DLog(@"Finish save to magical record");
  }];
  
  return arrProducts;
}

@end
