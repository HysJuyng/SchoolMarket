/*
 特价商品cell
 加减view
 */

#import <UIKit/UIKit.h>

@protocol SCCAddAndMinusViewDelegate <NSObject>

- (void)addNum:(UIButton*)button ;
- (void)minusNum:(UIButton*)button ;

@end

@interface SCCAddAndMinusView : UIView

@property (nonatomic,assign) id<SCCAddAndMinusViewDelegate> delegate;

@property (nonatomic,weak) UIButton *btnAdd;
@property (nonatomic,weak) UIButton *btnMinus;
@property (nonatomic,weak) UILabel *selectedNum;


@end
