//
//  CommDetail.m
//  SchoolMarket
//
//  Created by tb on 16/4/6.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "CommDetail.h"
#import "RootTabBarController.h"

@implementation CommDetail

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat detailTblW = frame.size.width;
        CGFloat detailTblH = frame.size.height * 0.9;
        [self detailTblWithFrame:CGRectMake(0, 0, detailTblW, detailTblH)];
        CGFloat BTViewW = frame.size.width;
        CGFloat BTViewH = frame.size.height - detailTblH;
        CGFloat BTViewY = frame.size.height - BTViewH;
        [self bottomToolViewWithFrame:CGRectMake(0, BTViewY, BTViewW, BTViewH)];
    }
    return self;
}

#pragma mark - 商品详情部分
/**  详情tableView */
- (UITableView *)detailTblWithFrame:(CGRect)frame
{
    if (self.detailTbl == nil) {
        UITableView *detailTbl = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        detailTbl.dataSource = self;
        detailTbl.delegate = self;
        self.detailTbl = detailTbl;
        [self addSubview:self.detailTbl];
    }
    return self.detailTbl;
}

#pragma mark 数据源方法
/**  设置头视图高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

/**  设置脚视图高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4.0f;
}

/**  分组数量 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

/**  每个分组的数量 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else {
        return 2;
    }
}

/**  设置cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        UIImageView *pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        pic.backgroundColor = [UIColor purpleColor];
        [cell addSubview:pic];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"comm";
        cell.textLabel.font = [UIFont systemFontOfSize:30.0f];
        cell.detailTextLabel.text = @"price";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:25.0f];
        cell.detailTextLabel.textColor = [UIColor redColor];
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"specification";
            cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
            cell.textLabel.textColor = [UIColor grayColor];
        } else {
            cell.textLabel.text = @"stock";
            cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
            cell.textLabel.textColor = [UIColor grayColor];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.frame.size.width;
    } else if (indexPath.section == 1) {
        return self.frame.size.width * 0.2;
    } else return tableView.rowHeight;
}

#pragma mark - 底部工具栏
/**  初始化底部工具栏 */
- (UIView *)bottomToolViewWithFrame:(CGRect)frame
{
    if (self.bottomToolView == nil) {
        UIView *bottomToolView = [[UIView alloc] initWithFrame:frame];
        bottomToolView.backgroundColor = [UIColor greenColor];
        
        // 初始化购买按钮和数量变化按钮
        CGFloat BtnW = frame.size.width * 0.4;
        CGFloat BtnH = frame.size.height * 0.5;
        CGFloat BtnX = (frame.size.width - BtnW) * 0.5;
        CGFloat BtnY = (frame.size.height - BtnH) * 0.5;

        [self buyAndChangeNumBtnWithView:bottomToolView andFrame:CGRectMake(BtnX, BtnY, BtnW, BtnH)];
        
        // 初始化购物车按钮
        CGFloat SCBtnH = frame.size.height;
        CGFloat SCBtnW = SCBtnH;
        CGFloat SCBtnY = frame.size.height - SCBtnH * 1.2;
        
        [self shoppingCartBtnWithView:bottomToolView andFrame:CGRectMake(10.0, SCBtnY, SCBtnW, SCBtnH)];
        
        self.bottomToolView = bottomToolView;
        [self addSubview:self.bottomToolView];
    }
    return self.bottomToolView;
}

/**  购买按钮和数量变化按钮 */
- (void)buyAndChangeNumBtnWithView:(UIView *)view andFrame:(CGRect)frame
{
    if (self.buyBtn == nil || self.changeNumBtn == nil) {
        // 立即购买按钮
        if (self.buyBtn == nil) {
            UIButton *buyBtn = [[UIButton alloc] initWithFrame:frame];
            
            // 设置标题
            [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
            
            // 监听方法
            [buyBtn addTarget:commVC action:@selector(increase) forControlEvents:UIControlEventTouchUpInside];
            
            self.buyBtn = buyBtn;
            [view addSubview:self.buyBtn];
        }
        
        // 数量变化按钮
        if (self.changeNumBtn == nil) {
            UIButton *changeNumBtn = [[UIButton alloc] initWithFrame:frame];
            
            // 设置圆角和背景颜色
            changeNumBtn.layer.cornerRadius = 8.0;
            changeNumBtn.backgroundColor = [UIColor whiteColor];
            
            // 设置标题颜色，同时将按钮隐藏
            [changeNumBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            changeNumBtn.hidden = YES;
            
            // 监听方法
            [self increaseAndDecreaseBtnWithButton:changeNumBtn];
            
            self.changeNumBtn = changeNumBtn;
            [view addSubview:self.changeNumBtn];
        }
    }
}

/**  增加按钮和减少按钮 */
- (void)increaseAndDecreaseBtnWithButton:(UIButton *)btn
{
    if (self.increaseBtn == nil || self.decreaseBtn == nil) {
        CGFloat btnH = btn.frame.size.height;
        CGFloat btnW = btnH;
        CGFloat btnX = btn.frame.size.width - btnW;
        // 增加按钮
        if (self.increaseBtn == nil) {
            UIButton *increaseBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, 0, btnW, btnH)];
            // 设置标题文字属性
            [increaseBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [increaseBtn setTitle:@"+" forState:UIControlStateNormal];
            
            // 监听方法
            [increaseBtn addTarget:commVC action:@selector(increase) forControlEvents:UIControlEventTouchUpInside];
            
            self.increaseBtn = increaseBtn;
            [btn addSubview:self.increaseBtn];
        }
        
        // 减少按钮
        if (self.decreaseBtn == nil) {
            UIButton *decreaseBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnW, btnH)];
            // 设置标题文字属性
            [decreaseBtn setTitle:@"-" forState:UIControlStateNormal];
            [decreaseBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            
            // 监听方法
            [decreaseBtn addTarget:commVC action:@selector(decrease) forControlEvents:UIControlEventTouchUpInside];
            
            self.decreaseBtn = decreaseBtn;
            [btn addSubview:self.decreaseBtn];
        }
    }
}

/**  购物车按钮 */
- (void)shoppingCartBtnWithView:(UIView *)view andFrame:(CGRect)frame
{
    UIButton *shoppingCartBtn = [[UIButton alloc] initWithFrame:frame];
    
    // 设置圆角和背景颜色
    shoppingCartBtn.layer.cornerRadius = shoppingCartBtn.frame.size.height * 0.5;
    shoppingCartBtn.backgroundColor = [UIColor whiteColor];
    
    // 设置标题文字(购物车商品数量)属性(数量需从网络获取)
    [shoppingCartBtn setTitle:[NSString stringWithFormat:@"%d", self.shoppingCartNum] forState:UIControlStateNormal];
    [shoppingCartBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    shoppingCartBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    shoppingCartBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    shoppingCartBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    // 监听方法
    [shoppingCartBtn addTarget:commVC action:@selector(shoppingCart) forControlEvents:UIControlEventTouchUpInside];
    
    self.shoppingCartBtn = shoppingCartBtn;
    [view addSubview:self.shoppingCartBtn];
}
@end
