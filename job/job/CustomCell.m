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
#import "UIImageView+LoadImage.h"
#import <AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
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

    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.frame = CGRectMake(5, 5, 30, 30);
    //self.iconButton.layer.borderWidth = 2.0;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 5.5f;
    
    [self addSubview:self.iconImageView];
    
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
        self.iconImageView.image = [UIImage imageNamed:@"58"];
        self.fromLabel.text = @"来自58同城";
    }else if ([[dict objectForKey:JOB_SOURCE]isEqualToString:FROM_LAGOU]){
        self.iconImageView.image = [UIImage imageNamed:@"lagou.jpg"];
        self.fromLabel.text = @"来自拉勾网";
    }else if ([[dict objectForKey:JOB_SOURCE]isEqualToString:FROM_WEALINK]){
        self.iconImageView.image = [UIImage imageNamed:@"wealink.jpg"];

        self.fromLabel.text = @"来自若邻网";
    }else if ([[dict objectForKey:JOB_SOURCE]isEqualToString:FROM_51]) {
        self.iconImageView.image = [UIImage imageNamed:@"51Icon.png"];

        self.fromLabel.text = @"来自前程无忧";
    }else if ([[dict objectForKey:JOB_SOURCE]isEqualToString:FROM_OSCHINA]) {
        self.iconImageView.image = [UIImage imageNamed:@"oschina.png"];
        self.fromLabel.text = @"来自开源中国";
    }
    else
    {
        if ([[dict objectForKey:@"icon_url"]length]>0) {
            //[self.iconButton setImage:[Tools imageLoadingForUrl:[dict objectForKey:@"icon_url"]] forState:UIControlStateNormal];
           // [self.iconImageView setImageWithURLString:[dict objectForKey:@"icon_url"] placeholderImage:[UIImage imageNamed:@"Avatar1.png"]];
            NSURL *url = [NSURL URLWithString:[dict objectForKey:@"icon_url"]];
            
            [self.iconImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Avatar1.png"]];
            

        }
        else
        {
            self.iconImageView.image = [UIImage imageNamed:@"Avatar1.png"];

        }
        self.fromLabel.text = @"来自事业线";
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
