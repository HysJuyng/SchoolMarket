//
//  ShoppingCart.h
//  SchoolMarket
//
//  Created by tb on 16/4/8.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShoppingCartController;

@protocol ShoppingCartDelegate <NSObject>

@required
/**  跳转到超市 */
- (void)goToSuperMarket;

@end

@interface ShoppingCart : UIView
@property (nonatomic, strong) id<ShoppingCartDelegate> delegate;

@end
