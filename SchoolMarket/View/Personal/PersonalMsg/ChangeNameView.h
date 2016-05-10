/*
 修改姓名view
 */

#import <UIKit/UIKit.h>

@protocol ChangeNameViewDelegate <NSObject>

- (void)changeNameClick;

@end

@interface ChangeNameView : UIView


@property (nonatomic,assign) id<ChangeNameViewDelegate> delegate;


@property (nonatomic,weak) UITextField *tfName;
@property (nonatomic,weak) UIButton *btnChange;


/** 初始化方法*/
- (instancetype)initWithFrame:(CGRect)frame andUserName:(NSString*)name;

@end
