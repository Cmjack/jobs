//
//  AboutViewController.m
//  job
//
//  Created by caiming on 13-12-18.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "AboutViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface AboutViewController ()

@end

@implementation AboutViewController

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
    NSDictionary *dict = [[NSBundle mainBundle]infoDictionary];
    UIImageView *appIconImageview = [[UIImageView alloc]initWithFrame:CGRectMake(130, 100, 60, 60)];
    appIconImageview.image = [UIImage imageNamed:@"AppIcon60x60"];
    appIconImageview.layer.cornerRadius = 5.0f;
    appIconImageview.layer.masksToBounds = YES;
    [self.view addSubview:appIconImageview];
    UILabel *appVersion = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, 320, 30)];
    appVersion.backgroundColor = [UIColor whiteColor];
    appVersion.text = [NSString stringWithFormat:@"版本:%@",[dict objectForKey:@"CFBundleShortVersionString"]];
    appVersion.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:appVersion];
    
    UILabel *appbuild=[[UILabel alloc]initWithFrame:CGRectMake(0, 220, 320, 30)];
    appbuild.text = [NSString stringWithFormat:@"(%@)",[dict objectForKey:@"CFBundleVersion"]];
    appbuild.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:appbuild];
    
    
    NSLog(@"%@",dict);
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
