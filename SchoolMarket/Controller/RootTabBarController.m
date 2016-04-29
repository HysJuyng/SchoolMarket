/*
 tabbar
 四个页面：主页  超市  购物车  个人
 */

#import "RootTabBarController.h"

#import "HomepageController.h"
#import "SuperMarketViewController.h"
#import "ShoppingCartController.h"
#import "PersonalViewController.h"
#import "LoginViewController.h"



@interface RootTabBarController () <UITabBarControllerDelegate>

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //测试用 过后删
    //=================
    NSUserDefaults *userdef = [[NSUserDefaults alloc] init];
    [userdef setValue:@"true" forKey:@"logined"];
    //=================
    
    
    
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
    
    self.selectedIndex = 1;
    
    //各tabbar属性
    UITabBarItem *home = [[UITabBarItem alloc]initWithTitle:@"主页" image:[UIImage imageNamed:@"tab_home_default"] tag:1];
    UITabBarItem *supermarket = [[UITabBarItem alloc]initWithTitle:@"超市" image:[UIImage imageNamed:@"tab_supermarket_default"] tag:2];
    UITabBarItem *shopcart = [[UITabBarItem alloc]initWithTitle:@"购物车" image:[UIImage imageNamed:@"tab_cart_default"] tag:3];
    UITabBarItem *personal = [[UITabBarItem alloc]initWithTitle:@"个人中心" image:[UIImage imageNamed:@"tab_me_default"] tag:4];
    
    //选中后的图片
    home.selectedImage = [UIImage imageNamed:@"tab_home_selected"];
    supermarket.selectedImage = [UIImage imageNamed:@"tab_supermarket_selected"];
    shopcart.selectedImage = [UIImage imageNamed:@"tab_cart_selected"];
    personal.selectedImage = [UIImage imageNamed:@"tab_me_selected"];
    
    homeNavi.tabBarItem = home;
    supermarketNavi.tabBarItem = supermarket;
    shopcartNavi.tabBarItem = shopcart;
    personalNavi.tabBarItem = personal;
    
    
    //设置代理
    self.delegate = self;

    NSLog(@"%@",NSHomeDirectory());
}

#pragma mark tabbarcontroller代理
//选择tabbar代理方法
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    //判断是否选择个人
    if ([viewController.tabBarItem.title isEqualToString:@"个人中心"]) {
        //判断是否登录
        NSUserDefaults *userdef = [[NSUserDefaults alloc] init];
        if ([[userdef objectForKey:@"logined"] isEqualToString:@"true"]) {
            //跳转
            return true;
        } else {  //没有登录
            LoginViewController *loginvc = [[LoginViewController alloc] init];
            
            //隐藏tabbar
            self.selectedViewController.hidesBottomBarWhenPushed = YES;

            [self.selectedViewController pushViewController:loginvc animated:true];
            self.selectedViewController.hidesBottomBarWhenPushed = NO;
            return false;
        }
    } else if ([viewController.tabBarItem.title isEqualToString:@"购物车"]) {  //判断是否选择购物车
        //判断购物车数据库是否有更新
        NSUserDefaults *userdef = [[NSUserDefaults alloc] init];
        if ([[userdef objectForKey:@"shopcartIsUpdate"] isEqualToString:@"true"]) {
            //数据库 有修改 则提示购物车controller进行reload
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            //发送购物车数据库已更新 消息
            [center postNotificationName:@"shopcartIsUpdate" object:self.selectedViewController];
        }
        return true;
    }
    return true;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
