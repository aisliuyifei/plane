//
//  CCAnimation+Helper.h
//  testcocos
//
//  Created by wupeng on 12-8-6.
//
//

#import "CCAnimation.h"
#import "cocos2d.h"


@interface CCAnimation (Helper)
+(CCAnimation*) animationWithFile:(NSString*)name frameCount:(int)frameCount delay:(float)delay;
+(CCAnimation*) animationWithFrame:(NSString*)frame frameCount:(int)frameCount delay:(float)delay;

@end
