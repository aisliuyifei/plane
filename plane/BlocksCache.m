//
//  BlocksCache.m
//  testcocos
//
//  Created by wupeng on 12-8-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BlocksCache.h"
#import "GameScene.h"

@implementation BlocksCache

+(id) cache
{
	return [[[self alloc] init] autorelease];
}

-(id) init
{
	if ((self = [super init]))
	{
        blockFrequency = BLOCK_FREQUENCY_SLOW;
		CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"monster-a.png"];
		batch = [CCSpriteBatchNode batchNodeWithTexture:frame.texture];
		[self addChild:batch];
        [self initBlocks];
        [self scheduleUpdate];
	}
	
	return self;
}

-(void)initBlocks{
    blocks = [[CCArray alloc] initWithCapacity:MAX_BLOCKS];

    for (int i = 0 ; i<MAX_BLOCKS; i++) {
        [blocks addObject:[BlockEntity block]];
    }
}


-(void) update:(ccTime)delta
{
	updateCount++;
    if (updateCount % blockFrequency == 0)
    {
			[self addBlock];
    }
	
	[self checkForCollisions];
}

-(void) addBlock{
	
	BlockEntity* block;
	CCARRAY_FOREACH(blocks, block)
	{
		// find the first free enemy and respawn it
		if (block.visible == NO)
		{
			//CCLOG(@"spawn enemy type %i", enemyType);
			[block showUp];
			break;
		}
	}
}

-(void)checkForCollisions{
    BlockEntity* block;
	CCARRAY_FOREACH(blocks, block)
	{
		if (block.visible)
		{
			ShipEntity* ship = [[GameScene sharedGameScene] defaultShip];
            CGRect bbox = [block boundingBox];
            CGRect shbox = [ship boundingBox];
            if (CGRectIntersectsRect(bbox,shbox))
			{
                NSLog(@"GAME OVER");
                [[GameScene sharedGameScene] gameOver];
			}
		}
	}
}

-(void)reset{
    BlockEntity* block;
    CCARRAY_FOREACH(blocks, block){
        [block setVisible:NO];
        CCNode * node =[block getChildByTag:BLOCK_TAG_MOVE];
        [node unscheduleAllSelectors];
        [node scheduleUpdate];
    }
}

@end
