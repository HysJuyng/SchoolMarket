/*
 个人主页 头部信息
 头像  用户名  手机号码
 */

#import "PersonalMsgCell.h"

@implementation PersonalMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.frame = frame;
        self.backgroundColor = [UIColor greenColor];
        
        
        //头像
        UIImageView *tempimgv = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 6, self.frame.size.height / 4, self.frame.size.height / 2, self.frame.size.height / 2)];
        self.userImgv = tempimgv;
        self.userImgv.backgroundColor = [UIColor blueColor];
        [self addSubview:self.userImgv];
        
        //用户名
        UILabel *tempname = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 6 + self.frame.size.height / 2 + 5, self.frame.size.height / 4, self.frame.size.width / 3 * 2 - self.frame.size.height / 2 - 5 , self.frame.size.height / 6)];
        self.lbName = tempname;
        self.lbName.textAlignment = NSTextAlignmentLeft;
        self.lbName.text = @"请输入您的昵称";
        [self addSubview:self.lbName];
        
        self.lbName.backgroundColor = [UIColor purpleColor];
        
        //手机号码
        UILabel *tempphone = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 6 + self.frame.size.height / 2 + 5, self.frame.size.height / 12 * 5, self.frame.size.width / 3 * 2 - self.frame.size.height / 2 - 5 , self.frame.size.height / 6)];
        self.lbPhone = tempphone;
        self.lbPhone.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.lbPhone];
        
        self.lbPhone.backgroundColor = [UIColor grayColor];
        
    }
    return self;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
