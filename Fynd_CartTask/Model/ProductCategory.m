//
//  ProductCategory.m
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 24/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import "ProductCategory.h"

@implementation ProductCategory

- (instancetype)initWithCategoryName:(NSString *)categoryName {
    self = [super init];
    if (!self) return nil;
    
    _name = [categoryName copy];
    return self;
}

@end
