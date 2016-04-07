/*
 tabbar
 四个页面：主页  超市  购物车  个人
 */

#import "RootTabBarController.h"


@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化4个页面
    HomepageController *homeVC = [[HomepageController alloc] init];
    SuperMarketViewController *supermarketVC = [[SuperMarketViewController alloc] init];
    ShoppingCartController *shopcartVC = [[ShoppingCartController alloc] init];
    PersonalViewController *personalVC = [[PersonalViewController alloc] init];
    
    //navigation化
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UINavigationController *supermarketNavi = [[UINavigationController alloc] initWithRootViewController:supermarketVC];
    UINavigationController *shopcartNavi = [[UINavigationController alloc] initWithRootViewController:shopcartVC];
    UINavigationController *personalNavi = [[UINavigationController alloc] initWithRootViewController:personalVC];
    
    //添加vc到tabbar
    self.viewControllers = [[NSArray alloc] initWithObjects:homeNavi,supermarketNavi,shopcartNavi,personalNavi, nil];
    
    self.selectedIndex = 1;
    
    //各tabbar属性 (图片待补)
    UITabBarItem *home = [[UITabBarItem alloc]initWithTitle:@"主页" image:nil tag:1];
    UITabBarItem *supermarket = [[UITabBarItem alloc]initWithTitle:@"超市" image:nil tag:2];
    UITabBarItem *shopcart = [[UITabBarItem alloc]initWithTitle:@"购物车" image:nil tag:3];
    UITabBarItem *personal = [[UITabBarItem alloc]initWithTitle:@"个人" image:nil tag:4];
    
    homeNavi.tabBarItem = home;
    supermarketNavi.tabBarItem = supermarket;
    shopcartNavi.tabBarItem = shopcart;
    personalNavi.tabBarItem = personal;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
