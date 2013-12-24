//
//  JIViewController.m
//  job
//
//  Created by caiming on 13-12-18.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "JIViewController.h"
#import "headSetting.h"
#import "EditJITBC.h"
#import "JIInputView.h"
#import "DataModel.h"
#import "JIViewCell.h"
#import "HttpRequest.h"
@interface JIViewController ()<UITableViewDataSource,UITableViewDelegate,EditJITBCDelegate,JIInputViewDelegate>
@property(nonatomic,strong)UITableView *myTableview;
@property(nonatomic,strong)NSArray *myArray;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)NSMutableDictionary *mutableDict;
@property(nonatomic,strong)NSArray *key;
@property(nonatomic,assign)NSInteger selectRow;
@end

@implementation JIViewController

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
    self.mutableDict = [NSMutableDictionary dictionaryWithDictionary:[[DataModel shareData].resumeDict objectForKey:KEY_CO]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myTableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.myTableview.delegate = self;
    self.myTableview.dataSource = self;
    [self.view addSubview:self.myTableview];
    
    self.myArray = @[@"职位",@"期望薪水",@"到岗时间",@"自我介绍"];
    self.arr = @[
                @[@"iOS开发工程师",@"android开发工程师",@"JAVA开发工程师",@"PHP开发工程师",@"C++开发工程师",@"Web开发工程师",@"软件开发工程师"],
                @[@"面议",@"4000-4999",@"5000-5999",@"6000-7999",@"8000-9999",@"10000-14999",@"15000-19999",@"20000以上"],
                @[@"即时",@"一周以内",@"一个月以内",@"待定"],
                
                ];
    
    self.key = @[KEY_POSITION,KEY_SALARY,KEY_START_DATE,KEY_CAPTION];
    
    UIBarButtonItem *barButton= [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarButton)];
    self.navigationItem.rightBarButtonItem = barButton;
}
-(void)clickRightBarButton
{
    
    NSString *userName = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    
    NSDictionary *dictresume = [NSDictionary dictionaryWithObjectsAndKeys:self.mutableDict,KEY_CO,userName,@"username", nil];
    
    [[DataModel shareData].resumeDict setObject:self.mutableDict forKey:KEY_CO];

    [HttpRequest httpRequestForSaveResume:dictresume];
    
    
    [self.navigationController popViewControllerAnimated:YES];

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indexCell = @"cell";
    JIViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indexCell];
    if (cell == NULL) {
        cell = [[JIViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell initViews];
    }
    cell.titleLab.text = [self.myArray objectAtIndex:indexPath.row];
    cell.textLab.text = [self.mutableDict objectForKey:[self.key objectAtIndex:indexPath.row]];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectRow = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3) {
        JIInputView *input = [[JIInputView alloc]initWithNibName:nil bundle:nil];
        input.degate = self;
        input.textViewString = [self.mutableDict objectForKey:KEY_CAPTION];
        [self.navigationController pushViewController:input animated:YES];
    }
    else
    {
        EditJITBC *edit = [[EditJITBC alloc]initWithNibName:nil bundle:nil];
        edit.myArray = [self.arr objectAtIndex:indexPath.row];
        edit.delegate = self;
        [self.navigationController pushViewController:edit animated:YES];

    }
}
-(void)retuanChoose:(NSString *)str
{
    
    [self.mutableDict setObject:str forKey:[self.key objectAtIndex:self.selectRow]];
    [self.myTableview reloadData];
}
-(void)retuanSelfCaption:(NSString *)str
{
    [self.mutableDict setObject:str forKey:KEY_CAPTION];
    
    [self.myTableview reloadData];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
