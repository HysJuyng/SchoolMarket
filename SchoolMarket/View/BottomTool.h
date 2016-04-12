//
//  BottomTool.h
//  SchoolMarket
//
//  Created by tb on 16/4/9.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShoppingCartController;

@protocol BottomToolDelegate <NSObject>

- (void)goToSuperMarket;

@end

@interface BottomTool : UIView
{
    ShoppingCartController *shoppingCartVC;
}

/**  总价Label */
@property (nonatomic, weak) UILabel *sumPriceLbl;
@end
