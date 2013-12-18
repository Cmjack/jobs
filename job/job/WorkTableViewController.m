//
//  WorkTableViewController.m
//  job
//
//  Created by impressly on 13-12-4.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "WorkTableViewController.h"
#import "WorkCustomCell.h"
#import "headSetting.h"
#import "DataModel.h"
#import "EditWorkViewController.h"
#import "HttpRequest.h"
@interface WorkTableViewController ()<EditWorkViewControllerDelegate>
@property(nonatomic ,strong)WorkCustomCell *customCell;
@property(nonatomic ,strong)DataModel *dataModel;
@property(nonatomic ,assign)NSInteger selectRow;

@end

@implementation WorkTableViewController

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
    self.dataModel =[DataModel shareData];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section ==0) {
        return 1;
    }
    else
    {
        return [self.mutableArray count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cell = @"addCell";
         self.customCell = [tableView dequeueReusableCellWithIdentifier:cell];
        if (self.customCell == nil) {
            self.customCell = [[WorkCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
            [self.customCell initViewForAddLab];
            
        }
        self.customCell.addLab.text = self.type;
        return self.customCell;
        
    }else{
    
        static NSString *reuseIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        cell.textLabel.text = [[self.mutableArray objectAtIndex:indexPath.row] objectForKey:KEY_COMPANY];
        cell.detailTextLabel.text = @"时间";
        return cell;
    }
    
    
    // Configure the cell...
    return NULL;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}


#pragma mark - tableviewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        EditWorkViewController *editview = [[EditWorkViewController alloc]initWithNibName:nil bundle:nil];
        
        if ([self.type isEqualToString:@"添加工作经历"]) {
            
            editview.lablesTextArray = [self getWorkArray];
            
        }else
        {
            editview.lablesTextArray = [self getEducationArray];
        }
        self.selectRow = -1;
        editview.delegate =self;
        [self.navigationController pushViewController:editview animated:YES];
    }
    else
    {
        EditWorkViewController *editview = [[EditWorkViewController alloc]initWithNibName:nil bundle:nil];
        if ([self.type isEqualToString:@"添加工作经历"]) {
            editview.lablesTextArray = [self getWorkArray];
        }else
        {
            editview.lablesTextArray = [self getEducationArray];
        }
        self.selectRow = indexPath.row;
        editview.delegate =self;
        editview.textsDict = [self.mutableArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:editview animated:YES];
    }
    
      }
#pragma mark- EditWorkViewControllerDelegate
-(void)EditWorkViewControllerAddOrAmend:(BOOL)isAdd withData:(NSDictionary *)dict
{
    if (self.selectRow == -1) {
        
        if ([self.mutableArray count] == 0) {
            
            self.mutableArray = [NSMutableArray arrayWithCapacity:1];
        }
        [self.mutableArray addObject:dict];
    }else
    {
        [self.mutableArray replaceObjectAtIndex:self.selectRow withObject:dict];
    }
    
    NSString *key;
    if ([self.type isEqualToString:@"添加工作经历"]) {
        key = KEY_WE;
    }else if ([self.type isEqualToString:@"添加教育经历"]){
        key = KEY_EDUCATION;
    }else if ([self.type isEqualToString:@"添加培训经历"]){
        key = KEY_TRAINING;
    }
    
    NSString *userName = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    NSDictionary *dictresume = [NSDictionary dictionaryWithObjectsAndKeys:self.mutableArray,key,userName,@"username", nil];
    
     NSLog(@"%@: %@",key,dictresume);
    [HttpRequest httpRequestForSaveResume:dictresume];
    
    [[DataModel shareData].resumeDict setObject:self.mutableArray forKey:key];
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];
}

-(NSArray*)getWorkArray
{
    NSArray *arr = @[@"公司名称:",@"当前职位:",@"开始时间:",@"结束时间:",@"工作描述:"];
    return arr;
}

-(NSArray*)getEducationArray
{
    NSArray *arr = @[@"学校名称:",@"专业:",@"开始时间:",@"结束时间:",@"专业描述:"];
    return arr;
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
