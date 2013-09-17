//
//  UIFont+Additions.m
//  TemplateProject
//
//  Created by Torin on 17/4/13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "UIFont+Additions.h"

@implementation UIFont (Additions)

+ (void)load
{
  [super load];
  //EXCHANGE_METHOD( systemFontOfSize:, appFontOfSize: );
  //EXCHANGE_METHOD( boldSystemFontOfSize:, boldAppFontOfSize: );
}

+ (UIFont *)appFontOfSize:(CGFloat)fontSize
{
  return [UIFont fontWithName:@"Helvetica Neue" size:fontSize];
}

+ (UIFont *)boldAppFontOfSize:(CGFloat)fontSize
{
  return [UIFont fontWithName:@"Helvetica Neue" size:fontSize];
}

+ (UIFont *)lightAppFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:fontSize];
}

+ (UIFont *)mediumAppFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeueLTStd-Md" size:fontSize];
}

+ (UIFont *)ultraLightCondensedAppFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeueLTStd-UltLtCn" size:fontSize];
}

+ (UIFont *)lightCondensedAppFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeueLTStd-LtCn" size:fontSize];
}

+ (UIFont *)condensedAppFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeueLTStd-Cn" size:fontSize];
}

+ (UIFont *)boldCondensedAppFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeueLTStd-BdCn" size:fontSize];
}

+ (UIFont *)romanAppFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:fontSize];
}

- (UIFont *)mediumAppFontOfSameFontSize
{
    return [UIFont mediumAppFontOfSize:self.pointSize];
}

- (UIFont *)ultraLightCondensedAppFontOfSameFontSize
{
    return [UIFont ultraLightCondensedAppFontOfSize:self.pointSize];
}

- (UIFont *)lightCondensedAppFontOfSameFontSize
{
    return [UIFont lightCondensedAppFontOfSize:self.pointSize];
}

- (UIFont *)condensedAppFontOfSameFontSize
{
    return [UIFont condensedAppFontOfSize:self.pointSize];
}

- (UIFont *)boldCondensedAppFontOfSameFontSize
{
    return [UIFont boldCondensedAppFontOfSize:self.pointSize];
}

- (UIFont *)romanAppFontOfSameFontSize
{
    return [UIFont romanAppFontOfSize:self.pointSize];
}

- (UIFont *)boldSystemFontOfSameFontSize
{
  return [UIFont systemFontOfSize:self.pointSize];
}

- (UIFont *)systemFontOfSameFontSize
{  
  return [UIFont boldSystemFontOfSize:self.pointSize];
}

- (UIFont *)boldAppFontOfSameFontSize
{
  return [UIFont appFontOfSize:self.pointSize];
}

- (UIFont *)appFontOfSameFontSize
{
  return [UIFont boldAppFontOfSize:self.pointSize];
}

// New fonts used in Eagle-child
+ (UIFont *)governorFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Governor" size:fontSize];
}

+ (UIFont *)latoBlackFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Lato-Black" size:fontSize];
}

+ (UIFont *)latoBlackItalicFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Lato-BlackItalic" size:fontSize];
}

+ (UIFont *)latoBoldFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Lato-Bold" size:fontSize];
}

+ (UIFont *)latoBoldItalicFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Lato-BoldItalic" size:fontSize];
}

+ (UIFont *)latoHairlineFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Lato-Hairline" size:fontSize];
}

+ (UIFont *)latoHairlineItalicFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Lato-HairlineItalic" size:fontSize];
}

+ (UIFont *)latoLightFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Lato-Light" size:fontSize];
}

+ (UIFont *)latoLightItalicFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Lato-LightItalic" size:fontSize];
}

+ (UIFont *)latoRegularFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Lato-Regular" size:fontSize];
}

+ (UIFont *)latoRegularItalicFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Lato-RegularItalic" size:fontSize];
}

@end
