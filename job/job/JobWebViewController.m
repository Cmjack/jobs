//
//  JobWebViewController.m
//  job
//
//  Created by caiming on 13-12-17.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "JobWebViewController.h"

@interface JobWebViewController ()<UIWebViewDelegate>
@property(nonatomic ,strong)UIWebView *webView;
@end

@implementation JobWebViewController

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
	// Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.delegate =self;
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *requset = [[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:requset];
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
