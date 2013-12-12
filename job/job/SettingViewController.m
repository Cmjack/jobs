//
//  SettingViewController.m
//  job
//
//  Created by caiming on 13-12-11.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView *setTableview;
@property(nonatomic, strong)NSArray *array;

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)clickBarButton
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.setTableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.setTableview.delegate = self;
    self.setTableview.dataSource = self;
    self.setTableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.setTableview];
    
    UIBarButtonItem *barbutton =[[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(clickBarButton)];
    self.navigationItem.rightBarButtonItem = barbutton;
	// Do any additional setup after loading the view.
    self.array = @[@"招聘中心",@"简历中心",@"职位搜索",@"地区搜索",@"切换用户",@"关于应用"];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellString = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == NULL) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        cell.backgroundColor = [UIColor clearColor];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    }
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"border_color-25"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56.0f;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
