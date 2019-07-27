//
//  ProductHeaderCollectionReusableView.h
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 26/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductHeaderCollectionReusableView : UICollectionReusableView
    @property (weak, nonatomic) IBOutlet UILabel *headerTitle;
    @property (weak, nonatomic) IBOutlet UIButton *sortByPrice;
    @property (weak, nonatomic) IBOutlet UIButton *sortByName;
    
@end

NS_ASSUME_NONNULL_END
