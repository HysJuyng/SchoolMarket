/*
 tabbar
 四个页面：主页  超市  购物车  个人
 */

#import "RootTabBarController.h"

#import "HomepageController.h"
#import "SuperMarketViewController.h"
#import "ShoppingCartController.h"
#import "PersonalViewController.h"



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
    
    //navigation
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UINavigationController *supermarketNavi = [[UINavigationController alloc] initWithRootViewController:supermarketVC];
    UINavigationController *shopcartNavi = [[UINavigationController alloc] initWithRootViewController:shopcartVC];
    UINavigationController *personalNavi = [[UINavigationController alloc] initWithRootViewController:personalVC];
    
    //添加vc到tabbar
    self.viewControllers = [[NSArray alloc] initWithObjects:homeNavi,supermarketNavi,shopcartNavi,personalNavi, nil];
    
    self.selectedIndex = 2;
    
    //各tabbar属性
    UITabBarItem *home = [[UITabBarItem alloc]initWithTitle:@"主页" image:[UIImage imageNamed:@"tab_home_default"] tag:1];
    UITabBarItem *supermarket = [[UITabBarItem alloc]initWithTitle:@"超市" image:[UIImage imageNamed:@"tab_supermarket_default"] tag:2];
    UITabBarItem *shopcart = [[UITabBarItem alloc]initWithTitle:@"购物车" image:[UIImage imageNamed:@"tab_cart_default"] tag:3];
    UITabBarItem *personal = [[UITabBarItem alloc]initWithTitle:@"个人" image:[UIImage imageNamed:@"tab_me_default"] tag:4];
    
    //选中后的图片
    home.selectedImage = [UIImage imageNamed:@"tab_home_selected"];
    supermarket.selectedImage = [UIImage imageNamed:@"tab_supermarket_selected"];
    shopcart.selectedImage = [UIImage imageNamed:@"tab_cart_selected"];
    personal.selectedImage = [UIImage imageNamed:@"tab_me_selected"];
    
    homeNavi.tabBarItem = home;
    supermarketNavi.tabBarItem = supermarket;
    shopcartNavi.tabBarItem = shopcart;
    personalNavi.tabBarItem = personal;
    
    

    NSLog(@"%@",NSHomeDirectory());
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex == 3) {
        return false;
    }
    return true;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
