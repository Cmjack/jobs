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
#import "headSetting.h"
#import "JIViewController.h"
#import "HttpRequest.h"
#import "DataModel.h"
#import "PreviewResumeViewController.h"
@interface ResumeViewController ()<UITableViewDataSource,UITableViewDelegate,HttpRequestDelegate>
@property (nonatomic ,strong)UITableView *tableview;
@property (nonatomic ,strong)NSArray *array;
@property (nonatomic ,strong)NSDictionary *resumeMessage;
@property (nonatomic ,strong)UILabel *loadingLab;
@property (nonatomic ,strong)DataModel *dataModel;

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
    self.array = @[@[@"个人信息",@"工作经验",@"教育经历"],@[@"求职意向",@"培训经历"]];
    self.dataModel = [DataModel shareData];
    // Do any additional setup after loading the view.
    
    HttpRequest *http = [[HttpRequest alloc]init];
    http.delegate = self;
    [http httpRequestForGetResume];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"简历预览" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
}
-(void)initViews{
    self.tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    self.tableview.hidden = YES;
    
    
    self.loadingLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.loadingLab.text = @"加载中.....";
    self.loadingLab.backgroundColor = [UIColor clearColor];
    self.loadingLab.center = self.view.center;
    [self.view addSubview:self.loadingLab];
    
}
-(void)clickRightButton
{
    PreviewResumeViewController *preview = [[PreviewResumeViewController alloc]initWithNibName:nil bundle:nil];
    preview.resumeDict = self.dataModel.resumeDict;
    [self.navigationController pushViewController:preview animated:YES];
}

#pragma mark- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.array objectAtIndex:section] count];
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
        
    }else if (indexPath.section ==0 && indexPath.row ==1)
    {
        WorkTableViewController *workTBC = [[WorkTableViewController alloc]initWithNibName:nil bundle:nil];
        workTBC.type = @"添加工作经历";
        workTBC.mutableArray = [NSMutableArray arrayWithArray:[self.dataModel.resumeDict objectForKey:KEY_WE]];
        
        [self.navigationController pushViewController:workTBC animated:YES];
    }else if (indexPath.section ==0 && indexPath.row ==2)
    {
        WorkTableViewController *workTBC = [[WorkTableViewController alloc]initWithNibName:nil bundle:nil];
        workTBC.type = @"添加教育经历";

        workTBC.mutableArray = [NSMutableArray arrayWithArray:[self.dataModel.resumeDict objectForKey:KEY_EDUCATION]];
        
        [self.navigationController pushViewController:workTBC animated:YES];
    }else if (indexPath.section ==1 && indexPath.row ==1)
    {
        WorkTableViewController *workTBC = [[WorkTableViewController alloc]initWithNibName:nil bundle:nil];
        workTBC.type = @"添加培训经历";
        
        workTBC.mutableArray = [NSMutableArray arrayWithArray:[self.dataModel.resumeDict objectForKey:KEY_TRAINING]];
        [self.navigationController pushViewController:workTBC animated:YES];
    }else if (indexPath.section ==1 && indexPath.row ==0)
    {
        JIViewController *JIView = [[JIViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:JIView animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - HttprequestDelegate
-(void)getUserResumeMessage:(NSDictionary *)resumeMessage
{
    self.tableview.hidden = NO;
    self.loadingLab.hidden = YES;
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
