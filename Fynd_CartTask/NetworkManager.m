//
//  NetworkManager.m
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 24/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import "NetworkManager.h"


@implementation NetworkManager

+(NetworkManager *)shared {
    static NetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

-(void)fetchProductCategories:(SuccessBlockWithResult)success failure:(FailureBlockWithError)failure {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://demo3325365.mockable.io/category"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            NSDictionary *categories = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            success(categories);
        }
    }];
    [dataTask resume];
}

-(void)fetchProducts:(NSString*)category success:(SuccessBlockWithResult)success failure:(FailureBlockWithError)failure {
    NSString *urlString = [@"http://demo3325365.mockable.io/" stringByAppendingString:category.lowercaseString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            NSDictionary *categories = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            success(categories);
        }
    }];
    [dataTask resume];
    
}

@end
