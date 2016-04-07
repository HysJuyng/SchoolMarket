//
//  SuperMarketView.h
//  SchoolMarket
//
//  Created by tb on 16/4/5.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperMarketView : UIView <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
/**  营业时间试图 */
@property (nonatomic, weak) UIButton *openTimeView;
/**  大分类 */
@property (nonatomic, weak) UITableView *category;
/**  小分类 */
@property (nonatomic, weak) UITableView *subCategory;
/**  商品展示 */
@property (nonatomic, weak) UICollectionView *comm;

@end
