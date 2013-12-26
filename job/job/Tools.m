//
//  Tools.m
//  job
//
//  Created by impressly on 13-12-5.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "Tools.h"
#import "HttpRequest.h"
#import "DataModel.h"
@implementation Tools

+(float)autoSizeLab:(CGSize)size  withFont:(UIFont*)font withSting:(NSString*)string
{
    CGSize labelsize = [string sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    return labelsize.height;
    
}
+(UIImage*)imageLoading
{
    NSString *string= [DataModel getHeadURL];
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:data];
    
}
+(UIImage*)imageLoadingForUrl:(NSString*)string
{
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:data];

}
+(UIImage*)drawImageInBounds:(UIImage*)image
{
    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:image];
    imageview.frame = CGRectMake(0, 0, 48, 48);
    
    
    UIGraphicsBeginImageContextWithOptions(imageview.frame.size, NO, 0.0);
    [imageview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image2 = UIGraphicsGetImageFromCurrentImageContext();
    return image2;
}
@end
