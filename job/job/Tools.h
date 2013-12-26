//
//  Tools.h
//  job
//
//  Created by impressly on 13-12-5.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
+(float)autoSizeLab:(CGSize)size  withFont:(UIFont*)font withSting:(NSString*)string;
+(UIImage*)imageLoading;
+(UIImage*)imageLoadingForUrl:(NSString*)string;
+(UIImage*)drawImageInBounds:(UIImage*)image;
@end
