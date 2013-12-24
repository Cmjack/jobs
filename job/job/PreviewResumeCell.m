//
//  PreviewResumeCell.m
//  job
//
//  Created by caiming on 13-12-20.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "PreviewResumeCell.h"
#import "headSetting.h"
#import "Tools.h"
@implementation PreviewResumeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
//基本信息
-(void)insertDataForBasic:(NSDictionary*)dict
{
    static  int once = 0;
    
    if ([[dict objectForKey:@"icon_url"]length]>0 && once == 0) {
        self.headImage.image = [Tools imageLoadingForUrl:[dict objectForKey:@"icon_url"]];
        once +=1;
    }
    self.nameLab.text = [dict objectForKey:KEY_NAME];
    self.positionLab.text = [dict objectForKey:KEY_POSITION];
    self.diplomaLeb.text = [dict objectForKey:KEY_DIPLOMA];
    self.ageLab.text = [dict objectForKey:KEY_AGE];
    self.telLab.text = [dict objectForKey:KEY_TEL];
    self.emailLab.text = [dict objectForKey:KEY_EMAIL];
    self.workLab.text = [dict objectForKey:KEY_WORK];
}
//工作、教育、培训



-(void)insertData:(NSDictionary*)dict
{
    
    self.position.text = [dict objectForKey:KEY_POSITION];
    self.companyLab.text = [dict objectForKey:KEY_COMPANY];
    NSString *starDate = [[dict objectForKey:KEY_START_DATE]substringToIndex:7];
    NSString *endDate = [[dict objectForKey:KEY_END_DATE]substringToIndex:7];
    if (starDate.length>0 && endDate.length>0) {
        self.startLab.text = [NSString stringWithFormat:@"%@ 至 %@",starDate,endDate];

    }
//    NSString *str = [dict objectForKey:KEY_CAPTION];
    
//    self.desLab.numberOfLines = 0;
//    self.desLab.lineBreakMode = NSLineBreakByWordWrapping;
//    self.desLab.text = str;
//    self.desLab.backgroundColor = [UIColor redColor];
//     UIFont *font = [UIFont systemFontOfSize:14.0f];
//    float height = [Tools autoSizeLab:CGSizeMake(250, 10000) withFont:font withSting:str];
//    NSLog(@"%f",height);
//    self.desLab.frame = CGRectMake(50, 72, 250, height);
    
}
-(void)insertDataForTitleType:(NSArray*)arr
{
    self.psoitionTitle.text = [arr objectAtIndex:0];
    self.companyTitle.text = [arr objectAtIndex:1];
    
}

//求职意向

-(void)insertdataForCO:(NSDictionary*)dict
{
    
    self.positionLable.text = [dict objectForKey:KEY_POSITION];
    self.salaryLable.text = [dict objectForKey:KEY_SALARY];
    self.dateTimeLable.text = [dict objectForKey:KEY_START_DATE];
    
//    NSString * str = [dict objectForKey:KEY_CAPTION];
//    self.captionLable.text = str;
//    self.captionLable.numberOfLines = 0;
//    self.captionLable.lineBreakMode = NSLineBreakByWordWrapping;
//    self.captionLable.backgroundColor = [UIColor brownColor];
//    UIFont *font = [UIFont systemFontOfSize:14.0f];
//    float height = [Tools autoSizeLab:CGSizeMake(220, 10000) withFont:font withSting:str];
//    self.captionLable.frame = CGRectMake(80, 72, 220, height);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
