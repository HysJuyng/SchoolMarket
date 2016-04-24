/*
 特价商品tableviewcell
 
 商品图片 名称 规格
 原价 特价
 加减 数量
 */

#import <UIKit/UIKit.h>

@class LbMiddleLine;
@class Commodity;
@class SCCAddAndMinusView;

@interface SpecialCommCell : UITableViewCell

@property (nonatomic,weak) UIImageView *commImgv;          //图片
@property (nonatomic,weak) UILabel *lbCommName;          //名字
@property (nonatomic,weak) UILabel *lbSpecification;    //规格
@property (nonatomic,weak) LbMiddleLine *lbPrice;           //原价
@property (nonatomic,weak) UILabel *lbSpecialPrice;  //特价

@property (nonatomic,weak) SCCAddAndMinusView *addAndMinusView;

//初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame;

//设置内容
- (void)setSpecialComm:(Commodity*)comm;

@end
