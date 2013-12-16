//
//  TecentSDK.h
//  job
//
//  Created by caiming on 13-12-13.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentOAuthObject.h>

@protocol TecentSDKDelegate <NSObject>

-(void)tencentLoginIsSuccess:(BOOL)isSuccess withDict:(NSDictionary*)userInfo;

@end
@interface TecentSDK : NSObject<TencentSessionDelegate>
@property (nonatomic, retain)TencentOAuth *oauth;

@property (nonatomic, strong)id<TecentSDKDelegate> delegate;
-(void)tencentLogout;
+(id)getinstance;
@end
