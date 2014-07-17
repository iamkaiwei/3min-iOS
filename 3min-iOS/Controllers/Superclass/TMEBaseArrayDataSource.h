//
//  TMEBaseArrayDataSource.h
//  PhotoButton
//
//  Created by Toan Slan on 2/10/14.
//
//

#import <Foundation/Foundation.h>

@interface TMEBaseArrayDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)aCellIdentifier
           delegate:(id)delegate;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
