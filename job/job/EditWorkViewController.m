//
//  EditWorkViewController.m
//  job
//
//  Created by impressly on 13-12-9.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "EditWorkViewController.h"

@interface EditWorkViewController ()
@property(nonatomic ,strong)UILabel *companyLab;
@property(nonatomic ,strong)UITextField *companyTextField;
@property(nonatomic ,strong)UILabel *positionLab;
@property(nonatomic ,strong)UITextField *positionTextfield;
@property(nonatomic ,strong)UIScrollView *editWorkscrollView;
@property(nonatomic ,strong)UILabel *startTimeLab;
@property(nonatomic ,strong)UITextField *startTimeTF;
@property(nonatomic ,strong)UILabel *endTimeLab;
@property(nonatomic ,strong)UITextField *endTimeTF;
@end

@implementation EditWorkViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    [self initViews];
    // Do any additional setup after loading the view.
}
-(void)initViews{
    
    self.editWorkscrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.editWorkscrollView];
    
    float height = 10.0f;
    
    self.companyLab = [[UILabel alloc]initWithFrame:CGRectMake(10, height, 80, 20)];
    self.companyLab.text = @"公司名称:";
    [self.editWorkscrollView addSubview:self.companyLab];
    
    self.companyTextField = [[UITextField alloc]initWithFrame:CGRectMake(90, height, 210, 20)];
    self.companyTextField.borderStyle = UITextBorderStyleBezel;
    self.companyTextField.placeholder = @"请输入公司名称";
    [self.editWorkscrollView addSubview:self.companyTextField];
    
    self.positionLab = [[UILabel alloc]initWithFrame:CGRectMake(10, height+25, 80, 20)];
    self.positionLab.text = @"当前职位:";
    [self.editWorkscrollView addSubview:self.positionLab];
    
    self.positionTextfield = [[UITextField alloc]initWithFrame:CGRectMake(90, height+25, 210, 20)];
    self.positionTextfield.borderStyle = UITextBorderStyleBezel;
    self.positionTextfield.placeholder = @"请输入职位名称";
    [self.editWorkscrollView addSubview:self.positionTextfield];
    
    self.startTimeLab = [[UILabel  alloc]initWithFrame:CGRectMake(10, height+50, 80, 20)];
    self.startTimeLab.text = @"开始时间:";
    [self.editWorkscrollView addSubview:self.startTimeLab];
    
    self.startTimeTF = [[UITextField  alloc]initWithFrame:CGRectMake(90, height+50, 80, 20)];
    self.startTimeTF.text = @"开始时间:";
    [self.editWorkscrollView addSubview:self.startTimeTF];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
