/*
 主页
 */

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface HomepageController : BaseViewController 

@property (weak,nonatomic) UIBarButtonItem *btnRegion;  //定位地区
@property (weak,nonatomic) UIBarButtonItem *btnSearch;  //搜索
@property (weak,nonatomic) UIBarButtonItem *btnMessage; //消息

@end
