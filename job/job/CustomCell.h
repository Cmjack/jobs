//
//  CustomCell.h
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property(strong,nonatomic)UIButton    *iconButton;
@property(strong,nonatomic)UILabel     *fromLabel;
@property(strong,nonatomic)UILabel     *PCALable;
@property(strong,nonatomic)UILabel     *captionLab;
@property(strong,nonatomic)UILabel     *creatDateLab;
@property(strong,nonatomic)UILabel     *countLab;
-(void)initViews;
-(void)insertData:(NSDictionary*)dict;
@end
