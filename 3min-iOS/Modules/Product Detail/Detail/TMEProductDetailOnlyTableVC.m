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
#import "TMEProductCommentViewModel.h"
#import <KVOController/FBKVOController.h>
#import "KHRoundAvatar.h"
#import <FormatterKit/TTTTimeIntervalFormatter.h>
#import <CoreLocation/CoreLocation.h>
#import "TMEEditProductVC.h"

NSInteger const kMaxCommentCountInBrief = 3;

typedef NS_ENUM(NSUInteger, TMEProductDetailSection) {
    TMEProductDetailSectionUser,
    TMEProductDetailSectionImage,
    TMEProductDetailSectionInfo,
    TMEProductDetailSectionComment
};

@interface TMEProductDetailOnlyTableVC () <TMEProductCommentsVCDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeInfoButton;
@property (weak, nonatomic) IBOutlet UIButton *commentInfoButton;
@property (weak, nonatomic) IBOutlet UIView *commentsContainerView;
@property (weak, nonatomic) IBOutlet KHRoundAvatar *userAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productDateLabel;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *productImageViews;

@property (nonatomic, strong) TMEProductCommentsVC *commentsVC;
@property (nonatomic, strong) TMEProductCommentViewModel *commentViewModel;
@property (nonatomic, assign) CGFloat commentsVCHeight;
@property (nonatomic, strong) FBKVOController *commentViewModelKVOController;

@property (weak, nonatomic) IBOutlet UIButton *editButton;

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

    [self configureViewModel];
    [self setupTableView];
    [self setupCommentsVC];
    [self setupFont];
    [self displayProduct];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

     [self.commentViewModel pullProductComments];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)configureViewModel
{
    self.commentViewModel = [[TMEProductCommentViewModel alloc] initWithProduct:self.product];
    self.commentViewModelKVOController = [FBKVOController controllerWithObserver:self];
    [self.commentViewModelKVOController observe:self.commentViewModel
                                        keyPath:@"productCommentsCount"
                                        options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                                          block:^(id observer, id object, NSDictionary *change)
    {
        typeof(self) innerSelf = observer;
        [innerSelf updateCommentInfo];
    }];
}

- (void)setupTableView
{
    // Leave room for the "Chat to buy" button
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (void)setupCommentsVC
{
    self.commentsVC = [TMEProductCommentsVC tme_instantiateFromStoryboardNamed:@"ProductComment"];
    self.commentsVC.product = self.product;
    self.commentsVC.displayedInBrief = YES;
    self.commentsVC.delegate = self;
    self.commentsVC.viewModel = self.commentViewModel;
    self.commentsVC.maxCommentCountInBrief = kMaxCommentCountInBrief;

    [self addChildVC:self.commentsVC containerView:self.commentsContainerView];
}

- (void)setupFont
{
    self.userNameLabel.font = [UIFont openSansSemiBoldFontWithSize:self.userNameLabel.font.pointSize];
    self.productDateLabel.font = [UIFont openSansRegularFontWithSize:self.productDateLabel.font.pointSize];
    self.nameLabel.font = [UIFont openSansSemiBoldFontWithSize:self.nameLabel.font.pointSize];
    self.priceLabel.font = [UIFont openSansSemiBoldFontWithSize:self.priceLabel.font.pointSize];
    self.descriptionLabel.font = [UIFont openSansRegularFontWithSize:self.descriptionLabel.font.pointSize];
    self.locationLabel.font = [UIFont openSansRegularFontWithSize:self.locationLabel.font.pointSize];
    self.likeInfoButton.titleLabel.font = [UIFont openSansSemiBoldFontWithSize:self.likeInfoButton.titleLabel.font.pointSize];
    self.commentInfoButton.titleLabel.font = [UIFont openSansSemiBoldFontWithSize:self.commentInfoButton.titleLabel.font.pointSize];
    self.likeButton.titleLabel.font = [UIFont openSansSemiBoldFontWithSize:self.likeButton.titleLabel.font.pointSize];
    self.commentButton.titleLabel.font = [UIFont openSansSemiBoldFontWithSize:self.commentButton.titleLabel.font.pointSize];
    self.shareButton.titleLabel.font = [UIFont openSansSemiBoldFontWithSize:self.shareButton.titleLabel.font.pointSize];
}


#pragma mark - Data
- (void)displayProduct
{
    self.editButton.hidden = ![[TMEUserManager sharedManager].loggedUser.userID isEqual:self.product.user.userID];

    // User
    [self.userAvatarImageView setImageWithURL:[NSURL URLWithString:self.product.user.avatar]
                             placeholderImage:[UIImage imageNamed:@"photo-placeholder"]];
    self.userNameLabel.text = self.product.user.fullName;
    TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
    self.productDateLabel.text = [timeIntervalFormatter stringForTimeInterval:self.product.updateAt.timeIntervalSinceNow];

    // Images
    for (int i=0; i<self.product.images.count; ++i) {
        TMEProductImage *image = self.product.images[i];
        UIImageView *imageView = self.productImageViews[i];
        [imageView setImageWithURL:image.mediumURL placeholderImage:[UIImage imageNamed:@"photo-placeholder"]];
    }

    // Info
    self.nameLabel.text = self.product.name;
    self.priceLabel.text = self.product.price;
    self.descriptionLabel.text =  self.product.productDescription;
    self.locationLabel.text = self.product.venueName;

    self.locationLabel.text = self.product.venueName;

    [self updateLikeInfo];
}


#pragma mark - Action
- (IBAction)likeInfoButtonTouched:(id)sender
{
    if (self.product.likeCount == 0) {
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
    commentsVC.viewModel = self.commentViewModel;

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

- (IBAction)editButtonTouched:(id)sender
{
    TMEEditProductVC *editProductVC = [TMEEditProductVC tme_instantiateFromStoryboardNamed:@"EditProduct"];
    editProductVC.product = self.product;
    [self.navigationController pushViewController:editProductVC animated:YES];
}


#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
    {
        cell.contentView.frame = cell.bounds;
        cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    }

    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == TMEProductDetailSectionImage) {
        if (indexPath.row < self.product.images.count) {
            TMEProductImage *image = self.product.images[indexPath.row];
            CGSize size = [image.dim CGSizeValue];
            return size.height / size.width * (tableView.width - 10);
        } else {
            UIImageView *imageView = self.productImageViews[indexPath.row];
            [imageView.superview removeConstraints:imageView.superview.constraints];
            return 0;
        }
    }

    if (indexPath.section == TMEProductDetailSectionInfo && indexPath.row == 2) {
        CGFloat height = [self.descriptionLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        return height == 0 ? 36 : height + 23;
    }

    if (indexPath.section == TMEProductDetailSectionComment && indexPath.row == 1) {
        // commentsVCContainerView cell
        return self.commentsVCHeight;
    }

    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - TMEProductCommentsVCDelegate
- (void)productCommentsVC:(TMEProductCommentsVC *)commentsVC didChangeHeight:(CGFloat)height
{
    self.commentsVCHeight = height + 20;
    [self.tableView reloadData];
}

#pragma mark - Like
- (void)updateLikeInfo
{
    UIImage *likeImage = self.product.liked ? [UIImage imageNamed:@"icn_liked"] : [UIImage imageNamed:@"icn_like"];
    [self.likeButton setImage:likeImage forState:UIControlStateNormal];

    NSString *likeInfoString = NSStringf(@"%d people like this", self.product.likeCount);
    [self.likeInfoButton setTitle:likeInfoString forState:UIControlStateNormal];
    self.likeInfoButton.userInteractionEnabled = self.product.likeCount > 0;
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
            self.product.likeCount += amount;

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
    NSInteger count = self.commentViewModel.productCommentsCount;

    NSString *infoString = nil;
    if (count == 0) {
        infoString = @"There are no comments";
        self.commentInfoButton.userInteractionEnabled = NO;
    } else if (count <= kMaxCommentCountInBrief) {
        self.commentInfoButton.userInteractionEnabled = NO;
        NSString *formatString = count > 1 ? @"%d comment" : @"%d comments";
        infoString = NSStringf(formatString, count);
    } else {
        self.commentInfoButton.userInteractionEnabled = YES;
        infoString = NSStringf(@"View all %d comments", count);
    }

    [self.commentInfoButton setTitle:infoString forState:UIControlStateNormal];
}

@end
