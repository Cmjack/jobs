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
#import "headSetting.h"
#import "DataModel.h"
#import "ApplyJobsViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, strong)UITableView *setTableview;
@property(nonatomic, strong)NSArray *array;
@property(nonatomic, strong)SettingCustomCell *customCell;
@property(nonatomic, strong)NSDictionary *userInfo;
@property(nonatomic, strong)NSString *loginType;
@property(nonatomic, strong)UIImage *headImage;

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
-(void)clickHeadButton:(id)sender
{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.setTableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.setTableview.delegate = self;
    self.setTableview.dataSource = self;
    self.setTableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.setTableview];
    self.title = @"个人中心";
    
	// Do any additional setup after loading the view.
    self.array = @[@[@"账户资料"],@[@"已发招聘信息",],@[@"已申请职位",@"简历中心"],@[@"注销",@"关于"]];
    self.userInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"userinfo"];
    self.loginType = [[NSUserDefaults standardUserDefaults]objectForKey:LOGINTYPE];
    self.headImage = [Tools imageLoading];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    
    return [[self.array objectAtIndex:section]count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0) {
        static  NSString *cellString = @"CustomCell";
        _customCell = [tableView dequeueReusableCellWithIdentifier:cellString];
        if (_customCell == nil) {
            _customCell = [[SettingCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
            _customCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if ([self.loginType isEqualToString:MYAPPLOGIN]) {
            _customCell.userNameLab.text = [[NSUserDefaults standardUserDefaults]objectForKey:USERNAME];
            
        }else
        {
            _customCell.userNameLab.text = [self.userInfo objectForKey:@"nick_name"];
            
           [_customCell.headImageView setBackgroundImage:self.headImage forState:UIControlStateNormal];
        }
        [_customCell.headImageView addTarget:self action:@selector(clickHeadButton:) forControlEvents:UIControlEventTouchUpInside];
        
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
        cell.textLabel.text = [[self.array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
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
    }else if (indexPath.section == 2 && indexPath.row ==1){
        ResumeViewController *resume = [[ResumeViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:resume animated:YES];
    }else if (indexPath.section == 3 && indexPath.row == 1)
    {
        AboutViewController *about = [[AboutViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:about animated:YES];
    }else if (indexPath.section == 3 && indexPath.row == 0)
    {
        if ([self.delegate respondsToSelector:@selector(cancelUser)]) {
            
            [LoginHelp removeUserInfo];
            [self.navigationController popViewControllerAnimated:NO];
            [self.delegate cancelUser];
            
        }
    }else if (indexPath.section == 2 && indexPath.row == 0)
    {
        NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
        NSString *resumeId= [[DataModel shareData].resumeDict objectForKey:@"_id"];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"user_id",resumeId,@"resume_id", nil];
        ApplyJobsViewController *apply = [[ApplyJobsViewController alloc]initWithNibName:Nil bundle:Nil];
        apply.dict =dict;
        [self.navigationController pushViewController:apply animated:YES];
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"账户资料";
        
    }else if (section == 1)
    {
        return @"招聘中心";
    }else if (section == 2)
    {
        return @"求职中心";
    }else
    {
        return @"应用信息";
    }
}
#pragma mark UIImagePickerControllerDelegate methods
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //加载图片
    //选择框消失
    self.headImage =image;
    [self.setTableview reloadData];
    [[[HttpRequest alloc]init]httpPostFile:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
