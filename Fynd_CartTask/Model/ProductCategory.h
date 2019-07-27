//
//  ProductCategory.h
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 24/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ProductCategory;
@interface ProductCategory: JSONModel
//@property (nonatomic, readonly) NSString *priority;
//@property (nonatomic, copy, readonly) NSString *description1;
@property (nonatomic, copy, readonly) NSString *name;
//@property (nonatomic, copy, readonly) NSArray *nested_facets;

- (instancetype)initWithCategoryName:(NSString *)categoryName;
@end

@interface Object: JSONModel
//@property (nonatomic, copy, readonly) NSArray<ProductCategory> *all;
- (instancetype)initWithCategoryName:(NSString *)categoryName;
@end

@interface Root: JSONModel
@property (nonatomic, readonly) NSDictionary *meta;
@property (nonatomic, readonly) Object *objects;
@end






NS_ASSUME_NONNULL_END
