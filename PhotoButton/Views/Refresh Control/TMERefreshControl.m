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
        self.refreshLabel = [[MTAnimatedLabel alloc] initWithFrame:CGRectMake(95, 15, 130, 50)];
        self.refreshLabel.text = NSLocalizedString(@"Pull to refresh", nil);
        self.refreshLabel.textColor = [UIColor darkTextColor];
        self.refreshLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.refreshLabel];
    }
    return self;
}

- (void)amountOfControlVisible:(CGFloat)visibility{
    self.refreshLabel.alpha = visibility/2;
}

- (void)refreshingWithDelta:(CGFloat)delta{
    self.refreshLabel.text = NSLocalizedString(@"3 mins loading...", nil);;
    [self.refreshLabel startAnimating];
    self.tableView.userInteractionEnabled = NO;
}

- (void)beginRefreshing{
    [super beginRefreshing];
    self.refreshLabel.alpha = 0.5;
}

- (void)reset{
    self.refreshLabel.text = NSLocalizedString(@"Pull to refresh", nil);
    [self.refreshLabel stopAnimating];
    self.tableView.userInteractionEnabled = YES;
}

@end
