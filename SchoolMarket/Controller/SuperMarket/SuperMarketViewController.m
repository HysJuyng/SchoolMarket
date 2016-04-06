/*
 超市
 */

#import "SuperMarketViewController.h"
#import "Categories.h"
#import "CategoriesCell.h"
#import "SuperMarketView.h"

@interface SuperMarketViewController ()

@property (nonatomic, weak) SuperMarketView *smView;

@end

@implementation SuperMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    [self BarButtonItem];
    
    [self showSMView];
}

- (SuperMarketView *)showSMView
{
    if (self.smView == nil) {
        CGFloat smViewY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        CGFloat smViewW = self.view.bounds.size.width;
        CGFloat smViewH = CGRectGetMinY(self.tabBarController.tabBar.frame) - smViewY;
        SuperMarketView *smView = [[SuperMarketView alloc] initWithFrame:CGRectMake(0, smViewY, smViewW, smViewH)];
        self.smView = smView;
        [self.view addSubview:self.smView];
    }
    return self.smView;
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
@end
