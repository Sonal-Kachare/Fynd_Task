//
//  ProductListCollectionViewCell.m
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 25/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import "ProductListCollectionViewCell.h"

@implementation ProductListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) setup:(Product*)product {
    self.listView.backgroundColor = [UIColor grayColor];
    self.productImgView.backgroundColor = [UIColor lightGrayColor];
    self.productName.text = product.name;
}

@end
