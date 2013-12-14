//
//  loginViewController.m
//  job
//
//  Created by impressly on 13-12-5.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "loginViewController.h"
#import "HttpRequest.h"
#import "registerView.h"
#import "DataModel.h"
#import "TecentSDK.h"
@interface loginViewController ()<HttpRequestDelegate,UIAlertViewDelegate>
@property(nonatomic, strong)UILabel *userNameLab;
@property(nonatomic, strong)UILabel *passwordLab;

@property(nonatomic, strong)UITextField *userNameTF;
@property(nonatomic, strong)UITextField *passWordTF;
@property(nonatomic, strong)UIButton *loginButton;
@property(nonatomic, strong)UIButton *registerButton;
@property(nonatomic, strong)UIButton *cancelButton;

@property(nonatomic, strong)UIButton *autoLogin;
@property(nonatomic,strong)UIButton  *sinaLogin;

@end

@implementation loginViewController


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    [self loadView];
    return self;
}
- (void)loadView
{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self initViews];
    
    self.autoLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.autoLogin.frame = CGRectMake(90, 173, 18, 18);
    self.autoLogin.layer.borderWidth = 1.0;
    self.autoLogin.layer.cornerRadius = 4.0f;
    self.autoLogin.layer.borderColor = [[UIColor grayColor]CGColor];
    [self addSubview:self.autoLogin];
    
    // Do any additional setup after loading the view.
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //float y= self.bounds.size.height*1/3;
    self.loginButton.frame = CGRectMake(90, 200, 75, 44);
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    self.loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton  setBackgroundColor:[UIColor brownColor]];
    [self.loginButton  addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.loginButton];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.frame = CGRectMake(175, 210, 60, 34);
    [self.registerButton setTitle:@"免费注册" forState:UIControlStateNormal];
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[self.registerButton  setBackgroundColor:[UIColor brownColor]];
    [self.registerButton addTarget:self action:@selector(clickRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.registerButton];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(270, 25, 32, 32);
    [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"btn_close_normal"] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
    
    self.sinaLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sinaLogin.frame = CGRectMake(90, 260, 150, 44);
    self.sinaLogin.backgroundColor = [UIColor brownColor];
    [self.sinaLogin setImage:[UIImage imageNamed:@"login_logo"] forState:UIControlStateNormal];
    [self.sinaLogin setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 106)];
    [self.sinaLogin setTitle:@"微博账号" forState:UIControlStateNormal];
    [self.sinaLogin setTitleEdgeInsets:UIEdgeInsetsMake(0, -106, 0, 0)];
    [self.sinaLogin addTarget:self action:@selector(clickSinaLogin) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sinaLogin];
    

}

-(void)initViews
{
    self.userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 80, 60, 34)];
    self.userNameLab.text = @"账户名";
    [self addSubview:self.userNameLab];
    self.userNameTF = [[UITextField alloc]initWithFrame:CGRectMake(90, 80, 200, 34)];
    self.userNameTF.placeholder = @"用户名/电子邮箱";
    self.userNameTF.borderStyle = UITextBorderStyleBezel;
    [self addSubview:self.userNameTF];
    
    self.userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 130, 60, 34)];
    self.userNameLab.text = @"密码";
    [self addSubview:self.userNameLab];
    
    self.passWordTF = [[UITextField alloc]initWithFrame:CGRectMake(90, 130, 200, 34)];
    self.passWordTF.placeholder = @"请输入密码";
    [self.passWordTF setSecureTextEntry:YES];
    self.passWordTF.borderStyle = UITextBorderStyleBezel;
    [self addSubview:self.passWordTF];
    
}
-(void)clickLogin
{

    if ((self.passWordTF.text.length < 1 )|| (self.userNameTF.text.length <1)) {
        
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:@"请输入用户名和密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
        
    }else {
        
        HttpRequest *http = [[HttpRequest alloc]init];
        http.delegate = self;
        [http loginUserName:self.userNameTF.text withSalt:self.passWordTF.text];
        self.loginButton.enabled = NO;
        self.registerButton.enabled = NO;

    }
    
    
}
-(void)clickSinaLogin
{
//    [[[HttpRequest alloc]init]ssoButtonPressed];
    
    NSArray *permissions = [NSArray arrayWithObjects:@"all", nil];
    [[[TecentSDK getinstance] oauth] authorize:permissions inSafari:NO];
    
//    TencentOAuth *tencentOAuth = [[TencentOAuth alloc]initWithAppId:@"100576079" andDelegate:self];
//    
//    NSArray * permissions = [NSArray arrayWithObjects:@"get_user_info", @"add_t", nil];
//    [tencentOAuth authorize:permissions inSafari:YES];

}
-(void)clickRegister:(id)sender
{
    registerView *view = [[registerView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height, 320, self.bounds.size.height)];
    [self.window addSubview:view];
    [UIView animateWithDuration:0.25f animations:^{
        
        view.frame = CGRectMake(0, 0, 320, self.bounds.size.height);
        self.frame = CGRectMake(0, 0-self.bounds.size.height, 320, self.bounds.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
- (void)didReceiveMemoryWarning
{
    
    // Dispose of any resources that can be recreated.
}
-(void)clickCancelButton
{
    [self popView];
}

-(void)popView
{
    [self.userNameTF resignFirstResponder];
    [self.passWordTF resignFirstResponder];
    [UIView animateWithDuration:0.25f animations:^{
        
    
        self.frame = CGRectMake(0, self.bounds.size.height, 320, self.bounds.size.height);
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

#pragma mark - httpdelegate
-(void)loginSucessOrFail:(BOOL)isSucess
{
    
    self.loginButton.enabled = YES;
    self.registerButton.enabled = YES;
    if (isSucess) {
        
        [[NSUserDefaults standardUserDefaults]setObject:self.userNameTF.text forKey:@"username"];
        [[NSUserDefaults standardUserDefaults]setObject:self.passWordTF.text forKey:@"password"];
        
        [self popView];
        
    }else
    {
        
        UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:nil message:@"用户名或密码错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alerView.delegate = self;
        [alerView show];
    }
    
    
}
//-(void)tencentDidLogin
//{
//    
//}
//-(void)tencentDidLogout
//{
//    
//}
//-(void)tencentDidNotNetWork
//{
//    
//}
//-(void)tencentDidNotLogin:(BOOL)cancelled
//{
//    
//}
//- (void)getUserInfoResponse:(APIResponse*) response
//{
//    NSLog(@"%@",response);
//}
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
