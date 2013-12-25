//
//  SinaSDK.h
//  job
//
//  Created by caiming on 13-12-14.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SinaSDKDelegate <NSObject>

-(void)sinaLoginSuccess;


@end
@interface SinaSDK : NSObject
@property(nonatomic, strong)id<SinaSDKDelegate> delegate;
- (void)ssoButtonPressed;
+(id)shareSinaSdk;
@end
