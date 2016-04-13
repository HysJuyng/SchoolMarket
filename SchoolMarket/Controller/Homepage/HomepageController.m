/*
 主页
 */

#import "HomepageController.h"

@interface HomepageController ()   <HomepageCellDelegate>

@property (strong,nonatomic) UITableView *tableview;

@property (nonatomic,strong) NSMutableArray *hotComms;
@property (nonatomic,strong) NSMutableArray *recommendComms;
@property (nonatomic,strong) NSMutableArray *adverImgs;
@end

@implementation HomepageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //导航栏按钮  左1：定位地区   右1：搜索 右2：消息
    //左1 定位地区
    UIButton *reginbtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    [reginbtn setImage:[UIImage imageNamed:@"home_down_arrow"] forState:(UIControlStateNormal)];
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
    
    //初始化tableview  样式为grouped
    self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = NO;  //去掉分割线
    [self.view addSubview:self.tableview];
    
    AFRequest *request = [[AFRequest alloc] init];
    //获取商品数据源
    //-------推荐
    NSString *recommendCommUrl = @"http://schoolserver.nat123.net/SchoolMarketServer/findAllCommodity.jhtml";
    NSDictionary *recommendParam = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"supermarketId", nil];
    [request getComm:recommendCommUrl andParameter:recommendParam andCommBlock:^(NSMutableArray * _Nonnull comms) {
        self.recommendComms = comms;  //获得推荐商品
        //刷新推荐商品
        NSIndexPath *recommendSection = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:recommendSection] withRowAnimation:(UITableViewRowAnimationNone)];
    }];
//    AFRequest *request = [[AFRequest alloc] init];
//    //获取商品数据源
//    //-------推荐
//    NSString *recommendCommUrl = @"http://schoolserver.nat123.net/SchoolMarketServer/findAllCommodity.jhtml";
//    NSDictionary *recommendParam = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"supermarketId", nil];
//    [request getComm:recommendCommUrl andParameter:recommendParam andCommBlock:^(NSMutableArray * _Nonnull comms) {
//        self.recommendComms = comms;  //获得推荐商品
//        //刷新推荐商品
//        NSIndexPath *recommendSection = [NSIndexPath indexPathForRow:0 inSection:1];
//        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:recommendSection] withRowAnimation:(UITableViewRowAnimationNone)];
//    }];
//    //-------热卖
//    NSString *hotCommUrl = @"";
//    [request getComm:hotCommUrl andParameter:nil andCommBlock:^(NSMutableArray * _Nonnull comms) {
//        self.hotComms = comms;  //获得热卖商品
//        //刷新热卖section
//        NSIndexPath *hotSection = [NSIndexPath indexPathForRow:0 inSection:2];
//        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:hotSection] withRowAnimation:(UITableViewRowAnimationNone)];
//    }];
//    //------广告
//    self.adverImgs = [[NSMutableArray alloc] init];
//    NSString *adverUrl = @"";
//    [request getImgs:adverUrl andParameter:nil andImgsBlock:^(NSMutableArray * _Nonnull responseArr) {
//        self.adverImgs = responseArr;  //获得广告图片
//        //刷新广告区域视图
//        [[self.tableview headerViewForSection:0] reloadInputViews];;  //测试 刷新头视图
//    }];

}



//tableview分区区数 （1：头（广告、特价等按钮）  2：推荐   3:热卖  ）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 3;
}
//tableview行数(1：1个、2：2个)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
//tableview头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 150;
    }
    return 0.01f;
}
//tableview脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 50;
    }
    return 5;
}
//tableview头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //第一区的头视图内有公告
    if (section == 0) {
        HCHeaderView *hcHeaderView = [[HCHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 148) andImgs:self.adverImgs];
        //设置公告
        hcHeaderView.lbTitle.text = @"这里放的是公告";
        return hcHeaderView;
    }
    return nil;
}
//tableview脚视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        HCLastFootView *hcLastFV = [[HCLastFootView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        [hcLastFV.btnGoSM addTarget:self action:@selector(goSuperMarket) forControlEvents:(UIControlEventTouchUpInside)];
        hcLastFV.btnGoSM.tag = 101;
        return hcLastFV;
    }
    return nil;
}
//hc 单元格
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
        if (indexPath.section == 1) {
            cellid = @"tuijian";
        } else if(indexPath.section == 2) {
            cellid = @"remai";
        }
        HomepageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[HomepageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andSuperVc:self andFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width + 15)];
        }
        //设置每个cell的内容
        if (indexPath.section == 1) {
            cell.lbTitle.text = @"推荐";
            cell.imgvTitle.image = [UIImage imageNamed:@"home_recommend"];
        } else if(indexPath.section == 2) {
            cell.lbTitle.text = @"热卖";
            cell.imgvTitle.image = [UIImage imageNamed:@"home_hot"];
        }
        
        //collectionview的实现
        cell.cvComm.dataSource = self;
        cell.cvComm.delegate = self;
        //注册cv cell
        [cell.cvComm registerClass:[CommCell class] forCellWithReuseIdentifier:@"commcell"];
        //collection tag
        if (indexPath.section == 1) {
            cell.cvComm.tag = 102;   //推荐
        } else {
            cell.cvComm.tag = 103;    //热卖
        }
        
        //cell点击样式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}
//hc cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.view.frame.size.width / 4;
    }
    return self.view.frame.size.width / 6 * 5 + 50;
}

//cv cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 101) {  //若collectionview为头部的collectionview
        return 4;
    } else if (collectionView.tag == 102) {
        if (self.recommendComms.count == 0) {
            return 6;
        }
        return self.recommendComms.count;
    }
    //若collectionview为非头部的collectionview
    return 6;
}

//cv 单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 101) {  //若collectionview为头部的collectionview
        NSString *cvcell = @"headercell";
        HCHeaderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cvcell forIndexPath:indexPath];
        //设置每个单元格的内容
        if (indexPath.row == 0) {   // 0:特价
            cell.lbTitle.text = @"特价专区";
            cell.imgv.image = [UIImage imageNamed:@"home_special"];
        } else if (indexPath.row == 1) {   //1:签到
            cell.lbTitle.text = @"每日签到";
            cell.imgv.image = [UIImage imageNamed:@"home_qiandao"];
        } else if (indexPath.row == 2) {   //2:优惠
            cell.lbTitle.text = @"优惠";
            cell.imgv.image = [UIImage imageNamed:@"home_youhui"];
        } else if (indexPath.row == 3) {  //3:快递
            cell.lbTitle.text = @"快递";
            cell.imgv.image = [UIImage imageNamed:@"home_kuaidi"];
        }
        
        return cell;
    }
    //若collectionview为非头部的collectionview
    NSString *cvcell = @"commcell";
    CommCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cvcell forIndexPath:indexPath];
    if (collectionView.tag == 102) {
        if (self.recommendComms.count != 0) {
            cell.lbName.text = [((Commodity*)self.recommendComms[indexPath.row]) commName];
            cell.lbSpecification.text = [(Commodity*)self.recommendComms[indexPath.row] specification];
            cell.lbPrice.text = [NSString stringWithFormat:@"$%0.2f",[(Commodity*)self.recommendComms[indexPath.row] price]];
            [cell.commImgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://schoolserver.nat123.net/SchoolMarketServer/uploadDir/%@",[(Commodity*)self.recommendComms[indexPath.row] picture]]] placeholderImage:[UIImage imageNamed:[(Commodity*)self.recommendComms[indexPath.row] picture]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"%@",[(Commodity*)self.recommendComms[indexPath.row] picture]);
                NSLog(@"success");
            }];
        } else {
            cell.lbName.text = @"comm";
            cell.lbSpecification.text = @"500ml";
            cell.lbPrice.text = @"羊2.50";
        }
        
    } else if (collectionView.tag == 103) {
        cell.lbName.text = @"comm";
        cell.lbSpecification.text = @"500ml";
        cell.lbPrice.text = @"羊2.50";
    }
    [cell.btnAdd addTarget:self action:@selector(commCellClickAdd:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.btnMinus addTarget:self action:@selector(commCellClickMinus:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

//cv cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 101 ) {  //若collectionview为头部的collectionview
        return CGSizeMake(self.view.frame.size.width / 4 - 8, self.view.frame.size.width / 4 - 8);
    }
    //若collectionview为非头部的collectionview
    return CGSizeMake(self.view.frame.size.width / 4, self.view.frame.size.width / 12 * 5);
}
//cv cell边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView.tag == 101 ) {  //若collectionview为头部的collectionview
        return UIEdgeInsetsMake(5, 0.5, 0.5, 0.5);
    }
    //若collectionview为非头部的collectionview
    return UIEdgeInsetsMake(5, self.view.frame.size.width / 15, 5, 20);
}
//cv 选中事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (collectionView == self.comm) {
        CommDetailViewController *commDetail = [CommDetailViewController alloc];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:commDetail animated:YES];
        self.hidesBottomBarWhenPushed = NO;
//    }
}

//商品单元格 添加按钮事件 （重用bug）
- (void)commCellClickAdd:(UIButton *)button {
    //获取button所在的cell
    CommCell *cell = (CommCell *)[button superview];
    
    //操作
    [cell addNum];
    int num = [cell commNum];
    if (num > 0) {
        cell.btnMinus.hidden = false;
        cell.lbNum.hidden = false;
        cell.lbNum.text = [NSString stringWithFormat:@"%d",num];
        cell.lbPrice.hidden = true;
    }
}
//商品单元格 减少按钮事件
- (void)commCellClickMinus:(UIButton *)button {
    //获取button所在的cell
    CommCell *cell = (CommCell *)[button superview];
    
    //操作
    [cell minusNum];
    int num = [cell commNum];
    if (num == 0) {
        cell.btnMinus.hidden = true;
        cell.lbNum.hidden = true;
        cell.lbNum.text = @"";
        cell.lbPrice.hidden = false;
    } else {
        cell.lbNum.text = [NSString stringWithFormat:@"%d",num];
    }
}

//跳转到超市
- (void)goSuperMarket {
    self.tabBarController.selectedIndex = 1;   //通过tabbar直接跳转
}

//定位地区
- (void)regionClick {
    NSLog(@"定位");
}
//搜索
- (void)searchClick {
    NSLog(@"搜索");
}
//消息
- (void)messageClick {
    NSLog(@"消息");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
