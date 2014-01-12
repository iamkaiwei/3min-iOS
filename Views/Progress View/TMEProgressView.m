//
//  TMEProgressView.m
//  PhotoButton
//
//  Created by Toan Slan on 1/10/14.
//
//

#import "TMEProgressView.h"

@interface TMEProgressView()

@property (assign, nonatomic) CGFloat currentValue;
@property (assign, nonatomic) CGFloat newToValue;
@property (assign, nonatomic) BOOL isAnimationInProgress;

@end

@implementation TMEProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      self.currentValue = 0.0;
      self.newToValue = 0.0;
      self.isAnimationInProgress = NO;
      self.alpha = 0.95;
      self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
    }
    return self;
}

-(void)setAnimationDone
{
  self.isAnimationInProgress = NO;
  if (self.newToValue > self.currentValue)
    [self setProgress:[NSNumber numberWithFloat:self.newToValue]];
}

- (void)setProgress:(NSNumber*)value{
  
  CGFloat toValue = [value floatValue];
  
  if (toValue <= self.currentValue)
    return;
  else if (toValue > 1.0)
    toValue = 1.0;
  
  if (self.isAnimationInProgress)
  {
    self.newToValue = toValue;
    return;
  }
  
  self.isAnimationInProgress = YES;
  
  CGFloat animationTime = toValue - self.currentValue;
  
  [self performSelector:@selector(setAnimationDone) withObject:nil afterDelay:animationTime];
  
  if (toValue == 1.0 && [self.delelgate respondsToSelector:@selector(didFinishAnimation:)])
  {
    [self.delelgate performSelector:@selector(didFinishAnimation:) withObject:self afterDelay:animationTime];
  }
  
  CGFloat startAngle = 2 * M_PI * self.currentValue - M_PI_2;
  CGFloat endAngle = 2 * M_PI * toValue - M_PI_2;
  
  CGFloat radius = self.frame.size.height/2;
  
  CAShapeLayer *circle = [CAShapeLayer layer];
  
  // Make a circular shape
  
  circle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2,self.frame.size.height/2)
                                               radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES].CGPath;
  
  // Configure the apperence of the circle
  circle.fillColor = [UIColor whiteColor].CGColor;
  circle.strokeColor = [UIColor orangeMainColor].CGColor;
  circle.lineWidth = 3;
  
  // Add to parent layer
  [self.layer addSublayer:circle];
  
  // Configure animation
  CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  
  drawAnimation.duration            = animationTime;
  drawAnimation.repeatCount         = 0.0;  // Animate only once..
  drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
  
  // Animate from no part of the stroke being drawn to the entire stroke being drawn
  drawAnimation.fromValue = [NSNumber numberWithFloat:0.0];
  drawAnimation.toValue   = [NSNumber numberWithFloat:1.0];
  
  // Experiment with timing to get the appearence to look the way you want
  drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
  
  // Add the animation to the circle
  [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
  self.currentValue = toValue;
}

@end
