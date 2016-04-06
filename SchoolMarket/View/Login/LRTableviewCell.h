/*
 登录注册页面 cell
 包括： 图片 文本输入框
 */

#import <UIKit/UIKit.h>

@interface LRTableviewCell : UITableViewCell

@property (nonatomic,weak) UIImageView *titleImgv;   //标题图片
@property (nonatomic,weak) UITextField *tfContent;   //内容输入框

//初始化
- (instancetype)initWithFrame:(CGRect)frame;
@end
