/*
 商品详情
 */
//  Created by tb on 16/4/6.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "CommDetailViewController.h"
#import "CDBottomTool.h"

@interface CommDetailViewController () <UITableViewDataSource, UITableViewDelegate, CDBottomToolDelegate>

@property (nonatomic, weak) CDBottomTool *bottomTool;

/**  商品详情（容器） */
@property (nonatomic, weak) UITableView *detailTbl;

/** 购买数量 */
@property (nonatomic, assign) int shoppingCartNum;

@end

@implementation CommDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    
    CGFloat detailTblW = self.view.bounds.size.width;
    CGFloat detailTblH = (self.view.bounds.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame)) * 0.9;
    NSLog(@"%f", detailTblH);
    [self detailTblWithFrame:CGRectMake(0, 0, detailTblW, detailTblH)];
    
    CGFloat bottomToolW = self.view.bounds.size.width;
    CGFloat bottomToolH = self.view.bounds.size.height * 0.1;
    CGFloat bottomToolY = detailTblH;
    [self bottomToolWithFrame:CGRectMake(0, bottomToolY, bottomToolW, bottomToolH)];
    
    NSLog(@"%f, %f", self.view.bounds.size.height, CGRectGetMaxY(self.view.bounds));
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (UIView *)bottomToolWithFrame:(CGRect)frame
{
    if (self.bottomTool == nil) {
        CDBottomTool *bottomTool = [[CDBottomTool alloc] initWithFrame:frame];
        self.bottomTool = bottomTool;
        [self.view addSubview:self.bottomTool];
    }
    return self.bottomTool;
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
        [self.view addSubview:self.detailTbl];
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
        UIImageView *pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
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
        return self.view.bounds.size.width;
    } else if (indexPath.section == 1) {
        return self.view.bounds.size.width * 0.2;
    } else return tableView.rowHeight;
}


#pragma mark - 点击事件
/**  数量变化 */
- (void)changeNumWithBtn:(UIButton *)btn andNum:(int)num
{
    // 获取当前数量
    int currentNum = btn.currentTitle.intValue;
    
    // 改变数量
    currentNum += num;
    self.bottomTool.shoppingCartNum = currentNum;
    
    // 改变按钮标题
    [btn setTitle:[NSString stringWithFormat:@"%d", currentNum] forState:UIControlStateNormal];
}

/**  增加数量 */
- (void)increase
{
    if (self.bottomTool.changeNumBtn.isHidden == YES) {
        self.bottomTool.buyBtn.hidden = YES;
        self.bottomTool.changeNumBtn.hidden = NO;
    }
    // 需要加一个判断库存是否充足的条件
    [self changeNumWithBtn:self.bottomTool.changeNumBtn andNum:1];
    [self changeNumWithBtn:self.bottomTool.shoppingCartBtn andNum:1];
}

/**  减少数量 */
- (void)decrease
{
    if (self.bottomTool.shoppingCartNum > 1) {
        [self changeNumWithBtn:self.bottomTool.changeNumBtn andNum:-1];
        [self changeNumWithBtn:self.bottomTool.shoppingCartBtn andNum:-1];
    } else {
        self.bottomTool.changeNumBtn.hidden = YES;
        self.bottomTool.buyBtn.hidden = NO;
        [self changeNumWithBtn:self.bottomTool.shoppingCartBtn andNum:-1];
        [self changeNumWithBtn:self.bottomTool.changeNumBtn andNum:-1];
    }
}

/**  购物车 */
- (void)shoppingCart
{
    if (self.tabBarController.selectedIndex != 2) {
        self.tabBarController.selectedIndex = 2;
        [self removeFromParentViewController];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
