//
//  GetResumeViewController.m
//  job
//
//  Created by caiming on 13-12-23.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "GetResumeViewController.h"
#import "HttpRequest.h"
#import "headSetting.h"
#import "PreviewResumeViewController.h"
@interface GetResumeViewController ()<UITableViewDelegate,UITableViewDataSource,HttpRequestDelegate>
@property(nonatomic ,strong)UITableView *myTableivew;
@property(nonatomic ,strong)NSArray *resumeArray;
@property(nonatomic ,strong)UILabel *loadLab;
@end

@implementation GetResumeViewController

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
    self.title = @"已收简历";
	// Do any additional setup after loading the view.
    self.myTableivew = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myTableivew.delegate = self;
    self.myTableivew.dataSource = self;
    self.myTableivew.hidden = YES;
    [self.view addSubview:self.myTableivew];
    
    HttpRequest *http = [[HttpRequest alloc]init];
    http.delegate = self;
    [http httpGetApplylist:self.jobId];
    
    self.loadLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.loadLab.center = self.view.center;
    _loadLab.text = @"努力加载中....";
    _loadLab.textAlignment = NSTextAlignmentCenter;
    _loadLab.textColor = [UIColor blackColor];
    [self.view addSubview:_loadLab];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resumeArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdex = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdex];
    if (cell == NULL) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdex];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [[[self.resumeArray objectAtIndex:indexPath.row]objectForKey:KEY_PERSON]objectForKey:KEY_NAME];
    cell.detailTextLabel.text = [[[self.resumeArray objectAtIndex:indexPath.row]objectForKey:KEY_PERSON]objectForKey:KEY_POSITION];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PreviewResumeViewController *preview = [[PreviewResumeViewController alloc]initWithNibName:Nil bundle:Nil];
    preview.resumeDict = [self.resumeArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:preview animated:YES];
}

#pragma mark- HttpRequestDelegate
-(void)getResume:(NSArray *)resumeArray
{
    if (resumeArray.count > 0 )
    {
        self.resumeArray = resumeArray;
        self.myTableivew.hidden = NO;
        self.loadLab.hidden = YES;
        [self.myTableivew reloadData];
        

    }else
    {
        self.loadLab.text = @"该职位暂时没有人投递!";
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
