//
//  PreviewResumeCell.h
//  job
//
//  Created by caiming on 13-12-20.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewResumeCell : UITableViewCell
@property(nonatomic, strong) IBOutlet UIImageView *headImage;
@property(nonatomic, strong) IBOutlet UILabel *nameLab;
@property(nonatomic, strong) IBOutlet UILabel *positionLab;
@property(nonatomic, strong) IBOutlet UILabel *diplomaLeb;
@property(nonatomic, strong) IBOutlet UILabel *ageLab;
@property(nonatomic, strong) IBOutlet UILabel *telLab;
@property(nonatomic ,strong) IBOutlet UILabel *emailLab;
@property(nonatomic, strong) IBOutlet UILabel *workLab;


@property(nonatomic, strong) IBOutlet UILabel *position;
@property(nonatomic, strong) IBOutlet UILabel *companyLab;
@property(nonatomic, strong) IBOutlet UILabel *startLab;
@property(nonatomic, strong) IBOutlet UILabel *desLab;
//
@property (strong, nonatomic) IBOutlet UILabel *psoitionTitle;
@property (strong, nonatomic) IBOutlet UILabel *companyTitle;
@property (strong, nonatomic) IBOutlet UILabel *dateTitle;
@property (strong, nonatomic) IBOutlet UILabel *desTitle;

@property (strong, nonatomic) IBOutlet UILabel *positionLable;
@property (strong, nonatomic) IBOutlet UILabel *salaryLable;
@property (strong, nonatomic) IBOutlet UILabel *dateTimeLable;
@property (strong, nonatomic) IBOutlet UILabel *captionLable;

-(void)insertDataForBasic:(NSDictionary*)dict;
-(void)insertData:(NSDictionary*)dict;
-(void)insertdataForCO:(NSDictionary*)dict;
-(void)insertDataForTitleType:(NSArray*)arr;
@end
