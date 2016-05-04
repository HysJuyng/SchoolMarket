//
//  SCCommCell.h
//  SchoolMarket
//
//  Created by tb on 16/4/10.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Commodity;

@protocol SCCommCellDelegate <NSObject>

- (void)increaseOrDecreaseButtonDidClickWith:(UIButton *)btn;

@end

@interface SCCommCell : UITableViewCell

@property (nonatomic, weak) id<SCCommCellDelegate> delegate;
@property (nonatomic, strong) Commodity *comm;

+ (instancetype)cellWithTableView:(UITableView *)tableView andFrame:(CGRect)frame;

@end
