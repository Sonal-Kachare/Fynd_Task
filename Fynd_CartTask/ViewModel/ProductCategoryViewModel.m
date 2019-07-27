//
//  ProductCategoryViewModel.m
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 24/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import "ProductCategoryViewModel.h"
#import "NetworkManager.h"

@implementation ProductCategoryViewModel

+(ProductCategoryViewModel *)shared {
    static ProductCategoryViewModel *sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedModel = [[self alloc] init];
    });
    return sharedModel;
}


-(NSArray<ProductCategory *> *)fetchCategories {
    return @[ ];
}

-(void)fetchProductCategories:(SuccessBlock)success failure:(FailureBlockWithError)failure {
    [NetworkManager.shared fetchProductCategories:^(id result) {
        NSMutableArray<ProductCategory *> *categories = [[NSMutableArray alloc]init];
        NSDictionary *objects = [result objectForKey:@"objects"];
        NSArray *all = [objects objectForKey:@"all"];
        for (id item in all) {
            NSString *category = [item objectForKey:@"name"];
            [categories addObject: [[ProductCategory alloc]initWithCategoryName:category]];
        }
        self.productCategories = (NSArray<ProductCategory> *)[[NSArray alloc]initWithArray:categories];
        success(true);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
