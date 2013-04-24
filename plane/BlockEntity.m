//
//  BlockEntity.m
//  testcocos
//
//  Created by wupeng on 12-8-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BlockEntity.h"
#import "StandardMoveComponent.h"
#import "GameScene.h"

@implementation BlockEntity


-(id) init
{
    if (self = [super initWithFile:@"block.png"]) {
        [self addChild:[StandardMoveComponent node] z:0 tag:BLOCK_TAG_MOVE];
        self.visible = NO;
    }
    return self;
}

+(id)block{
    return [[[self alloc] init] autorelease];
}

-(void)showUp{
  CGRect screenRect = [GameScene screenRect];
//	CGSize spriteSize = [self contentSize];
	float xPos = 480;
	float yPos = self.contentSize.height/2 + arc4random()%200;
	self.position = CGPointMake(xPos, yPos);
    @try {
        self.visible = YES;
        [[GameScene sharedGameScene] addChild:self];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

@end
