//
//  JIInputView.m
//  job
//
//  Created by caiming on 13-12-18.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "JIInputView.h"
#import "headSetting.h"

@interface JIInputView ()
@property(nonatomic ,strong)UITextView *mytextview;

@end

@implementation JIInputView

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
    self.title = @"自我介绍";
    [self inintViews];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
	// Do any additional setup after loading the view.
}
-(void)clickRightButton
{
    if (self.mytextview.text.length>0) {
        
        if ([self.degate respondsToSelector:@selector(retuanSelfCaption:)]) {
            [self.degate retuanSelfCaption:self.mytextview.text];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

-(void)inintViews
{
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageview];
    
    self.mytextview = [[UITextView alloc]init];
    if (VERSION >= 7.0f) {
        self.mytextview.frame = CGRectMake(5, 69, 310, 150);
    }
    else
    {
        self.mytextview.frame = CGRectMake(5, 5, 310, 150);
    }
    self.mytextview.textColor = [UIColor blackColor];
    self.mytextview.font = [UIFont systemFontOfSize:14.0f];
    self.mytextview.text = self.textViewString;
    [self.mytextview becomeFirstResponder];
    [self.view addSubview:self.mytextview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
