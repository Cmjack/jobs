//
//  ResumeViewController.m
//  job
//
//  Created by impressly on 13-12-4.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "ResumeViewController.h"
#import "PersonMessageViewController.h"
#import "WorkTableViewController.h"
@interface ResumeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableview;
@property (nonatomic ,strong)NSArray *array;
@end

@implementation ResumeViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"简历中心";
    [self initViews];
    self.array = @[@[@"个人信息",@"工作经验",@"教育经历"],@[@"求职意向",@"培训经历",@"语言能力"]];
    // Do any additional setup after loading the view.
}
-(void)initViews{
    self.tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
}
#pragma mark- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString * indexCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexCell];
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    cell.textLabel.text = [[self.array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    return cell;
    
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"必填:只需填写完整即可投递职位";
    }else if (section == 1)
    {
        return @"选填:完善信息让企业对你有更多的了解";
    }
    return NULL;
    
}

#pragma mark -UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==0 &&indexPath.row ==0)
    {
        PersonMessageViewController *personVC = [[PersonMessageViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:personVC animated:YES];
    }else if (indexPath.section ==0 && indexPath.row ==1){
        WorkTableViewController *workTBC = [[WorkTableViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:workTBC animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
