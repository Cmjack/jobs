//
//  JoinCustomCell.m
//  job
//
//  Created by impressly on 13-12-10.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "JoinCustomCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation JoinCustomCell

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
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, 240, 24)];
    self.textfield.rightViewMode = UITextFieldViewModeUnlessEditing;
    self.textfield.font = [UIFont systemFontOfSize:13.0f];
    //self.textfield.layer.borderWidth = 0.5f;
    
    [self addSubview:self.textfield];
    
}
-(void)initLab
{
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 25, 25)];
    [self addSubview:self.iconImageView];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(60, 8, 240, 150)];
    self.textView.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:self.textView];
    
    //self.textView.layer.borderWidth = 0.5f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
