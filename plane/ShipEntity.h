//
//  ShipEntity.h
//  testcocos
//
//  Created by wupeng on 12-8-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Entity.h"

@interface ShipEntity : Entity {
    CGPoint  velocity;
    CGPoint  accelorate;
}
+(id) ship;
-(void)up;
-(void)down;
-(void)resetPosition;
@end
