//
//  Fire.h
//  testcocos
//
//  Created by wupeng on 12-8-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Entity.h"
@interface Fire : Entity {
    int countUpdated;
}
@property(nonatomic,assign)int countUpdated;
+(id)fire;
-(void)showUp;
@end
