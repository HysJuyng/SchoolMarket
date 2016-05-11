//
//  AddressCell.m
//  SchoolMarket
//
//  Created by tb on 16/4/24.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

/**  初始化cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // 可重用标识符
    static NSString *ID = @"address";
    
    // tableView查询可重用Cell
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 如果没有可重用cell，则进行初始化
    if (cell == nil) {
        cell = [[AddressCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *edit = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edit"]];
        edit.frame = CGRectMake(0, 0, 20, 20);
        self.accessoryView = edit;
        
        UIButton *tempbtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.btnEdit = tempbtn;
        self.btnEdit.frame = CGRectMake(self.frame.size.width - self.frame.size.height, self.frame.size.height / 4, self.frame.size.height / 2, self.frame.size.height / 2);
        [self.btnEdit setImage:[[UIImage imageNamed:@"personal_feedback"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        [self.btnEdit addTarget:self.delegate action:@selector(editClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.btnEdit];
    
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
