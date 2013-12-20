//
//  CustomCell.m
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "CustomCell.h"
#import <QuartzCore/QuartzCore.h>
#import "Tools.h"
#import "headSetting.h"
@implementation CustomCell

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

    self.iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconButton.frame = CGRectMake(5, 5, 30, 30);
    //self.iconButton.layer.borderWidth = 2.0;
    self.iconButton.layer.masksToBounds = YES;
    self.iconButton.layer.cornerRadius = 5.5f;
    [self addSubview:self.iconButton];
    
    self.countLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 35, 30, 30)];
    self.countLab.font = [UIFont systemFontOfSize:7.0f];
    self.countLab.textColor = [UIColor whiteColor];
    //[self addSubview:self.countLab];
    
    self.fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 5, 140, 10)];
    self.fromLabel.backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont systemFontOfSize:10.0f];
    self.fromLabel.font = font;
    self.fromLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.fromLabel];
    
    self.creatDateLab = [[UILabel alloc]initWithFrame:CGRectMake(220, 5, 85, 10)];
    self.creatDateLab.backgroundColor = [UIColor clearColor];
    self.creatDateLab.font = font;
    self.creatDateLab.textAlignment = NSTextAlignmentRight;
    self.creatDateLab.textColor = [UIColor whiteColor];
    [self addSubview:self.creatDateLab];
    
    

    self.PCALable = [[UILabel alloc]initWithFrame:CGRectMake(45, 15, 260, 30)];
    self.PCALable.textColor = [UIColor lightGrayColor];
    self.PCALable.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.PCALable];
   
    
    self.captionLab = [[UILabel alloc]initWithFrame:CGRectMake(45, 60, 260, 20)];
    self.captionLab.backgroundColor = [UIColor clearColor];
    self.captionLab.lineBreakMode = NSLineBreakByTruncatingTail;
    self.captionLab.textColor = [UIColor lightTextColor];
    [self addSubview:self.captionLab];
    
}

-(void)insertData:(NSDictionary*)dict
{
    if ([[dict objectForKey:JOB_SOURCE]isEqualToString:FROM_58]) {
       
        [self.iconButton setImage:[UIImage imageNamed:@"58"] forState:UIControlStateNormal];
        self.fromLabel.text = @"来自58同城";
    }else if ([[dict objectForKey:JOB_SOURCE]isEqualToString:FROM_LAGOU]){
        
        [self.iconButton setImage:[UIImage imageNamed:@"lagou.jpg"] forState:UIControlStateNormal];
        self.fromLabel.text = @"来自拉勾网";
    }else if ([[dict objectForKey:JOB_SOURCE]isEqualToString:FROM_WEALINK]){
        
        [self.iconButton setImage:[UIImage imageNamed:@"wealink.jpg"] forState:UIControlStateNormal];
        self.fromLabel.text = @"来自若邻网";
    }else if ([[dict objectForKey:JOB_SOURCE]isEqualToString:FROM_WEALINK]) {
        [self.iconButton setImage:[UIImage imageNamed:@"51Icon.png"] forState:UIControlStateNormal];
        self.fromLabel.text = @"来自前程无忧";
    }else if ([[dict objectForKey:JOB_SOURCE]isEqualToString:FROM_OSCHINA]) {
        [self.iconButton setImage:[UIImage imageNamed:@"oschina.png"] forState:UIControlStateNormal];
        self.fromLabel.text = @"来自开源中国";
    }
    else
    {
        self.iconButton.layer.borderWidth = 0.5f;
        self.iconButton.layer.borderColor = [[UIColor grayColor]CGColor];

    }
    
    
    self.creatDateLab.text = [[dict objectForKey:@"posted_date"]substringToIndex:10];
    
    NSMutableString *PCAString = [NSMutableString stringWithFormat:@"%@ • %@ • %@",[dict objectForKey:JOB_TITLE],[dict objectForKey:JOB_COMPANY],[dict objectForKey:JOB_LOCATION]];
    
    NSString *sto= [PCAString stringByReplacingOccurrencesOfString: @"\n" withString:@""];
    
    self.PCALable.text = sto;
    UIFont *PCAFont = [UIFont boldSystemFontOfSize:13.0f];
    self.PCALable.font = PCAFont;
    self.PCALable.numberOfLines = 10;
    float height = [Tools autoSizeLab:CGSizeMake(260, 300) withFont:PCAFont withSting:sto];
    self.PCALable.frame = CGRectMake(45, 15, 260, height);
    
    self.captionLab.text = [dict objectForKey:JOB_DESC];
    UIFont *capFont = [UIFont systemFontOfSize:13];
    self.captionLab.font = capFont;
    self.captionLab.numberOfLines = 0;
    //float caHeight = [Tools autoSizeLab:CGSizeMake(260, 8000) withFont:capFont withSting:[dict objectForKey:JOB_DESC]];
    self.captionLab.frame = CGRectMake(45, height+15, 260, 50);
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
