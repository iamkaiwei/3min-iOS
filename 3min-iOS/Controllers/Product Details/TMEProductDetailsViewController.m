//
//  TMEProductDetailsViewController.m
//  PhotoButton
//
//  Created by Triệu Khang on 21/9/13.
//
//

#import "TMEOfferViewController.h"
#import "TMESubmitViewController.h"
#import "TMEListOffersTableViewController.h"

@interface TMEProductDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnFollow;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIImageView *imgUserAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblTimestamp;
@property (weak, nonatomic) IBOutlet UIImageView *imgProductImage1;
@property (weak, nonatomic) IBOutlet UIImageView *imgProductImage2;
@property (weak, nonatomic) IBOutlet UIImageView *imgProductImage3;
@property (weak, nonatomic) IBOutlet UIImageView *imgProductImage4;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblProductPrice;
@property (weak, nonatomic) IBOutlet UIView *viewChatToBuyWrapper;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewProductDetail;
@property (weak, nonatomic) IBOutlet UIView *viewBottomDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblProductDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblProductLocation;
@property (weak, nonatomic) IBOutlet UILabel *labelLikes;
@property (weak, nonatomic) IBOutlet UILabel *labelBottom;
@property (weak, nonatomic) IBOutlet UIButton *btnChatToBuy;
@property (weak, nonatomic) IBOutlet MTAnimatedLabel *labelChatToBuy;
@property (strong, nonatomic) TMEConversation *conversation;
@property (assign, nonatomic) BOOL firstTimeOffer;

@end

@implementation TMEProductDetailsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

	self.title = self.product.name;

	[self loadProductDetail];
	[self setUpView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self setUpView];
}

- (void)loadProductDetail {
	NSArray *arrayImageView = @[self.imgProductImage1, self.imgProductImage2, self.imgProductImage3, self.imgProductImage4];

	// user
	[self.imgUserAvatar setImageWithURL:[NSURL URLWithString:self.product.user.avatar]];
	self.lblUserName.text = self.product.user.fullName;
	self.lblTimestamp.text = [self.product.createAt relativeDate];

	self.imgProductImage1.hidden = NO;

	NSInteger minCount = MIN(self.product.images.count, 3);

	for (int i = 0; i < minCount; i++) {
		TMEProductImage *img = self.product.images[i];
		[arrayImageView[i] setHidden:NO];
		[arrayImageView[i] setImageWithURL:img.originURL
		                     placeholderImage:[UIImage imageNamed:@"photo-placeholder"]];
	}

	[self.viewBottomDetail alignBelowView:arrayImageView[(minCount == 0 ? 0 : minCount - 1)] offsetY:0 sameWidth:NO];

	self.lblProductName.text = self.product.name;
	self.lblProductPrice.text = [NSString stringWithFormat:@"%@ VND", self.product.price];

	[self.lblProductPrice sizeToFitKeepHeightAlignRight];

	self.labelBottom.text = self.lblProductPrice.text;
	self.labelLikes.text = self.product.likes.stringValue;
	self.btnFollow.selected = self.product.liked;

	self.lblProductLocation.text = self.product.venueID;
	self.lblProductDescription.text = self.product.details;
	[self.lblProductDescription sizeToFitKeepWidth];
	self.viewBottomDetail.height = CGRectGetMaxY(self.lblProductDescription.frame);
	[self.labelBottom sizeToFitKeepHeight];

	[self.scrollViewProductDetail autoAdjustScrollViewContentSize];

	if ([self.product.user.userID isEqual:[TMEUserManager sharedManager].loggedUser.userID]) {
		self.labelChatToBuy.text = NSLocalizedString(@"View Offers", nil);
		return;
	}

	if (self.product.soldOut) {
		self.labelChatToBuy.text = NSLocalizedString(@"Sold", nil);
		self.btnChatToBuy.enabled = NO;
	}
}

- (void)setUpView {
	UIScrollView *scrollView = (UIScrollView *)self.view.subviews[0];
	scrollView.bounces = NO;
	scrollView.showsVerticalScrollIndicator = NO;

	if ([self respondsToSelector:@selector(setExtendedLayoutIncludesOpaqueBars:)]) {
		[self setExtendedLayoutIncludesOpaqueBars:YES];
	}
}

- (UIViewController *)controllerForNextStep {
	if (self.firstTimeOffer) {
		TMEOfferViewController *offerController = [[TMEOfferViewController alloc] init];
		offerController.product = self.product;
		offerController.conversation = self.conversation;
		return offerController;
	}
	else {
		TMESubmitViewController *submitController = [[TMESubmitViewController alloc] init];
		submitController.product = self.product;
		submitController.conversation = self.conversation;
		return submitController;
	}
}

- (IBAction)chatButtonAction:(id)sender {
	if (![TMEReachabilityManager isReachable]) {
		[SVProgressHUD showErrorWithStatus:NSLocalizedString(@"No connection!", nil)];
		return;
	}
	if ([self.product.user.userID isEqual:[TMEUserManager sharedManager].loggedUser.userID]) {
		TMEListOffersTableViewController *listOfferTableViewController = [[TMEListOffersTableViewController alloc] init];
		listOfferTableViewController.product = self.product;
		[self.navigationController pushViewController:listOfferTableViewController animated:YES];
		return;
	}

	[self checkFirstTimeOffer];
}

- (void)checkFirstTimeOffer {
	self.labelChatToBuy.textColor = [UIColor darkGrayColor];
	[self.labelChatToBuy startAnimating];
	[TMEConversationManager checkConversationExistWithProductID:self.product.productID
	                                                   toUserID:self.product.user.userID
	                                             onSuccessBlock: ^(TMEConversation *conversation)
	{
	    self.firstTimeOffer = YES;
	    if (conversation.id) {
	        self.firstTimeOffer = NO;
	        self.conversation = conversation;
		}

	    UIViewController *viewController = [self controllerForNextStep];
	    self.hidesBottomBarWhenPushed = NO;
	    [self.navigationController pushViewController:viewController animated:YES];
	}

	                                               failureBlock: ^(NSError *error)
	{
	    [self.labelChatToBuy stopAnimating];
	}];
}

- (IBAction)onBtnLike:(id)sender {
	self.btnFollow.selected = !self.product.liked;

	if (!self.product.liked) {
		[TMEProductsManager likeProductWithProductID:self.product.productID
		                              onSuccessBlock: ^(NSString *status)
		{
		    if (![status isEqualToString:@"success"]) {
		        [self likeProductFailureHandleButtonLike:sender currentProduct:self.product label:self.labelLikes unlike:NO];
			}
		    self.product.liked = YES;
		    self.product.likes = @([self.product.likes integerValue] + 1);
		    self.labelLikes.text = [@(self.labelLikes.text.integerValue + 1)stringValue];
		}

		                                failureBlock: ^(NSError *error)
		{
		    [self likeProductFailureHandleButtonLike:sender currentProduct:self.product label:self.labelLikes unlike:NO];
		}];
		return;
	}

	[TMEProductsManager unlikeProductWithProductID:self.product.productID
	                                onSuccessBlock: ^(NSString *status)
	{
	    if (![status isEqualToString:@"success"]) {
	        [self likeProductFailureHandleButtonLike:sender currentProduct:self.product label:self.labelLikes unlike:YES];
		}
	    self.product.liked = NO;
	    self.product.likes = @([self.product.likes integerValue] - 1);
	    self.labelLikes.text = [@(self.labelLikes.text.integerValue - 1)stringValue];
	}

	                                  failureBlock: ^(NSError *error)
	{
	    [self likeProductFailureHandleButtonLike:sender currentProduct:self.product label:self.labelLikes unlike:YES];
	}];
}

- (void)likeProductFailureHandleButtonLike:(UIButton *)sender currentProduct:(TMEProduct *)currentProduct label:(UILabel *)label unlike:(BOOL)flag {
	[UIAlertView showAlertWithTitle:NSLocalizedString(@"Something Wrong", nil) message:NSLocalizedString(@"Please try again later!", nil)];
	sender.selected = !currentProduct.liked;
	currentProduct.liked = !currentProduct.liked;

	if (flag) {
	    self.product.likes = @([self.product.likes integerValue] + 1);
		label.text = [@(label.text.integerValue + 1)stringValue];
		return;
	}

	self.product.likes = @([self.product.likes integerValue] - 1);
	label.text = [@(label.text.integerValue - 1)stringValue];
}

@end
