/*
 主页
 */

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface HomepageController : BaseViewController 

@property (weak,nonatomic) UIBarButtonItem *btnRegion;  //定位地区
@property (weak,nonatomic) UIBarButtonItem *btnSearch;  //搜索
@property (weak,nonatomic) UIBarButtonItem *btnMessage; //消息


- (void)commCellClickAdd:(UIButton *)button;  //商品单元格 添加按钮事件
- (void)commCellClickMinus:(UIButton *)button; //商品单元格 减少按钮事件

/** 获取到数据后填充商品cell数据*/
- (void)setCommCellWithCommdatas:(NSMutableArray*)comms andTableview:(UITableView*)tableview andSection:(NSInteger)section;
@end
