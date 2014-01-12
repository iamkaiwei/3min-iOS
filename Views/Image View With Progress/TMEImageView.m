//
//  TMEImageView.m
//  PhotoButton
//
//  Created by admin on 1/12/14.
//
//

#import "TMEImageView.h"
#import "TMEProgressView.h"

@interface TMEImageView()
<TMEProgressViewDelegate>
@property (weak, nonatomic) IBOutlet TMEProgressView *progressViewCustom;

@end

@implementation TMEImageView

- (void)setImageHaveProgressWithURL:(NSURL *)URL{
  [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:URL
                                                        options:0
                                                       progress:^(NSUInteger receivedSize, long long expectedSize){
                                                         [self.progressViewCustom performSelectorOnMainThread:@selector(setProgress:) withObject:@(receivedSize/expectedSize) waitUntilDone:NO];
                                                       }
                                                      completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished){
                                                        self.image = image;
                                                      }];
}

-(void)didFinishAnimation:(TMEProgressView *)progressView{
  progressView.hidden = YES;
}

@end
