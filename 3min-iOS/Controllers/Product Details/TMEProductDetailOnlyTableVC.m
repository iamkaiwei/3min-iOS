//
//  TMEProductDetailOnlyTableVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 9/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductDetailOnlyTableVC.h"
#import "TMEProductCommentsVC.h"
#import "TMEProductLikesVC.h"
#import "TMEProductAddCommentVC.h"

@interface TMEProductDetailOnlyTableVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeInfoButton;
@property (weak, nonatomic) IBOutlet UIButton *commentInfoButton;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *commentUserAvatarImageViews;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *commentUserNameLabels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *commentUserCommentLabels;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end

@implementation TMEProductDetailOnlyTableVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Leave room for the "Chat to buy" button
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    // Display
    [self displayProduct];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data
- (void)displayProduct
{
    // Image
    if (self.product.images.count > 0) {
        TMEProductImage *image = self.product.images[0];
        [self.imageView setImageWithURL:image.mediumURL placeholderImage:[UIImage imageNamed:@"photo-placeholder"]];
    }

    // Info
    self.priceLabel.text = self.product.price;
    self.descriptionLabel.text = @"Directly animating constraints is really only a feasible strategy on OS X, and it is limited in what you can animate, since only a constraint’s constant can be changed after creating it. On iOS you would have to drive the animation manually, whereas on OS X you can use an animator proxy on the constraint’s constant. Furthermore, this approach is significantly slower than the Core Animation approach, which also makes it a bad fit for mobile platforms for the time being";
    self.locationLabel.text = @"Some where on Earth";

    NSString *likeInfoString = NSStringf(@"%@ people like this", self.product.likes);
    [self.likeInfoButton setTitle:likeInfoString forState:UIControlStateNormal];

    NSString *commentInfoString = @"View all 123 comments";
    [self.commentInfoButton setTitle:commentInfoString forState:UIControlStateNormal];

    // Comment
}

#pragma mark - Action
- (IBAction)likeInfoButtonTouched:(id)sender
{
    TMEProductLikesVC *likesVC = [TMEProductLikesVC tme_instantiateFromStoryboardNamed:@"ProductLikes"];
    [self.navigationController pushViewController:likesVC animated:YES];
}

- (IBAction)commentInfoButtonTouched:(id)sender
{
    TMEProductCommentsVC *commentsVC = [TMEProductCommentsVC tme_instantiateFromStoryboardNamed:@"ProductComment"];
    [self.navigationController pushViewController:commentsVC animated:YES];
}

- (IBAction)likeButtonTouched:(id)sender
{

}

- (IBAction)commentButtonTouched:(id)sender
{
    TMEProductAddCommentVC *addCommentVC = [TMEProductAddCommentVC tme_instantiateFromStoryboardNamed:@"ProductComment"];
    [self.navigationController pushViewController:addCommentVC animated:YES];
}

- (IBAction)shareButtonTouched:(id)sender
{

}


#pragma mark - UITableViewDataSource

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row > 0) {
        return 0;
    }

    if (indexPath.section == 0 && indexPath.row == 2) {
        CGSize size = [self.descriptionLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height + 23;
    }

    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}



@end
