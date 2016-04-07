/*
 个人主页第一个区的cell
 图片和标题
 */

#import <UIKit/UIKit.h>

@interface PersonalCell : UITableViewCell

@property (nonatomic,weak) UIImageView *titleImgv;
@property (nonatomic,weak) UILabel *lbTitle;
@property (nonatomic,weak) UIImageView *nextImgv;



//初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andSuperVc:(UIViewController*)supervc;

@end
