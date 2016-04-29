//
//  SubCategories.h
//  SchoolMarket
//
//  Created by tb on 16/4/28.
//  Copyright © 2016年 linjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubCategories : NSObject
/**  子分类id */
@property (nonatomic, assign) int subclassId;
/**  子分类名称 */
@property (nonatomic, copy) NSString *subclassName;

/** 使用字典实例化模型 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;
/** 类方法快速实例化一个对象 */
+ (instancetype)subClassWithDict:(NSDictionary *)dict;

/**
 *  传入一个字典数组
 *
 *  @return 返回一个子分类模型数组
 */
+ (NSArray *)subClassWithArray:(NSArray *)array;
@end
