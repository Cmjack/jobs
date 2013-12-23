//
//  Tools.m
//  job
//
//  Created by impressly on 13-12-5.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "Tools.h"
#import "HttpRequest.h"
@implementation Tools

+(float)autoSizeLab:(CGSize)size  withFont:(UIFont*)font withSting:(NSString*)string
{
    CGSize labelsize = [string sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    return labelsize.height;
    
}
+(UIImage*)imageLoading
{
    NSString *string= [[[NSUserDefaults standardUserDefaults]objectForKey:@"userinfo"]objectForKey:@"head_url"];
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:data];
    
}

@end
