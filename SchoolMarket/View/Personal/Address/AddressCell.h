//
//  AddressCell.h
//  SchoolMarket
//
//  Created by tb on 16/4/24.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddressCellDelegate <NSObject>

/** 编辑点击事件*/
- (void)editClick:(UIButton*)button;

@end

@interface AddressCell : UITableViewCell

/**  提供一个类方法快速创建Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,weak) UIButton *btnEdit;  //编辑按钮

@property (nonatomic,assign) id<AddressCellDelegate> delegate;

@end
