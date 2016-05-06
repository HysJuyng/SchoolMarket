//
//  ConfirmOrderViewController.h
//  SchoolMarket
//
//  Created by tb on 16/4/21.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "ViewController.h"

@interface ConfirmOrderViewController : ViewController

/**  商品模型数组 */
@property (nonatomic, strong) NSArray *commsNum;
/**  商品总价 */
@property (nonatomic, copy) NSString *commSumPrice;

@end
