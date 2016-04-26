/*
 特价商品
 */

#import "SpecialCommdityController.h"
#import "Commodity.h"
#import "CommDetailViewController.h"
#import "AFRequest.h"
#import "SpecialCommCell.h"
#import "SCCAddAndMinusView.h"
#import "LbMiddleLine.h"
#import "FMDBsql.h"

@interface SpecialCommdityController () <UITableViewDataSource,UITableViewDelegate,SCCAddAndMinusViewDelegate>

@property (nonatomic,weak) UITableView *specialTableview;

@property (nonatomic,strong) NSMutableArray *specialComms;

@end

@implementation SpecialCommdityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"特价专区";
    
    //创建tableview
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.specialTableview = tableview;
    [self.view addSubview:self.specialTableview];
    
    self.specialTableview.delegate = self;
    self.specialTableview.dataSource = self;
    
    //创建购物车按钮
    [self shoppingCartBtnWithFrame:CGRectMake(10, self.view.frame.size.height - 60, 50, 50)];
    
    
}

- (NSMutableArray *)specialComms {
    if (! _specialComms) {
        //获取特价商品
        NSString *url = @"http://schoolserver.nat123.net/SchoolMarketServer/findAllCommodity.jhtml";
        NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"supermarketId", nil];
        [AFRequest getComm:url andParameter:param andCommBlock:^(NSMutableArray * _Nonnull comms) {
            //获得数据
            self.specialComms = comms;
            //reload tableview
            [self.specialTableview reloadData];
            NSLog(@"123");
        }];
    }
    return _specialComms;
}


#pragma mark 购物车按钮
/**  购物车按钮 */
- (void)shoppingCartBtnWithFrame:(CGRect)frame
{
    UIButton *shoppingCartBtn = [[UIButton alloc] initWithFrame:frame];
    
    // 设置圆角和背景颜色
    shoppingCartBtn.layer.cornerRadius = shoppingCartBtn.frame.size.height * 0.5;
    shoppingCartBtn.backgroundColor = [UIColor whiteColor];
    
    //设置图片
    [shoppingCartBtn setBackgroundImage:[UIImage imageNamed:@"cart_btn"] forState:(UIControlStateNormal)];
    
    // 设置标题文字(购物车商品数量)属性(数量需从网络获取)
    
    self.shoppingCartNum = [FMDBsql getShopcartAllSelectedNum];
    
    [shoppingCartBtn setTitle:[NSString stringWithFormat:@"%d", self.shoppingCartNum] forState:UIControlStateNormal];
    [shoppingCartBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    shoppingCartBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    shoppingCartBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    shoppingCartBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    // 监听方法
    [shoppingCartBtn addTarget:self action:@selector(shoppingCart) forControlEvents:UIControlEventTouchUpInside];
    
    self.shoppingCartBtn = shoppingCartBtn;
    [self.view addSubview:self.shoppingCartBtn];
}

#pragma mark tableview代理方法
/** 单元格个数*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.specialComms.count;
}

/** 获取单元格*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellid = @"cellid";
    SpecialCommCell *cell = (SpecialCommCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[SpecialCommCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / 4)];
    }
    
    //cell选中样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //设置内容
    Commodity *comm = self.specialComms[indexPath.row];
    [cell setSpecialComm:(Commodity*)comm];
    //设置代理和tag
    cell.addAndMinusView.delegate = self;
    cell.addAndMinusView.btnAdd.tag = indexPath.row;
    cell.addAndMinusView.btnMinus.tag = indexPath.row;
    
    return cell;
}
/** 单元格高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.width / 4;
}
/** 头视图高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
/** 脚视图高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 70;
}
/** 选中单元格*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommDetailViewController *subvc = [[CommDetailViewController alloc] init];
    
    //正向传值
    subvc.comm = self.specialComms[indexPath.row];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subvc animated:true];
}


#pragma mark 特价商品cell代理方法
/** 商品加*/
- (void)addNum:(UIButton*)button {
    NSLog(@"add");
    
    //判断库存
    if (((Commodity*)self.specialComms[button.tag]).selectedNum == [((Commodity*)self.specialComms[button.tag]).stock intValue]) {
        [self showErrorMessage:@"大于在库数量"];
        return ;
    }
    
    //显示控件
    if (((Commodity*)self.specialComms[button.tag]).selectedNum == 0) {
        ((SCCAddAndMinusView*)button.superview).btnMinus.hidden = false;
        ((SCCAddAndMinusView*)button.superview).selectedNum.hidden = false;
    }
    
    
    
    //===数量自增
    //商品cell数量
    ((Commodity*)self.specialComms[button.tag]).selectedNum++;
    //购物车图标数量
    self.shoppingCartNum++;
    //===更新文本
    //商品cell数量文本
    ((SCCAddAndMinusView*)button.superview).selectedNum.text = [NSString stringWithFormat:@"%d",((Commodity*)self.specialComms[button.tag]).selectedNum];
    //购物车图标文本
    [self.shoppingCartBtn setTitle:[NSString stringWithFormat:@"%d",self.shoppingCartNum] forState:(UIControlStateNormal)];
    
    
    //操作数据库 从0到1 则插入数据库  否则修改数据库
    if (((Commodity*)self.specialComms[button.tag]).selectedNum == 1) {
        //插入数据库
        [FMDBsql insertShopcartComm:((Commodity*)self.specialComms[button.tag])];
    } else {
        //更新数据库
        [FMDBsql updateShopcartComm:((Commodity*)self.specialComms[button.tag]).commodityId andSelectedNum:((Commodity*)self.specialComms[button.tag]).selectedNum];
    }
    
}
/** 商品减*/
- (void)minusNum:(UIButton*)button  {
    NSLog(@"minus");
    
    //隐藏控件
    if (((Commodity*)self.specialComms[button.tag]).selectedNum == 1) {
        ((SCCAddAndMinusView*)button.superview).btnMinus.hidden = true;
        ((SCCAddAndMinusView*)button.superview).selectedNum.hidden = true;
    }
    
    //===数量自增
    //商品cell数量
    ((Commodity*)self.specialComms[button.tag]).selectedNum--;
    //购物车图标数量
    self.shoppingCartNum--;
    //===更新文本
    //商品cell数量文本
    ((SCCAddAndMinusView*)button.superview).selectedNum.text = [NSString stringWithFormat:@"%d",((Commodity*)self.specialComms[button.tag]).selectedNum];
    //购物车图标文本
    NSString *shopcartbtnnum;
    if (self.shoppingCartNum == 0) {
        shopcartbtnnum = @"";
    } else {
        shopcartbtnnum = [NSString stringWithFormat:@"%d",self.shoppingCartNum];
    }
    [self.shoppingCartBtn setTitle:shopcartbtnnum forState:(UIControlStateNormal)];
    
    
    //操作数据库 从1到0 则删除数据库 否则修改数据库
    [FMDBsql updateShopcartComm:((Commodity*)self.specialComms[button.tag]).commodityId andSelectedNum:((Commodity*)self.specialComms[button.tag]).selectedNum];
}

#pragma mark 其它自定义方法
/**
 *  错误信息提示
 *
 *  @param message 错误信息
 */
- (void)showErrorMessage:(NSString*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:(UIAlertControllerStyleAlert)];
    //action
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel");
    }];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:true completion:nil];
}
/**
 *  跳转购物车
 */
- (void)shoppingCart
{
    self.tabBarController.selectedIndex = 2;
    [self.navigationController popToRootViewControllerAnimated:true];
    [self removeFromParentViewController];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"hahaha");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"lilii");
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
