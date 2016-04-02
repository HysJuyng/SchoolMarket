/*
 主页
 */

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HomepageCell.h"
#import "CommCell.h"
#import "HCLastFootView.h"
#import "HCHeaderView.h"
#import "HCHeaderCell.h"
#import "HCHeaderCollectionCell.h"

@interface HomepageController : BaseViewController <UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak,nonatomic) UIBarButtonItem *btnRegion;  //定位地区
@property (weak,nonatomic) UIBarButtonItem *btnSearch;  //搜索
@property (weak,nonatomic) UIBarButtonItem *btnMessage; //消息

@end
