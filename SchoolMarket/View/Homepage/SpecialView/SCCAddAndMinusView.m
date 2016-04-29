/*
 特价商品cell
 加减view
 */

#import "SCCAddAndMinusView.h"

@implementation SCCAddAndMinusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //加按钮
        UIButton *tempadd = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnAdd = tempadd;
        self.btnAdd.frame = CGRectMake(self.frame.size.width / 3 * 2 , 0, self.frame.size.height , self.frame.size.height );
        [self.btnAdd setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        [self.btnAdd setTitle:@"+" forState:(UIControlStateNormal)];
        self.btnAdd.titleLabel.font = [UIFont systemFontOfSize:self.btnAdd.frame.size.width * 1.2];
        [self.btnAdd setTitleColor:[UIColor colorWithRed:0.317 green:1.000 blue:0.444 alpha:1.000] forState:(UIControlStateNormal)];
        [self addSubview:self.btnAdd];
        
        [self.btnAdd addTarget:self.delegate action:@selector(addNum:) forControlEvents:(UIControlEventTouchUpInside)];
        
        //减按钮
        UIButton *tempminus = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnMinus = tempminus;
        self.btnMinus.frame = CGRectMake(0, 0, self.frame.size.height , self.frame.size.height );
        [self.btnMinus setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        [self.btnMinus setTitle:@"-" forState:(UIControlStateNormal)];
        self.btnMinus.titleLabel.font = [UIFont systemFontOfSize:self.btnMinus.frame.size.width * 1.5];
        [self.btnMinus setTitleColor:[UIColor colorWithRed:0.840 green:0.816 blue:1.000 alpha:1.000] forState:(UIControlStateNormal)];
        [self addSubview:self.btnMinus];
        
        [self.btnMinus addTarget:self.delegate action:@selector(minusNum:) forControlEvents:(UIControlEventTouchUpInside)];
        
        //数量文本
        UILabel *tempnum = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 3, 0, self.frame.size.height, self.frame.size.height)];
        self.selectedNum = tempnum;
        self.selectedNum.textAlignment = NSTextAlignmentCenter;
        self.selectedNum.text = @"0";
        [self addSubview:self.selectedNum];
        
    }
    return self;
}

@end
