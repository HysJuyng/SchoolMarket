/*
    修改地址cell
 */

#import "EditAddressCell.h"

@implementation EditAddressCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //标题
        UILabel *temptitle = [[UILabel alloc] initWithFrame:CGRectMake(15,0, frame.size.width / 4, frame.size.height)];
        self.lbTitle = temptitle;
        [self addSubview:self.lbTitle];
        
        //内容输入框
        UITextField *tempcontent = [[UITextField alloc] initWithFrame:CGRectMake(self.lbTitle.frame.size.width + 20, 0, frame.size.width - self.lbTitle.frame.size.width - 20, frame.size.height)];
        self.tfContent = tempcontent;
        [self addSubview:self.tfContent];
    }
    return self;
}

/**
 *  设置文本
 *
 *  @param title       标题
 *  @param placeholder 提示文字
 *  @param text        文本内容
 */
- (void)setEditAddressCell:(NSString *)title andPlaceholder:(NSString *)placeholder andText:(NSString *)text {
    self.lbTitle.text = title;
    self.tfContent.placeholder = placeholder;
    self.tfContent.text = text;
}


- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
