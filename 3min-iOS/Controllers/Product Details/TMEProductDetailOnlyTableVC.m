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
    self.descriptionLabel.text = self.product.productDescription;
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

@end
