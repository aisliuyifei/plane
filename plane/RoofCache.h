//
//  RoofCache.h
//  testcocos
//
//  Created by wupeng on 12-8-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface RoofCache : CCNode {
    CCSpriteBatchNode * batch;
    CCArray *roofs;
}

+(id) cache;
-(void)reset;
@end
