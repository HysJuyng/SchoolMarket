//
//  EditAddressController.h
//  SchoolMarket
//
//  Created by tb on 16/4/24.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "ViewController.h"

@class Address;

@interface EditAddressController : ViewController
/** 修改地址时的地址*/
@property (nonatomic,strong) Address *address;
/** 新增的时候的地址数量*/
@property (nonatomic,assign) int count;

@end
