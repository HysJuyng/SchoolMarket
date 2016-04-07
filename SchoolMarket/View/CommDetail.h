//
//  CommDetail.h
//  SchoolMarket
//
//  Created by tb on 16/4/6.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comm.h"

@interface CommDetail : UIView <UITableViewDataSource, UITableViewDelegate>

/**  商品详情（容器） */
@property (nonatomic, weak) UITableView *detailTbl;

/**  底部工具栏 */
@property (nonatomic, weak) UIView *bottomToolView;
/**  购买按钮 */
@property (nonatomic, weak) UIButton *buyBtn;
/**  数量变化按钮 */
@property (nonatomic, weak) UIButton *changeNumBtn;
/**  增加按钮 */
@property (nonatomic, weak) UIButton *increaseBtn;
/**  减少按钮 */
@property (nonatomic, weak) UIButton *decreaseBtn;
/**  购物车按钮 */
@property (nonatomic, weak) UIButton *shoppingCartBtn;

/**  商品对象 */
@property (nonatomic, strong) Comm *comm;

/** 购买数量 */
@property (nonatomic, assign) int shoppingCartNum;
@end
