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
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(80, 10, 220, 24)];
    self.textfield.rightViewMode = UITextFieldViewModeUnlessEditing;
    self.textfield.font = [UIFont systemFontOfSize:13.0f];
    //self.textfield.layer.borderWidth = 0.5f;
    self.textfield.placeholder = @"请输入。。。";
    
    [self addSubview:self.textfield];
    
}
-(void)initLab
{
    self.lable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 60, 30)];
    self.lable.text = @"岗位描述:";
    self.lable.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:self.lable];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(80, 8, 220, 100)];
    self.textView.text = @"例如: 需要会些什么";
    [self addSubview:self.textView];
    
    self.textView.layer.borderWidth = 0.5f;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
