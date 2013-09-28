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

    product.created_at = data[@"create_at"];
    
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
    TMECategory *category = [[TMECategory alloc] init];
    if (data[@"category"]) {
        NSDictionary *categoryData = data[@"category"];
        category.photo_url = categoryData[@"photo_url"];
        product.category = category;
    }
    
    // user
    TMEUser *user = [[TMEUser alloc] init];
    if (data[@"user"]) {
        NSDictionary *userData = data[@"user"];
        user.photo_url = userData[@"photo_url"];
        user.username = userData[@"username"];
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
    
    return arrProducts;
}

@end
