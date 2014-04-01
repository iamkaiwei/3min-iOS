#import "TMEProduct.h"


@interface TMEProduct ()

// Private interface goes here.

@end


@implementation TMEProduct

// Custom logic goes here.
+ (TMEProduct *)productWithDictionary:(NSDictionary *)data
{
    TMEProduct *product = [[TMEProduct MR_findByAttribute:@"id" withValue:data[@"id"]] lastObject];
    
    if (!product) {
        product = [TMEProduct MR_createEntity];
        product.id = data[@"id"];
        
        if ([data[@"name"] isEqual:[NSNull null]])
            product.name = @"";
        else product.name = data[@"name"];
        
        if ([data[@"description"] isEqual:[NSNull null]])
            product.details = @"";
        else product.details = data[@"description"];
    }
    
    
    if ([data[@"venue_id"] isEqual:[NSNull null]])
        product.venue_id = @"";
    else product.venue_id = data[@"venue_id"];
    
    if ([data[@"venue_long"] isEqual:[NSNull null]])
        product.venue_long = nil;
    else product.venue_long = @([data[@"venue_long"] floatValue]);
    
    if ([data[@"venue_lat"] isEqual:[NSNull null]])
        product.venue_lat = nil;
    else product.venue_lat = @([data[@"venue_lat"] floatValue]);
    
    if ([data[@"venue_name"] isEqual:[NSNull null]])
        product.venue_name = @"";
    else product.venue_name = data[@"venue_name"];
    
    if ([data[@"price"] isEqual:[NSNull null]])
        product.price = @0;
    else product.price = @([data[@"price"] floatValue]);
    
    // category
    if (data[@"category"]) {
        NSDictionary *categoryData = data[@"category"];
        TMECategory *category = [[TMECategory MR_findByAttribute:@"id" withValue:categoryData[@"id"]] lastObject];
        
        if (!category) {
            category = [TMECategory MR_createEntity];
            category.id = categoryData[@"id"];
            category.name = categoryData[@"name"];
            if (categoryData[@"image"]) {
                NSDictionary *image = categoryData[@"image"];
                category.photo_url = image[@"url"];
            }
        }
        product.category = category;
    }
    
    NSInteger timeStamp = [data[@"create_time"] integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    product.created_at = date;
    
    if (![data[@"update_time"] isEqual:[NSNull null]] && data[@"update_time"]){
        NSInteger timeStamp = [data[@"update_time"] integerValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
        product.updated_at = date;
    }
    
    NSSet *setImages = [[NSSet alloc] init];
    if ([data[@"images"] isKindOfClass:[NSArray class]])
        setImages = [TMEProductImages productImagesSetFromArray:data[@"images"]];
    
    if (setImages.count > 0)
        product.images = setImages;
    
    // user
    if (data[@"owner"]) {
        NSDictionary *userData = data[@"owner"];
        TMEUser *user = [TMEUser userWithData:userData];
        product.user = user;
    }
    
    if (![data[@"likes"] isEqual:[NSNull null]] && data[@"likes"])
        product.likes = @([data[@"likes"] floatValue]);
    
    if (![data[@"liked"] isEqual:[NSNull null]] && data[@"liked"])
        product.liked = data[@"liked"];
    
    product.sold_out = data[@"sold_out"];
    
    return product;
}

+ (NSArray *)arrayProductsFromArray:(NSArray *)arrData
{
    return [TMEProduct arrayProductsFromArray:arrData liked:NO];
}

+ (NSArray *)arrayProductsFromArray:(NSArray *)arrData liked:(BOOL)liked
{
    NSMutableArray *arrProducts = [@[] mutableCopy];
    for (NSDictionary *data in arrData) {
        TMEProduct *product = [TMEProduct productWithDictionary:data];
        if (liked) {
            product.likedValue = YES;
        }
        [arrProducts addObject:product];
    }
    NSManagedObjectContext *mainContext  = [NSManagedObjectContext MR_defaultContext];
    [mainContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        DLog(@"Finish save to magical record");
    }];
    
    return arrProducts;
}


@end
