//
//  UIFont+TMECustomFonts.m
//  ThreeMin
//
//  Created by iSlan on 10/27/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "UIFont+TMECustomFonts.h"

@implementation UIFont (TMECustomFonts)

+ (UIFont *)openSansBoldFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"OpenSans-Bold" size:size];
}

+ (UIFont *)openSansBoldItalicFontWithSize:(CGFloat)size
{
   return [UIFont fontWithName:@"OpenSans-BoldItalic" size:size];
}

+ (UIFont *)openSansExtraBoldFontWithSize:(CGFloat)size
{
   return [UIFont fontWithName:@"OpenSans-ExtraBold" size:size];
}

+ (UIFont *)openSansExtraBoldItalicFontWithSize:(CGFloat)size
{
   return [UIFont fontWithName:@"OpenSans-ExtraBoldItalic" size:size];
}

+ (UIFont *)openSansItalicFontWithSize:(CGFloat)size
{
   return [UIFont fontWithName:@"OpenSans-Italic" size:size];
}

+ (UIFont *)openSansLightFontWithSize:(CGFloat)size
{
   return [UIFont fontWithName:@"OpenSans-Light" size:size];
}

+ (UIFont *)openSansLightItalicFontWithSize:(CGFloat)size
{
   return [UIFont fontWithName:@"OpenSans-LightItalic" size:size];
}

+ (UIFont *)openSansRegularFontWithSize:(CGFloat)size
{
   return [UIFont fontWithName:@"OpenSans" size:size];
}

+ (UIFont *)openSansSemiBoldFontWithSize:(CGFloat)size
{
   return [UIFont fontWithName:@"OpenSans-Semibold" size:size];
}

+ (UIFont *)openSansSemiBoldItalicFontWithSize:(CGFloat)size
{
   return [UIFont fontWithName:@"OpenSans-SemiboldItalic" size:size];
}

@end
