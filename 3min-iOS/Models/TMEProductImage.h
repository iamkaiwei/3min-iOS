//
//  TMEProductImage.h
//  ThreeMin
//
//  Created by Triệu Khang on 15/7/14.
//
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

@interface TMEProductImage : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *description;

@property (nonatomic, assign) CGSize dim;

@property (nonatomic, copy) NSURL *thumbURL;
@property (nonatomic, copy) NSURL *squareURL;
@property (nonatomic, copy) NSURL *mediumURL;
@property (nonatomic, copy) NSURL *originURL;

@end
