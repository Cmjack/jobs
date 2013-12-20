//
//  JIViewCell.m
//  job
//
//  Created by caiming on 13-12-20.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "JIViewCell.h"

@implementation JIViewCell

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
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 24)];
    self.titleLab.font = [UIFont systemFontOfSize:17.0f];
    [self addSubview:self.titleLab];
    
    self.textLab = [[UILabel alloc]initWithFrame:CGRectMake(90, 10, 200, 20)];
    self.textLab.font = [UIFont systemFontOfSize:17.0f];
    self.textLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.textLab];
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
