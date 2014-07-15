//
//  TMEProduct.h
//  ThreeMin
//
//  Created by Triệu Khang on 15/7/14.
//
//

#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>

@class TMECategory;
@class TMEUser;

typedef NS_ENUM (NSUInteger, TMEProductStatus) {
	TMEProductStatusSoldOut,
	TMEProductStatusSelling,
	TMEProductStatusUnknow
};

@interface TMEProduct : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *productID;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *productDescription;
@property (nonatomic, copy) NSString *details;

@property (nonatomic, copy) NSString *comments;

@property (nonatomic, copy) NSDate *createAt;
@property (nonatomic, copy) NSDate *updateAt;

@property (nonatomic, copy) NSNumber *dislikes;
@property (nonatomic, copy) NSNumber *likes;

@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, assign) BOOL soldOut;

@property (nonatomic, copy) NSString *venueID;
@property (nonatomic, copy) NSNumber *venueLong;
@property (nonatomic, copy) NSNumber *venueLat;

@property (nonatomic, strong) TMECategory *category;

@property (nonatomic, strong) NSSet *conversation;
@property (nonatomic, strong) NSArray *images;

@property (nonatomic, strong) TMEUser *user;

@end
