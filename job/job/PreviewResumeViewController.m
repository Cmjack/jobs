//
//  PreviewResumeViewController.m
//  job
//
//  Created by caiming on 13-12-20.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "PreviewResumeViewController.h"
#import "PreviewResumeCell.h"
#import "DataModel.h"
#import "headSetting.h"
#import "Tools.h"
@interface PreviewResumeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *preTableview;
@property(nonatomic,strong)NSMutableArray * resumeDataArray;
@property(nonatomic,strong)NSArray *workMessgae;
@property(nonatomic,strong)NSArray *schoolMessage;
@property(nonatomic,strong)UILabel *captionLab;
@end

@implementation PreviewResumeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@" resume %@",self.resumeDict);
	// Do any additional setup after loading the view.
    self.preTableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.preTableview.delegate = self;
    self.preTableview.dataSource = self;
    [self.view addSubview:self.preTableview];
    
    self.resumeDataArray = [NSMutableArray arrayWithObjects:@[@"基本信息"],@[@"工作经历"],@[@"教育经历"],@[@"培训经历"],@[@"求职意向"], nil];
    
    self.workMessgae = @[@"职位",@"公司"];
    self.schoolMessage = @[@"专业",@"学校"];
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resumeDataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        if ([[self.resumeDict objectForKey:KEY_WE] count]>0) {
            
            return [[self.resumeDict objectForKey:KEY_WE] count];
        }
        
        
    }
    else if (section == 2)
    {
        if ([[self.resumeDict objectForKey:KEY_EDUCATION] count]>0) {
            
            return [[self.resumeDict objectForKey:KEY_EDUCATION] count];
        }
    }
    else if (section == 3)
    {
        if ([[self.resumeDict objectForKey:KEY_TRAINING] count]>0) {
            
            return [[self.resumeDict objectForKey:KEY_TRAINING] count];
        }
    }

    
    
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {
        PreviewResumeCell *cell;
        static NSString *cellIndex = @"basic";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIndex];
        if (cell == NULL) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PreviewResumeCell" owner:nil options:nil];
            cell = [nib objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell insertDataForBasic:[self.resumeDict objectForKey:KEY_PERSON]];
        return cell;
        
    }else if (indexPath.section == 4)
    {
        PreviewResumeCell *cell1;
        static NSString *cellIndex1 = @"apply";
        cell1 = (PreviewResumeCell*)[tableView dequeueReusableCellWithIdentifier:cellIndex1];
        if (cell1 == NULL) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PreviewResumeCell" owner:nil options:nil];
            cell1 = [nib objectAtIndex:2];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            self.captionLab= [[UILabel alloc]initWithFrame:CGRectMake(80, 72, 220, 20)];
            _captionLab.textColor = [UIColor blackColor];
            [cell1 addSubview:_captionLab];

        }
        [cell1 insertdataForCO:[self.resumeDict objectForKey:KEY_CO]];
        [self insertDataForCaption:CGRectMake(80, 72, 220, 20) withText:[[self.resumeDict objectForKey:KEY_CO] objectForKey:KEY_CAPTION]];
        return cell1;
    }
    else
    {
        PreviewResumeCell *cell2;
        static NSString *cellIndex2 = @"work";
        cell2 = [tableView dequeueReusableCellWithIdentifier:cellIndex2];
        if (cell2 == NULL) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PreviewResumeCell" owner:nil options:nil];
            cell2 = [nib objectAtIndex:1];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            self.captionLab= [[UILabel alloc]initWithFrame:CGRectMake(50, 72, 250, 20)];
            _captionLab.textColor = [UIColor blackColor];
            [cell2 addSubview:_captionLab];
        }
        if (indexPath.section == 1) {
            
            [cell2 insertDataForTitleType:self.workMessgae];
            if ([[self.resumeDict objectForKey:KEY_WE] count]>0) {
                
                [cell2 insertData:[[self.resumeDict objectForKey:KEY_WE] objectAtIndex:indexPath.row]];
                [self insertDataForCaption:CGRectMake(50, 72, 250, 20) withText:[[[self.resumeDict objectForKey:KEY_WE]objectAtIndex:indexPath.row]objectForKey:KEY_CAPTION]];
            }
            else
            {
                [cell2 insertData:NULL];
            }
        }
        else if (indexPath.section == 2)
        {
            [cell2 insertDataForTitleType:self.schoolMessage];
            if ([[self.resumeDict objectForKey:KEY_EDUCATION] count]>0) {
                
                [cell2 insertData:[[self.resumeDict objectForKey:KEY_EDUCATION] objectAtIndex:indexPath.row]];
                [self insertDataForCaption:CGRectMake(50, 72, 250, 20)withText:[[[self.resumeDict objectForKey:KEY_EDUCATION] objectAtIndex:indexPath.row] objectForKey:KEY_CAPTION]];
            }else
            {
                [cell2 insertData:NULL];
            }
            

            

        }
        else if (indexPath.section == 3)
        {
            [cell2 insertDataForTitleType:self.schoolMessage];
            if ([[self.resumeDict objectForKey:KEY_TRAINING] count]>0) {
                
                [cell2 insertData:[[self.resumeDict objectForKey:KEY_TRAINING] objectAtIndex:indexPath.row]];
                [self insertDataForCaption:CGRectMake(50, 72, 250, 20) withText:[[[self.resumeDict objectForKey:KEY_TRAINING] objectAtIndex:indexPath.row] objectForKey:KEY_CAPTION]];
            }
            else
            {
                [cell2 insertData:NULL];
            }

        }
        
        
        return cell2;
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIFont *font = [UIFont systemFontOfSize:14.0f];
    if (indexPath.section ==1) {
        
        if ([[self.resumeDict objectForKey:KEY_WE] count]<=0) {
            return 100;
        }
       NSString *str = [[[self.resumeDict objectForKey:KEY_WE]objectAtIndex:indexPath.row]objectForKey:KEY_CAPTION];
       float height= [Tools autoSizeLab:CGSizeMake(250, 10000) withFont:font withSting:str];
        return height +80;
    
    }
    else if (indexPath.section == 2)
    {
        if ([[self.resumeDict objectForKey:KEY_EDUCATION] count]<=0) {
            return 100;
        }
        NSString *str = [[[self.resumeDict objectForKey:KEY_EDUCATION]objectAtIndex:indexPath.row]objectForKey:KEY_CAPTION];
        float height= [Tools autoSizeLab:CGSizeMake(250, 10000) withFont:font withSting:str];

        return height +80;

    }else if (indexPath.section == 3)
    {
        if ([[self.resumeDict objectForKey:KEY_TRAINING] count]<=0) {
            return 100;
        }
        NSString *str = [[[self.resumeDict objectForKey:KEY_TRAINING]objectAtIndex:indexPath.row]objectForKey:KEY_CAPTION];
        float height= [Tools autoSizeLab:CGSizeMake(250, 10000) withFont:font withSting:str];

        return height +80;
    }
    else if (indexPath.section == 4)
    {
        if ([[[self.resumeDict objectForKey:KEY_CO]objectForKey:KEY_CAPTION] length]<=0) {
            return 100;
        }
        NSString *str = [[self.resumeDict objectForKey:KEY_CO]objectForKey:KEY_CAPTION];
        float height = [Tools autoSizeLab:CGSizeMake(220, 10000) withFont:font withSting:str];

        return height +88;
    }
    
    return 180;
    
}

-(void)insertDataForCaption:(CGRect)rect withText:(NSString*)string
{
    self.captionLab.text = string;
    self.captionLab.numberOfLines = 0;
    self.captionLab.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont *font = [UIFont systemFontOfSize:14.0f];
    self.captionLab.font = font;
    float height = [Tools autoSizeLab:CGSizeMake(rect.size.width, 10000) withFont:font withSting:string];
    self.captionLab.frame = CGRectMake(rect.origin.x, 72, rect.size.width, height);
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return [[self.resumeDataArray objectAtIndex:section]objectAtIndex:0];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
