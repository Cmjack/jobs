//
//  ApplyJobsViewController.m
//  job
//
//  Created by caiming on 13-12-23.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "ApplyJobsViewController.h"
#import "CustomCell.h"
#import "HttpRequest.h"
#import "headSetting.h"
#import "Tools.h"
#import <QuartzCore/QuartzCore.h>
@interface ApplyJobsViewController ()<HttpRequestDelegate>
@property(nonatomic,strong)CustomCell  *customCell;
@property(nonatomic,strong)NSArray *jobMessageArray;
@property(nonatomic,strong)UILabel *loadLab;
@end

@implementation ApplyJobsViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    HttpRequest *http = [[HttpRequest alloc]init];
    http.delegate = self;
    [http httpGetMyApplylist:_dict];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.loadLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.loadLab.center = self.view.center;
    _loadLab.text = @"努力加载中....";
    _loadLab.textAlignment = NSTextAlignmentCenter;
    _loadLab.textColor = [UIColor blackColor];
    [self.view addSubview:_loadLab];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.jobMessageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    self.customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (_customCell == NULL) {
        _customCell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [_customCell initViews];
        _customCell.fromLabel.textColor = [UIColor blackColor];
        _customCell.captionLab.textColor = [UIColor blackColor];
        _customCell.PCALable.textColor = [UIColor blackColor];
        _customCell.creatDateLab.textColor = [UIColor blackColor];
        [_customCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [_customCell insertData:[self.jobMessageArray objectAtIndex:indexPath.row]];
    // Configure the cell...
    
    return _customCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 0;
    UIFont *PCAFont = [UIFont boldSystemFontOfSize:13.0f];
    NSDictionary *dict = [self.jobMessageArray objectAtIndex:indexPath.row];
    NSMutableString *PCAString = [NSMutableString stringWithFormat:@"%@ • %@ • %@",[dict objectForKey:JOB_TITLE],[dict objectForKey:JOB_COMPANY],[dict objectForKey:JOB_LOCATION]];
    CGSize size = CGSizeMake(260, 5000);
    NSString *sto= [PCAString stringByReplacingOccurrencesOfString: @"\n" withString:@""];
    
    height += [Tools autoSizeLab:size withFont:PCAFont withSting:sto];
    height += 65;
    
    return height;
}
#pragma mark - httpDelegate
-(void)getApplyJobs:(NSArray *)jobArrray
{
    if (jobArrray.count>0 ) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

        self.loadLab.hidden = YES;
        self.tableView.hidden = NO;
        self.jobMessageArray = jobArrray;
        [self.tableView reloadData];

    }else
    {
        self.loadLab.text = @"没有申请职位信息";
    }
}
@end
