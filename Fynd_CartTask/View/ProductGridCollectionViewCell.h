//
//  ProductGridCollectionViewCell.h
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 25/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductGridCollectionViewCell : UICollectionViewCell
    @property (weak, nonatomic) IBOutlet UIView *gridView;
    @property (weak, nonatomic) IBOutlet UIImageView *productImgView;
    @property (weak, nonatomic) IBOutlet UILabel *productName;
-(void) setup:(Product*)product;
@end

NS_ASSUME_NONNULL_END
