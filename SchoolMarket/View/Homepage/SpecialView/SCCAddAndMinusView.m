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
        [self.btnAdd setImage:[[UIImage imageNamed:@"plus_circle_green"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        [self addSubview:self.btnAdd];
        
        [self.btnAdd addTarget:self.delegate action:@selector(addNum:) forControlEvents:(UIControlEventTouchUpInside)];
        
        //减按钮
        UIButton *tempminus = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.btnMinus = tempminus;
        self.btnMinus.frame = CGRectMake(0, 0, self.frame.size.height , self.frame.size.height );
        [self.btnMinus setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        [self.btnMinus setImage:[[UIImage imageNamed:@"minus_circle_grey"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
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
