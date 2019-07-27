//
//  Product.m
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 24/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)initWithSKU:(NSInteger *)sku productName:(NSString *)name cost:(float)cost {
    self = [super init];
    if (!self) return nil;
    _sku = sku;
    _name = name;
    _cost = cost;
    return self;
}
@end
