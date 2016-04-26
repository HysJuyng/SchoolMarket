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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
