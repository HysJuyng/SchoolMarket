//
//  SCCommCell.h
//  SchoolMarket
//
//  Created by tb on 16/4/10.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCCommCellDelegate <NSObject>

- (void)increaseButtonDidClickWith:(int)num andPrice:(NSString *)price;

@end

@interface SCCommCell : UITableViewCell

@property (nonatomic, weak) id<SCCommCellDelegate> delegate;


+ (instancetype)cellWithTableView:(UITableView *)tableView andFrame:(CGRect)frame;

@end
