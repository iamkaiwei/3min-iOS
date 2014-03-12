//
//  TMESwitch.m
//  PhotoButton
//
//  Created by Toan Slan on 2/19/14.
//
//

#import "TMESwitch.h"

@implementation TMESwitch

+ (void)initialize{
    [super initialize];
    
    [[TMESwitch appearance] setBackgroundImage:[UIImage imageNamed:@"Switch_Background"]];
    [[TMESwitch appearance] setOverlayImage:nil];
    [[TMESwitch appearance] setKnobImage:[UIImage imageNamed:@"Switch_Knob"]];
    [[TMESwitch appearance] setHighlightedKnobImage:nil];
    [[TMESwitch appearance] setKnobOffset:CGSizeMake(0, 0)];
    [[TMESwitch appearance] setCornerRadius:0];
    [[TMESwitch appearance] setFont:[UIFont boldSystemFontOfSize:14]];
    [[TMESwitch appearance] setTextOffset:CGSizeMake(0, 2) forLabel:RESwitchLabelOn];
    [[TMESwitch appearance] setTextOffset:CGSizeMake(0, 2) forLabel:RESwitchLabelOff];
    [[TMESwitch appearance] setTextShadowOffset:CGSizeMake(0, 0)];
    [[TMESwitch appearance] setTextColor:[UIColor whiteColor] forLabel:RESwitchLabelOn];
    [[TMESwitch appearance] setTextColor:[UIColor orangeMainColor] forLabel:RESwitchLabelOff];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.on = NO;

    self.layer.cornerRadius = 4;
    self.layer.borderColor = [UIColor orangeMainColor].CGColor;
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
  }
  return self;
}

@end
