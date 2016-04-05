/*
 超市
 */

#import "SuperMarketViewController.h"
#import "Categories.h"
#import "CategoriesCell.h"

@interface SuperMarketViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UIButton *openTimeView;
@property (nonatomic, weak) UITableView *category;
@property (nonatomic, weak) UITableView *subCategory;
@property (nonatomic, weak) UICollectionView *goods;

@property (nonatomic, strong) NSArray *categoriesList;

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
    [self OpenTimeView];
    [self CategoryTableView];
    [self SubCategoryScrollView];
    [self GoodsCollectionView];
    

}

#pragma mark - 设置tableView
/**  数据源方法 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoriesList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    CategoriesCell *cell = [CategoriesCell cellWithTableView:tableView];
    // 通过数据模型，设置Cell内容
    cell.mainCategories = self.categoriesList[indexPath.row];
    return cell;
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
    
    // 设置聊天
    UIButton *test1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    test1.backgroundColor = [UIColor magentaColor];
    UIBarButtonItem *chatItem = [[UIBarButtonItem alloc] initWithCustomView:test1];
    
    // 设置搜索
    UIButton *test2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    test2.backgroundColor = [UIColor purpleColor];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:test2];
    
    self.navigationItem.rightBarButtonItems = @[chatItem, searchItem];
}

#pragma mark - 创建控件
/**  创建营业时间 */
- (UIButton *)OpenTimeView
{
    if (self.openTimeView == nil) {
        CGFloat openTimeViewY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        CGFloat openTimeViewW = self.view.bounds.size.width;
        
        UIButton *openTimeView = [[UIButton alloc] initWithFrame:CGRectMake(0, openTimeViewY, openTimeViewW, 20)];
        
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

/**  创建大分类category */
- (UITableView *)CategoryTableView
{
    if (self.category == nil) {
        CGFloat categoryY = CGRectGetMaxY(self.openTimeView.frame);
        CGFloat categoryW = self.view.bounds.size.width * 0.3;
        CGFloat categoryH = self.view.bounds.size.height - categoryY - self.tabBarController.tabBar.frame.size.height;
        
        UITableView *category = [[UITableView alloc] initWithFrame:CGRectMake(0, categoryY, categoryW, categoryH) style:UITableViewStylePlain];
        category.delegate = self;
        category.dataSource = self;
        // 设置单元格分割线
        category.separatorStyle = NO;
        
        [self.view addSubview:(self.category = category)];
    }
    return self.category;
}

/**  创建小分类detailCategory */
//- (UIScrollView *)SubCategoryScrollView
//{
//    if (self.subCategory == nil) {
//        CGFloat subX = CGRectGetMaxX(self.category.frame);
//        CGFloat subY = self.category.frame.origin.y;
//        CGFloat subW = self.view.bounds.size.height * 2;
//        
//        UIScrollView *subCategory = [[UIScrollView alloc] initWithFrame:CGRectMake(subX, subY, subW, 40)];
//        //    self.detailCategory.showsVerticalScrollIndicator = NO;
//        subCategory.backgroundColor = [UIColor blackColor];
//        
//        [self.view addSubview:(self.subCategory = subCategory)];
//    }
//    return self.subCategory;
//}
- (UITableView *)SubCategoryScrollView
{
    if (self.subCategory == nil) {
        CGFloat subH = self.view.bounds.size.width - CGRectGetWidth(self.category.frame);
        CGFloat subW = 44.0;
        CGFloat subX = subH * 0.5 + CGRectGetWidth(self.category.frame) - subW / 2;
        CGFloat subY = self.category.frame.origin.y - (subH - subW) * 0.5;
        
        UITableView *subCategory = [[UITableView alloc] initWithFrame:CGRectMake(subX, subY, 44, subH)];
        self.subCategory.showsVerticalScrollIndicator = NO;
        subCategory.backgroundColor = [UIColor blackColor];
        subCategory.transform = CGAffineTransformMakeRotation(-M_PI_2);
        subCategory.delegate = self;
        subCategory.dataSource = self;
        
        [self.view addSubview:(self.subCategory = subCategory)];
    }
    return self.subCategory;
}

/**  创建商品展示goods */
- (UICollectionView *)GoodsCollectionView
{
    if (self.goods == nil) {
        CGFloat goodsX = self.subCategory.frame.origin.x;
        CGFloat goodsY = CGRectGetMaxY(self.subCategory.frame);
        CGFloat goodsW = self.view.bounds.size.width - self.category.frame.size.width;
        CGFloat goodsH = self.view.bounds.size.height * 2;
        
        UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
        UICollectionView *goods = [[UICollectionView alloc] initWithFrame:CGRectMake(goodsX, goodsY, goodsW, goodsH) collectionViewLayout:layout];
        goods.backgroundColor = [UIColor redColor];
        
        [self.view addSubview:(self.goods = goods)];
    }
    return self.goods;
}
@end
