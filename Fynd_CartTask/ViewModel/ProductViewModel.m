//
//  ProductViewModel.m
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 24/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import "ProductViewModel.h"
#import "NetworkManager.h"

@implementation ProductViewModel

+(ProductViewModel *)shared {
    static ProductViewModel *sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedModel = [[self alloc] init];
    });
    return sharedModel;
}

-(void)fetchProducts:(NSString*)category success:(SuccessBlockWithResult)success failure:(FailureBlockWithError)failure {
    [NetworkManager.shared fetchProducts:category success:^(id  _Nonnull result) {
        NSMutableArray<Product *> *products = [[NSMutableArray alloc]init];
        NSArray *objects = [result objectForKey:@"objects"];
        
        for (id item in objects) {
            NSString *productName = [item objectForKey:@"name"];
            NSInteger *productSku = [[item objectForKey:@"sku"] integerValue];
            float productCost = [[item objectForKey:@"cost"] floatValue];
            [products addObject: [[Product alloc]initWithSKU:productSku productName:productName cost:productCost]];
        }
        NSArray *productsArray = (NSArray<Product *> *)[[NSArray alloc]initWithArray:products];
        success(productsArray);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
