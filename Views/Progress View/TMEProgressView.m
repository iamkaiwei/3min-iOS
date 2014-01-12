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
      self.backgroundColor = [UIColor clearColor];
      
      CGFloat startAngle = - M_PI_2;
      CGFloat endAngle = 2 * M_PI - M_PI_2;
      
      CGFloat radius = self.frame.size.height > self.frame.size.width ? self.frame.size.width/2 : self.frame.size.height/2;
      
      CAShapeLayer *circleBorder = [self makeCirclePathWithStartAngle:startAngle
                                                             endAngle:endAngle
                                                               radius:radius + 4
                                                          strokeColor:[UIColor whiteColor].CGColor
                                                            lineWidth:4];
      CAShapeLayer *circleInner = [self makeCirclePathWithStartAngle:startAngle
                                                            endAngle:endAngle
                                                              radius:radius - 3
                                                         strokeColor:[UIColor whiteColor].CGColor
                                                           lineWidth:3];
      [self.layer addSublayer:circleBorder];
      [self.layer addSublayer:circleInner];
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
  
  CGFloat radius = self.frame.size.height > self.frame.size.width ? self.frame.size.width/2 : self.frame.size.height/2;
  
  CAShapeLayer *circle = [self makeCirclePathWithStartAngle:startAngle
                                                   endAngle:endAngle
                                                     radius:radius
                                                strokeColor:[UIColor orangeColor].CGColor
                                                  lineWidth:3];  
  // Add to parent layer
  [self.layer addSublayer:circle];
//  [self.layer addSublayer:circleBorder];
//  [self.layer addSublayer:circleInner];
  
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

+ (CGRect)getCenterFrameWithFrame:(CGRect)frame{
  CGFloat width = CGRectGetWidth(frame) / 3.5;
  CGFloat height = CGRectGetHeight(frame) / 3.5;
  CGPoint origin = CGPointMake(CGRectGetMidX(frame) - (width/2), CGRectGetMidY(frame) - (height/2));
  CGRect returnFrame = CGRectMake(origin.x, origin.y, width, height);
  return returnFrame;
}

- (CAShapeLayer *)makeCirclePathWithStartAngle:(CGFloat)startAngle
                                      endAngle:(CGFloat)endAngle
                                        radius:(CGFloat)radius
                                   strokeColor:(CGColorRef)color
                                     lineWidth:(CGFloat)lineWidth
{
  CAShapeLayer *circleShape = [CAShapeLayer layer];
  circleShape.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2,self.frame.size.height/2)
                                                    radius:radius
                                                startAngle:startAngle
                                                  endAngle:endAngle
                                                 clockwise:YES].CGPath;
  
  circleShape.fillColor = [UIColor clearColor].CGColor;
  circleShape.strokeColor = color;
  circleShape.lineWidth = lineWidth;
  return circleShape;
};

@end
