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
    TMEProduct *product = [TMEProduct MR_createEntity];
    
    product.id = data[@"id"];
    
    if ([data[@"name"] isEqual:[NSNull null]])
        product.name = @"";
    else product.name = data[@"name"];

    NSInteger timeStamp = [data[@"create_at"] integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:timeStamp];
    NSLog(@"%@", date);
    product.created_at = date;
    
    if ([data[@"description"] isEqual:[NSNull null]])
        product.details = @"";
    else product.details = data[@"description"];
    
    product.dislikes = data[@"dislike"];
    product.likes = data[@"like"];
    
    if ([data[@"price"] isEqual:[NSNull null]])
        product.price = @0;
    else product.price = @([data[@"price"] floatValue]);
    
    product.sold_out = data[@"sold_out"];
    product.updated_at = data[@"update_at"];
    
    // category
    TMECategory *category = [TMECategory MR_createEntity];
    if (data[@"category"]) {
        NSDictionary *categoryData = data[@"category"];
        category.name = categoryData[@"name"];
        
        // dig for category image
        if (categoryData[@"image"]) {
            NSDictionary *image = categoryData[@"image"];
            category.photo_url = image[@"url"];
        }
        
        product.category = category;
    }
    
    // user
    TMEUser *user = [TMEUser MR_createEntity];
    if (data[@"owner"]) {
        NSDictionary *userData = data[@"owner"];
        
        // dig for user image
        if (userData[@"image"]) {
            NSDictionary *image = userData[@"image"];
            user.photo_url = image[@"url"];
        }
        
        user.username = userData[@"username"];
        user.fullname = userData[@"full_name"];
        user.id = userData[@"id"];
        product.user = user;
    }
    
    // images
    NSSet *setImages = [[NSSet alloc] init];
    if ([data[@"images"] isKindOfClass:[NSArray class]])
        setImages = [TMEProductImages productImagesSetFromArray:data[@"images"]];
    
    if (setImages.count > 0)
        product.images = setImages;
    
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
