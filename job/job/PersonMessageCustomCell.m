//
//  PersonMessageCustomCell.m
//  job
//
//  Created by impressly on 13-12-4.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "PersonMessageCustomCell.h"

@implementation PersonMessageCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)initViewsForTextField{
    self.textField =[[UITextField alloc]initWithFrame:CGRectMake(120, 5, 180, 30)];
    //self.textField.text = @"xingming";
    //self.textField.rightViewMode = UITextFieldViewModeAlways;
    self.textField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    self.textField.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    self.textField.textAlignment = NSTextAlignmentRight;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    [self addSubview:self.textField];
}
-(void)initViewsForLable{
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 180, 30)];
    
    self.label.textAlignment = NSTextAlignmentRight;
    [self addSubview:_label];

}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"%ld",(long)self.textField.tag);
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  
    [self.textField resignFirstResponder];
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
