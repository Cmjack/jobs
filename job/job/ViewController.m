//
//  ViewController.m
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "ResumeViewController.h"
#import "HttpRequest.h"
#import "loginViewController.h"
#import "DataModel.h"
#import "Tools.h"
#import "headSetting.h"
#import "HttpRequest.h"
#import "JoinViewController.h"
#import "SettingViewController.h"
#import "SearchView.h"
#define  VERSION [[[UIDevice currentDevice] systemVersion]floatValue]
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,HttpRequestDelegate,SearchViewDelegate>
@property(nonatomic,strong)UITableView *jobTableView;
@property(nonatomic,strong)CustomCell *customCell;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIButton *positionButton;
@property(nonatomic,strong)UIButton *areaButton;
@property(nonatomic,strong)NSArray *jobDataArray;
@property(nonatomic,strong)DataModel *shareDataModel;
@property(nonatomic,strong)UIRefreshControl *refresh;
@property(nonatomic,strong)UIButton *searchButton;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];
    [self refreshData];
    self.shareDataModel = [DataModel shareData];
    self.title = @"事业线";
    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(185, 30, 24, 24)];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"ball_point_pen-25"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(clickSearchButton) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:searchButton];
    self.searchButton = searchButton;
    
    [self addObserver:self.jobTableView forKeyPath:@"offset" options:NSKeyValueObservingOptionNew context:nil];
    []
//
//     self.jobDataArray = self.shareDataModel.shareData;
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"chang::::%@",change);
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (VERSION>=7.0f) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:87.0/255.0f green:147.0/255.0f blue:158.0/255.0 alpha:0.5];
    }
    self.searchButton.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (VERSION>=7.0f) {
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
    self.searchButton.hidden = YES;

}
-(void)initViews{
    
//    self.view.backgroundColor = [UIColor colorWithWhite:230.0f/255.0f alpha:1.0];
    
    // background image
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Splash.png"]];
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    UIImageView* bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Splash.png"]];
    bgImage.frame = self.view.bounds;
    [self.view addSubview:bgImage];
    
    self.jobTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.jobTableView.delegate = self;
    self.jobTableView.dataSource = self;
    
    self.jobTableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.jobTableView];
    self.jobTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"settings-25"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftButton:)];
    leftBarButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftBarButton;

    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"border_color-25"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton:)];
    rightButton.tintColor = [UIColor blackColor];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    self.refresh = refresh;
    [refresh addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [self.jobTableView addSubview:refresh];
}

-(void)clickSearchButton
{
    SearchView *search = [[SearchView alloc]initWithFrame:CGRectMake(0,self.view.bounds.size.height , 320, self.view.bounds.size.height)];
    search.delegate = self;
    [self.view.window addSubview:search];
    [UIView animateWithDuration:0.25 animations:^{
        search.frame = self.view.bounds;
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)clickRightButton:(id)sender
{
    //[[[HttpRequest alloc]init]httpRequestForGetResume];
    JoinViewController *join = [[JoinViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:join animated:YES];
    
}
-(void)clickLeftButton:(id)sender
{
    
    SettingViewController *setVC = [[SettingViewController alloc]initWithNibName:Nil bundle:nil];
    
    [self.navigationController pushViewController:setVC animated:YES];
    
//    if (self.shareDataModel.isLogin == NO) {
//        loginViewController *loginVC = [[loginViewController alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, self.view.bounds.size.height)];
//        
//        
//        [self.view.window addSubview:loginVC];
//        
//        [UIView animateWithDuration:0.25f animations:^{
//            
//            loginVC.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
//            
//        } completion:^(BOOL finished) {
//            
//        }];
//
//    }else
//    {
//        ResumeViewController *resume = [[ResumeViewController alloc]initWithNibName:nil bundle:nil];
//        [self.navigationController pushViewController:resume animated:YES];
//    }
//    ResumeViewController *resume = [[ResumeViewController alloc]initWithNibName:nil bundle:nil];
//    [self.navigationController pushViewController:resume animated:YES];
    
}

#pragma mark - refreshData
-(void)refreshData
{
    HttpRequest *request = [[HttpRequest alloc]init];
    request.delegate = self;
    [request httpRequestForGet];
    
}
#pragma mark - HttpRequestDelegate
-(void)getDataSucess:(NSArray *)dataArray
{
    
    self.jobDataArray = dataArray;
    [self.jobTableView reloadData];
    [self.refresh endRefreshing];
}

#pragma mark - searchviewdelegate
-(void)searchDataGetSuccess:(NSArray *)arr
{
    self.jobDataArray = arr;
    [self.jobTableView reloadData];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.jobDataArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  static NSString *indexPathCell =@"cell";
    _customCell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:indexPathCell];
    if (_customCell == nil) {
        _customCell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexPathCell];
        [_customCell initViews];
        _customCell.backgroundColor = [UIColor clearColor];
        _customCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [_customCell insertData:[self.jobDataArray objectAtIndex:indexPath.row]];
    
    return _customCell;
}
#pragma mark -UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 0;
    UIFont *PCAFont = [UIFont boldSystemFontOfSize:13.0f];
    NSDictionary *dict = [self.jobDataArray objectAtIndex:indexPath.row];
    NSMutableString *PCAString = [NSMutableString stringWithFormat:@"%@ • %@ • %@",[dict objectForKey:JOB_TITLE],[dict objectForKey:JOB_COMPANY],[dict objectForKey:JOB_LOCATION]];
    CGSize size = CGSizeMake(260, 5000);
    NSString *sto= [PCAString stringByReplacingOccurrencesOfString: @"\n" withString:@""];

    height += [Tools autoSizeLab:size withFont:PCAFont withSting:sto];
    height += 50;
    
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (VERSION >=7.0) {
        return 64.0f;
    }
    return 0.0f;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    headview.backgroundColor = [UIColor clearColor];
    
    return headview;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"---%f",scrollView.contentOffset.y+scrollView.frame.size.height);
    NSLog(@"----%f",scrollView.contentSize.height);
    if (scrollView.contentOffset.y+scrollView.frame.size.height - scrollView.contentSize.height >20) {
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
