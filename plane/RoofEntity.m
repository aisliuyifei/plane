//
//  RoofEntity.m
//  testcocos
//
//  Created by wupeng on 12-8-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoofEntity.h"
#import "StandardMoveComponent.h"
#import "GameScene.h"
@implementation RoofEntity
-(id) init
{
    if (self = [super initWithFile:@"bg.png"]) {
        [self addChild:[StandardMoveComponent node] z:0 tag:ROOF_TAG_MOVE];
    }
    return self;
}

+(id)roof{
    return [[[self alloc] init] autorelease];
}

-(void)showUp{
    @try {
        self.visible = YES;
        [[GameScene sharedGameScene] addChild:self z:1];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

@end
