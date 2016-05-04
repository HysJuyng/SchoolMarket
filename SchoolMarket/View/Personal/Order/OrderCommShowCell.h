/*
 订单详情 商品展示cell
 */

#import <UIKit/UIKit.h>

@interface OrderCommShowCell : UITableViewCell

/**
 *  标题
 */
@property (nonatomic,weak) UILabel *lbTitle;
/**
 *  内容
 */
@property (nonatomic,weak) UILabel *lbContent;
/**
 *  商品展示 collectionview
 */
@property (nonatomic,weak) UICollectionView *commCollectionview;



/**
 *  设置cell内容
 *
 *  @param title   标题
 *  @param content 内容
 */
- (void)setOrderDetail:(NSString *)title andContent:(NSString *)content;

@end
