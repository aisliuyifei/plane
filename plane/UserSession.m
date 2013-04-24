//
//  UserSession.m
//  OralEnglish
//
//  Created by 鹏 吴 on 6/21/12.
//  Copyright (c) 2012 galiumsoft. All rights reserved.
//

#import "UserSession.h"
static UserSession *_sharedUserSession = nil;

@implementation UserSession
@synthesize bestScore;

-(id)init{
    if (self= [super init]) {
        [self loadBestScore];
    }
    return self;
}

+ (UserSession *)sharedUserSession{
    if (!_sharedUserSession) {
        _sharedUserSession = [[self alloc] init];
	}
    return _sharedUserSession;
}

-(void)saveBestScore:(NSInteger)score{
    self.bestScore = score;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *userDataPath = [NSString stringWithString:[documentsDirectory stringByAppendingPathComponent:@"user_data.plist"]];
    NSDictionary *userData = [[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:bestScore],@"bestScore",nil] autorelease];
    [userData writeToFile:userDataPath atomically:YES];
}

-(void)loadBestScore{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *userDataPath = [NSString stringWithString:[documentsDirectory stringByAppendingPathComponent:@"user_data.plist"]];
    NSDictionary *userData = [NSDictionary dictionaryWithContentsOfFile:userDataPath];
    if (userData ==nil) {
        self.bestScore =0;
        return;
    }
    self.bestScore = [[userData objectForKey:@"bestScore"] intValue];
}

@end