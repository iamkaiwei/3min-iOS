//
//  TMESwitch.m
//  PhotoButton
//
//  Created by Toan Slan on 2/19/14.
//
//

#import "TMESwitch.h"

@implementation TMESwitch

- (id)initWithCoder:(NSCoder *)aDecoder{
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.on = NO;
    [self setBackgroundImage:[UIImage imageNamed:@"Switch_Background"]];
    [self setKnobImage:[UIImage imageNamed:@"Switch_Knob"]];
    [self setOverlayImage:nil];
    [self setHighlightedKnobImage:nil];
    [self setCornerRadius:0];
    [self setKnobOffset:CGSizeMake(0, 0)];
    [self setTextShadowOffset:CGSizeMake(0, 0)];
    [self setFont:[UIFont boldSystemFontOfSize:14]];
    [self setTextOffset:CGSizeMake(0, 2) forLabel:RESwitchLabelOn];
    [self setTextOffset:CGSizeMake(3, 2) forLabel:RESwitchLabelOff];
    [self setTextColor:[UIColor whiteColor] forLabel:RESwitchLabelOn];
    [self setTextColor:[UIColor orangeMainColor] forLabel:RESwitchLabelOff];
    self.layer.cornerRadius = 4;
    self.layer.borderColor = [UIColor orangeMainColor].CGColor;
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
  }
  return self;
}

@end
