/*
 广告model
 */

#import "Advert.h"

@implementation Advert

//初始化
- (instancetype)initWitDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        
        self.advertiseId = [dic[@"advertiseId"] intValue];
//        self.supermarket = [dic[@"supermarket"] intValue];
        self.advertisePic = dic[@"advertisePic"];
        self.linkContent = dic[@"linkContent"];
        
    }
    return self;
}

@end
