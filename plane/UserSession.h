//
//  UserSession.h
//  OralEnglish
//
//  Created by 鹏 吴 on 6/21/12.
//  Copyright (c) 2012 galiumsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSession : NSObject{
    NSInteger bestScore;
}

@property (nonatomic,assign)NSInteger bestScore;

+ (UserSession *)sharedUserSession;
-(void)saveBestScore:(NSInteger)score;
@end
