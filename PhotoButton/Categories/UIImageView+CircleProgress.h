//
//  UIImageView+CircleProgress.h
//  PhotoButton
//
//  Created by Toan Slan on 2/24/14.
//
//

#import <UIKit/UIKit.h>

@interface UIImageView (CircleProgress)

- (void)setImageWithURLRequest:(NSURLRequest *)urlRequest
              placeholderImage:(UIImage *)placeholderImage
                       success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure
         downloadProgressBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))downloadProgressBlock;

- (void)setImageWithProgressIndicatorAndURL:(NSURL *)url
                           placeholderImage:(UIImage *)placeholderImage;

@end
