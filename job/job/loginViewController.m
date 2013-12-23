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
#import "SinaSDK.h"
#import "headSetting.h"
#import "DataModel.h"
@interface loginViewController ()<HttpRequestDelegate,UIAlertViewDelegate,TecentSDKDelegate>
@property(nonatomic, strong)UILabel *userNameLab;
@property(nonatomic, strong)UILabel *passwordLab;

@property(nonatomic, strong)UITextField *userNameTF;
@property(nonatomic, strong)UITextField *passWordTF;
@property(nonatomic, strong)UIButton *loginButton;
@property(nonatomic, strong)UIButton *registerButton;
@property(nonatomic, strong)UIButton *cancelButton;

@property(nonatomic, strong)UIButton *autoLogin;
@property(nonatomic, strong)UIButton  *sinaLogin;

@property(nonatomic ,strong)UIButton *QQLogin;

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weiboLogin:) name:@"weibologin" object:nil];

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
    [self.sinaLogin setTitle:@"新浪微博" forState:UIControlStateNormal];
    [self.sinaLogin setTitleEdgeInsets:UIEdgeInsetsMake(0, -106, 0, 0)];
    [self.sinaLogin addTarget:self action:@selector(clickSinaLogin) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sinaLogin];
    
    
    self.QQLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.QQLogin.frame = CGRectMake(90, 310, 150, 44);
    self.QQLogin.backgroundColor = [UIColor brownColor];
    [self.QQLogin setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    
    [self.QQLogin setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 106)];
    
    [self.QQLogin setTitle:@"QQ" forState:UIControlStateNormal];
    [self.QQLogin setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.QQLogin addTarget:self action:@selector(clickQQLogin) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.QQLogin];
    

}

-(void)initViews
{
    self.userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 80, 60, 34)];
    self.userNameLab.text = @"账户名";
    [self addSubview:self.userNameLab];
    self.userNameTF = [[UITextField alloc]initWithFrame:CGRectMake(90, 80, 200, 34)];
    self.userNameTF.placeholder = @"用户名/电子邮箱";
    self.userNameTF.borderStyle = UITextBorderStyleBezel;
    self.userNameTF.keyboardType = UIKeyboardTypeEmailAddress;
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
    [[[SinaSDK alloc]init]ssoButtonPressed];
    [[NSUserDefaults standardUserDefaults]setObject:WEIBOLOGIN forKey:LOGINTYPE];

}

-(void)clickQQLogin
{
    NSArray *permissions = [NSArray arrayWithObjects:@"all", nil];
    [[[TecentSDK getinstance] oauth] authorize:permissions inSafari:NO];
    [[TecentSDK getinstance]setDelegate:self];
    [[NSUserDefaults standardUserDefaults]setObject:QQLOGIN forKey:LOGINTYPE];

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
        
        [[NSUserDefaults standardUserDefaults]setObject:MYAPPLOGIN forKey:LOGINTYPE];
        [[NSUserDefaults standardUserDefaults]setObject:self.userNameTF.text forKey:@"username"];
        [[NSUserDefaults standardUserDefaults]setObject:self.passWordTF.text forKey:@"password"];
        [DataModel shareData].isLogin = YES;
        [self popView];
        
    }else
    {
        [DataModel shareData].isLogin = NO;
        UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:nil message:@"用户名或密码错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alerView.delegate = self;
        [alerView show];
    }
    
    
}
#pragma mark - TecentSDKDelegate
-(void)tencentLoginIsSuccess:(BOOL)isSuccess withDict:(NSDictionary *)userInfo
{
    
    NSDictionary *newUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:[userInfo objectForKey:@"nickname"],@"nick_name",[userInfo objectForKey:@"figureurl_qq_2"],@"head_url", nil];
    
    [DataModel shareData].isLogin = YES;
    [self popView];
    if ([self.delegate respondsToSelector:@selector(loginSuccess:)]) {
        [self.delegate loginSuccess:newUserInfo];
        
    }
}
#pragma mark -NSNotificationCenter
-(void)weiboLogin:(NSNotification*)dict
{
    NSDictionary *userinfo = [dict userInfo];
    [[NSUserDefaults standardUserDefaults]setObject:WEIBOLOGIN forKey:LOGINTYPE];
    [DataModel shareData].isLogin = YES;
    NSLog(@"%@",userinfo);
    NSString * wbUserName = [NSString stringWithFormat:@"%@",[userinfo objectForKey:@"id"]];
    NSDictionary *newUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:[userinfo objectForKey:@"avatar_hd"],@"head_url",
                                 [userinfo objectForKey:@"screen_name"],@"nick_name",
                                 
                                 nil];
    
    [[NSUserDefaults standardUserDefaults]setObject:wbUserName forKey:@"username"];
    
    [[[HttpRequest alloc]init]registerUserEmail:wbUserName withPassWard:@"1234" withType:@"weibo"];
    [self popView];
    if ([self.delegate respondsToSelector:@selector(loginSuccess:)]) {
        [self.delegate loginSuccess:newUserInfo];
        
    }
    
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
