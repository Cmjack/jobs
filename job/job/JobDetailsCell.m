//
//  JobDetailsCell.m
//  job
//
//  Created by caiming on 13-12-17.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "JobDetailsCell.h"
#import "Tools.h"
#import "headSetting.h"
#import <QuartzCore/QuartzCore.h>
@implementation JobDetailsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)initViews
{
    self.positionLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
    self.positionLab.backgroundColor = [UIColor clearColor];
    self.positionLab.font = [UIFont boldSystemFontOfSize:15.0f];
    [self addSubview:self.positionLab];
    
    self.applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.applyButton.frame = CGRectMake(220, 10, 80, 30);
    [self.applyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.applyButton setTitle:@"立即申请" forState:UIControlStateNormal];
    self.applyButton.layer.borderWidth = 0.5f;
    self.applyButton.layer.cornerRadius = 4.0f;
    self.applyButton.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:0.7];
    
    
    [self.applyButton addTarget:self action:@selector(clickApplyButtonDown) forControlEvents:UIControlEventTouchDown];
    
    [self.applyButton addTarget:self action:@selector(clickApplyButtonOutSide) forControlEvents:UIControlEventTouchUpOutside];
    
    [self.applyButton addTarget:self action:@selector(clickApplyButton) forControlEvents:UIControlEventTouchUpInside];
    
   // [self.applyButton addTarget:self action:@selector(clickApplyButtonCancel) forControlEvents:UIControlEventTouchCancel];
    
    self.applyButton.layer.borderColor = [[UIColor colorWithWhite:0.0f alpha:0.6]CGColor];
    [self addSubview:self.applyButton];
    
    self.companYLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 200, 20)];
    self.companYLab.backgroundColor = [UIColor clearColor];
    self.companYLab.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:self.companYLab];
    
    self.salaryLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 200, 20)];
    self.salaryLab.backgroundColor = [UIColor clearColor];
    self.salaryLab.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:self.salaryLab];
    
    self.dateLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 200, 20)];
    self.dateLab.backgroundColor = [UIColor clearColor];
    self.dateLab.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:self.dateLab];
    
}

-(void)insertData:(NSDictionary*)dict
{
    self.jobDict = dict;
    self.positionLab.text = [dict objectForKey:JOB_TITLE];
    self.companYLab.text = [dict objectForKey:JOB_COMPANY];
    if ([[dict objectForKey:JOB_SALARY] length]>0) {
        self.salaryLab.text = [NSString stringWithFormat:@"薪资待遇:%@",[dict objectForKey:JOB_SALARY]];

    }
    else
    {
        self.salaryLab.text = @"薪资待遇:面议";

    }
    
   
    self.dateLab.text = [NSString stringWithFormat:@"发布时间:%@",[[dict objectForKey:@"posted_date"]substringToIndex:10]];
}

-(void)initCaptionLab
{
    self.captionLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 200)];
    self.captionLab.backgroundColor = [UIColor clearColor];
    self.captionLab.textColor = [UIColor blackColor];
    self.captionLab.numberOfLines = 0;
    self.captionLab.lineBreakMode = NSLineBreakByWordWrapping;
    self.captionLab.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:self.captionLab];
}

-(void)insertCaptionData:(NSString*)captionStr
{
    NSLog(@"caption:%@",captionStr);
    UIFont * font = [UIFont systemFontOfSize:15.0f];
    CGSize size = CGSizeMake(300, 10000);
    self.captionLab.text = captionStr;
    float height= [Tools autoSizeLab:size withFont:font withSting:captionStr];
    NSLog(@"%f",height);
    self.captionLab.frame = CGRectMake(10, 10, 300,height+20);
    
}

-(void)clickApplyButtonDown
{
    self.applyButton.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    
}
-(void)clickApplyButton
{
  
    self.applyButton.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:0.70];
    
    if ([self.delegate respondsToSelector:@selector(sendApply)]) {
        [self.delegate sendApply];
    }
//    if ([[self.jobDict objectForKey:JOB_URL] length]>0) {
//        NSURL *url = [NSURL URLWithString:[self.jobDict objectForKey:JOB_URL]];
//        [[UIApplication sharedApplication]openURL:url];
//        
//    }
}
-(void)clickApplyButtonOutSide
{
    self.applyButton.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:0.70];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
