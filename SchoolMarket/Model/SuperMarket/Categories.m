//
//  Categories.m
//  SchoolMarket
//
//  Created by tb on 16/4/2.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "Categories.h"
#import "SubCategories.h"
#import "AFRequest.h"

@implementation Categories

//@synthesize image = _image;
//
//- (UIImage *)image
//{
//    if (_image == nil) {
//        _image = [UIImage imageNamed:self.icon];
//    }
//    return _image;
//}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        // KVC
        [self setValuesForKeysWithDictionary:dict[@"mainClassify"]];
        
        // 将字典数组 dict[@"subCategories"] 转换成模型数组
        self.subClass = [SubCategories subClassWithArray:dict[@"subClass"]];
    }
    return self;
}

+ (instancetype)categoriesWithDict:(NSDictionary *)dict
{
    // 返回实例化对象
    return [[self alloc] initWithDictionary:dict];
}

@end
