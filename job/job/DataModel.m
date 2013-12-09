//
//  DataModel.m
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel
+(DataModel*)shareData
{
    static DataModel * shareData ;
    if (shareData == nil) {
        shareData = [[DataModel alloc]init];
        shareData.resumeDict = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return shareData;
}
@end
