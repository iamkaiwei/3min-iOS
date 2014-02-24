//
//  UIImageView+CircleProgress.m
//  PhotoButton
//
//  Created by Toan Slan on 2/24/14.
//
//

#import "UIImageView+CircleProgress.h"
#import <objc/runtime.h>

static char kTMEImageProgressIndicatorKey;

@interface UIImageView (_CircleProgress)

@property (readwrite, nonatomic, strong, setter = af_setImageRequestOperation:) AFImageRequestOperation *af_imageRequestOperation;
@property (readwrite, nonatomic, strong, setter = tme_setProgressIndicatorView:) TMECircleProgressIndicator *tme_progressIndicatorView;

@end

@implementation UIImageView (_CircleProgress)

@dynamic af_imageRequestOperation;
@dynamic tme_progressIndicatorView;

@end

@implementation UIImageView (CircleProgress)

-(TMECircleProgressIndicator *)progressIndicatorView
{
    return [self tme_progressIndicatorView];
}

-(void)tme_setProgressIndicatorView:(TMECircleProgressIndicator *)tme_progressIndicatorView{
    objc_setAssociatedObject(self, &kTMEImageProgressIndicatorKey, tme_progressIndicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(TMECircleProgressIndicator *)tme_progressIndicatorView
{
    TMECircleProgressIndicator * progressIndicator = (TMECircleProgressIndicator *)objc_getAssociatedObject(self, &kTMEImageProgressIndicatorKey);
    if (progressIndicator) return progressIndicator;
    CGRect frame = CGRectMake(0, 0, MIN(100, self.bounds.size.width), MIN(100, self.bounds.size.height));
    progressIndicator = [[TMECircleProgressIndicator alloc] initWithFrame:frame];
    progressIndicator.center = self.boundCenter;
    progressIndicator.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    [self tme_setProgressIndicatorView:progressIndicator];
    return progressIndicator;
}

- (void)setImageWithURLRequest:(NSURLRequest *)urlRequest
              placeholderImage:(UIImage *)placeholderImage
                       success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure
         downloadProgressBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))downloadProgressBlock

{
    [self cancelImageRequestOperation];
    // get AFNetworking UIImageView cache
    NSCache * cache =  (NSCache *)objc_msgSend([self class], @selector(af_sharedImageCache));
    // try to get the image from cache
    UIImage * cachedImage = objc_msgSend(cache, @selector(cachedImageForRequest:), urlRequest);
    if (cachedImage) {
        self.af_imageRequestOperation = nil;
        
        if (success) {
            success(nil, nil, cachedImage);
        } else {
            self.image = cachedImage;
        }
    } else {
        if (placeholderImage) {
            self.image = placeholderImage;
        }
        
        AFImageRequestOperation *requestOperation = [[AFImageRequestOperation alloc] initWithRequest:urlRequest];
		
#ifdef _AFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES_
		requestOperation.allowsInvalidSSLCertificate = YES;
#endif
		
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([urlRequest isEqual:[self.af_imageRequestOperation request]]) {
                if (self.af_imageRequestOperation == operation) {
                    self.af_imageRequestOperation = nil;
                }
                
                if (success) {
                    success(operation.request, operation.response, responseObject);
                } else if (responseObject) {
                    self.image = responseObject;
                }
            }
            // cache the image recently fetched.
            objc_msgSend(cache, @selector(cacheImage:forRequest:), responseObject, urlRequest);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([urlRequest isEqual:[self.af_imageRequestOperation request]]) {
                if (self.af_imageRequestOperation == operation) {
                    self.af_imageRequestOperation = nil;
                }
                
                if (failure) {
                    failure(operation.request, operation.response, error);
                }
            }
        }];
        
        if (downloadProgressBlock){
            [requestOperation setDownloadProgressBlock:downloadProgressBlock];
        }
        self.af_imageRequestOperation = requestOperation;
        // get the NSOperation associated to UIImageViewClass
        NSOperationQueue * operationQueue =  (NSOperationQueue *)objc_msgSend([self class], @selector(af_sharedImageRequestOperationQueue));
        [operationQueue addOperation:self.af_imageRequestOperation];
    }
}
-(void)setImageWithProgressIndicatorAndURL:(NSURL *)url
                          placeholderImage:(UIImage *)placeholderImage
{
    [self setImage:nil];
    [self.tme_progressIndicatorView setProgressValue:0.0f];
    if (![self.tme_progressIndicatorView superview]){
        [self addSubview:self.tme_progressIndicatorView];
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    __typeof__(self) __weak weakSelf = self;
    [self setImageWithURLRequest:request
                placeholderImage:placeholderImage
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                             [weakSelf.tme_progressIndicatorView removeFromSuperview];
                             weakSelf.alpha = 0;
                             weakSelf.image = image;
                             [CAAnimation addAnimationToLayer:weakSelf.layer
                                                  withKeyPath:@"opacity"
                                                     duration:0.5
                                                           to:1
                                               easingFunction:CAAnimationEasingFunctionEaseInCubic];

                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                             [weakSelf.tme_progressIndicatorView setProgressValue:0.0f];
                         }
           downloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
               float newValue = ((float)totalBytesRead / totalBytesExpectedToRead);
               [weakSelf.tme_progressIndicatorView setProgressValue:newValue];
           }];
}

@end
