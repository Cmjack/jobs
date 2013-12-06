//
//  Tools.m
//  job
//
//  Created by impressly on 13-12-5.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+(float)autoSizeLab:(CGSize)size  withFont:(UIFont*)font withSting:(NSString*)string
{
    CGSize labelsize = [string sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    return labelsize.height;
    
}
@end
