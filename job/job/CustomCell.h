//
//  CustomCell.h
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property(strong,nonatomic)UILabel *positionLabel;
@property(strong,nonatomic)UILabel *companyLabel;
@property(strong,nonatomic)UILabel *areaLabel;
@property(strong,nonatomic)UILabel *fromLabel;

-(void)initViews;
-(void)insertData:(NSDictionary*)dict;
@end
