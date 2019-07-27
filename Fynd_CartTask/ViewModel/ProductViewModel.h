//
//  ProductViewModel.h
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 24/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "CommonBlocks.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductViewModel : NSObject
+(ProductViewModel *)shared;
@property (nonatomic, strong) NSArray<Product *> *products;
-(void)fetchProducts:(NSString*)category success:(SuccessBlockWithResult)success failure:(FailureBlockWithError)failure;
@end

NS_ASSUME_NONNULL_END
