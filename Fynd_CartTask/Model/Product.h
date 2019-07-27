//
//  Product.h
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 24/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Product : JSONModel

@property (nonatomic, readonly) NSInteger *sku;
@property (nonatomic, readonly) NSString *name;
@property (readonly) float cost;

- (instancetype)initWithSKU:(NSInteger *)sku productName:(NSString *)name cost:(float)cost;

@end

NS_ASSUME_NONNULL_END
