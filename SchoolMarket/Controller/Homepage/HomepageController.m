/*
 主页
 */

#import "HomepageController.h"

@interface HomepageController ()   <HomepageCellDelegate>

@property (strong,nonatomic) UITableView *tableview;

@end

@implementation HomepageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tableview  样式为grouped
    self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = NO;  //去掉分割线
    [self.view addSubview:self.tableview];
    
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
    if (section == 0) {
        HCHeaderView *hcHeaderView = [[HCHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150) andImgs:nil];
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
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellid"];
        cell.textLabel.text = @"header";
        return cell;
    } else if (indexPath.section > 0) {   //第二区为商品展示
        HomepageCell *cell = [[HomepageCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width + 15) andSuperVC:self];
        cell.lbTitle.text = [NSString stringWithFormat:@"title%ld",indexPath.row];
        
        //collectionview的实现
        cell.cvComm.dataSource = self;
        cell.cvComm.delegate = self;
        //注册cell
        [cell.cvComm registerClass:[CommCell class] forCellWithReuseIdentifier:@"commcell"];
        
        
        //点击样式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}
//hc cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }
    return self.view.frame.size.width / 6 * 5 + 50;
}

//cv cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}
//cv 单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cvcell = @"commcell";
    CommCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cvcell forIndexPath:indexPath];
    cell.lbName.text = @"comm";
    cell.lbSpecification.text = @"500ml";
    cell.lbPrice.text = @"羊2.50";
    
    return cell;
}
//cv cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width / 4, self.view.frame.size.width / 12 * 5);
}
//cv cell边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, self.view.frame.size.width / 15, 5, 20);
}

//hc更多按钮点击
- (void)hcMoreClick {
    NSLog(@"click");
}

//跳转到超市
- (void)goSuperMarket {
    self.tabBarController.selectedIndex = 1;   //通过tabbar直接跳转
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
