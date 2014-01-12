//
//  TMEImageView.m
//  PhotoButton
//
//  Created by admin on 1/12/14.
//
//

#import "TMEViewImageWithProgress.h"
#import "TMEProgressView.h"

@interface TMEViewImageWithProgress()
<TMEProgressViewDelegate>

@property (strong, nonatomic) TMEProgressView *progressViewCustom;
@property (strong, nonatomic) UIImageView *imageViewMain;

@end

@implementation TMEViewImageWithProgress

- (void)setUpView{
  self.progressViewCustom = [[TMEProgressView alloc] initWithFrame:[TMEProgressView getCenterFrameWithFrame:self.bounds]];
  self.progressViewCustom.delelgate = self;
  
  self.imageViewMain = [[UIImageView alloc] initWithFrame:self.bounds];
  self.imageViewMain.image = [UIImage imageNamed:@"photo-placeholder"];
  self.imageViewMain.contentMode = UIViewContentModeScaleAspectFill;
  self.imageViewMain.clipsToBounds = YES;
  
  [self addSubview:self.imageViewMain];
  [self addSubview:self.progressViewCustom];
}

- (void)setImageHaveProgressWithURL:(NSURL *)URL{
  [self setUpView];
  [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:URL
                                                        options:0
                                                       progress:^(NSUInteger receivedSize, long long expectedSize){
                                                         [self.progressViewCustom performSelectorOnMainThread:@selector(setProgress:) withObject:@(receivedSize/expectedSize) waitUntilDone:NO];
                                                       }
                                                      completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished){
                                                        self.imageViewMain.highlightedImage = image;
                                                      }];
}

-(void)didFinishAnimation:(TMEProgressView *)progressView{
  progressView.hidden = YES;
  self.imageViewMain.highlighted = YES;
}

@end
