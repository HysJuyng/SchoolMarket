//
//  ConfirmOrderCell.h
//  SchoolMarket
//
//  Created by tb on 16/4/24.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOrderCell : UITableViewCell 

/**  重写这两个属性为可读写，以用于弹出时间选择器 */
@property (nonatomic, strong, readwrite) UIView *inputAccessoryView;
@property (nonatomic, strong, readwrite) UIView *inputView;

@end
