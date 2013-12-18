//
//  EditWorkViewController.m
//  job
//
//  Created by impressly on 13-12-9.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "EditWorkViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "headSetting.h"
@interface EditWorkViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic ,strong)UILabel *companyLab;
@property(nonatomic ,strong)UITextField *companyTextField;
@property(nonatomic ,strong)UILabel *positionLab;
@property(nonatomic ,strong)UITextField *positionTextfield;
@property(nonatomic ,strong)UIScrollView *editWorkscrollView;
@property(nonatomic ,strong)UILabel *startTimeLab;
@property(nonatomic ,strong)UITextField *startTimeTF;
@property(nonatomic ,strong)UILabel *endTimeLab;
@property(nonatomic ,strong)UITextField *endTimeTF;

@property(nonatomic ,strong)UILabel *captionLab;
@property(nonatomic ,strong)UITextView *captionTextView;
@property(nonatomic ,strong)UIButton *upButton;
@property(nonatomic ,strong)UIButton *downButton;
@property(nonatomic, assign)NSInteger selectTag;

@property(nonatomic ,assign)BOOL isAdd;
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
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarButton)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
//    UIImageView *background = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    background.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:background];
    
    // Do any additional setup after loading the view.
}
-(void)clickRightBarButton
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.companyTextField.text,KEY_COMPANY,self.positionTextfield.text,KEY_POSITION,self.startTimeTF.text,KEY_START_DATE,self.endTimeTF.text,KEY_END_DATE,self.captionTextView.text,KEY_CAPTION, nil];
    
    if ([self.delegate respondsToSelector:@selector(EditWorkViewControllerAddOrAmend:withData:)]) {
        [self.delegate EditWorkViewControllerAddOrAmend:self.isAdd withData:dict];
    }
}
-(void)initViews{
    
    self.editWorkscrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.editWorkscrollView];
    
    float height = 10.0f;
    
    self.companyLab = [[UILabel alloc]initWithFrame:CGRectMake(10, height, 80, 20)];
    
    [self.editWorkscrollView addSubview:self.companyLab];
    
    self.companyTextField = [[UITextField alloc]initWithFrame:CGRectMake(90, height, 210, 20)];
    self.companyTextField.borderStyle = UITextBorderStyleBezel;
    self.companyTextField.placeholder = @"请输入...";
    self.companyTextField.tag = 1001;
    self.companyTextField.delegate = self;
    [self.editWorkscrollView addSubview:self.companyTextField];
    
    self.positionLab = [[UILabel alloc]initWithFrame:CGRectMake(10, height+25, 80, 20)];
    [self.editWorkscrollView addSubview:self.positionLab];
    
    self.positionTextfield = [[UITextField alloc]initWithFrame:CGRectMake(90, height+25, 210, 20)];
    self.positionTextfield.borderStyle = UITextBorderStyleBezel;
    self.positionTextfield.placeholder = @"请输入...";
    self.positionTextfield.tag = 1002;
    self.positionTextfield.delegate =self;
    [self.editWorkscrollView addSubview:self.positionTextfield];
    
    self.startTimeLab = [[UILabel  alloc]initWithFrame:CGRectMake(10, height+50, 80, 20)];
    [self.editWorkscrollView addSubview:self.startTimeLab];
    
    self.startTimeTF = [[UITextField  alloc]initWithFrame:CGRectMake(90, height+50, 80, 20)];
    self.startTimeTF.text = @"1999-11";
    self.startTimeTF.tag = 1003;
    self.startTimeTF.delegate = self;
    [self.editWorkscrollView addSubview:self.startTimeTF];
    
    self.endTimeLab = [[UILabel  alloc]initWithFrame:CGRectMake(160, height+50, 80, 20)];
    [self.editWorkscrollView addSubview:self.endTimeLab];
    
    self.endTimeTF = [[UITextField  alloc]initWithFrame:CGRectMake(240, height+50, 80, 20)];
    self.endTimeTF.text = @"2012-11";
    self.endTimeTF.tag = 1004;

    self.endTimeTF.delegate = self;
    [self.editWorkscrollView addSubview:self.endTimeTF];
    
    
    UIDatePicker * date = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 320, 216)];
    date.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"datepicker_bg"]];
    date.datePickerMode = UIDatePickerModeDate;
    [date addTarget:self action:@selector(datePickerValueChange:) forControlEvents:UIControlEventValueChanged];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.backgroundColor = [UIColor yellowColor];
    
    UIButton *upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *donebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    upButton.tag = 101;
    downButton.tag = 102;
    self.upButton = upButton;
    self.downButton = downButton;
    [upButton addTarget:self action:@selector(clickUpAndDownButton:) forControlEvents:UIControlEventTouchUpInside];
    [downButton addTarget:self action:@selector(clickUpAndDownButton:) forControlEvents:UIControlEventTouchUpInside];
    [donebutton addTarget:self action:@selector(clickDoneButton:) forControlEvents:UIControlEventTouchUpInside];

    upButton.frame=CGRectMake(10, 6, 55, 32);
    downButton.frame=CGRectMake(65, 6, 55, 32);
    donebutton.frame=CGRectMake(255, 6, 56, 32);
    
    [upButton setImage:[UIImage imageNamed:@"previous"] forState:UIControlStateNormal];
    [downButton setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    [donebutton setImage:[UIImage imageNamed:@"home_finished"] forState:UIControlStateNormal];
    
    [upButton setBackgroundImage:[UIImage imageNamed:@"previous_bg"] forState:UIControlStateNormal];
    [downButton setBackgroundImage:[UIImage imageNamed:@"next_bg"] forState:UIControlStateNormal];
    [donebutton setBackgroundImage:[UIImage imageNamed:@"home_navigationbutton_normal"] forState:UIControlStateNormal];
    
    
    [toolBar addSubview:upButton];
    [toolBar addSubview:downButton];
    [toolBar addSubview:donebutton];
    
    self.positionTextfield.inputAccessoryView = toolBar;
    self.companyTextField.inputAccessoryView = toolBar;
    
    self.startTimeTF.inputView = date;
    self.startTimeTF.inputAccessoryView = toolBar;
    self.endTimeTF.inputView = date;
    self.endTimeTF.inputAccessoryView = toolBar;
    
    
    self.captionLab = [[UILabel alloc]initWithFrame:CGRectMake(10, height+75, 80, 20)];
    
    [self.editWorkscrollView addSubview:self.captionLab];
    
    self.captionTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, height+100, 300, 100)];
    self.captionTextView.inputAccessoryView = toolBar;
    self.captionTextView.delegate = self;
    self.captionTextView.layer.borderWidth = 1.0f;
    self.captionTextView.tag = 1005;

    [self.editWorkscrollView addSubview:self.captionTextView];
    
    [self insertLablesText:self.lablesTextArray];
    if (self.textsDict !=NULL) {
        self.isAdd = YES;
        [self insertTextFields:self.textsDict];
    }
    
    
}
-(void)insertLablesText:(NSArray*)array
{
    self.companyLab.text = [array objectAtIndex:0];
    self.positionLab.text = [array objectAtIndex:1];
    self.startTimeLab.text = [array objectAtIndex:2];
    self.endTimeLab.text = [array objectAtIndex:3];
    self.captionLab.text = [array objectAtIndex:4];
}
-(void)insertTextFields:(NSDictionary*)dict
{
    self.companyTextField.text = [dict objectForKey:KEY_COMPANY];
    self.positionTextfield.text = [dict objectForKey:KEY_POSITION];
    self.startTimeTF.text = [[dict objectForKey:KEY_START_DATE]substringToIndex:7];
    self.endTimeTF.text = [[dict objectForKey:KEY_END_DATE]substringToIndex:7];
    self.captionTextView.text = [dict objectForKey:KEY_CAPTION];

}
-(void)clickUpAndDownButton:(UIButton*)sender
{
    if (sender.tag ==101) {
        
        self.selectTag -=1;
        
    }else if (sender.tag == 102)
    {
        self.selectTag +=1;
    }
    self.upButton.enabled = YES;
    self.downButton.enabled = YES;
    if (self.selectTag>=1005) {
        self.selectTag = 1005;
        self.downButton.enabled = NO;
        [self.captionTextView becomeFirstResponder];
        [self animation:CGPointMake(0, 44)];
    }else if (self.selectTag >1001)
    {
        UITextField *textfield = (UITextField*)[self.editWorkscrollView viewWithTag:self.selectTag];
        [textfield becomeFirstResponder];
        [self animation:CGPointMake(0, -64)];
    }
    else
    {
        [self animation:CGPointMake(0, -64)];
        self.selectTag =1001;
        self.upButton.enabled = NO;
        [self.companyTextField becomeFirstResponder];
    }
    
}
-(void)clickDoneButton:(id)sender
{
    [self animation:CGPointMake(0, -64)];
    [self.companyTextField resignFirstResponder];
    [self.positionTextfield resignFirstResponder];
    [self.startTimeTF resignFirstResponder];
    [self.endTimeTF resignFirstResponder];
    [self.captionTextView resignFirstResponder];
    
}
-(void)animation:(CGPoint)point
{
    [UIView animateWithDuration:0.25 animations:^{
    self.editWorkscrollView.contentOffset = point;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)datePickerValueChange:(UIDatePicker*)sender
{
    NSLog(@"%@",sender.date);
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM";
    NSString *string = [fmt stringFromDate:sender.date];
    if (self.selectTag ==1003) {
        self.startTimeTF.text = string;
    }else if (self.selectTag == 1004)
    {
        self.endTimeTF.text = string;
    }
    
    
}
#pragma mark --- UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self didSelect:textField.tag];
    [self animation:CGPointMake(0, -64)];
}
#pragma mark --- UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self didSelect:textView.tag];
    [self animation:CGPointMake(0, 44)];
}
-(void)didSelect:(int)tag
{
    self.selectTag = tag;
    self.upButton.enabled = YES;
    self.downButton.enabled =YES;
    if (self.selectTag == 1001) {
        self.upButton.enabled = NO;
    }else if (self.selectTag == 1005){
        self.downButton.enabled =NO;

    }
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
