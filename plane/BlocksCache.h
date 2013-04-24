//
//  BlocksCache.h
//  testcocos
//
//  Created by wupeng on 12-8-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BlockEntity.h"
#define BLOCK_FREQUENCY_FAST 60
#define BLOCK_FREQUENCY_MID 90
#define BLOCK_FREQUENCY_SLOW 120
#define MAX_BLOCKS 20

@interface BlocksCache : CCNode {
    CCSpriteBatchNode * batch;
    CCArray *blocks;
    int blockFrequency;
    int updateCount;
}
-(void)reset;
@end
