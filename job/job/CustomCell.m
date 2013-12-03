//
//  CustomCell.m
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "CustomCell.h"
#import <QuartzCore/QuartzCore.h>
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
    UIImageView * backimageView = [[UIImageView alloc]initWithFrame:CGRectMake(4, 2.5, 312, 65)];
    backimageView.backgroundColor = [UIColor whiteColor];
    backimageView.layer.cornerRadius =2.5f;
    [self addSubview:backimageView];
    
    self.positionLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 200, 30)];
    UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
    self.positionLabel.font =font;
    
    self.companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, 200, 20)];
    self.companyLabel.font = [UIFont systemFontOfSize:13.0f];
    
    self.areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(220, 10, 80, 20)];
    self.areaLabel.textAlignment = NSTextAlignmentRight;
    self.areaLabel.font = [UIFont systemFontOfSize:12.0f];
    
    [self addSubview:self.positionLabel];
    [self addSubview:self.companyLabel];
    [self addSubview:self.areaLabel];
    
}
-(void)insertData:(NSDictionary*)dict
{
    self.positionLabel.text = @"iOS开发工程师";
    self.companyLabel.text = @"上海市XX网络公司";
    self.areaLabel.text = @"上海-浦东区";
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
