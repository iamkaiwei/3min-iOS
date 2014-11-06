//
//  TMEViewController.m
//  ThreeMin
//
//  Created by Triệu Khang on 22/9/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEMyTopProfileViewController.h"
#import "TMETopProfileCellFactory.h"
#import "TMETopUserSection.h"
#import <KHTableViewController/KHCollectionController.h>
#import <KHTableViewController/KHLoadMoreSection.h>
#import <KHTableViewController/KHBasicTableViewModel.h>
#import "TMEProfilePageContentViewController.h"
#import "TMEFollowerViewController.h"
#import "TMEFollowingViewController.h"
#import "TMEMyItemViewController.h"
#import "TMEBrowserPageContentViewController.h"

@interface TMEMyTopProfileViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionTop;
@property (strong, nonatomic) KHCollectionController *collectionController;
@property (strong, nonatomic) TMETopProfileCellFactory *cellFactory;

@end

@implementation TMEMyTopProfileViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

	KHCollectionController *collectionController = [[KHCollectionController alloc] init];
	KHBasicTableViewModel *basicSection = [[KHBasicTableViewModel alloc] init];
	KHLoadMoreSection *loadingSection = [[KHLoadMoreSection alloc] init];
	basicSection.sectionModel = loadingSection;

	self.collectionController = collectionController;
	self.collectionController.model = basicSection;

	self.cellFactory = [[TMETopProfileCellFactory alloc] init];
	self.collectionController.cellFactory = (id)self.cellFactory;
	self.cellFactory.delegate = self;

	self.collectionTop.delegate = self.collectionController;
	self.collectionTop.dataSource = self.collectionController;

	[self.collectionTop reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self loadingUserInformation];
}

- (void)updateViewConstraints {
	[super updateViewConstraints];

	[self.view mas_remakeConstraints: ^(MASConstraintMaker *make) {
	    make.leading.equalTo(self.view.superview).with.offset(0);
	    make.top.equalTo(self.view.superview).with.offset(0);
	    make.width.equalTo(@(self.view.superview.width));
	}];

	[self.view.superview layoutIfNeeded];
}

- (void)loadingUserInformation {
	TMEUserNetworkClient *client = [[TMEUserNetworkClient alloc] init];
	[client getFullInformationWithUserID:[self.user.userID integerValue] success: ^(TMEUser *user) {
	    KHBasicTableViewModel *basicSection = [[KHBasicTableViewModel alloc] init];

	    TMETopUserSection *userInfoSection = [[TMETopUserSection alloc] init];
	    userInfoSection.user = user;

	    basicSection.sectionModel = userInfoSection;

	    self.collectionController.model = basicSection;
	    [self.collectionTop reloadData];
	} failure: ^(NSError *error) {
	}];
}

#pragma mark - Cell delegate

- (void)onTapMyLikes {
}

- (void)onTapPositive {
}

- (void)onTapFollowers {
	TMEFollowerViewController *vc = [[UIStoryboard storyboardWithName:@"TMEFollowerViewController" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([TMEFollowerViewController class])];
	vc.user = self.user;
	UINavigationController *nav = (UINavigationController *)self.parentViewController.parentViewController.parentViewController;
	[nav pushViewController:vc animated:YES];
	return;
}

- (void)onTapFollwings {
	TMEFollowingViewController *vc = [[UIStoryboard storyboardWithName:@"TMEFollowingViewController" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([TMEFollowingViewController class])];
	vc.user = self.user;
	UINavigationController *nav = (UINavigationController *)self.parentViewController.parentViewController.parentViewController;
	[nav pushViewController:vc animated:YES];
	return;
}

- (void)onTapMyItems {
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor whiteColor];
	TMEMyItemViewController *vc = [[UIStoryboard storyboardWithName:@"TMEMyItemViewController" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([TMEMyItemViewController class])];
//	TMEBrowserPageContentViewController *vc = [[UIStoryboard storyboardWithName:@"TMEBrowserPageContentViewController" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([TMEBrowserPageContentViewController class])];
    UINavigationController *nav = (UINavigationController *)self.parentViewController.parentViewController.parentViewController;
	[nav pushViewController:vc animated:YES];
    return;
}

- (void)onTapEdit {
}

@end
