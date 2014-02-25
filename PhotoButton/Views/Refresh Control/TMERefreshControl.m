//
//  TMERefreshControl.m
//  PhotoButton
//
//  Created by Toan Slan on 2/24/14.
//
//

#import "TMERefreshControl.h"
#import "MTAnimatedLabel.h"

@interface TMERefreshControl()

@property (strong, nonatomic) MTAnimatedLabel *refreshLabel;

@end

@implementation TMERefreshControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.refreshLabel = [[MTAnimatedLabel alloc] initWithFrame:CGRectMake(100, 15, 200, 50)];
        self.refreshLabel.text = @"3 mins loading...";
        self.refreshLabel.textColor = [UIColor darkTextColor];
        [self addSubview:self.refreshLabel];
    }
    return self;
}

- (void)amountOfControlVisible:(CGFloat)visibility{
    self.refreshLabel.alpha = visibility/2;
}

- (void)refreshingWithDelta:(CGFloat)delta{
    [self.refreshLabel startAnimating];
    self.tableView.userInteractionEnabled = NO;
}

- (void)reset{
    [self.refreshLabel stopAnimating];
    self.tableView.userInteractionEnabled = YES;
}

@end
