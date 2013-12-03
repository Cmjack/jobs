//
//  ViewController.m
//  job
//
//  Created by impressly on 13-12-3.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *jobTableView;
@property(nonatomic,strong)CustomCell *customCell;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIButton *positionButton;
@property(nonatomic,strong)UIButton *areaButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];
    [self CreatHeaderView];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)initViews{
    
    self.view.backgroundColor = [UIColor colorWithWhite:230.0f/255.0f alpha:1.0];
    self.jobTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.jobTableView.delegate = self;
    self.jobTableView.dataSource = self;
    self.jobTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.jobTableView];
    self.jobTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(20, 5, 60, 30);
    [leftButton setTitle:@"简历" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc]initWithTitle:@"投递" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    NSLog(@"%@",leftBarButton);
    self.navigationItem.rightBarButtonItem = rightButton;
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
    
}
-(void)clickLeftButton:(id)sender
{
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
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
    [_customCell insertData:nil];
    return _customCell;
}
#pragma mark -UITableViewDelegate
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    headview.backgroundColor = [UIColor clearColor];
    [headview addSubview:_headImageView];
    return headview;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
