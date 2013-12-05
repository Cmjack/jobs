//
//  HttpRequest.h
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol HttpRequestDelegate <NSObject>

-(void)loginSucessOrFail:(BOOL)isSucess;

@end
@interface HttpRequest : NSObject
@property(nonatomic, weak)id<HttpRequestDelegate> delegate;
-(void)httpRequestForGet;
-(void)registerUserEmail:(NSString*)email withPassWard:(NSString*)passWord;
-(void)loginUserName:(NSString*)name withSalt:(NSString*)salt;
+(void)check;
@end
