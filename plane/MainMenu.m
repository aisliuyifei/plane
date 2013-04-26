//
//  HelloWorldLayer.m
//  plane
//
//  Created by wupeng on 12-8-5.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// Import the interfaces
#import "MainMenu.h"
#import "GameScene.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - MainMenu

// HelloWorldLayer implementation
@implementation MainMenu

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenu *layer = [MainMenu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:NSLocalizedString(@"Flying Plane", @"Flying Plane") fontName:NSLocalizedString(@"FONT NAME", @"FONT NAME") fontSize:40];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height*0.8 );
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        [CCMenuItemFont setFontSize:28];
        
        CCMenuItem *itemStartGame = [CCMenuItemFont itemWithString:NSLocalizedString(@"START GAME", @"START GAME") block:^(id sender){
            [self startGame];
        }];
        
//        CCMenuItem *itemTopList = [CCMenuItemFont itemWithString:@"TOP LIST" block:^(id sender){
//        }];
//        
        CCMenuItem *itemHelp = [CCMenuItemFont itemWithString:NSLocalizedString(@"ABOUT", @"ABOUT") block:^(id sender){
            [self showAbout];
        }];
        
		CCMenu *menu = [CCMenu menuWithItems:itemStartGame,itemHelp,nil];

		[menu alignItemsVerticallyWithPadding:20];
		[menu setPosition:ccp( size.width/2, size.height/2 - 50)];

		// Add the menu to the layer
		[self addChild:menu];

//		[CCMenuItemFont setFontSize:28];
//		
//		// Achievement Menu Item using blocks
//		CCMenuItem *itemAchievement = [CCMenuItemFont itemWithString:@"Achievements" block:^(id sender) {
//			
//			
//			GKAchievementViewController *achivementViewController = [[GKAchievementViewController alloc] init];
//			achivementViewController.achievementDelegate = self;
//			
//			AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
//			
//			[[app navController] presentModalViewController:achivementViewController animated:YES];
//			
//			[achivementViewController release];
//		}
//									   ];
//        
//		// Leaderboard Menu Item using blocks
//		CCMenuItem *itemLeaderboard = [CCMenuItemFont itemWithString:@"Leaderboard" block:^(id sender) {
//			
//			
//			GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
//			leaderboardViewController.leaderboardDelegate = self;
//			
//			AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
//			
//			[[app navController] presentModalViewController:leaderboardViewController animated:YES];
//			
//			[leaderboardViewController release];
//		}
//									   ];
//		
//		CCMenu *menu = [CCMenu menuWithItems:itemAchievement, itemLeaderboard, nil];
//		
//		[menu alignItemsHorizontallyWithPadding:20];
//		[menu setPosition:ccp( size.width/2, size.height/2 - 50)];
//		
//		// Add the menu to the layer
//		[self addChild:menu];
	}
	return self;
}

- (void)startGame{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene scene] withColor:ccBLACK]];
#ifdef LITEVERSION
    [[GameScene sharedGameScene] addAdMobBanner];
#endif
}

- (void)showAbout{
    
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
