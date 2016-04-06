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
        [self addSubview:self.tfContent];
        
        
    }
    return self;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
