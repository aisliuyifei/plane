//
//  Fire.m
//  testcocos
//
//  Created by wupeng on 12-8-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Fire.h"
#import "GameScene.h"

@implementation Fire
@synthesize countUpdated;

+(id)fire{
    return [[[self alloc] initWithFireImage] autorelease];
}

-(id)initWithFireImage{
    if ((self = [super initWithFile:@"smokeball.png"]))
	{
        self.countUpdated =0;
        self.visible = NO;
        [self scheduleUpdate];
	}
	return self;
}

-(void) update:(ccTime)delta
{
    self.countUpdated ++;
    self.scale *=0.8;
    self.position = ccpAdd(self.position, ccp(-1, 0));
    if (self.countUpdated>10) {
        self.visible = NO;
    }
}

-(void)showUp{
    ShipEntity *ship =[[GameScene sharedGameScene]defaultShip];
	self.position = ccp(ship.position.x-ship.contentSize.width*ship.scale/2,ship.position.y);
    
    @try {
        self.countUpdated = 0;
        self.visible = YES;
        self.scale =1.0;
        if (![[[GameScene sharedGameScene] children] containsObject:self]) {
            [[GameScene sharedGameScene] addChild:self];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

@end
