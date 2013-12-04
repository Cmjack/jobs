//
//  PersonMessageViewController.m
//  job
//
//  Created by impressly on 13-12-4.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "PersonMessageViewController.h"
#import "PersonMessageCustomCell.h"
#import "EditDiplomaTableViewController.h"
@interface PersonMessageViewController ()<UITableViewDelegate,
                                          UITableViewDataSource,
                                          UIActionSheetDelegate,
                                          EditDiplomaTableViewControllerDelegate>
@property(nonatomic,strong)UITableView *PersonTableView;
@property(nonatomic,strong)NSArray *personArr;
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)NSMutableArray *mutableArr;
@property(nonatomic,strong)PersonMessageCustomCell *customCell;
@end

@implementation PersonMessageViewController

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
    self.title = @"个人信息";
    [self initViews];
    self.personArr = @[@"姓       名",
                       @"性       别",
                       @"最高学历",
                       @"年       龄",
                       @"手机号码",
                       @"Email",
                       @"工作年限",
                       @"证       件",
                       @"证件号码"
                       ];
    self.mutableArr = [NSMutableArray arrayWithObjects:
                        @"李某某",
                        @"男",
                        @"本科",
                        @"22",
                        @"1388888888",
                        @"xxxx@163.com",
                        @"3年以上",
                        @"身份证",
                        @"360199633567894",
                         nil];
    // Do any additional setup after loading the view.
}
-(void)initViews{
    self.PersonTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.PersonTableView.delegate = self;
    self.PersonTableView.dataSource = self;
    [self.view addSubview:self.PersonTableView];
}
#pragma mark- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.personArr count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 ||indexPath.row ==3||indexPath.row ==4 ||indexPath.row ==5||indexPath.row ==8) {
        static NSString * indexCell = @"cellTextField";
        self.customCell = [tableView dequeueReusableCellWithIdentifier:indexCell];
        if (self.customCell == nil) {
            self.customCell = [[PersonMessageCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexCell];
            [self.customCell initViewsForTextField];
            self.customCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        self.customCell.textLabel.text = [self.personArr objectAtIndex:indexPath.row];
        self.customCell.textField.text = [self.mutableArr objectAtIndex:indexPath.row];
        self.customCell.textField.tag = 1000+indexPath.row;
        return self.customCell;
        
    }else{
        
        static NSString * indexCell = @"cellLab";
        self.customCell = [tableView dequeueReusableCellWithIdentifier:indexCell];
        if (self.customCell == nil) {
            self.customCell = [[PersonMessageCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexCell];
            [self.customCell initViewsForLable];
            [self.customCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        self.customCell.label.text = [self.mutableArr objectAtIndex:indexPath.row];
        self.customCell.textLabel.text = [self.personArr objectAtIndex:indexPath.row];
        return self.customCell;
    
    }
    
    return NULL;
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
        
        [actionSheet setActionSheetStyle:UIActionSheetStyleAutomatic];
        [actionSheet showInView:self.view];
    }
    else if (indexPath.row == 2)
    {
        EditDiplomaTableViewController *editDiploma = [[EditDiplomaTableViewController alloc]initWithNibName:nil bundle:nil];
        editDiploma.delegate = self;
        [self.navigationController pushViewController:editDiploma animated:YES];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.mutableArr replaceObjectAtIndex:1 withObject:@"男"];

    }else if(buttonIndex ==1){
        [self.mutableArr replaceObjectAtIndex:1 withObject:@"女"];
        
    }
    [self.PersonTableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- EditDiplomaTableViewControllerDelegate
-(void)EditDiplomaTableViewController:(NSString *)string
{
    [self.navigationController popViewControllerAnimated:YES];

    [self.mutableArr replaceObjectAtIndex:2 withObject:string];
    NSLog(@"%@",string);
    
    [self.PersonTableView reloadData];
    NSLog(@"%@",_mutableArr);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
