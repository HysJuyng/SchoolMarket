//
//  SubCategories.m
//  SchoolMarket
//
//  Created by tb on 16/4/28.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import "SubCategories.h"

@implementation SubCategories

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        // KVC
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)subClassWithDict:(NSDictionary *)dict
{
    // 返回实例化对象
    return [[self alloc] initWithDictionary:dict];
}

+ (NSArray *)subClassWithArray:(NSArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self subClassWithDict:dict]];
    }
    return arrayM;
}

@end
