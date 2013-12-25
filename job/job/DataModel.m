//
//  DataModel.m
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "DataModel.h"
#import "headSetting.h"
@implementation DataModel

+(DataModel*)shareData
{
    static DataModel * shareData ;
    
    
    @synchronized(self)
    {
        if (shareData == nil) {
            shareData = [[DataModel alloc]init];
            shareData.resumeDict = [NSMutableDictionary dictionaryWithCapacity:10];
        }

    }
    
    return shareData;
}

+(NSString*)getLoginType
{
    return  [[NSUserDefaults standardUserDefaults]objectForKey:LOGINTYPE];
}

+(NSString*)getUserName
{
     return  [[NSUserDefaults standardUserDefaults]objectForKey:USERNAME];
}
+(NSString*)getPassword
{
    return  [[NSUserDefaults standardUserDefaults]objectForKey:PASSWORD];
}

+(NSString*)getHeadURL
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:HEAD_URL];
}

+(NSString*)getNickName
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:NICK_NAME];

}

+(NSString*)getMyToken
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:MYAPPTOKEN];

}
+(NSString*)getUserId
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
}


+(void)setLoginType:(NSString*)string
{
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:LOGINTYPE];
}

+(void)setUserName:(NSString*)string
{
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:USERNAME];
}

+(void)setPassword:(NSString*)string
{
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:PASSWORD];
}

+(void)setHeadURL:(NSString*)string
{
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:HEAD_URL];
}

+(void)setNickName:(NSString*)string
{
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:NICK_NAME];
}

+(void)setMyToken:(NSString*)string
{
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:MYAPPTOKEN];
}

+(void)setUserId:(NSString*)string
{
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:USER_ID];

}

@end
