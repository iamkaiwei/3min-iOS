//
//  TMESingleSectionDataSource.h
//  ThreeMin
//
//  Created by Khoa Pham on 9/2/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TMESingleSectionDataSourceCellConfigureBlock)(id cell, id item);
typedef void (^TMESingleSectionDataSourceActionBlock)(id item);

@interface TMESingleSectionDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) NSString *sectionName;

@property (nonatomic, copy) TMESingleSectionDataSourceCellConfigureBlock cellConfigureBlock;
@property (nonatomic, copy) TMESingleSectionDataSourceActionBlock actionBlock;

@end
