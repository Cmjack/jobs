//
//  JoinViewController.m
//  job
//
//  Created by impressly on 13-12-10.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "JoinViewController.h"
#import "JoinCustomCell.h"
#import "headSetting.h"
#import "HttpRequest.h"
#import "loginViewController.h"
@interface JoinViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>
@property(nonatomic, strong)JoinCustomCell *customCell;
@property(nonatomic, strong)UITableView *joinTableView;
@property(nonatomic, strong)NSArray *joinDataArray;
@property(nonatomic, strong)NSArray *placeholderArray;
@property(nonatomic, strong)NSArray *messageKey;
@property(nonatomic, strong)NSString *captionString;
@end

@implementation JoinViewController

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
    self.joinTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.joinTableView.delegate = self;
    self.joinTableView.dataSource = self;
    
    [self.view addSubview:self.joinTableView];
    self.title = @"发布招聘信息";
    self.joinDataArray = @[@"log_cabine-25",@"street_view-25",@"map_marker-25"];
    self.placeholderArray = @[@"请输入公司名称",@"请输入招聘职位",@"请输入公司所在城市"];
    self.captionString = @"例如:\n岗位要求：\n1. 有一年以上iPhone系统或苹果软件开发经验\n2. 具备扎实的 Objective C、C/C++ /Cocos2d基础\n4. 熟悉iPhone下网络通信机制，对Socket通信、TCP/IP和HTTP有较深刻的理解和经验，有网络编程经验优先；";
    UIBarButtonItem *sendBarButton = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(clickSendButton:)];
    self.navigationItem.rightBarButtonItem = sendBarButton;
    
    self.messageKey = @[JOB_COMPANY,JOB_TITLE,JOB_LOCATION];
    // Do any additional setup after loading the view.
    
}

-(void)showLoginView
{
    UIWindow *keywindow = [[UIApplication sharedApplication]keyWindow];
    
    loginViewController *loginVC = [[loginViewController alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, self.view.bounds.size.height)];
    
    
    
    [keywindow addSubview:loginVC];
    
    [UIView animateWithDuration:0.25f animations:^{
        
        loginVC.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)clickSendButton:(id)sender
{
    UITextField *textfield1 = (UITextField*)[self.joinTableView viewWithTag:1000];
    UITextField *textfield2 = (UITextField*)[self.joinTableView viewWithTag:1001];
    UITextField *textfield3 = (UITextField*)[self.joinTableView viewWithTag:1002];
    UITextView  *textView   = (UITextView*) [self.joinTableView viewWithTag:1004];
    NSString *username = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    if (username.length <=0) {
        
        [textfield1 resignFirstResponder];
        [textfield2 resignFirstResponder];
        [textfield3 resignFirstResponder];
        [textView resignFirstResponder];
        
        [self showLoginView];
    }
    else
    {
        if (textView.text.length>0&&(![textView.text isEqualToString:self.captionString])&&textfield1.text.length>0&&textfield2.text.length>0&&textfield3.text.length>0&&username.length >0) {
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         textfield1.text,JOB_COMPANY,
                                         textfield2.text,JOB_TITLE,
                                         textfield3.text,JOB_LOCATION,
                                         textView.text,JOB_DESC,
                                         username,@"username",
                                         nil];
            if ([self.dictMessage objectForKey:@"_id"]!=NULL) {
                
                [dict setValue:[self.dictMessage objectForKey:JOB_ID] forKey:JOB_ID];
            }
            NSLog(@"send:%@",dict);
            
            [[[HttpRequest alloc]init]httpRequestForPostJoinMessgae:[NSDictionary dictionaryWithObjectsAndKeys:dict,@"param", nil]];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else{
            
            UIAlertView * alerview = [[UIAlertView alloc]initWithTitle:nil message:@"您输入的信息不完全请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alerview show];
            
        }

    }
    
    
   
    
    
}
#pragma mark- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==1) {
        return 1;
    }
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *indexPathCell =@"cell";
        _customCell = [tableView dequeueReusableCellWithIdentifier:indexPathCell];
        if (_customCell == nil) {
            _customCell = [[JoinCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexPathCell];
            [_customCell initViews];
            _customCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        _customCell.textfield.tag = 1000+indexPath.row;
        _customCell.textfield.delegate = self;
        _customCell.textLabel.font = [UIFont systemFontOfSize:13.0f];
        //_customCell.textLabel.text = [self.joinDataArray objectAtIndex:indexPath.row];
        _customCell.imageView.image = [UIImage imageNamed:[self.joinDataArray objectAtIndex:indexPath.row]];
        _customCell.textfield.placeholder = [self.placeholderArray objectAtIndex:indexPath.row];
        if (self.dictMessage != NULL) {
            _customCell.textfield.text = [self.dictMessage objectForKey:[self.messageKey objectAtIndex:indexPath.row]];
        }

    }else
    {
        static NSString *indexPathCell =@"celltoo";
        _customCell = [tableView dequeueReusableCellWithIdentifier:indexPathCell];
        if (_customCell == nil) {
            _customCell = [[JoinCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexPathCell];
            [_customCell initLab];
            _customCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        _customCell.iconImageView.image = [UIImage imageNamed:@"ball_point_pen-25"];
        _customCell.textView.text = self.captionString;
        
        if ([self.dictMessage objectForKey:JOB_DESC]!=NULL) {
            _customCell.textView.text = [self.dictMessage objectForKey:JOB_DESC];

        }
        _customCell.textView.tag = 1004;
        _customCell.textView.delegate = self;
    }
    
    return _customCell;
    
}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 44;
    }
    return 220;
}

#pragma mark- UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"start");
    self.joinTableView.contentOffset = CGPointMake(0, 44);
    if ([textView.text isEqualToString:self.captionString]) {
        textView.text = @"";
    }

}
#pragma mark- UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.joinTableView.contentOffset = CGPointMake(0, -64);
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
