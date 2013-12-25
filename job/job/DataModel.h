//
//  DataModel.h
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModel : NSObject
@property(nonatomic,strong)NSArray *shareData;
@property(nonatomic,assign)BOOL isLogin;
@property(nonatomic,strong)NSMutableDictionary *resumeDict;
+(DataModel*)shareData;
+(NSString*)getLoginType;
+(NSString*)getUserName;
+(NSString*)getPassword;
+(NSString*)getHeadURL;
+(NSString*)getNickName;
+(NSString*)getMyToken;
+(NSString*)getUserId;
+(void)setLoginType:(NSString*)string;
+(void)setUserName:(NSString*)string;
+(void)setPassword:(NSString*)string;
+(void)setHeadURL:(NSString*)string;
+(void)setNickName:(NSString*)string;
+(void)setMyToken:(NSString*)string;
+(void)setUserId:(NSString*)string;
@end
