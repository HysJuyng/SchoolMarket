/*
 超市
 */

#import "SuperMarketViewController.h"

@interface SuperMarketViewController ()

@property (nonatomic, weak) UIButton *openTimeView;
@property (nonatomic, weak) UITableView *category;
@property (nonatomic, weak) UIScrollView *detailCategory;
@property (nonatomic, weak) UICollectionView *goods;

@end

@implementation SuperMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    [self BarButtonItem];
    [self OpenTimeView];
    [self Category];
    [self DetailCategory];
    [self Goods];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
- (UITableView *)Category
{
    if (self.category == nil) {
        CGFloat categoryW = self.view.bounds.size.width * 0.3;
        CGFloat categoryH = self.view.bounds.size.height * 2;
        CGFloat categoryY = CGRectGetMaxY(self.openTimeView.frame);
        
        UITableView *category = [[UITableView alloc] initWithFrame:CGRectMake(0, categoryY, categoryW, categoryH)];
        category.backgroundColor = [UIColor blueColor];
        
        [self.view addSubview:(self.category = category)];
    }
    return self.category;
}

/**  创建小分类detailCategory */
- (UIScrollView *)DetailCategory
{
    if (self.detailCategory == nil) {
        CGFloat detailX = CGRectGetMaxX(self.category.frame);
        CGFloat detailY = self.category.frame.origin.y;
        CGFloat detailW = self.view.bounds.size.height * 2;
        
        UIScrollView *detailCategory = [[UIScrollView alloc] initWithFrame:CGRectMake(detailX, detailY, detailW, 40)];
        //    self.detailCategory.showsVerticalScrollIndicator = NO;
        detailCategory.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:(self.detailCategory = detailCategory)];
    }
    return self.detailCategory;
}

/**  创建商品展示goods */
- (UICollectionView *)Goods
{
    if (self.goods == nil) {
        CGFloat goodsX = self.detailCategory.frame.origin.x;
        CGFloat goodsY = CGRectGetMaxY(self.detailCategory.frame);
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
