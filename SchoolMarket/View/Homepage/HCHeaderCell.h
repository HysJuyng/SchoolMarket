/*
 主页头部cell
 
 collectinview  4个按钮
 */

#import <UIKit/UIKit.h>

@interface HCHeaderCell : UITableViewCell

@property (weak,nonatomic) UICollectionView *cvHeader;


//初始化
- (instancetype)initWithFrame:(CGRect)frame;

@end
