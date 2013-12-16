//
//  SettingViewController.m
//  job
//
//  Created by caiming on 13-12-11.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCustomCell.h"
#import "HttpRequest.h"
#import "JionMessageViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView *setTableview;
@property(nonatomic, strong)NSArray *array;
@property(nonatomic, strong)SettingCustomCell *customCell;
@property(nonatomic, strong)NSDictionary *userInfo;

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
    self.array = @[@"招聘中心",@"简历中心",@"切换用户",@"关于应用"];
    self.userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userinfo"];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    
    return [self.array count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0) {
        static  NSString *cellString = @"CustomCell";
        _customCell = [tableView dequeueReusableCellWithIdentifier:cellString];
        if (_customCell == nil) {
            _customCell = [[SettingCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
            
        }
        _customCell.userNameLab.text = [self.userInfo objectForKey:@"nickname"];
        return _customCell;
        
    }else
    {
        static  NSString *cellString = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
        if (cell == NULL) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
            cell.backgroundColor = [UIColor clearColor];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
        }
        cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
        return cell;
    }
    
    return NULL;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    return 56.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        JionMessageViewController *join = [[JionMessageViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:join animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
