//
//  WorkCustomCell.m
//  job
//
//  Created by impressly on 13-12-4.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "WorkCustomCell.h"

@implementation WorkCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)initViewForAddLab{
    self.addLab = [[UILabel alloc]initWithFrame:CGRectMake(60, 7, 200, 30)];
    self.addLab.backgroundColor = [UIColor clearColor];
    self.addLab.textAlignment = NSTextAlignmentCenter;
    UIFont *font = [UIFont boldSystemFontOfSize:20];
    self.addLab.font =font;
    [self addSubview:self.addLab];
  
}
-(void)initendDate
{
    self.endDate = [[UILabel alloc]initWithFrame:CGRectMake(180, 27,130, 14)];
    self.endDate.backgroundColor = [UIColor clearColor];
    self.endDate.textAlignment = NSTextAlignmentRight;
    self.endDate.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:self.endDate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
