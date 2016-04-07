/*
 个人主页头视图
 图像  用户名  手机号
 */

#import "PersonalHeaderView.h"

@implementation PersonalHeaderView

- (instancetype)initWithFrame:(CGRect)frame andSuperVC:(UIViewController*)supervc
{
    self = [super initWithFrame:frame];
    if (self) {
        
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


@end
