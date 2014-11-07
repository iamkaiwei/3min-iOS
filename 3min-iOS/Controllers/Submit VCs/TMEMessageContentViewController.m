//
//  TMEMessageContentViewController.m
//  ThreeMin
//
//  Created by iSlan on 11/7/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEMessageContentViewController.h"
#import "TMESubmitCellFactory.h"
#import "TMESubmitLoadingOperation.h"
#import <KHTableViewController/KHOrderedDataProvider.h>

@interface TMEMessageContentViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation TMEMessageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (id<KHCollectionViewCellFactoryProtocol>)cellFactory
{
    return [[TMESubmitCellFactory alloc] init];
}

- (id<KHTableViewSectionModel>)getLoadingContentViewModel
{
    return [[KHOrderedDataProvider alloc] init];
}

- (id<KHLoadingOperationProtocol>)loadingOperationForSectionViewModel:(id<KHTableViewSectionModel>)viewModel forPage:(NSUInteger)page
{
    return [[TMESubmitLoadingOperation alloc] initWithConversationID:[self.parameter.conversationID integerValue] largerReplyID:self.parameter.latestReplyID smallerReplyID:self.parameter.smallerReplyID withPage:page+1];
}

@end
