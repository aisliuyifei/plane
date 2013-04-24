//
//  GameScene.m
//  testcocos
//
//  Created by wupeng on 12-8-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "BlocksCache.h"
#import "RoofCache.h"
#import "UserSession.h"
#import "AppDelegate.h"
@implementation GameScene

static CGRect screenRect;

static GameScene * instanceOfGameScene;
+(GameScene *)sharedGameScene{
    NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
	return instanceOfGameScene;
}

+(CGRect)screenRect{
    return screenRect;
}
+(id) scene
{
	CCScene* scene = [CCScene node];
	GameScene* layer = [GameScene node];
	[scene addChild:layer z:0 tag:GameSceneLayerTagGame];
	return scene;
}

-(id) init
{
	if ((self = [super init]))
	{
		instanceOfGameScene = self;
        self.isTouchEnabled = YES;
        
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
		
		// Load all of the game's artwork up front.
		CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
		[frameCache addSpriteFramesWithFile:@"game-art.plist"];
		
//		ParallaxBackground* background = [ParallaxBackground node];
//		[self addChild:background z:-1];
		
		ShipEntity* ship = [ShipEntity ship];
		[self addChild:ship z:0 tag:GameSceneNodeTagShip];
        
        scoreBest = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@: %d",NSLocalizedString(@"BEST", @"BEST"),[[UserSession sharedUserSession] bestScore]]  fontName:NSLocalizedString(@"FONT NAME", @"FONT NAME") fontSize:20];
        scoreBest.position = ccp(scoreBest.contentSize.width/2+10,20);
        [self addChild:scoreBest z:100];

        scoreLabel = [CCLabelTTF labelWithString: [NSString stringWithFormat:@"%@: %d",NSLocalizedString(@"DISTANCE", @"DISTANCE"),0] fontName:NSLocalizedString(@"FONT NAME", @"FONT NAME") fontSize:20];
        scoreLabel.anchorPoint=ccp(1, 0);
        scoreLabel.position = CGPointMake(screenSize.width-10,10);
        [self addChild:scoreLabel z:100 tag:99];
        CCTintTo* tint1 = [CCTintTo actionWithDuration:2 red:255 green:0 blue:0];
        CCTintTo* tint2 = [CCTintTo actionWithDuration:2 red:255 green:255 blue:0];
        CCTintTo* tint3 = [CCTintTo actionWithDuration:2 red:0 green:255 blue:0];
        CCTintTo* tint4 = [CCTintTo actionWithDuration:2 red:0 green:255 blue:255];
        CCTintTo* tint5 = [CCTintTo actionWithDuration:2 red:0 green:0 blue:255];
        CCTintTo* tint6 = [CCTintTo actionWithDuration:2 red:255 green:0 blue:255];
        CCSequence* tintSequence = [CCSequence actions:tint1, tint2, tint3, tint4, tint5, tint6, nil];
        CCRepeatForever* repeatTint = [CCRepeatForever actionWithAction:tintSequence];
        [scoreLabel runAction:repeatTint];
		
		BlocksCache* blockCache = [BlocksCache node];
		[self addChild:blockCache z:0 tag:GameSceneNodeTagBlockCache];
        RoofCache *roofCache = [RoofCache node];
        [self addChild:roofCache z:0 tag:GameSceneNodeTagRoofCache];
        
        [self scheduleUpdate];
	}
	return self;
}

-(ShipEntity*) defaultShip
{
	CCNode* node = [self getChildByTag:GameSceneNodeTagShip];
	NSAssert([node isKindOfClass:[ShipEntity class]], @"node is not a ShipEntity!");
	return (ShipEntity*)node;
}
-(BlocksCache *)defaultBlockCache{
    CCNode* node = [self getChildByTag:GameSceneNodeTagBlockCache];
	NSAssert([node isKindOfClass:[BlocksCache class]], @"node is not a BlockCache!");
	return (BlocksCache*)node;
}

-(RoofCache *)defaultRoofCache{
    CCNode* node = [self getChildByTag:GameSceneNodeTagRoofCache];
	NSAssert([node isKindOfClass:[RoofCache class]], @"node is not a RoofCache!");
	return (RoofCache*)node;
}

-(void)gameOver
{
//    [[CCDirector sharedDirector] stopAnimation];
    if (score>[[UserSession sharedUserSession] bestScore]){
        [[UserSession sharedUserSession]saveBestScore:score];
    }
    [self showGameOver];
    isGameOver = YES;
    
}

-(void)showGameOver{
    [self setScreenSaverEnabled:YES];
    CCNode * node,*subnode;
    CCARRAY_FOREACH([self children], node){
        CCARRAY_FOREACH([node children], subnode){
            [subnode unscheduleAllSelectors];
        }
        [node unscheduleAllSelectors];
    }
    [self unscheduleAllSelectors];
    self.isTouchEnabled = YES;
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
	CCLabelTTF* gameOver = [CCLabelTTF labelWithString:NSLocalizedString(@"GAME OVER", @"GAME OVER") fontName:NSLocalizedString(@"FONT NAME", @"FONT NAME")  fontSize:60];
    gameOver.position = CGPointMake(screenSize.width / 2, screenSize.height / 3);
	[self addChild:gameOver z:100 tag:100];
	CCTintTo* tint1 = [CCTintTo actionWithDuration:2 red:255 green:0 blue:0];
	CCTintTo* tint2 = [CCTintTo actionWithDuration:2 red:255 green:255 blue:0];
	CCTintTo* tint3 = [CCTintTo actionWithDuration:2 red:0 green:255 blue:0];
	CCTintTo* tint4 = [CCTintTo actionWithDuration:2 red:0 green:255 blue:255];
	CCTintTo* tint5 = [CCTintTo actionWithDuration:2 red:0 green:0 blue:255];
	CCTintTo* tint6 = [CCTintTo actionWithDuration:2 red:255 green:0 blue:255];
    CCSequence* tintSequence = [CCSequence actions:tint1, tint2, tint3, tint4, tint5, tint6, nil];
	CCRepeatForever* repeatTint = [CCRepeatForever actionWithAction:tintSequence];
	[gameOver runAction:repeatTint];
    
    CCRotateTo* rotate1 = [CCRotateTo actionWithDuration:2 angle:3];
	CCEaseBounceInOut* bounce1 = [CCEaseBounceInOut actionWithAction:rotate1];
	CCRotateTo* rotate2 = [CCRotateTo actionWithDuration:2 angle:-3];
	CCEaseBounceInOut* bounce2 = [CCEaseBounceInOut actionWithAction:rotate2];
	CCSequence* rotateSequence = [CCSequence actions:bounce1, bounce2, nil];
	CCRepeatForever* repeatBounce = [CCRepeatForever actionWithAction:rotateSequence];
	[gameOver runAction:repeatBounce];
    
    CCJumpBy* jump = [CCJumpBy actionWithDuration:3 position:CGPointZero height:screenSize.height / 3 jumps:1];
	CCRepeatForever* repeatJump = [CCRepeatForever actionWithAction:jump];
	[gameOver runAction:repeatJump];
    
    CCLabelTTF* touch = [CCLabelTTF labelWithString: NSLocalizedString(@"tap screen to play again",@"tap screen to play again")  fontName:NSLocalizedString(@"FONT NAME", @"FONT NAME")  fontSize:20];
	touch.position = CGPointMake(screenSize.width / 2, screenSize.height / 4);
	[self addChild:touch z:100 tag:101];
    
    CCBlink* blink = [CCBlink actionWithDuration:10 blinks:20];
	CCRepeatForever* repeatBlink = [CCRepeatForever actionWithAction:blink];
	[touch runAction:repeatBlink];
}


-(void)resetGame{
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]];

//    isGameOver = NO;
//    [self setScreenSaverEnabled:NO];
//    [self removeChildByTag:100 cleanup:YES];
//    [self removeChildByTag:101 cleanup:YES];
//    [self resetPlane];
//    [self scheduleUpdate];
//    [[self defaultShip] scheduleUpdate];
//    [[self defaultBlockCache] scheduleUpdate];
//    [[self defaultRoofCache] scheduleUpdate];
//    [self resetBlocks];
//    totalTime = 0;
//    score = 0;
//    [scoreLabel setString:[NSString stringWithFormat:@"%@ : %d",NSLocalizedString(@"DISTANCE", @"DISTANCE"),0]];
}

-(void)resetBlocks{
    [[self defaultBlockCache] reset];
    [[self defaultRoofCache] reset];
}
-(void)resetPlane{
    [[self defaultShip] resetPosition];
}


-(void) setScreenSaverEnabled:(bool)enabled
{
	UIApplication *thisApp = [UIApplication sharedApplication];
	thisApp.idleTimerDisabled = !enabled;
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!isGameOver) {
        [[self defaultShip] up];
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (isGameOver) {
        [self resetGame];
    }else{
        [[self defaultShip] down];
    }
}

-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self defaultShip] down];
}

-(void) update:(ccTime)delta{
    totalTime += delta;
    int currentTime = (int)(totalTime*50);
    if (score<currentTime) {
        score=currentTime;
        [scoreLabel setString:[NSString stringWithFormat:@"%@: %d",NSLocalizedString(@"DISTANCE", @"DISTANCE"),score]];
    }
}

-(void)addAdMobBanner{
#ifdef LITEVERSION
    gAdBannerView= [[GADBannerView alloc]
                    initWithFrame:CGRectMake(0.0,0.0,
                                             480,
                                             GAD_SIZE_468x60.height)];
    
    gAdBannerView.adUnitID = @"a15045c01ff40bc";
    
    // 告知运行时文件，在将用户转至广告的展示位置之后恢复哪个 UIViewController
    // 并将其添加至视图层级结构。
    AppController * delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    UINavigationController *viewController = [delegate navController];
    gAdBannerView.rootViewController = viewController;
    [[[CCDirector sharedDirector] view] addSubview:gAdBannerView];
    
    // 启动一般性请求并在其中加载广告。
    [gAdBannerView loadRequest:[GADRequest request]];
#endif
}

@end
