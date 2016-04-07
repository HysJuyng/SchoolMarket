/*
 购物车
 */

#import "ShoppingCartController.h"
#import "CommDetailViewController.h"

@interface ShoppingCartController ()
{
    CommDetailViewController *commDetailVC;
}
@end

@implementation ShoppingCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"购物车";
}

@end
