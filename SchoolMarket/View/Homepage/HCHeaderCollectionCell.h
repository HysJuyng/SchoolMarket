/*
 主页头部cell 的 collectionviewcell
 图片 + 标题
 */

#import <UIKit/UIKit.h>

@interface HCHeaderCollectionCell : UICollectionViewCell

@property (weak,nonatomic) UIImageView *imgv;
@property (weak,nonatomic) UILabel *lbTitle;



//设置标题和图片
- (void)setTitleAndImage:(NSString*)title andImage:(NSString*)image;
@end
