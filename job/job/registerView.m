//
//  regiterView.m
//  job
//
//  Created by impressly on 13-12-6.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "registerView.h"
#import "HttpRequest.h"
#define HEIGHT 60
@interface registerView ()<HttpRequestDelegate,UIAlertViewDelegate>
@property(nonatomic, strong)UITextField *emailTF;
@property(nonatomic, strong)UITextField *passWordTF;
@property(nonatomic, strong)UITextField *confirmTF;
@property(nonatomic, strong)UIButton *registerButton;
@property(nonatomic, strong)UIButton *cancelButton;
@end


@implementation registerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    [self inintViews];
    return self;
}

-(void)inintViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.emailTF = [[UITextField alloc]initWithFrame:CGRectMake(60, HEIGHT, 200, 44)];
    self.emailTF.placeholder = @"请输入email";
    self.emailTF.borderStyle = UITextBorderStyleBezel;
    [self addSubview:self.emailTF];
    
    self.passWordTF = [[UITextField alloc]initWithFrame:CGRectMake(60, HEIGHT+50, 200, 44)];
    self.passWordTF.placeholder = @"请输入密码";
    [self.passWordTF setSecureTextEntry:YES];
    self.passWordTF.borderStyle = UITextBorderStyleBezel;
    [self addSubview:self.passWordTF];
    
    self.confirmTF = [[UITextField alloc]initWithFrame:CGRectMake(60, HEIGHT+100, 200, 44)];
    self.confirmTF.placeholder = @"请确认密码";
    [self.confirmTF setSecureTextEntry:YES];
    self.confirmTF.borderStyle = UITextBorderStyleBezel;
    [self addSubview:self.confirmTF];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.frame = CGRectMake(60, HEIGHT+150, 200, 44);
    [self.registerButton setBackgroundColor:[UIColor brownColor]];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.registerButton addTarget:self action:@selector(clickSignButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.registerButton];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(250, 45, 32, 32);
    [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"btn_close_normal"] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
    

}
-(void)clickSignButton
{
    if (self.emailTF.text.length >0 && self.passWordTF.text >0 && self.confirmTF.text >0  ) {
        
        if ([self.passWordTF.text isEqualToString:self.confirmTF.text]) {
            
            HttpRequest *request = [[HttpRequest alloc]init];
            [request registerUserEmail:self.emailTF.text withPassWard:self.passWordTF.text];
            request.delegate = self;
            self.registerButton.enabled = NO;
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"两次输入的密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
    
}

-(void)clickCancelButton{
    
    [self popView];
    
}
-(void)popView
{
    [self.emailTF resignFirstResponder];
    [self.passWordTF resignFirstResponder];
    [self.confirmTF resignFirstResponder];
    [UIView animateWithDuration:0.25f animations:^{
        
        self.frame = CGRectMake(0, self.bounds.size.height, 320, self.bounds.size.height);
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

#pragma mark - HttpRequestDelegate
-(void)signSucessOrFail:(BOOL)isSucess
{
    self.registerButton.enabled = YES;
    if (isSucess) {
        
        [[NSUserDefaults standardUserDefaults]setObject:self.emailTF.text forKey:@"username"];
        [[NSUserDefaults standardUserDefaults]setObject:self.passWordTF.text forKey:@"password"];
        [self popView];
        
        NSLog(@"sucess");

    }
    else
    {
        NSLog(@"fail");
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"此邮箱已注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
