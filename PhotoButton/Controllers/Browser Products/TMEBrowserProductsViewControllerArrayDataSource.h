//
//  TMEBrowserProductsViewControllerArrayDataSource.h
//  PhotoButton
//
//  Created by Toan Slan on 2/21/14.
//
//

#import <Foundation/Foundation.h>
#import "TMEBaseArrayDataSource.h"

@interface TMEBrowserProductsViewControllerArrayDataSource : TMEBaseArrayDataSource

@property (nonatomic, strong) NSString *headerIdentifier;


- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)aCellIdentifier
   headerIdentifier:(NSString *)aHeaderIdentifier
           delegate:(id)delegate;

@end
