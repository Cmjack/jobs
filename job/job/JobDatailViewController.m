//
//  JobDatailViewController.m
//  job
//
//  Created by caiming on 13-12-17.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "JobDatailViewController.h"
#import "JobDetailsCell.h"
#import "headSetting.h"
#import "Tools.h"
#import "JobWebViewController.h"
#import "DataModel.h"
#import "HttpRequest.h"
@interface JobDatailViewController ()<UITableViewDataSource,UITableViewDelegate,JobDetailsCellDelegate>
@property(nonatomic,strong)UITableView * JDTableview;

@end

@implementation JobDatailViewController

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
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.JDTableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.JDTableview.delegate = self;
    self.JDTableview.dataSource = self;
    self.JDTableview.backgroundColor = [UIColor clearColor];
    self.JDTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.JDTableview];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        JobDetailsCell *jdcell = [[JobDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        jdcell.delegate = self;
        [jdcell initViews];
        [jdcell insertData:self.jobMessageDict];
        jdcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return jdcell;
    }else if (indexPath.section == 1)
    {
        JobDetailsCell *jdcell = [[JobDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        [jdcell initCaptionLab];
        jdcell.selectionStyle = UITableViewCellSelectionStyleNone;
        [jdcell insertCaptionData:[self.jobMessageDict objectForKey:JOB_DESC]];
        return jdcell;
    }
//    if (indexPath.section == 0) {
//        static NSString *indexPathCell =@"cell";
//        JobDetailsCell *jdcell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:indexPathCell];
//        if (jdcell == nil) {
//            jdcell = [[JobDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexPathCell];
//            [jdcell initViews];
//            jdcell.backgroundColor = [UIColor clearColor];
//            jdcell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        [jdcell insertData:Nil];
//        
//        return jdcell;
//        
//    }
    
    return NULL;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==1) {
        UIFont * font = [UIFont systemFontOfSize:15.0f];
        CGSize size = CGSizeMake(300, 10000);
        float height= [Tools autoSizeLab:size withFont:font withSting:[self.jobMessageDict objectForKey:JOB_DESC]];
        return height+30;
        
    }
    
    return 100;
}
-(void)sendApply
{
    if ([[self.jobMessageDict objectForKey:JOB_URL]length]>0) {
        JobWebViewController *web = [[JobWebViewController alloc]initWithNibName:nil bundle:nil];
        web.urlStr = [self.jobMessageDict objectForKey:JOB_URL];
        [self.navigationController pushViewController:web animated:YES];
    }
    else
    {
       NSString *jobId = [self.jobMessageDict objectForKey:JOB_ID];
       NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"];
       NSString *resumeId = [[DataModel shareData].resumeDict objectForKey:@"_id"];
       NSString  *token = [[NSUserDefaults standardUserDefaults]objectForKey:MYAPPTOKEN];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:jobId,@"job_id",userId,@"user_id",resumeId,@"resume_id",token,@"token", nil];
        NSLog(@"%@",dict);
        if (jobId.length>0 && userId.length>0 && resumeId.length >0 && token.length>0) {
           
            [[[HttpRequest alloc]init]httpPostApplyJob:dict];
        }else
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"对不起，暂时无法帮你投递！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alertView show];
        }
        
        
      
       
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
