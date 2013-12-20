//
//  SettingCustomCell.m
//  job
//
//  Created by caiming on 13-12-16.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "SettingCustomCell.h"
#import <QuartzCore/QuartzCore.h>
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
    self.headImageView.frame = CGRectMake(15, 5, 48, 48);
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 2.5f;
    [self addSubview:self.headImageView];
    self.userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(80, 5, 200, 25)];
    self.userNameLab.backgroundColor = [UIColor clearColor];
    [self addSubview:self.userNameLab];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
