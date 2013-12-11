//
//  JoinCustomCell.h
//  job
//
//  Created by impressly on 13-12-10.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinCustomCell : UITableViewCell
@property(nonatomic,strong)UITextField *textfield;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UITextView *textView;
-(void)initViews;
-(void)initLab;
@end
