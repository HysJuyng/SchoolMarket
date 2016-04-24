/*
 主页
 */

#import "HomepageController.h"

#import "CommCell.h"
#import "HomepageView.h"
#import "Commodity.h"
#import "CommDetailViewController.h"
#import "SpecialCommdityController.h"
#import "AFRequest.h"
#import "FMDBsql.h"


@interface HomepageController ()   <HomepageCellDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CommCellDelegate>

@property (strong,nonatomic) UITableView *tableview;

@property (nonatomic,strong) NSMutableArray *hotComms;
@property (nonatomic,strong) NSMutableArray *recommendComms;
@property (nonatomic,weak) NSMutableArray *adverImgs;
@end

@implementation HomepageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavigationItem];
    
    //初始化tableview  样式为grouped
    self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = NO;  //去掉分割线
    [self.view addSubview:self.tableview];
    
    //获取商品数据源
    //-------推荐
    NSString *recommendCommUrl = @"http://schoolserver.nat123.net/SchoolMarketServer/findAllCommodity.jhtml";
    NSDictionary *recommendParam = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"supermarketId", nil];
    [AFRequest getComm:recommendCommUrl andParameter:recommendParam andCommBlock:^(NSMutableArray * _Nonnull comms) {
        self.recommendComms = comms;  //获得推荐商品
        //填充推荐商品数据
//        [self setCommCellWithCommdatas:self.recommendComms andTableview:self.tableview andSection:1];
        NSIndexPath *recommendSection = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:recommendSection] withRowAnimation:(UITableViewRowAnimationNone)];
    }];

//    //-------热卖
    NSString *hotCommUrl = @"http://schoolserver.nat123.net/SchoolMarketServer/findAllCommodity.jhtml";
    NSDictionary *hotParam = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"supermarketId", nil];
    [AFRequest getComm:hotCommUrl andParameter:hotParam andCommBlock:^(NSMutableArray * _Nonnull comms) {
        self.hotComms = comms;  //获得热卖商品
        //刷新热卖section
        NSIndexPath *hotSection = [NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:hotSection] withRowAnimation:(UITableViewRowAnimationNone)];
    }];
//    //------广告
//    self.adverImgs = [[NSMutableArray alloc] init];
//    NSString *adverUrl = @"";
//    [request getImgs:adverUrl andParameter:nil andImgsBlock:^(NSMutableArray * _Nonnull responseArr) {
//        self.adverImgs = responseArr;  //获得广告图片
//        //刷新广告区域视图
//        [[self.tableview headerViewForSection:0] reloadInputViews];;  //测试 刷新头视图
//    }];

    
}

#pragma mark 设置导航栏
/** 设置导航栏*/
- (void)setNavigationItem {
    //导航栏按钮  左1：定位地区   右1：搜索 右2：消息
    //左1 定位地区
    UIButton *reginbtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        [reginbtn setImage:[UIImage imageNamed:@"home_down_arrow"] forState:(UIControlStateNormal)];
//    [reginbtn setImageEdgeInsets:UIEdgeInsetsMake(10, 90, 10, 0)];
    [reginbtn setTitle:@"五邑大学" forState:(UIControlStateNormal)];
    reginbtn.frame = CGRectMake(0, 0, 60, 30);
    [reginbtn addTarget:self action:@selector(regionClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *tempregion = [[UIBarButtonItem alloc] initWithCustomView:reginbtn];
    self.btnRegion = tempregion;
    //添加左侧按钮
    self.navigationItem.leftBarButtonItem = self.btnRegion;
    //右1 搜索
    UIButton *searchbtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [searchbtn setImage:[UIImage imageNamed:@"home_search"] forState:(UIControlStateNormal)];
    searchbtn.frame = CGRectMake(0, 0, 30, 30);
    [searchbtn addTarget:self action:@selector(searchClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *tempsearch = [[UIBarButtonItem alloc] initWithCustomView:searchbtn];
    self.btnSearch = tempsearch;
    //右2 消息
    UIButton *messagebtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [messagebtn setImage:[UIImage imageNamed:@"home_message"] forState:(UIControlStateNormal)];
    messagebtn.frame = CGRectMake(0, 0, 30, 30);
    [messagebtn addTarget:self action:@selector(messageClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *tempmessage = [[UIBarButtonItem alloc] initWithCustomView:messagebtn];
    self.btnMessage = tempmessage;
    //添加右侧按钮
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:self.btnSearch,self.btnMessage,nil];
    
}

#pragma mark tableview设置方法
/** tableview分区区数 （1：头（广告、特价等按钮）  2：推荐   3:热卖  ）*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 3;
}
/** tableview行数(1：1个、2：2个)*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
/** tableview头视图高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 150;
    }
    return 0.01f;
}
/** tableview脚视图高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 50;
    }
    return 5;
}
/** tableview头视图*/
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //第一区的头视图内有公告
    if (section == 0) {
        HCHeaderView *hcHeaderView = [[HCHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 148) andImgs:self.adverImgs];
        //设置公告
        [hcHeaderView setTitle:@"这里放公告"];
        
        return hcHeaderView;
    }
    return nil;
}
/** tableview脚视图*/
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        HCLastFootView *hcLastFV = [[HCLastFootView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        //添加脚视图监听方法
        [hcLastFV.btnGoSM addTarget:self action:@selector(goSuperMarket) forControlEvents:(UIControlEventTouchUpInside)];
        hcLastFV.btnGoSM.tag = 101;
        return hcLastFV;
    }
    return nil;
}
/** hc 单元格*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {   //第一区为广告和其它按钮
        HCHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"guanggao"];
        if (cell == nil) {
            cell = [[HCHeaderCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / 4)];
        }
        
        //collectionview的实现
        cell.cvHeader.dataSource =self;
        cell.cvHeader.delegate = self;
        //注册cv cell
        [cell.cvHeader registerClass:[HCHeaderCollectionCell class] forCellWithReuseIdentifier:@"headercell"];
        //collection tag
        cell.cvHeader.tag = 101;
        
        //cell点击样式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (indexPath.section > 0) {   //第二区为商品展示
        NSString *cellid = [[NSString alloc]init];
        cellid = @"commcell";
        HomepageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[HomepageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andSuperVc:self andFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width + 15)];
        }
        //设置每个cell的内容
        if (indexPath.section == 1) {
            [cell setTitleAndImage:@"推荐" andImage:@"home_recommend"];
            cell.cvComm.tag = 102;   //推荐
        } else if(indexPath.section == 2) {
            [cell setTitleAndImage:@"热卖" andImage:@"home_hot"];
            cell.cvComm.tag = 103;    //热卖
        }
        
        //collectionview的实现
        cell.cvComm.dataSource = self;
        cell.cvComm.delegate = self;
        //注册cv cell
        [cell.cvComm registerClass:[CommCell class] forCellWithReuseIdentifier:@"commcell"];
        //cell点击样式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}
/** hc cell高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.view.frame.size.width / 4;
    }
    return self.view.frame.size.width / 6 * 5 + 50;
}

#pragma mark collectionview设置方法
/** cv cell个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 101) {  //若collectionview为头部的collectionview
        return 4;
    } else if (collectionView.tag == 102) {
        return 6;
    }
    //若collectionview为非头部的collectionview
    return 6;
}

/** cv 单元格*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 101) {  //若collectionview为头部的collectionview
        NSString *cvcell = @"headercell";
        HCHeaderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cvcell forIndexPath:indexPath];
        //设置每个单元格的内容
        if (indexPath.row == 0) {   // 0:特价
            [cell setTitleAndImage:@"特价" andImage:@"home_special"];
        } else if (indexPath.row == 1) {   //1:签到
            [cell setTitleAndImage:@"签到" andImage:@"home_qiandao"];
        } else if (indexPath.row == 2) {   //2:优惠
            [cell setTitleAndImage:@"优惠" andImage:@"home_youhui"];
        } else if (indexPath.row == 3) {  //3:快递
            [cell setTitleAndImage:@"快递" andImage:@"home_kuaidi"];
        }
        
        return cell;
    }
    //若collectionview为非头部的collectionview
    NSString *cvcell = @"commcell";
    CommCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cvcell forIndexPath:indexPath];
    cell.delegate =self;
    if (collectionView.tag == 102) {
        if (self.recommendComms.count != 0) {
            [cell setCommCell:((Commodity*)self.recommendComms[indexPath.row])];
        } else {
            cell.lbName.text = @"加载中...";
            cell.lbSpecification.text = @"加载中...";
            cell.lbPrice.text = @"加载中...";
        }
        
    } else if (collectionView.tag == 103) {
        if (self.hotComms.count != 0) {
            [cell setCommCell:((Commodity*)self.hotComms[indexPath.row + 6])];
        } else {
            cell.lbName.text = @"加载中...";
            cell.lbSpecification.text = @"加载中...";
            cell.lbPrice.text = @"加载中...";
        }
    }

    return cell;
}

/** cv cell大小*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 101 ) {  //若collectionview为头部的collectionview
        return CGSizeMake(self.view.frame.size.width / 4 - 8, self.view.frame.size.width / 4 - 8);
    }
    //若collectionview为非头部的collectionview
    return CGSizeMake(self.view.frame.size.width / 4, self.view.frame.size.width / 12 * 5);
}
/** cv cell边距*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView.tag == 101 ) {  //若collectionview为头部的collectionview
        return UIEdgeInsetsMake(5, 0.5, 0.5, 0.5);
    }
    //若collectionview为非头部的collectionview
    return UIEdgeInsetsMake(5, self.view.frame.size.width / 15, 5, 20);
}
/** cv 选中事件*/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //当选择第一区的内容的时候
    if (collectionView.tag == 101) {
        UIViewController *subvc;
        if (indexPath.row == 0) {
            subvc = [[SpecialCommdityController alloc] init];
        }
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:subvc animated:true];
        self.hidesBottomBarWhenPushed = NO;
        
    } else if (collectionView.tag == 102 || collectionView.tag == 103) { //当section不在第一区的时候
        CommDetailViewController *commDetail = [CommDetailViewController alloc];
        
//        //正向传值
//        if (collectionView.tag == 102) {
//            commDetail.comm = self.recommendComms[indexPath.row];
//        } else {
//            commDetail.comm = self.hotComms[indexPath.row];
//        }
        
        
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:commDetail animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

#pragma mark 商品cell代理方法
/** 商品单元格 添加按钮事件*/                 //（重用bug）
- (void)commCellClickAdd:(UIButton *)button {
    
    NSLog(@"aadd");
    // 获取button所在的cell
    CommCell *commcell = (CommCell *)[button superview];
    //获得商品model
    Commodity *comm = [self selectedComm:commcell];
    
    //判断库存
    if (comm.selectedNum == [comm.stock intValue]) {
        [self showErrorMessage:@"大于在库数量"];
        return ;
    }
    
    //判断完后操作修改model
    //显示和隐藏
    if (comm.selectedNum == 0) {
        //显示
        commcell.btnMinus.hidden = false;
        commcell.lbNum.hidden = false;
        //隐藏
        commcell.lbPrice.hidden = true;
    }
    //修改数据
    comm.selectedNum ++;   //选中数量自增
    commcell.lbNum.text = [NSString stringWithFormat:@"%d",comm.selectedNum];  //更改cell上的数量显示
    
    
    //操作数据库 从0到1 则插入数据库  否则修改数据库
    if (comm.selectedNum == 1) {
        //插入数据库
        [FMDBsql insertShopcartComm:comm];
    } else {
        //更新数据库
        [FMDBsql updateShopcartComm:comm.commodityId andSelectedNum:comm.selectedNum];
    }
    
}
/** 商品单元格 减少按钮事件*/
- (void)commCellClickMinus:(UIButton *)button {
    
    NSLog(@"minus");
    // 获取button所在的cell
    CommCell *commcell = (CommCell *)[button superview];
    //获得商品model
    Commodity *comm = [self selectedComm:commcell];
    
    //判断完后操作修改model
    //显示和隐藏
    if (comm.selectedNum == 1) {
        //隐藏
        commcell.btnMinus.hidden = true;
        commcell.lbNum.hidden = true;
        //显示
        commcell.lbPrice.hidden = false;
    }
    //修改数据
    comm.selectedNum --;   //选中数量自减
    commcell.lbNum.text = [NSString stringWithFormat:@"%d",comm.selectedNum];  //更改cell上的数量显示
    
    //操作数据库 从1到0 则删除数据库 否则修改数据库
    [FMDBsql updateShopcartComm:comm.commodityId andSelectedNum:comm.selectedNum];
    
}


#pragma mark 自定义方法
/**
 *  获取到数据后填充商品cell数据
 *
 *  @param comms     商品数组
 *  @param tableview 所在tableview
 *  @param section   所在区
 */
- (void)setCommCellWithCommdatas:(NSMutableArray*)comms andTableview:(UITableView*)tableview andSection:(NSInteger)section {
    //遍历数组
    for (int i = 0 ;i < 6 ; i++) {
        
        Commodity* comm = (Commodity*)comms[i];
        
        NSIndexPath *recommendSection = [NSIndexPath indexPathForRow:0 inSection:section];
        HomepageCell *tablecell = (HomepageCell*)[tableview cellForRowAtIndexPath:recommendSection];;
        NSIndexPath *commindexpath = [NSIndexPath indexPathForRow:i inSection:0];
        CommCell *cell = (CommCell*)[tablecell.cvComm cellForItemAtIndexPath:commindexpath];
        
        cell.lbName.text = comm.commName;
        cell.lbPrice.text = comm.price;
        cell.lbSpecification.text = comm.specification;
        [cell.commImgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://schoolserver.nat123.net/SchoolMarketServer/uploadDir/%@",comm.picture]] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",comm.picture]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"success");
        }];
    }
}
/**
 *  获得选中cell的商品model
 *
 *  @param cell 商品cell
 *
 *  @return 返回cell的model
 */
- (Commodity*)selectedComm:(CommCell*)cell {
    //commcell所在的collectionview
    UICollectionView *collectionview = (UICollectionView*)cell.superview;
    
    //求cell在collectionview的indexpath
    NSIndexPath *indexpath = [collectionview indexPathForCell:cell];
    //判断是哪个collection
    if (collectionview.tag == 102) {   //推荐collection
        return self.recommendComms[indexpath.row];
    } else if (collectionview.tag == 103) {    //热卖collection
        return self.hotComms[indexpath.row];
    }
    return nil;
}
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
 *  跳转到超市
 */
- (void)goSuperMarket {
    self.tabBarController.selectedIndex = 1;   //通过tabbar直接跳转
}

/**
 *  定位地区
 */
- (void)regionClick {
    NSLog(@"定位");
}
/**
 *  搜索
 */
- (void)searchClick {
    NSLog(@"搜索");
}
/**
 *  消息
 */
- (void)messageClick {
    NSLog(@"消息");
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
