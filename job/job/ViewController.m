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
#define  VERSION [[[UIDevice currentDevice] systemVersion]floatValue]
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,HttpRequestDelegate>
@property(nonatomic,strong)UITableView *jobTableView;
@property(nonatomic,strong)CustomCell *customCell;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIButton *positionButton;
@property(nonatomic,strong)UIButton *areaButton;
@property(nonatomic,strong)NSArray *jobDataArray;
@property(nonatomic,strong)DataModel *shareDataModel;
@property(nonatomic,strong)UIRefreshControl *refresh;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];
    [self CreatHeaderView];
    [self refreshData];
    self.shareDataModel = [DataModel shareData];
    

//
//     self.jobDataArray = self.shareDataModel.shareData;
	// Do any additional setup after loading the view, typically from a nib.
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

-(void)CreatHeaderView{
    
    self.headImageView= [[UIImageView alloc]initWithFrame:CGRectMake(4, 0, 312, 30)];
    _headImageView.backgroundColor = [UIColor whiteColor];
    
    UIFont * font = [UIFont systemFontOfSize:15];
    self.positionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _positionButton.frame = CGRectMake(16, 5, 100, 20);
    _positionButton.titleLabel.font = font;
    [_positionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_positionButton setTitle:@"职位" forState:UIControlStateNormal];
    _positionButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    //_positionButton.backgroundColor = [UIColor redColor];
    [self.headImageView addSubview:_positionButton];
    
    self.areaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _areaButton.frame = CGRectMake(240, 5, 60, 20);
    _areaButton.titleLabel.font = font;
    [_areaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_areaButton setTitle:@"地区" forState:UIControlStateNormal];
    _areaButton.titleLabel.textAlignment = NSTextAlignmentRight;
    //_areaButton.backgroundColor = [UIColor redColor];

    [self.headImageView addSubview:_areaButton];
}

-(void)clickRightButton:(id)sender
{
    //[[[HttpRequest alloc]init]httpRequestForGetResume];
    JoinViewController *join = [[JoinViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:join animated:YES];
    
}
-(void)clickLeftButton:(id)sender
{
    
    if (self.shareDataModel.isLogin == NO) {
        loginViewController *loginVC = [[loginViewController alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, self.view.bounds.size.height)];
        
        
        [self.view.window addSubview:loginVC];
        
        [UIView animateWithDuration:0.25f animations:^{
            
            loginVC.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
            
        } completion:^(BOOL finished) {
            
        }];

    }else
    {
        ResumeViewController *resume = [[ResumeViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:resume animated:YES];
    }
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
    float height = 30;
    UIFont *PCAFont = [UIFont boldSystemFontOfSize:13.0f];
    UIFont *capFont = [UIFont systemFontOfSize:13];
    NSDictionary *dict = [self.jobDataArray objectAtIndex:indexPath.row];
    NSMutableString *PCAString = [NSMutableString stringWithFormat:@"%@ • %@ • %@",[dict objectForKey:JOB_TITLE],[dict objectForKey:JOB_COMPANY],[dict objectForKey:JOB_LOCATION]];
    CGSize size = CGSizeMake(260, 5000);
    
    height += [Tools autoSizeLab:size withFont:PCAFont withSting:PCAString];
    height += [Tools autoSizeLab:size withFont:capFont withSting:[dict objectForKey:JOB_DESC]];
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
