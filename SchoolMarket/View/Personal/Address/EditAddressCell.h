/*
 修改地址cell
 */

#import <UIKit/UIKit.h>

@interface EditAddressCell : UITableViewCell 

@property (nonatomic,weak) UILabel *lbTitle;   //标题
@property (nonatomic,weak) UITextField *tfContent;   //内容输入框


//初始化
- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  设置文本
 *
 *  @param title       标题
 *  @param placeholder 提示文字
 *  @param text        文本内容
 */
- (void)setEditAddressCell:(NSString *)title andPlaceholder:(NSString *)placeholder andText:(NSString *)text;
@end
