//
//  ConfirmOrderCell.m
//  SchoolMarket
//
//  Created by tb on 16/4/24.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "ConfirmOrderCell.h"

@implementation ConfirmOrderCell

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)setInputAccessoryView:(UIView *)inputAccessoryView
{
    _inputAccessoryView = inputAccessoryView;
}

- (void)setInputView:(UIView *)inputView
{
    _inputView = inputView;
}

//- (UIView *)inputView
//{
//    return _inputView;
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
