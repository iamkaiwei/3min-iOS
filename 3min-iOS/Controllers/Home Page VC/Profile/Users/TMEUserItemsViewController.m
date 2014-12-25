//
//  TMEUserItemsViewController.m
//  ThreeMin
//
//  Created by Vinh Nguyen on 22/12/2014.
//  Copyright (c) Năm 2014 3min. All rights reserved.
//

#import "TMEUserItemsViewController.h"
#import <KHTableViewController/KHCollectionController.h>
#import <KHTableViewController/KHContentLoadingCellFactory.h>
#import <KHTableViewController/KHOrderedDataProvider.h>
#import "TMEUserItemsLoadingOperation.h"
#import "TMEBrowserProductCellFactory.h"
#import "TMEFeedback.h"
#import "TMEFeedbackView.h"
#import "TMEFeedbacksVC.h"

@interface TMEUserItemsViewController ()
<
UICollectionViewDelegateFlowLayout,
TMEProductCollectionViewCellDelegate,
KHBasicOrderedCollectionViewControllerProtocol,
TMEFeedbackViewDelegate
>

@property (nonatomic, copy) NSArray *feedbacks;
@end

@implementation TMEUserItemsViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self handleFeedback];
    [self enablePullToRefresh];
}

#pragma mark - Setup

- (id <KHCollectionViewCellFactoryProtocol> )cellFactory
{
    TMEBrowserProductCellFactory *cellFactory = [[TMEBrowserProductCellFactory alloc] init];
    cellFactory.delegate = self;
    return cellFactory;
}

- (UICollectionViewLayout *)getCollectionViewLayout
{
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.columnCount = 2;
    layout.minimumColumnSpacing = 5;
    layout.minimumInteritemSpacing = 6;
    // inset
    UIEdgeInsets feedbackInset = UIEdgeInsetsMake(180.f, 0, 0, 0);
    layout.sectionInset = self.feedbacks.count > 0 ? feedbackInset : UIEdgeInsetsZero;
    return layout;
}

- (id <KHTableViewSectionModel> )getLoadingContentViewModel
{
    return [[KHOrderedDataProvider alloc] init];
}

- (id <KHLoadingOperationProtocol> )loadingOperationForSectionViewModel:(id <KHTableViewSectionModel> )viewModel forPage:(NSUInteger)page
{
    return [[TMEUserItemsLoadingOperation alloc] initWithUserID:[self.user.userID unsignedIntegerValue] page:page + 1];
}

#pragma mark - Collection delegate

- (void)tapOnDetailsProductOnCell:(TMEProductCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
    ProductCollectionCellAct(self, product, TMEProductCollectionCellGoDetails);
}

- (void)tapOnLikeProductOnCell:(TMEProductCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
    ProductCollectionCellAct(self, product, TMEProductCollectionCellLike);
}

- (void)tapOnCommentProductOnCell:(TMEProductCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
    ProductCollectionCellAct(self, product, TMEProductCollectionCellComment);
}

- (void)tapOnShareProductOnCell:(TMEProductCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
    ProductCollectionCellAct(self, product, TMEProductCollectionCellShare);
}

- (void)tapOnViewProfileOnProductOnCell:(TMEProductCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    TMEProduct *product = (TMEProduct *)[self itemAtIndexPath:indexPath];
    ProductCollectionCellAct(self, product, TMEProductCollectionCellViewProfile);
}

#pragma mark - Get Feedbacks

- (void)handleFeedback
{
    [TMEFeedbackClient getFeedbacksForUser:self.user success:^(NSArray *feedbacks) {
        self.feedbacks = feedbacks;
        NSUInteger feedbackCount = feedbacks.count;
        if (feedbackCount > 0) {
            TMEFeedbackView *feedbackView = [TMEFeedbackView new];
            [self.collectionView addSubview:feedbackView];
            feedbackView.feedbackViewDelegate = self;
            [feedbackView.viewFeedbackButton setTitle:[NSString stringWithFormat:@"View %@ feedbacks", @(feedbackCount)]
                                             forState:UIControlStateNormal];
            
            TMEFeedback *feedback = [feedbacks firstObject];
            feedbackView.feedback = feedback;
            [self.collectionView layoutIfNeeded];
        }
    } failure:^(NSError *error) {
        DLog(@"%@", error);
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

#pragma mark - View delegate

- (void)didTapViewFeedbackButton:(UIButton *)button
{
    TMEFeedbacksVC *vc = [TMEFeedbacksVC tme_instantiateFromStoryboardNamed:@"Feedback"];
    vc.user = self.user;
    
    if (IS_IOS8_OR_ABOVE) {
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    } else {
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
    }
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end
