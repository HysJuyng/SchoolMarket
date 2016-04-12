/*
 超市
 */

#import "SuperMarketViewController.h"
#import "Categories.h"
#import "CategoriesCell.h"
#import "SubCategoriesCell.h"
#import "Comm.h"
#import "CommCell.h"
#import "CommDetailViewController.h"

@interface SuperMarketViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
/**  营业时间试图 */
@property (nonatomic, weak) UIButton *openTimeView;
/**  大分类 */
@property (nonatomic, weak) UITableView *category;
/**  小分类 */
@property (nonatomic, weak) UITableView *subCategory;
/**  商品展示 */
@property (nonatomic, weak) UICollectionView *comm;

/**  分类对象数组 */
@property (nonatomic, strong) NSArray *categoriesList;

/**  collectionViewCell边距 */
@property (nonatomic, assign) CGFloat margin;

/**  被选择的分类 */
@property (nonatomic, strong) Categories *selectedCategory;

/**  被选择的商品 */
@property (nonatomic, strong) Comm *selectedComm;

@end

@implementation SuperMarketViewController

- (NSArray *)categoriesList
{
    if (_categoriesList == nil) {
        _categoriesList = [Categories categoriesList];
    }
    return _categoriesList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    [self BarButtonItem];
    
    CGFloat frameY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat frameW = self.view.bounds.size.width;
    CGFloat frameH = CGRectGetMinY(self.tabBarController.tabBar.frame);
        
    CGRect frame = CGRectMake(0, frameY, frameW, frameH);
    [self openTimeViewWithFrame:frame];
    [self categoryTableViewWithFrame:frame];
    [self subCategoryTablelViewWithFrame:frame];
    [self commCollectionViewWithFrame:frame];
    
    [self setSelectedIndexPath:self.category];
    // 被点击的分类
    self.selectedCategory = self.categoriesList[0];
    // 刷新子分类数据
    [self.subCategory reloadData];
    [self setSelectedIndexPath:self.subCategory];
}

#pragma mark - 创建导航控制器Item
/**  创建导航控制器Item */
- (void)BarButtonItem
{
    // 设置定位
    UIButton *test = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    test.backgroundColor = [UIColor orangeColor];
    UIBarButtonItem *locationItem = [[UIBarButtonItem alloc] initWithCustomView:test];
    self.navigationItem.leftBarButtonItem = locationItem;
    
    // 设置消息
    UIButton *test1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    test1.backgroundColor = [UIColor magentaColor];
    UIBarButtonItem *chatItem = [[UIBarButtonItem alloc] initWithCustomView:test1];
    
    // 设置搜索
    UIButton *test2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    test2.backgroundColor = [UIColor purpleColor];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:test2];
    
    self.navigationItem.rightBarButtonItems = @[chatItem, searchItem];
}

#pragma mark - 添加控件

#pragma mark 营业时间
/**  创建营业时间 */
- (UIButton *)openTimeViewWithFrame:(CGRect)frame
{
    if (self.openTimeView == nil) {
        CGFloat openTimeViewW = frame.size.width;
        UIButton *openTimeView = [[UIButton alloc] initWithFrame:CGRectMake(0, frame.origin.y, openTimeViewW, 20)];
        
        // 设置按钮颜色
        openTimeView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        // 设置按钮文字
        [openTimeView setTitle:@"超市营业时间：9:00 - 23:00" forState:UIControlStateNormal];
        [openTimeView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        openTimeView.titleLabel.font = [UIFont systemFontOfSize:14.0];
        // 设置文字偏移量
        openTimeView.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 80);
        
        // 设置按钮不可用
        openTimeView.enabled = NO;
        
        // 设置时钟图片
        
        [self.view addSubview:(self.openTimeView = openTimeView)];
    }
    return self.openTimeView;
}

#pragma mark - 分类
/**  创建大分类category */
- (UITableView *)categoryTableViewWithFrame:(CGRect)frame
{
    if (self.category == nil) {
        CGFloat categoryY = CGRectGetMaxY(self.openTimeView.frame);
        CGFloat categoryW = frame.size.width * 0.3;
        CGFloat categoryH = frame.size.height - categoryY;
        
        UITableView *category = [[UITableView alloc] initWithFrame:CGRectMake(0, categoryY, categoryW, categoryH) style:UITableViewStylePlain];
        category.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.06];
        category.delegate = self;
        category.dataSource = self;
        // 设置单元格分割线
        category.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:(self.category = category)];
    }
    return self.category;
}

/**  创建小分类subCategory */
- (UITableView *)subCategoryTablelViewWithFrame:(CGRect)frame
{
    if (self.subCategory == nil) {
        CGFloat subH = frame.size.width - CGRectGetWidth(self.category.frame);
        CGFloat subW = 44;
        CGFloat subX = subH * 0.5 + CGRectGetWidth(self.category.frame) - subW / 2;
        CGFloat subY = self.category.frame.origin.y - (subH - subW) * 0.5;
        
        UITableView *subCategory = [[UITableView alloc] initWithFrame:CGRectMake(subX, subY, subW, subH)];
        subCategory.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.06];
        // 使滚动条不可见
        subCategory.showsVerticalScrollIndicator = NO;
        // 逆时针旋转90°
        subCategory.transform = CGAffineTransformMakeRotation(-M_PI_2);
        subCategory.separatorStyle = UITableViewCellSeparatorStyleNone;
        subCategory.delegate = self;
        subCategory.dataSource = self;
        
        [self.view addSubview:(self.subCategory = subCategory)];
    }
    return self.subCategory;
}

#pragma mark 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.category) {
        // 如果是主分类TableView，则返回主分类的数量
        return self.categoriesList.count;
    } else {
        // 如果是子分类TableView，则返回子分类的数量
        return self.selectedCategory.subCategories.count;
    }
}

/**  设置tableViewCell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    UITableViewCell *cell = nil;
    if (tableView == self.category) {
        // 主分类
        cell = [CategoriesCell cellWithTableView:tableView];
        // 通过数据模型，设置Cell内容
        Categories *category = self.categoriesList[indexPath.row];
        cell.textLabel.text = category.name;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        // 子分类
        cell = [SubCategoriesCell cellWithTableView:tableView];
        
        cell.textLabel.text = self.selectedCategory.subCategories[indexPath.row];
        [cell.textLabel sizeToFit];
        cell.textLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
        tableView.rowHeight = cell.textLabel.frame.size.height + 10;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}

#pragma mark 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.category) {
        // 被点击的分类
        self.selectedCategory = self.categoriesList[indexPath.row];
        // 刷新子分类数据
        [self.subCategory reloadData];
        [self setSelectedIndexPath:self.subCategory];
    }
}

- (void)setSelectedIndexPath:(UITableView *)tableView
{
    // 设置默认选中第一个cell
    NSInteger selectedIndex = 0;
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - 商品展示
/**  创建商品展示comm */
- (UICollectionView *)commCollectionViewWithFrame:(CGRect)frame
{
    if (self.comm == nil) {
        CGFloat commX = self.subCategory.frame.origin.x;
        CGFloat commY = CGRectGetMaxY(self.subCategory.frame);
        CGFloat commW = frame.size.width - self.category.frame.size.width;
        CGFloat commH = frame.size.height - commY;
        
        UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView *comm = [[UICollectionView alloc] initWithFrame:CGRectMake(commX, commY, commW, commH) collectionViewLayout:layout];
        comm.backgroundColor = [UIColor whiteColor];
        comm.dataSource = self;
        comm.delegate = self;
        self.margin = comm.frame.size.width * 0.05;
        
        [self.view addSubview:(self.comm = comm)];
        [self.comm registerClass:[CommCell class] forCellWithReuseIdentifier:@"commcell"];
    }
    return self.comm;
}

#pragma mark 数据源方法
/**  返回collectionViewCell数量 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

/**  设置cell单元格 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"commcell";
    CommCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.lbName.text = @"comm";
    cell.lbSpecification.text = @"500ml";
    cell.lbPrice.text = @"羊2.50";
    
    // 添加监听方法
    [cell.btnAdd addTarget:self action:@selector(commCellClickAdd:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.btnMinus addTarget:self action:@selector(commCellClickMinus:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

/**  商品单元格 添加按钮事件 （重用bug） */
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

/**  商品单元格 减少按钮事件 */
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

#pragma mark 代理方法
/**  设置cell边距 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat margin = self.margin;
    return UIEdgeInsetsMake(margin, margin, margin, margin);
}

/**  设置cell规格 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellW = (collectionView.frame.size.width - self.margin * 4) / 2;
    CGFloat cellH = cellW * 5 / 3;
    return CGSizeMake(cellW, cellH);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.comm) {
        CommDetailViewController *commDetail = [CommDetailViewController alloc];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:commDetail animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}
@end
