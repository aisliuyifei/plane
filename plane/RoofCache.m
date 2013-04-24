//
//  RoofCache.m
//  testcocos
//
//  Created by wupeng on 12-8-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoofCache.h"
#import "RoofEntity.h"
#import "ShipEntity.h"
#import "GameScene.h"
#define MAX_ROOFS 8
@implementation RoofCache
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
        [self initRoofs];
        [self scheduleUpdate];
	}
	return self;
}

-(void)initRoofs{
    roofs = [[CCArray alloc] initWithCapacity:2*MAX_ROOFS];
    CGSize winSize = [GameScene screenRect].size;
    for (int i = 0 ; i < MAX_ROOFS; i++) {
        RoofEntity *roof = [RoofEntity roof];
        float roofHeight = [roof contentSize].height;
        float roofWidth = [roof contentSize].width;
        float randomDeltaHeight = arc4random()%30;
        
        [roof setPosition:ccp(i*(roofWidth-3),30-roofHeight/2+randomDeltaHeight)];
        [roofs addObject:roof];
        
        RoofEntity *roof2 = [RoofEntity roof];
        [roof2 setPosition:ccp(i*(roofWidth-3),winSize.height+roofHeight/8+randomDeltaHeight)];
        [roofs addObject:roof2];
        
        [roof showUp];
        [roof2 showUp];
    }
}

-(void) update:(ccTime)delta
{
    [self checkouForReuse];
	[self checkForCollisions];
}
-(void) checkouForReuse{
    RoofEntity* roof;
	CCARRAY_FOREACH(roofs, roof){
        if (roof.visible==NO) {
            roof.position = ccpAdd(roof.position,ccp((roof.contentSize.width-3)*MAX_ROOFS,0));
            [roof showUp];
        }
    }
}

-(void)checkForCollisions{
    RoofEntity* roof;
	CCARRAY_FOREACH(roofs, roof)
	{
		if (roof.visible)
		{
			ShipEntity* ship = [[GameScene sharedGameScene] defaultShip];
            CGRect bbox = [roof boundingBox];
            CGRect shbox = [ship boundingBox];
            if (CGRectIntersectsRect(bbox,shbox))
			{
                NSLog(@"GAME END");
                [[GameScene sharedGameScene] gameOver];
			}
		}
	}
}


-(void)reset{
    RoofCache* roof;
    CCARRAY_FOREACH(roofs, roof){
        CCNode * node =[roof getChildByTag:ROOF_TAG_MOVE];
        [node unscheduleAllSelectors];
        [node scheduleUpdate];
    }
}

@end
