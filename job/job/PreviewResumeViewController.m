//
//  PreviewResumeViewController.m
//  job
//
//  Created by caiming on 13-12-20.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "PreviewResumeViewController.h"
#import "PreviewResumeCell.h"
@interface PreviewResumeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *preTableview;
@property(nonatomic,strong)NSMutableArray * resumeDataArray;
@property(nonatomic,strong)NSArray *basicMessgae;
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
	// Do any additional setup after loading the view.
    self.preTableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.preTableview.delegate = self;
    self.preTableview.dataSource = self;
    [self.view addSubview:self.preTableview];
    
    self.resumeDataArray = [NSMutableArray arrayWithObjects:@[@"个人基本基本信息"],@[@"工作经历"],@[@"教育经历"],@[@"培训经历"],@[@"求职意向"], nil];
    
    self.basicMessgae = @[@"基本信息",@"姓名",@"应聘职位",@"最高学历",@"年龄",@"手机号码",@"Email",@"工作年限"];
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resumeDataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
        }
        cell.nameLab.text = @"修改成功";
        return cell;
        
    }else if (indexPath.section == 4)
    {
        PreviewResumeCell *cell1;
        static NSString *cellIndex1 = @"apply";
        cell1 = (PreviewResumeCell*)[tableView dequeueReusableCellWithIdentifier:cellIndex1];
        if (cell1 == NULL) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PreviewResumeCell" owner:nil options:nil];
            cell1 = [nib objectAtIndex:2];
            
        }
        NSLog(@"apply :%@,--%@ ",cell1,cell1.salaryLable);
        
        cell1.positionLable.text = @"android";
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
        }
        NSLog(@"work :%@",cell2);
        cell2.position.text = @"ios1111";
        [cell2 insertData:nil];
        return cell2;
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
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
