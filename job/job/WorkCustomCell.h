//
//  WorkCustomCell.h
//  job
//
//  Created by impressly on 13-12-4.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkCustomCell : UITableViewCell
@property(nonatomic ,strong)UILabel *addLab;
@property(nonatomic ,strong)UILabel *companyLab;

-(void)initViewForAddLab;
@end
