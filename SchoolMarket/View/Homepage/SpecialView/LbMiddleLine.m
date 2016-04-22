/*
 自定义label
 中划线
 */

#import "LbMiddleLine.h"

@implementation LbMiddleLine


- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:rect];
    
    CGFloat x = 0;
    CGFloat y = rect.size.height / 2;
    CGFloat w = rect.size.width;
    CGFloat h = 1;
    UIRectFill(CGRectMake(x, y, w, h));
}
@end
