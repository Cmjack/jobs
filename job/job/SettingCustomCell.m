//
//  SettingCustomCell.m
//  job
//
//  Created by caiming on 13-12-16.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "SettingCustomCell.h"

@implementation SettingCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    [self initViews];
    return self;
}
-(void)initViews
{
    self.headImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Avatar1"]];
    self.headImageView.frame = CGRectMake(5, 5, 48, 48);
    [self addSubview:self.headImageView];
    self.userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 200, 25)];
    self.userNameLab.backgroundColor = [UIColor clearColor];
    self.userNameLab.text = @"262552198@qq.com";
    [self addSubview:self.userNameLab];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
