//
//  FireCache.h
//  testcocos
//
//  Created by wupeng on 12-8-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define MAX_FIRES 50

@interface FireCache : CCNode {
    CCSpriteBatchNode * batch;
    CCArray *fires;
}
+(id) cache;
-(void)addFire;
@end
