//
//  StandardMoveComponent.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 20.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "StandardMoveComponent.h"
#import "Entity.h"
#import "GameScene.h"

@implementation StandardMoveComponent

-(id) init
{
	if ((self = [super init]))
	{
		velocity = CGPointMake(-6, 0);
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) update:(ccTime)delta
{
	if (self.parent.visible)
	{
		NSAssert([self.parent isKindOfClass:[Entity class]], @"node is not a Entity");
		
		Entity* entity = (Entity*)self.parent;
        [entity setPosition:ccpAdd(entity.position, velocity)];
        if (entity.position.x+entity.contentSize.width<0) {
            //左侧消失
            [[GameScene sharedGameScene] removeChild:self cleanup:YES];
            entity.visible = NO;

        }
	}
}


@end
