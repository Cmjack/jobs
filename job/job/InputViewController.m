//
//  InputViewController.m
//  job
//
//  Created by impressly on 13-12-5.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "InputViewController.h"


#define LAB_X  10.0f
#define LAB_Y  74.0f
#define LAB_WIDTH  60.0f
#define LAB_HEIGHT  30.0f
#define TF_WIDTH       180.0F
#define TF_HEIGHT  30.0F
@interface InputViewController ()<UITextFieldDelegate>
@property(nonatomic, strong)UILabel *nameLab;
@property(nonatomic, strong)UILabel *telLab;
@property(nonatomic, strong)UILabel *emailLab;
@property(nonatomic, strong)UILabel *cardLab;
@end

@implementation InputViewController

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
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = barButton;
    
    
    // Do any additional setup after loading the view.
}
-(void)initViews{
    self.nameLab  = [[UILabel alloc]initWithFrame:CGRectMake(LAB_X, LAB_Y, LAB_WIDTH, LAB_HEIGHT)];
    self.cardLab   = [[UILabel alloc]initWithFrame:CGRectMake(LAB_X, LAB_Y+40, LAB_WIDTH, LAB_HEIGHT)];
    self.emailLab = [[UILabel alloc]initWithFrame:CGRectMake(LAB_X, LAB_Y+80, LAB_WIDTH, LAB_HEIGHT)];
    self.telLab  = [[UILabel alloc]initWithFrame:CGRectMake(LAB_X, LAB_Y+120, LAB_WIDTH, LAB_HEIGHT)];
    
    self.nameLab.text  = @"姓名:";
    self.telLab.text   = @"电话:";
    self.emailLab.text = @"Email:";
    self.cardLab.text  = @"职位:";
    
    [self.view addSubview:self.nameLab];
    [self.view addSubview:self.telLab];
    [self.view addSubview:self.emailLab];
    [self.view addSubview:self.cardLab];
    
    self.nameTextField    =  [[UITextField alloc]initWithFrame:CGRectMake(LAB_X + LAB_WIDTH, LAB_Y, TF_WIDTH, TF_HEIGHT)];
    self.cardTextField     =  [[UITextField alloc]initWithFrame:CGRectMake(LAB_X + LAB_WIDTH, LAB_Y+40, TF_WIDTH, TF_HEIGHT)];
    self.emailTextField   =  [[UITextField alloc]initWithFrame:CGRectMake(LAB_X + LAB_WIDTH, LAB_Y+80, TF_WIDTH, TF_HEIGHT)];
    self.telTextField    =  [[UITextField alloc]initWithFrame:CGRectMake(LAB_X + LAB_WIDTH, LAB_Y+120, TF_WIDTH, TF_HEIGHT)];
    
    self.nameTextField.tag   = 1001;
    self.telTextField.tag    = 1002;
    self.emailTextField.tag  = 1003;
    self.cardTextField.tag   = 1004;
    
    self.nameTextField.delegate = self;
    self.telTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.cardTextField.delegate = self;
    
    self.nameTextField.borderStyle  = UITextBorderStyleBezel;
    self.telTextField.borderStyle   = UITextBorderStyleBezel;
    self.emailTextField.borderStyle = UITextBorderStyleBezel;
    self.cardTextField.borderStyle  = UITextBorderStyleBezel;
    
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.telTextField];
    [self.view addSubview:self.emailTextField];
    [self.view addSubview:self.cardTextField
     ];
    
}
#pragma mark - UITextFieldDelegate


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
