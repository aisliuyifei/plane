//
//  FireCache.m
//  testcocos
//
//  Created by wupeng on 12-8-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "FireCache.h"
#import "GameScene.h"
#import "Fire.h"

@implementation FireCache

+(id) cache
{
	return [[[self alloc] init] autorelease];
}

-(id) init
{
	if ((self = [super init]))
	{
		CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bullet.png"];
		batch = [CCSpriteBatchNode batchNodeWithTexture:frame.texture];
		[self addChild:batch];
        [self initFires];
	}
	return self;
}

-(void)initFires{
    fires = [[CCArray alloc] initWithCapacity:MAX_BLOCKS];
    for (int i = 0 ; i < MAX_FIRES; i++) {
        [fires addObject:[Fire fire]];
    }
}

-(void)addFire{
    Fire* fire;
	CCARRAY_FOREACH(fires, fire)
	{
		// find the first free enemy and respawn it
		if (fire.visible == NO)
		{
			//CCLOG(@"spawn enemy type %i", enemyType);
			[fire showUp];
			break;
		}
	}
}

@end
