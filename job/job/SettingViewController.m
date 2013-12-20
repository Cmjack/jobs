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
#import "ResumeViewController.h"
#import "AboutViewController.h"
#import "LoginHelp.h"
#import "Tools.h"
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
    self.title = @"个人中心";
    
	// Do any additional setup after loading the view.
    self.array = @[@"已发招聘信息",@"已收简历信息",@"已申请职位信息",@"个人简历信息",@"切换用户",@"关于应用"];
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
        _customCell.userNameLab.text = [self.userInfo objectForKey:@"nick_name"];
        
        _customCell.headImageView.image = [Tools imageLoading];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 0) {
        JionMessageViewController *join = [[JionMessageViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:join animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 3){
        ResumeViewController *resume = [[ResumeViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:resume animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 5)
    {
        AboutViewController *about = [[AboutViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:about animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 4)
    {
        if ([self.delegate respondsToSelector:@selector(cancelUser)]) {
            
            [LoginHelp removeUserInfo];
            [self.navigationController popViewControllerAnimated:NO];
            [self.delegate cancelUser];
            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
