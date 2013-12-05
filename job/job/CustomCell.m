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

    self.iconImageview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    self.iconImageview.layer.cornerRadius = 5.5f;
    [self addSubview:self.iconImageview];
    
    self.fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 5, 240, 15)];
    
    UIFont *font = [UIFont systemFontOfSize:12.0f];
    self.fromLabel.font = font;
    [self addSubview:self.fromLabel];
    

    self.PCALable = [[UILabel alloc]initWithFrame:CGRectMake(45, 20, 260, 30)];
    [self addSubview:self.PCALable];
   
    
    self.captionLab = [[UILabel alloc]initWithFrame:CGRectMake(45, 60, 260, 20)];
    [self addSubview:self.captionLab];
    
    [self insertData:nil];
    
}

-(void)insertData:(NSDictionary*)dict
{
    
    self.iconImageview.image = [UIImage imageNamed:@"58"];
    self.fromLabel.text = @"来自58同城";
    
    NSString * string = @"Java开发工程师 • 搜狗-用户平台事业部 • 北京市海淀区";
    self.PCALable.text = string;
    UIFont *PCAFont = [UIFont boldSystemFontOfSize:13.0f];
    self.PCALable.font = PCAFont;
    self.PCALable.numberOfLines = 10;
    float height = [Tools autoSizeLab:CGSizeMake(260, 300) withFont:PCAFont withSting:string];
    self.PCALable.frame = CGRectMake(45, 20, 260, height);
    
    
    NSString *captionString =@"【工作职责】\n 1.参与大型系统或产品的需求分析、架构设计和概要设计等；\n 2.负责系统详细设计、核心代码及相关文档的编写 ";
    
    self.captionLab.text = captionString;
    UIFont *capFont = [UIFont systemFontOfSize:13];
    self.captionLab.font = capFont;
    self.captionLab.numberOfLines = 0;
    float caHeight = [Tools autoSizeLab:CGSizeMake(260, 300) withFont:capFont withSting:captionString];
    self.captionLab.frame = CGRectMake(45, 30+height, 260, caHeight);
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
