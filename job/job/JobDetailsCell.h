//
//  JobDetailsCell.h
//  job
//
//  Created by caiming on 13-12-17.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JobDetailsCellDelegate <NSObject>

-(void)sendApply;

@end
@interface JobDetailsCell : UITableViewCell
@property(nonatomic,weak)id<JobDetailsCellDelegate> delegate;
@property(nonatomic,strong)UILabel *positionLab;
@property(nonatomic,strong)UILabel *companYLab;
@property(nonatomic,strong)UILabel *dateLab;
@property(nonatomic,strong)UILabel *salaryLab;
@property(nonatomic,strong)UILabel *captionLab;
@property(nonatomic,strong)UIButton *applyButton;
@property(nonatomic,strong)NSDictionary *jobDict;
-(void)initViews;
-(void)insertData:(NSDictionary*)dict;
-(void)initCaptionLab;
-(void)insertCaptionData:(NSString*)captionStr;
@end
