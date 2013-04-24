//
//  ShipEntity.m
//  testcocos
//
//  Created by wupeng on 12-8-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShipEntity.h"
#import "CCAnimation+Helper.h"
#import "GameScene.h"
#import "FireCache.h"
#define Y_VELOCITY_UP  2
#define Y_VELOCITY_DOWN -2
#define Y_VELOCITY_DOWN_MAX -5
#define Y_ACCELORATE_DOWN -0.05
#define Y_ACCELORATE_UP 0.04
#define STREAK_TAG 99
@implementation ShipEntity
+(id)ship{
    return [[[self alloc] initWithShipImage] autorelease];
}

-(id)initWithShipImage{
    if ((self = [super initWithFile:@"ship.png"]))
	{
        velocity = ccp(0,0);
        accelorate = ccp(0,Y_ACCELORATE_DOWN);
        [self setupFire];
        [self resetPosition];
        [self scheduleUpdate];
        
	}
	return self;
}

-(void)setupFire{
//    CCParticleSmoke *smoke = [[CCParticleSmoke alloc] init];
//    smoke.texture = [[CCTextureCache sharedTextureCache] addImage:@"snow.png"];
//    smoke.gravity = ccp(-10,0);
//    [self addChild:smoke];
    
    CCParticleSystemQuad * smoke = [[CCParticleSystemQuad alloc] initWithFile:@"fire.plist"];
    [smoke setScale:0.4];
    [smoke setZOrder:-1];
    [smoke setPosition:ccp(10,10)];
    [self addChild:smoke];
}


-(void) update:(ccTime)delta
{
//    [self addStreakPoint:self.position];
    self.position = ccpAdd(self.position, velocity);
    velocity = ccpAdd(velocity, accelorate);
    //    [[FireCache cache] addFire];
}

//-(void) addStreakPoint:(CGPoint)point
//{
//    CCMotionStreak * streak = [self getStreak];
//    [streak setPosition:point];
//}
//
//-(id) getStreak
//{
//    CCNode* node = [self getChildByTag:11];
//    return (CCMotionStreak*)node;
//}

-(void)up{
    accelorate = ccp(0,Y_ACCELORATE_UP);
    velocity = ccp(0,Y_VELOCITY_UP);
}

-(void)down{
    accelorate = ccp(0, Y_ACCELORATE_DOWN);
    velocity = ccp(0, Y_VELOCITY_DOWN);
}

-(void)crash{
    //Game over crash animation
}

-(void)resetPosition{
    CGSize screenSize = [GameScene screenRect].size;
    self.position = ccp([self contentSize].width / 2+100, screenSize.width / 2);
    accelorate = ccp(0, Y_ACCELORATE_DOWN);
    velocity = ccp(0, 0);
}

@end
