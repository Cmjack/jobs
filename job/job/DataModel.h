//
//  DataModel.h
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>

@interface DataModel : NSObject<TencentSessionDelegate,TCAPIRequestDelegate,TencentApiInterfaceDelegate>
@property(nonatomic,strong)NSArray *shareData;
@property(nonatomic,assign)BOOL isLogin;
@property(nonatomic,strong)NSMutableDictionary *resumeDict;
+(DataModel*)shareData;
-(void)tencent;
@end
