//
//  TMEMeViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 1/2/14.
//
//

#import "TMEMeViewController.h"
#import "TMEMeTableViewCell.h"
#import "TMEMeTableViewCellBackgroundView.h"

@interface TMEMeViewController ()
< UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) NSArray *arrayCellTitleSectionOne;
@property (strong, nonatomic) NSArray *arrayCellTitleSectionTwo;
@property (strong, nonatomic) NSArray *arrayCellTitleSectionThree;
@property (weak, nonatomic) IBOutlet UITableView *tableViewMenu;
@end

@implementation TMEMeViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGRect frame = CGRectMake(9, 0, 302, 568);
    self.tableViewMenu.frame = frame;
  }
  
  self.title = @"";
  self.navigationController.navigationBar.topItem.title = [[TMEUserManager sharedInstance] loggedUser].fullname;
  // Do any additional setup after loading the view from its nib.
  self.arrayCellTitleSectionOne = @[@"Find & Invite Friends", @"Recommended Users"];
  self.arrayCellTitleSectionTwo = @[@"My Listings", @"Offer I Made", @"Stuff I Liked"];
  self.arrayCellTitleSectionThree = @[@"Edit Profile", @"Share Settings", @"Notification Settings", @"Logout"];
  
  [self.tableViewMenu registerNib:[UINib nibWithNibName:NSStringFromClass([TMEMeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TMEMeTableViewCell class])];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  TMEMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMEMeTableViewCell class]) forIndexPath:indexPath];
  
  [self customBackgroundLayerOfCell:cell];
  
  switch (indexPath.section) {
    case 0:
      [cell configCellWithTitle:self.arrayCellTitleSectionOne[indexPath.row]];
      break;
    case 1:
      [cell configCellWithTitle:self.arrayCellTitleSectionTwo[indexPath.row]];
      break;
    default:
      [cell configCellWithTitle:self.arrayCellTitleSectionThree[indexPath.row]];
      break;
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  switch (section) {
    case 0:
      return 2;
    case 1:
      return 3;
    default:
      return 4;
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return [TMEMeTableViewCell getHeight];
}

- (void)customBackgroundLayerOfCell:(UITableViewCell *)cell{
  CGRect frame = cell.backgroundView.frame;
  cell.backgroundView = [[TMEMeTableViewCellBackgroundView alloc] initWithFrame:frame];
  
  CGFloat corner = 0;
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:cell.backgroundView.bounds
                                             byRoundingCorners:UIRectCornerAllCorners
                                                   cornerRadii:CGSizeMake(corner, corner)];
  
  CAShapeLayer  *shapeLayer = (CAShapeLayer *)cell.backgroundView.layer;
  shapeLayer.path = path.CGPath;
  shapeLayer.fillColor = cell.textLabel.backgroundColor.CGColor;
  
  if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
    UIColor *selectedGray = [UIColor colorWithHexString:@"bbbbbb"];
    cell.selectedBackgroundView = [[TMEMeTableViewCellBackgroundView alloc] initWithFrame:frame];
    CAShapeLayer  *shapeSelectedLayer = (CAShapeLayer *)cell.selectedBackgroundView.layer;
    shapeSelectedLayer.path = path.CGPath;
    shapeSelectedLayer.fillColor = [selectedGray CGColor];
  }
  
}

@end
