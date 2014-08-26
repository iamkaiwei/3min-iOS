//
//  FPArrayDataSource.h
//  FoxPlay
//
//  Created by iSlan on 5/21/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CollectionViewCellConfigureBlock)(id cell, id item);
typedef NSString * (^IdentifierParserBlock)(id item);

@interface FPCollectionArrayDataSource : NSObject<UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *items;

- (id)initWithItems  :(NSArray *)items
identifierParserBlock:(IdentifierParserBlock)parserBlock
 configureCellBlock  :(CollectionViewCellConfigureBlock)configureCellBlock;

@end
