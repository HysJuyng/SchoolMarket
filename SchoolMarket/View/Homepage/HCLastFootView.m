/*
 主页最后的脚视图
 */

#import "HCLastFootView.h"

@implementation HCLastFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //查看更多按钮
        UIButton *tempbtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnGoSM = tempbtn;
        self.btnGoSM.frame = frame;
        [self.btnGoSM setTitle:@"查看更多商品" forState:(UIControlStateNormal)];
        [self addSubview:self.btnGoSM];
        
    }
    return self;
}

@end
