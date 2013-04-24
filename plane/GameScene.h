//
//  GameScene.h
//  testcocos
//
//  Created by wupeng on 12-8-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ShipEntity.h"
#import "BlocksCache.h"
#import "RoofCache.h"
#ifdef LITEVERSION
#import "GADBannerView.h"
#endif
typedef enum{
    GameSceneLayerTagGame = 1,
}GameSceneLayerTags;

typedef enum{
    GameSceneNodeTagShip=1,
    GameSceneNodeTagBlockCache,
    GameSceneNodeTagRoofCache,

} GameSceneNodeTags;

@interface GameScene : CCLayer {
    bool isGameOver;
    ccTime totalTime;
    CCLabelTTF *scoreLabel;
    CCLabelTTF *scoreBest;
    int score;
#ifdef LITEVERSION
    GADBannerView *gAdBannerView;
#endif
}
+(id) scene;
+(GameScene*) sharedGameScene;
-(ShipEntity*) defaultShip;
+(CGRect) screenRect;
-(void)gameOver;
-(void) resetGame;
-(void)addAdMobBanner;
@end
