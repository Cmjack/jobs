//
//  JionMessageViewController.m
//  job
//
//  Created by caiming on 13-12-16.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "JionMessageViewController.h"
#import "JoinViewController.h"
#import "CustomCell.h"
#import "HttpRequest.h"
#import "headSetting.h"
#import "Tools.h"
#import <QuartzCore/QuartzCore.h>
#import "GetResumeViewController.h"
@interface JionMessageViewController ()<HttpRequestDelegate>
@property(nonatomic,strong)CustomCell  *customCell;
@property(nonatomic,strong)NSArray *joinMessageArray;
@property(nonatomic,strong)UIButton *LookButton;
@end

@implementation JionMessageViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *username= [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username", nil];
    HttpRequest *http = [[HttpRequest alloc]init];
    http.delegate = self;
    
    [http httpRequestForPostJoinList:dict];
    self.title = @"招聘信息";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)initLookButton
{
    UIColor* jade = [UIColor colorWithRed:19/255.0 green:77/255.0 blue:53/255.0 alpha:0.7f] ;
    UIColor* jadeLight = [UIColor colorWithRed:30/255.0 green:186/255.0 blue:121/255.0 alpha:0.7f];
    self.LookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.LookButton.frame = CGRectMake(240, 5, 60, 24);
    [self.LookButton setTitle:@"已收简历" forState:UIControlStateNormal];
    self.LookButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.LookButton setTitleColor:jade forState:UIControlStateNormal];
    [self.LookButton setTitleColor:jadeLight forState:UIControlStateHighlighted];
    self.LookButton.layer.borderWidth = 0.5f;
    self.LookButton.layer.cornerRadius = 4.0f;
    [self.LookButton addTarget:self action:@selector(clickLooKButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickLooKButton:(id)sender
{
    UIButton *button = (UIButton*)sender;
    NSString *jobId = [[self.joinMessageArray objectAtIndex:button.tag - 1000]objectForKey:@"_id"];
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:jobId,@"job_id", nil];
    
    GetResumeViewController *getResume = [[GetResumeViewController alloc]initWithNibName:nil bundle:nil];
    getResume.jobId = dict;
    [self.navigationController pushViewController:getResume animated:YES];
    
    
}


-(void)getJoinMessage:(NSArray *)array
{
    self.joinMessageArray = array;
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.joinMessageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    self.customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (_customCell == NULL) {
        _customCell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [_customCell initViews];
        _customCell.fromLabel.textColor = [UIColor blackColor];
        _customCell.captionLab.textColor = [UIColor blackColor];
        _customCell.PCALable.textColor = [UIColor blackColor];
        _customCell.creatDateLab.hidden = YES;
        [self initLookButton];
        [_customCell addSubview:self.LookButton];
        
    }
    [_customCell insertData:[self.joinMessageArray objectAtIndex:indexPath.row]];
    self.LookButton.tag = 1000+indexPath.row;
    // Configure the cell...
    
    return _customCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 0;
    UIFont *PCAFont = [UIFont boldSystemFontOfSize:13.0f];
    NSDictionary *dict = [self.joinMessageArray objectAtIndex:indexPath.row];
    NSMutableString *PCAString = [NSMutableString stringWithFormat:@"%@ • %@ • %@",[dict objectForKey:JOB_TITLE],[dict objectForKey:JOB_COMPANY],[dict objectForKey:JOB_LOCATION]];
    CGSize size = CGSizeMake(260, 5000);
    NSString *sto= [PCAString stringByReplacingOccurrencesOfString: @"\n" withString:@""];
    
    height += [Tools autoSizeLab:size withFont:PCAFont withSting:sto];
    height += 65;
    
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JoinViewController *editJoin = [[JoinViewController alloc]initWithNibName:nil bundle:nil];
    editJoin.dictMessage = [self.joinMessageArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:editJoin animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
