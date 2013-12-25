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
+(UIImage*)imageLoadingForUrl:(NSString*)stringURL
{
    dispatch_queue_t queue  =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        NSURL *url = [NSURL URLWithString:stringURL];
        UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        //[self writeImageToDocuments:imageData withImageName:fileName withFileType:fileType];
        
    });

    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:data];

}
//-(void)ssss
//{
//    dispatch_queue_t queue  =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        
//        NSURL *url = [NSURL URLWithString:string];
//        UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
//        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
//        [self writeImageToDocuments:imageData withImageName:fileName withFileType:fileType];
//        
//    });
//}
@end
