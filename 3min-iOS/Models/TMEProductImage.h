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
@property (nonatomic, copy) NSString *imageDescription;

@property (nonatomic, strong) NSValue *dim;

@property (nonatomic, strong) NSURL *thumbURL;
@property (nonatomic, strong) NSURL *squareURL;
@property (nonatomic, strong) NSURL *mediumURL;
@property (nonatomic, strong) NSURL *originURL;

@end
