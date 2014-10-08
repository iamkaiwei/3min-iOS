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

#import "TMEProductCommentsVC.h"

@interface TMEProductDetailOnlyTableVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeInfoButton;
@property (weak, nonatomic) IBOutlet UIButton *commentInfoButton;
@property (weak, nonatomic) IBOutlet UIView *commentsContainerView;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (nonatomic, strong) TMEProductCommentsVC *commentsVC;

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
    [self setupCommentsVC];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self updateCommentInfo];
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
    self.nameLabel.text = self.product.name;
    self.priceLabel.text = self.product.price;
    self.descriptionLabel.text =  self.product.productDescription;
    self.locationLabel.text = @"Somewhere on Earth";

    [self updateLikeInfo];
}

- (void)setupCommentsVC
{
    self.commentsVC = [TMEProductCommentsVC tme_instantiateFromStoryboardNamed:@"ProductComment"];
    self.commentsVC.product = self.product;
    self.commentsVC.displayedAsChild = YES;
    [self addChildVC:self.commentsVC containerView:self.commentsContainerView];

    self.commentsContainerView.backgroundColor = [UIColor greenColor];
}

#pragma mark - Action
- (IBAction)likeInfoButtonTouched:(id)sender
{
    if (self.product.likes.integerValue == 0) {
        return;
    }
    
    TMEProductLikesVC *likesVC = [TMEProductLikesVC tme_instantiateFromStoryboardNamed:@"ProductLikes"];
    likesVC.product = self.product;
    [self.navigationController pushViewController:likesVC animated:YES];
}

- (IBAction)commentInfoButtonTouched:(id)sender
{
    TMEProductCommentsVC *commentsVC = [TMEProductCommentsVC tme_instantiateFromStoryboardNamed:@"ProductComment"];
    commentsVC.product = self.product;
    [self.navigationController pushViewController:commentsVC animated:YES];
}

- (IBAction)likeButtonTouched:(id)sender
{
    [self toggleLike];
}

- (IBAction)commentButtonTouched:(id)sender
{
    TMEProductAddCommentVC *addCommentVC = [TMEProductAddCommentVC tme_instantiateFromStoryboardNamed:@"ProductComment"];
    addCommentVC.product = self.product;
    [self.navigationController pushViewController:addCommentVC animated:YES];
}

- (IBAction)shareButtonTouched:(id)sender
{
    [self share];
}


#pragma mark - UITableViewDataSource

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1) {
        return 500;
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - Like
- (void)updateLikeInfo
{
    UIImage *likeImage = self.product.liked ? [UIImage imageNamed:@"icn_liked"] : [UIImage imageNamed:@"icn_like"];
    [self.likeButton setImage:likeImage forState:UIControlStateNormal];

    NSString *likeInfoString = NSStringf(@"%@ people like this", self.product.likes);
    [self.likeInfoButton setTitle:likeInfoString forState:UIControlStateNormal];
}

- (void)toggleLike
{
    [SVProgressHUD show];
    self.likeButton.enabled = NO;

    void (^failureBlock)() = ^{
        self.likeButton.enabled = YES;
        [SVProgressHUD showErrorWithStatus:nil];
    };

    void (^successBlock)(NSString *) = ^(NSString *status){
        if ([status isEqualToString:kSuccess]) {
            self.likeButton.enabled = YES;
            [SVProgressHUD showSuccessWithStatus:nil];

            self.product.liked = !self.product.liked;

            NSInteger amount = self.product.liked ? 1 : -1;
            self.product.likes = @(self.product.likes.integerValue + amount);

            [self updateLikeInfo];
        } else {
            failureBlock();
        }
    };


    if (self.product.liked) {
        [TMEProductsManager unlikeProductWithProductID:self.product.productID onSuccessBlock:^(NSString *status) {
            [SVProgressHUD showSuccessWithStatus:nil];
            successBlock(status);
        } failureBlock:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:nil];
            failureBlock();
        }];
    } else {
        [TMEProductsManager likeProductWithProductID:self.product.productID onSuccessBlock:^(NSString *status) {
            successBlock(status);
        } failureBlock:^(NSError *error) {
            failureBlock();
        }];
    }
}

#pragma mark - Share
- (void)share
{
    NSString *text = @"Share";
    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];

    NSArray *items = @[text, url];
    UIActivityViewController *controller = [[UIActivityViewController alloc]
                                            initWithActivityItems:items
                                            applicationActivities:nil];

    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - Comment
- (void)updateCommentInfo
{
    NSString *commentInfoString = @"View all 123 comments";
    [self.commentInfoButton setTitle:commentInfoString forState:UIControlStateNormal];
}

@end
