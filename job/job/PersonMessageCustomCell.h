//
//  PersonMessageCustomCell.h
//  job
//
//  Created by impressly on 13-12-4.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonMessageCustomCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic, strong)UITextField *textField;
@property(nonatomic, strong)UILabel *label;

-(void)initViewsForTextField;
-(void)initViewsForLable;
@end
