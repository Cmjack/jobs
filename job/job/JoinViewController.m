//
//  JoinViewController.m
//  job
//
//  Created by impressly on 13-12-10.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "JoinViewController.h"
#import "JoinCustomCell.h"
#import "headSetting.h"
#import "HttpRequest.h"
@interface JoinViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>
@property(nonatomic, strong)JoinCustomCell *customCell;
@property(nonatomic, strong)UITableView *joinTableView;
@property(nonatomic, strong)NSArray *joinDataArray;
@property(nonatomic, strong)NSArray *placeholderArray;
@end

@implementation JoinViewController

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
    self.joinTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.joinTableView.delegate = self;
    self.joinTableView.dataSource = self;
    //self.joinTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.joinTableView];
    self.joinDataArray = @[@"log_cabine-25",@"street_view-25",@"map_marker-25"];
    self.placeholderArray = @[@"请输入公司名称",@"请输入招聘职位",@"请输入公司地址"];
    
    UIBarButtonItem *sendBarButton = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(clickSendButton:)];
    self.navigationItem.rightBarButtonItem = sendBarButton;
    
    // Do any additional setup after loading the view.
}
-(void)clickSendButton:(id)sender
{
    UITextField *textfield1 = (UITextField*)[self.joinTableView viewWithTag:1000];
    UITextField *textfield2 = (UITextField*)[self.joinTableView viewWithTag:1001];
    UITextField *textfield3 = (UITextField*)[self.joinTableView viewWithTag:1002];
    UITextView  *textView   = (UITextView*) [self.joinTableView viewWithTag:1004];
    
    NSString *username = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          textfield1.text,KEY_COMPANY,
                          textfield2.text,KEY_POSITION,
                          textfield3.text,KEY_LOCATION,
                          textView.text,KEY_CAPTION,
                          username,@"username",
                          nil];
    [[[HttpRequest alloc]init]httpRequestForPostJoinMessgae:dict];
    
    
}
#pragma mark- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==1) {
        return 1;
    }
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *indexPathCell =@"cell";
        _customCell = [tableView dequeueReusableCellWithIdentifier:indexPathCell];
        if (_customCell == nil) {
            _customCell = [[JoinCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexPathCell];
            [_customCell initViews];
            _customCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        _customCell.textfield.tag = 1000+indexPath.row;
        _customCell.textfield.delegate = self;
        _customCell.textLabel.font = [UIFont systemFontOfSize:13.0f];
        //_customCell.textLabel.text = [self.joinDataArray objectAtIndex:indexPath.row];
        _customCell.imageView.image = [UIImage imageNamed:[self.joinDataArray objectAtIndex:indexPath.row]];
        _customCell.textfield.placeholder = [self.placeholderArray objectAtIndex:indexPath.row];

    }else
    {
        static NSString *indexPathCell =@"celltoo";
        _customCell = [tableView dequeueReusableCellWithIdentifier:indexPathCell];
        if (_customCell == nil) {
            _customCell = [[JoinCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexPathCell];
            [_customCell initLab];
            _customCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        _customCell.textView.tag = 1004;
        _customCell.textView.delegate = self;

    }
    
    return _customCell;
    
}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 44;
    }
    return 120;
}

#pragma mark- UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"start");
    self.joinTableView.contentOffset = CGPointMake(0, 44);

}
#pragma mark- UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.joinTableView.contentOffset = CGPointMake(0, -64);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
