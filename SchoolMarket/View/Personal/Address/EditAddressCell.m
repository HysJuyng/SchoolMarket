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
        self.tfContent.delegate = self;
        [self addSubview:self.tfContent];
    }
    return self;
}

//检测输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.length == 0) {   //先判断是不是输入   length = 0 是表示输入 否则则是回退（仅限一个一个的输入）
        //判断是手机号码输入框
        if (textField.tag == 101) {
            if (![string intValue]) {              //检测是否能转换成数字
                if (![string compare:@"0"]) {    //除去0
                    return true;
                }
                return false;
            }
        }
    }
    
    
//    if (range.length == 0) {   //先判断是不是输入   length = 0 是表示输入 否则则是回退（仅限一个一个的输入）
//        if (!textField.secureTextEntry) {         //这里判断是否是密码框 （密码框可字母可数字  其余的纯数字）
//            if (![string intValue]) {              //检测是否能转换成数字
//                if (![string compare:@"0"]) {    //除去0
//                    return true;
//                }
//                return false;
//            }
//        } else {
//            if ([string compare:@" "] == NSOrderedDescending) {      //除去空格
//                return true;
//            } else {
//                return false;
//            }
//        }
//    }
    return true;
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
    if (text) {
        self.tfContent.text = text;
    }
    
}


- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
