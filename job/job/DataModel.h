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
+(DataModel*)shareData;
@end
