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

@interface SpecialCommdityController () <UITableViewDataSource,UITableViewDelegate,SCCAddAndMinusViewDelegate>

@property (nonatomic,strong) UITableView *specialTableview;

@property (nonatomic,strong) NSMutableArray *specialComms;

@end

@implementation SpecialCommdityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"特价专区";
    
    //创建tableview
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.specialTableview = tableview;
    [self.view addSubview:self.specialTableview];
    
    self.specialTableview.delegate = self;
    self.specialTableview.dataSource = self;
    
    //创建购物车按钮
    [self shoppingCartBtnWithFrame:CGRectMake(20, self.view.frame.size.height - 80, 60, 60)];
    
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
    
    
    //测试 过后删
    //===============
    self.specialComms = [[NSMutableArray alloc] init];
    for (int i = 0; i < 6;  i++) {
        Commodity *comm = [[Commodity alloc] init];
        comm.commName = @"name";
        comm.specification = @"10g";
        comm.price = @"12";
        
        [self.specialComms addObject:comm];
    }
    //===============
    
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
    if (self.specialComms.count != 0) {
//        return self.specialComms.count;
        return 4;
    }
    return 6;
}

/** 获取单元格*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *cellid = [NSString stringWithFormat:@"cellid%ld",(long)indexPath.row];
    NSString *cellid = @"cellid";
    SpecialCommCell *cell = (SpecialCommCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[SpecialCommCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / 4)];
    }
    
    
    //cell选中样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //设置内容
    if (self.specialComms.count != 0) {
        #pragma mark - BUG_刷新数据会崩溃  -
        [cell setSpecialComm:(Commodity*)self.specialComms[indexPath.row]];
        
    } else {
//        cell.lbCommName.text = @"name";
//        cell.lbSpecification.text = @"500ml";
//        cell.lbSpecialPrice.text = @"$12.8";
//        cell.lbPrice.text = @"15.0";
        [cell setSpecialComm:(Commodity*)self.specialComms[indexPath.row]];
    }
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
    return 0.01f;
}
/** 选中单元格*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommDetailViewController *subvc = [CommDetailViewController alloc];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subvc animated:true];
}


#pragma mark 特价商品cell代理方法
/** 商品加*/
- (void)addNum:(UIButton*)button {
    NSLog(@"add");
    
    //显示控件
    if (((Commodity*)self.specialComms[button.tag]).selectedNum == 0) {
        ((SCCAddAndMinusView*)button.superview).btnMinus.hidden = false;
        ((SCCAddAndMinusView*)button.superview).selectedNum.hidden = false;
    }
    
    //数量自增
    ((Commodity*)self.specialComms[button.tag]).selectedNum++;
    //更新文本
    ((SCCAddAndMinusView*)button.superview).selectedNum.text = [NSString stringWithFormat:@"%d",((Commodity*)self.specialComms[button.tag]).selectedNum];
    
    
}
/** 商品减*/
- (void)minusNum:(UIButton*)button  {
    NSLog(@"minus");
    
    //隐藏控件
    if (((Commodity*)self.specialComms[button.tag]).selectedNum == 1) {
        ((SCCAddAndMinusView*)button.superview).btnMinus.hidden = true;
        ((SCCAddAndMinusView*)button.superview).selectedNum.hidden = true;
    }
    
    //数量自增
    ((Commodity*)self.specialComms[button.tag]).selectedNum--;
    //更新文本
    ((SCCAddAndMinusView*)button.superview).selectedNum.text = [NSString stringWithFormat:@"%d",((Commodity*)self.specialComms[button.tag]).selectedNum];
}

#pragma mark 其它自定义方法
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
