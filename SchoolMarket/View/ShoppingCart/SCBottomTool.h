//
//  BottomTool.h
//  SchoolMarket
//
//  Created by tb on 16/4/9.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCBottomToolDelegate <NSObject>

- (void)goToSuperMarket;
- (void)goToConfirmOrder;

@end

@interface SCBottomTool : UIView

@property (nonatomic, weak) id<SCBottomToolDelegate> delegate;
/**  总价Label */
@property (nonatomic, weak) UILabel *sumPriceLbl;
@end
