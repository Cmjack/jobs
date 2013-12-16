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
#import "JoinViewController.h"
#import "SettingViewController.h"
#import "SearchView.h"
#import "PullingRefreshTableView.h"

#define  VERSION [[[UIDevice currentDevice] systemVersion]floatValue]
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,HttpRequestDelegate,SearchViewDelegate,PullingRefreshTableViewDelegate,loginViewControllerDelegate>
@property(nonatomic,strong)PullingRefreshTableView *jobTableView;
@property(nonatomic,strong)CustomCell *customCell;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIButton *positionButton;
@property(nonatomic,strong)UIButton *areaButton;
@property(nonatomic,strong)NSMutableArray *jobDataArray;
@property(nonatomic,strong)DataModel *shareDataModel;
@property(nonatomic,strong)UIRefreshControl *refresh;
@property(nonatomic,strong)UIButton *searchButton;
@property(nonatomic,strong)NSString *searchString;
@property(nonatomic,strong)NSString *requestEndString;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];
    [self refreshData];
    self.shareDataModel = [DataModel shareData];
    self.jobDataArray = [NSMutableArray arrayWithCapacity:10];
    self.title = @"事业线";
    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(185, 30, 24, 24)];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"ball_point_pen-25"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(clickSearchButton) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:searchButton];
    self.searchButton = searchButton;
    
//
//     self.jobDataArray = self.shareDataModel.shareData;
	// Do any additional setup after loading the view, typically from a nib.
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
    
    self.view.backgroundColor = [UIColor colorWithWhite:230.0f/255.0f alpha:1.0];
    
    // background image
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Splash.png"]];
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    UIImageView* bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Splash.png"]];
    bgImage.frame = self.view.bounds;
    [self.view addSubview:bgImage];
    
    CGRect frmae;
    if (VERSION<7.0) {
        frmae = CGRectMake(0, 0, 320, self.view.bounds.size.height - 64);
    }
    else
    {
        frmae = CGRectMake(0, 64, 320, self.view.bounds.size.height - 64);
    }
    
    self.jobTableView = [[PullingRefreshTableView alloc]initWithFrame:frmae pullingDelegate:self];
    
    self.jobTableView.delegate = self;
    self.jobTableView.dataSource = self;
    self.jobTableView.backgroundColor = [UIColor clearColor];
    self.jobTableView.autoScrollToNextPage = YES;
    [self.view addSubview:self.jobTableView];
    self.jobTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"settings-25"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftButton:)];
    leftBarButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftBarButton;

    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"border_color-25"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton:)];
    rightButton.tintColor = [UIColor blackColor];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
//    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
//    self.refresh = refresh;
//    [refresh addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
//    [self.jobTableView addSubview:refresh];
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
    JoinViewController *join = [[JoinViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:join animated:YES];
    
}
-(void)clickLeftButton:(id)sender
{
    
   
    
    if (self.shareDataModel.isLogin == NO) {
        loginViewController *loginVC = [[loginViewController alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, self.view.bounds.size.height)];
        loginVC.delegate = self;
        
        [self.view.window addSubview:loginVC];
        
        [UIView animateWithDuration:0.25f animations:^{
            
            loginVC.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
            
        } completion:^(BOOL finished) {
            
        }];

    }
    else
    {
        SettingViewController *setVC = [[SettingViewController alloc]initWithNibName:Nil bundle:nil];
        
        [self.navigationController pushViewController:setVC animated:YES];
    }
}

#pragma mark - refreshData
-(void)refreshData
{
    HttpRequest *request = [[HttpRequest alloc]init];
    request.delegate = self;
    NSString *pageString = [NSString stringWithFormat:@"%i",self.jobDataArray.count/20+1];
    [request httpRequestForGetSearch:self.searchString withPage:pageString];
    
}
#pragma mark - HttpRequestDelegate
-(void)getDataSucess:(NSDictionary *)dataDict
{
    self.requestEndString = [dataDict objectForKey:@"end"];
    [self.jobDataArray addObjectsFromArray:[dataDict objectForKey:@"Data"]];
    [self performSelector:@selector(re) withObject:nil afterDelay:0.5];
    [self.jobTableView reloadData];
}

#pragma mark - searchviewdelegate
-(void)searchDataGetSuccess:(NSDictionary *)dict withSearchString:(NSString *)searchString
{
    self.requestEndString = [dict objectForKey:@"end"];
    self.searchString = searchString;
    [self.jobDataArray removeAllObjects];
    [self.jobDataArray addObjectsFromArray:[dict objectForKey:@"Data"]];
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
    _customCell.countLab.text = [NSString stringWithFormat:@"%i",indexPath.row];
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
    height += 65;
    
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - PullingRefreshTableViewDelegate
//下拉刷新回调

-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    
    //[self performSelector:@selector(re) withObject:nil afterDelay:6.5];
    
}
-(void)re
{
    [self.jobTableView tableViewDidFinishedLoading];
}

//上拉加载回调
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    if ([self.requestEndString isEqualToString:@"true"])
    {
        //[self.jobTableView tableViewDidFinishedLoadingWithMessage:@"没有了"];
        [self.jobTableView flashMessage:@"meiyou le "];
        [self performSelector:@selector(re) withObject:nil afterDelay:1.5];

    }else
    {
        [self refreshData];
    }
    

}

#pragma mark - UIScrollViewDelegate
// －－－－上拉和下拉的刷新必须重写下面的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self.jobTableView tableViewDidScroll:scrollView];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [self.jobTableView tableViewDidEndDragging:scrollView];
    
}
#pragma mark - loginViewControllerDelegate
-(void)loginSuccess:(NSDictionary *)userInfo
{
    
    [[NSUserDefaults standardUserDefaults]setObject:userInfo forKey:@"userinfo"];
    SettingViewController *setVC = [[SettingViewController alloc]initWithNibName:Nil bundle:nil];
    
    [self.navigationController pushViewController:setVC animated:YES];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
