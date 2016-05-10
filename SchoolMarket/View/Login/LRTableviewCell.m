/*
 登录注册页面 cell
 包括： 图片 文本输入框
 */

#import "LRTableviewCell.h"

@implementation LRTableviewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //标题图片
        UIImageView *tempimgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, frame.size.height / 4, frame.size.height / 2, frame.size.height / 2)];
        self.titleImgv = tempimgv;
        [self addSubview:self.titleImgv];
        
        //内容输入框
        UITextField *tempcontent = [[UITextField alloc] initWithFrame:CGRectMake(frame.size.height / 2 + 20, 0, frame.size.width - frame.size.height / 2 - 20, frame.size.height)];
        self.tfContent = tempcontent;
        self.tfContent.delegate = self;
        [self addSubview:self.tfContent];
    }
    return self;
}


//检测输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.length == 0) {   //先判断是不是输入   length = 0 是表示输入 否则则是回退（仅限一个一个的输入）
        if (textField.tag == 101) {         //这里判断是否是手机输入框 （手机输入框纯数字）
            if (![string intValue]) {              //检测是否能转换成数字
                if (![string compare:@"0"]) {    //除去0
                    return true;
                }
                return false;
            }
        } else {
            if ([string compare:@" "] == NSOrderedDescending) {      //除去空格
                return true;
            } else {
                return false;
            }
        }
    }
    return true;
}






- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
