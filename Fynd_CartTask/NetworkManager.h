//
//  NetworkManager.h
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 24/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductCategory.h"
#import "CommonBlocks.h"
NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

+(NetworkManager *)shared;
@property (nonatomic, readonly) ProductCategory *productCategory;
-(void)fetchProductCategories:(SuccessBlockWithResult)success failure:(FailureBlockWithError)failure;
-(void)fetchProducts:(NSString*)category success:(SuccessBlockWithResult)success failure:(FailureBlockWithError)failure;

@end

NS_ASSUME_NONNULL_END
