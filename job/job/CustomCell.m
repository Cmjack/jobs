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
    self.iconButton.backgroundColor = [UIColor redColor];
    //self.iconButton.layer.borderWidth = 2.0;
    self.iconButton.layer.masksToBounds = YES;
    self.iconButton.layer.cornerRadius = 5.5f;
    [self addSubview:self.iconButton];
    
    self.fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 5, 240, 15)];
    
    UIFont *font = [UIFont systemFontOfSize:12.0f];
    self.fromLabel.font = font;
    self.fromLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.fromLabel];
    

    self.PCALable = [[UILabel alloc]initWithFrame:CGRectMake(45, 20, 260, 30)];
    self.PCALable.textColor = [UIColor lightGrayColor];
    [self addSubview:self.PCALable];
   
    
    self.captionLab = [[UILabel alloc]initWithFrame:CGRectMake(45, 60, 260, 20)];
    self.captionLab.textColor = [UIColor lightTextColor];
    [self addSubview:self.captionLab];
    
    [self insertData:nil];
    
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
    }
    
    NSMutableString *PCAString = [NSMutableString stringWithFormat:@"%@ • %@ • %@",[dict objectForKey:JOB_TITLE],[dict objectForKey:JOB_COMPANY],[dict objectForKey:JOB_LOCATION]];
    
    self.PCALable.text = PCAString;
    UIFont *PCAFont = [UIFont boldSystemFontOfSize:13.0f];
    self.PCALable.font = PCAFont;
    self.PCALable.numberOfLines = 10;
    float height = [Tools autoSizeLab:CGSizeMake(260, 300) withFont:PCAFont withSting:PCAString];
    self.PCALable.frame = CGRectMake(45, 20, 260, height);
    
    
    self.captionLab.text = [dict objectForKey:JOB_DESC];
    UIFont *capFont = [UIFont systemFontOfSize:13];
    self.captionLab.font = capFont;
    self.captionLab.numberOfLines = 0;
    float caHeight = [Tools autoSizeLab:CGSizeMake(260, 8000) withFont:capFont withSting:[dict objectForKey:JOB_DESC]];
    self.captionLab.frame = CGRectMake(45, 30+height, 260, caHeight);
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
