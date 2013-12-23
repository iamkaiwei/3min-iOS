//
//  TMESubmitViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 12/23/13.
//
//

#import "TMESubmitViewController.h"

@interface TMESubmitViewController()
<UITableViewDataSource,
UITableViewDelegate
>

@end

@interface TMESubmitViewController()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblProductPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblPriceOffered;
@property (weak, nonatomic) IBOutlet UILabel *lblDealLocation;
@property (weak, nonatomic) IBOutlet UITableView *tableViewConversation;
@property (weak, nonatomic) IBOutlet UITextField *txtInputMessage;

@end

@implementation TMESubmitViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"You Offer";
}



@end
