/*
 主页
 */

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CommCell.h"
#import "HomepageView.h"
#import "Model.h"
#import "CommDetailViewController.h"

#import "AFRequest.h"

@interface HomepageController : BaseViewController <UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak,nonatomic) UIBarButtonItem *btnRegion;  //定位地区
@property (weak,nonatomic) UIBarButtonItem *btnSearch;  //搜索
@property (weak,nonatomic) UIBarButtonItem *btnMessage; //消息


- (void)commCellClickAdd:(UIButton *)button;  //商品单元格 添加按钮事件
- (void)commCellClickMinus:(UIButton *)button; //商品单元格 减少按钮事件
@end
