/*
 特价商品
 */

#import "SpecialCommdityController.h"
#import "SpecialCommCell.h"

@interface SpecialCommdityController ()

@property (nonatomic,weak) UITableView *specialTableview;
@property (nonatomic,copy) NSArray *commDatasource;

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
    
}


#pragma mark tableview代理
//单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

//获取单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellid = [NSString stringWithFormat:@"cellid%ld",(long)indexPath.row];
    SpecialCommCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[SpecialCommCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid andFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / 4)];
    }
    
    cell.lbCommName.text = @"name";
    cell.lbSpecification.text = @"500ml";
    cell.lbSpecialPrice.text = @"$12.8";
    cell.lbPrice.text = @"15.0";
    
    return cell;
}
//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.width / 4;
}
//头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
//脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
