//
//  TMEProgressView.h
//  PhotoButton
//
//  Created by Toan Slan on 1/10/14.
//
//

#import <UIKit/UIKit.h>

@class TMEProgressView;

@protocol TMEProgressViewDelegate

- (void)didFinishAnimation:(TMEProgressView *)progressView;

@end

@interface TMEProgressView : UIView

@property (strong, nonatomic) NSObject <TMEProgressViewDelegate> *delelgate;
- (void)setProgress:(NSNumber*)value;

@end
