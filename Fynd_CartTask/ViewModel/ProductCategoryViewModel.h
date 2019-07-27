//
//  ProductCategoryViewModel.h
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 24/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductCategory.h"
#import "CommonBlocks.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductCategoryViewModel : NSObject
+(ProductCategoryViewModel *)shared;
@property (nonatomic, strong) NSArray<ProductCategory> *productCategories;
-(void)fetchProductCategories:(SuccessBlock)success failure:(FailureBlockWithError)failure;
@end

NS_ASSUME_NONNULL_END
