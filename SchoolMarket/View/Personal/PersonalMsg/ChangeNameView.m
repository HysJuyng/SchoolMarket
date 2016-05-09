/*
 修改姓名view
 */

#import "ChangeNameView.h"

@implementation ChangeNameView

- (instancetype)initWithFrame:(CGRect)frame andUserName:(NSString*)name
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
        
        //文本输入框
        UITextField *tempname = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, self.frame.size.width - 20, 40)];
        self.tfName = tempname;
        self.tfName.placeholder = @"姓名";
        self.tfName.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tfName];
        
        self.tfName.text = name;
        
        //确定修改按钮
        UIButton *tempchange = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnChange = tempchange;
        self.btnChange.frame = CGRectMake(25, 140, self.frame.size.width - 50, 33);
        [self.btnChange setTitle:@"确定修改" forState:(UIControlStateNormal)];
        self.btnChange.tintColor = [UIColor whiteColor];
        self.btnChange.backgroundColor = [UIColor colorWithRed:10.0/255.0 green:200.0/255.0 blue:150.0/255.0 alpha:1.0];
        self.btnChange.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.btnChange];
        
        [self.btnChange addTarget:self.delegate action:@selector(changeNameClick) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return self;
}

@end
