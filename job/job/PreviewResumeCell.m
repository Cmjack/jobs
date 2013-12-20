//
//  PreviewResumeCell.m
//  job
//
//  Created by caiming on 13-12-20.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "PreviewResumeCell.h"

@implementation PreviewResumeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

//工作、教育、培训
-(void)insertData:(NSDictionary*)dict
{
    NSLog(@"    %@",self.position);
    self.position.text = @"sss";
    NSString *str = @"您的应用“事业线”已经通过我方的来源文案审核，经由您的应用所发出的微博信息将会显示相应的来源文案，同时，您可以查看《微博开放平台审核指南》，对您的应用进行优化。感谢您对新浪微博开放平台的支持！";
    self.desLab.numberOfLines = 0;
    self.desLab.lineBreakMode = NSLineBreakByWordWrapping;
    self.desLab.text = str;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
