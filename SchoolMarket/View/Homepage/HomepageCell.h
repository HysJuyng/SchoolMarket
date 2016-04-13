/*
 主页tableview   商品区单元格

 内容：
 头图片  头标题   更多按钮
 商品展示
 */

#import <UIKit/UIKit.h>

//协议
@protocol HomepageCellDelegate <NSObject>

- (void)goSuperMarket;  //更多按钮事件

@end

@interface HomepageCell : UITableViewCell

@property (weak,nonatomic) UIImageView *imgvTitle;  //头图片
@property (weak,nonatomic) UILabel *lbTitle;       //头标题
@property (weak,nonatomic) UIButton *btnMore;      //更多按钮
@property (weak,nonatomic) UICollectionView *cvComm;      //商品展示

//初始化方法  视图控制器
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andSuperVc:(UIViewController*)supervc andFrame:(CGRect)frame;

@end
