//
//  ViewController.m
//  Fynd_CartTask
//
//  Created by Sonal Kachare on 24/07/19.
//  Copyright © 2019 Sonal Kachare. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductCategoryViewModel.h"
#import "ProductViewModel.h"
#import "Product.h"
#import "ProductGridCollectionViewCell.h"
#import "ProductListCollectionViewCell.h"
#import "ProductHeaderCollectionReusableView.h"

@interface ProductViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *productsCollectionView;
@property (nonatomic) BOOL isListView;
@end

@implementation ProductViewController

NSString *listReuseIdentifier = @"ListCell";
NSString *gridReuseIdentifier = @"GridCell";
NSString *headerReuseIdentifier =  @"headerView";
NSMutableDictionary *productsWithCategories;

bool isListView = true;

- (void)viewDidLoad {
    [super viewDidLoad];
    productsWithCategories = [[NSMutableDictionary alloc] init];
    isListView = true;
    [self setupCollectionView];
    [self setupLayout:self.view.frame.size];
    [self fetchProductCategories];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self setupLayout:size];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self setupLayout:self.view.frame.size];
}

-(void)setupCollectionView {
    [self.productsCollectionView registerNib:[UINib nibWithNibName:@"ProductListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:listReuseIdentifier];
    [self.productsCollectionView registerNib:[UINib nibWithNibName:@"ProductGridCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:gridReuseIdentifier];
}

- (IBAction)switchView:(id)sender {
    isListView = !isListView;
    [self setupLayout:self.view.frame.size];
}

- (void)fetchProductCategories {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    
    dispatch_async(queue, ^{
        [ProductCategoryViewModel.shared fetchProductCategories:^(BOOL result) {
            if (result) {
                for (ProductCategory *product in ProductCategoryViewModel.shared.productCategories) {
                    [ProductViewModel.shared fetchProducts:product.name success:^(id  _Nonnull result) {
                        [productsWithCategories setValue:result forKey:product.name.lowercaseString];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.productsCollectionView reloadData];
                        });
                    } failure:^(NSError * _Nonnull error) {
                        NSLog(@"%@", error);
                    }];
                }
            }
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    });
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return ProductCategoryViewModel.shared.productCategories.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        ProductHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
        ProductCategory *category = ProductCategoryViewModel.shared.productCategories[indexPath.section];
        header.headerTitle.text = category.name;
        header.sortByName.tag = indexPath.section;
        header.sortByPrice.tag = indexPath.section;
        [header.sortByName addTarget:self action:@selector(sortProductsByName:) forControlEvents:UIControlEventTouchUpInside];
        [header.sortByPrice addTarget:self action:@selector(sortProductsByPrice:) forControlEvents:UIControlEventTouchUpInside];
        reusableview = header;
    }
    return reusableview;
}

-(void)sortProductsByName:(UIButton *)sender {
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                 ascending:YES];
    ProductCategory *category = ProductCategoryViewModel.shared.productCategories[sender.tag];
    NSArray *products = [productsWithCategories valueForKey:category.name.lowercaseString];
    NSArray *sortedArray = [products sortedArrayUsingDescriptors:@[sortDescriptor]];
    [productsWithCategories setValue:sortedArray forKey:category.name.lowercaseString];
    [self.productsCollectionView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag]];
}

-(void)sortProductsByPrice:(UIButton *)sender {
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"cost"
                                                 ascending:YES];
    ProductCategory *category = ProductCategoryViewModel.shared.productCategories[sender.tag];
    NSArray *products = [productsWithCategories valueForKey:category.name.lowercaseString];
    NSArray *sortedArray = [products sortedArrayUsingDescriptors:@[sortDescriptor]];
    [productsWithCategories setValue:sortedArray forKey:category.name.lowercaseString];
    [self.productsCollectionView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ProductCategory *category = ProductCategoryViewModel.shared.productCategories[section];
    NSArray *products = [productsWithCategories valueForKey:category.name.lowercaseString];
    return products.count;
}

- (void)setupLayout:(CGSize)containerSize {
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.productsCollectionView.collectionViewLayout;
    
    if (isListView) {
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(8.0, 0, 8.0, 0);
        
        if (self.productsCollectionView.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
            CGFloat minItemWidth = 300;
            CGFloat numberOfCell = containerSize.width / minItemWidth;
            CGFloat width = (numberOfCell / numberOfCell) * minItemWidth;
            flowLayout.itemSize = CGSizeMake(width, 91);
        } else {
            flowLayout.itemSize = CGSizeMake(containerSize.width, 91);
        }
    } else {
        CGFloat minItemWidth = 120;
        CGFloat numberOfCell = containerSize.width / minItemWidth;
        CGFloat width = (numberOfCell / numberOfCell) * minItemWidth;
        CGFloat height = width * (4.0 / 3.0);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 8;
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.sectionInset = UIEdgeInsetsMake(8.0, 0, 8.0, 0);
    }
    [self.productsCollectionView reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCategory *category = ProductCategoryViewModel.shared.productCategories[indexPath.section];
    NSArray *products = [productsWithCategories valueForKey:category.name.lowercaseString];
    if (isListView) {
        ProductListCollectionViewCell *cell = (ProductListCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:listReuseIdentifier forIndexPath:indexPath];
        [cell setup:products[indexPath.row]];
        return cell;
    } else {
        ProductGridCollectionViewCell *cell = (ProductGridCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:gridReuseIdentifier forIndexPath:indexPath];
        [cell setup:products[indexPath.row]];
        return cell;
    }
}

@end
