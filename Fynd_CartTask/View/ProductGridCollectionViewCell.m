//
//  ProductGridCollectionViewCell.m
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 25/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import "ProductGridCollectionViewCell.h"

@implementation ProductGridCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) setup:(Product*)product {
    self.productImgView.backgroundColor = [UIColor lightGrayColor];
    self.gridView.backgroundColor = [UIColor grayColor];
    self.productName.text = product.name;
}

@end
