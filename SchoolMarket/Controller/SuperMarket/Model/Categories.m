//
//  Categories.m
//  SchoolMarket
//
//  Created by tb on 16/4/2.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "Categories.h"

@implementation Categories

@synthesize image = _image;

- (UIImage *)image
{
    if (_image == nil) {
        _image = [UIImage imageNamed:self.icon];
    }
    return _image;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        // KVC
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)categoriesWithDict:(NSDictionary *)dict
{
    // 返回实例化对象
    return [[self alloc] initWithDictionary:dict];
}

+ (NSArray *)categoriesList
{
    // 将plist文件数据取出
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"categories.plist" ofType:nil]];
    
    // 创建临时数组
    NSMutableArray *arrayM = [NSMutableArray array];
    
    // 遍历数组，依次转换模型
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self categoriesWithDict:dict]];
    }
    return arrayM;
}

@end
