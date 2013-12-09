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
@interface WorkTableViewController ()
@property(nonatomic ,strong)WorkCustomCell *customCell;
@property(nonatomic ,strong)DataModel *dataModel;
@property(nonatomic ,strong)NSMutableArray *workArray;
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
    self.workArray = [NSMutableArray arrayWithArray:[self.dataModel.resumeDict objectForKey:KEY_WE]];
    
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
        return [self.workArray count];
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
        self.customCell.addLab.text = @"添加工作经验";
        return self.customCell;
        
    }else{
    
        static NSString *reuseIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
            
        }
        cell.textLabel.text = @"xx公司";
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
    EditWorkViewController *editview = [[EditWorkViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:editview animated:YES];
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
