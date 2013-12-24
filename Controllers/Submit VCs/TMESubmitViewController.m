//
//  TMESubmitViewController.m
//  PhotoButton
//
//  Created by Toan Slan on 12/23/13.
//
//

#import "TMESubmitViewController.h"
#import "TMESubmitTableCell.h"

@interface TMESubmitViewController()
<UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate
>

@property (strong, nonatomic) NSMutableArray *arrayConversation;

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

- (NSMutableArray *)arrayConversation{
    if (!_arrayConversation) {
        _arrayConversation = [@[] mutableCopy];
    }
    return _arrayConversation;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"You Offer";
    [self.tableViewConversation registerNib:[UINib nibWithNibName:NSStringFromClass([TMESubmitTableCell class]) bundle:Nil] forCellReuseIdentifier:NSStringFromClass([TMESubmitTableCell class])];
    
    self.txtInputMessage.delegate = self;
    
    [self loadTransaction];
    [self loadProductDetail];
    
//    [self autoAdjustScrollViewContentSize];
}

- (void)loadProductDetail
{
    self.lblProductName.text = self.product.name;
    self.lblProductPrice.text = [NSString stringWithFormat:@"$%@",self.product.price];
    [self.imageViewProduct setImageWithURL:[NSURL URLWithString:[[self.product.images anyObject] thumb]]];
    
    self.lblPriceOffered.text = [NSString stringWithFormat:@"$%@",self.product.price];
}

- (void)loadTransaction
{
    [[TMETransactionManager sharedInstance] getListMessageOfProduct:self.product
                                                             toUser:self.product.user
                                                     onSuccessBlock:^(NSArray *arrayDictionary)
    {
        self.arrayConversation = [arrayDictionary mutableCopy];
        [self.tableViewConversation reloadData];
    }
                                                    andFailureBlock:^(NSInteger statusCode,id obj)
    {
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 101;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayConversation.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TMESubmitTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMESubmitTableCell class]) forIndexPath:indexPath];
    [cell configCellWithConversation:self.arrayConversation[indexPath.row]];
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self postTransaction];
    return YES;
}

- (void)postTransaction{
    [[TMETransactionManager sharedInstance] postMessageTo:self.product
                                              withMessage:self.txtInputMessage.text
                                           onSuccessBlock:^(TMETransaction *transaction)
    {
        [self.arrayConversation addObject:transaction];
        [self.tableViewConversation reloadData];
    }
                                          andFailureBlock:^(NSInteger statusCode, id obj)
    {
    
    }];
}

@end
