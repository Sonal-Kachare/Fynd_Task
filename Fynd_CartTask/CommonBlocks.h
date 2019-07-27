//
//  CommonBlocks.h
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 25/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonBlocks : NSObject
typedef void (^SuccessBlockWithResult) (id result);
typedef void (^FailureBlockWithError) (NSError *error);
typedef void (^SuccessBlock) (BOOL result);

@end

NS_ASSUME_NONNULL_END
