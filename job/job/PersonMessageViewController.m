//
//  PersonMessageViewController.m
//  job
//
//  Created by impressly on 13-12-4.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "PersonMessageViewController.h"
#import "PersonMessageCustomCell.h"
#import "EditDiplomaTableViewController.h"
#import "InputViewController.h"
#import "headSetting.h"
#import "HttpRequest.h"
#import "DataModel.h"
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

@interface PersonMessageViewController ()<UITableViewDelegate,
                                          UITableViewDataSource,
                                          UIActionSheetDelegate,
                                          EditDiplomaTableViewControllerDelegate,
                                          UIPickerViewDataSource,
                                          UIPickerViewDelegate,InputViewControllerDelegate>
@property(nonatomic,strong)UITableView *PersonTableView;
@property(nonatomic,strong)NSArray *personArr;
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic,strong)UITextField *textField;
//@property(nonatomic,strong)NSMutableArray *mutableArr;
@property(nonatomic,strong)NSMutableArray *pickerData;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)PersonMessageCustomCell *customCell;
@property(nonatomic,strong)UIView *pickerBackGroundView;
@property(nonatomic,strong)NSMutableDictionary *personDict;
@property(nonatomic,strong)NSArray *personDict_key;
@property(nonatomic,strong)DataModel *dataModel;
@end

@implementation PersonMessageViewController

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
    self.title = @"个人信息";
    [self initViews];
    [self initDatas];
    self.dataModel = [DataModel shareData];
    self.personDict = [NSMutableDictionary dictionaryWithDictionary:[self.dataModel.resumeDict objectForKey:KEY_PERSON]];
    NSLog(@"1:personDict %@",self.personDict);
    if ([self.personDict objectForKey:KEY_NAME ]== NULL) {
        
        self.personDict = [NSMutableDictionary dictionaryWithDictionary:[self getDefaultPersonData]];
        
        NSLog(@"2:personDict %@",self.personDict);
    }
    
        // Do any additional setup after loading the view.
}
-(void)initDatas{

    self.personArr = @[@"姓       名",
                       @"应聘职位",
                       @"最高学历",
                       @"年       龄",
                       @"手机号码",
                       @"Email",
                       @"工作年限",
                       ];
    
    self.personDict_key =@[KEY_NAME,
                           KEY_POSITION,
                           KEY_DIPLOMA,
                           KEY_AGE,
                           KEY_TEL,
                           KEY_EMAIL,
                           KEY_WORK];
    
    self.pickerData = [NSMutableArray arrayWithObjects:[self getDiplomaData],[self getAgeData],[self getWorkTimeData], nil];
}

-(void)initViews{
    
   
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    self.PersonTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.PersonTableView.delegate = self;
    self.PersonTableView.dataSource = self;
    [self.view addSubview:self.PersonTableView];
    
    
    self.pickerBackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, 320, 250)];
    self.pickerBackGroundView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    [self.view addSubview:self.pickerBackGroundView];
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setTitle:@"选定" forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(230, 0, 44, 44);
    [doneButton addTarget:self action:@selector(clickDoneButton) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerBackGroundView addSubview:doneButton];
    
    
    UIImageView *pickerBackGroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, 320, 216)];
    pickerBackGroundImage.image = [UIImage imageNamed:@"datepicker_bg"];
    pickerBackGroundImage.userInteractionEnabled = YES;
    [self.pickerBackGroundView addSubview:pickerBackGroundImage];
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 216)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    
    [pickerBackGroundImage addSubview:_pickerView];
}

-(void)showPickerView
{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.pickerBackGroundView.frame = CGRectMake(0, SCREEN_HEIGHT - 250, 320, 250);
    } completion:^(BOOL finished) {
        
        [self.pickerView selectRow:[[self.pickerData objectAtIndex:0] indexOfObject:[self.personDict objectForKey:KEY_DIPLOMA]] inComponent:0 animated:YES];
        
        [self.pickerView selectRow:[[self.pickerData objectAtIndex:1] indexOfObject:[self.personDict objectForKey:KEY_AGE]] inComponent:1 animated:YES];
        
        [self.pickerView selectRow:[[self.pickerData objectAtIndex:2] indexOfObject:[self.personDict objectForKey:KEY_WORK]] inComponent:2 animated:YES];
    }];
}

-(void)hidePickerView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.pickerBackGroundView.frame = CGRectMake(0, SCREEN_HEIGHT, 320, 250);
    } completion:^(BOOL finished) {
        
    }];

}
-(void)clickDoneButton
{
    [self hidePickerView];
}
-(BOOL)checkPersonMessage
{
    BOOL isFull=YES;
    NSEnumerator *enumerator = [self.personDict keyEnumerator];
    for (NSObject  *key in enumerator) {
        
        if ([[self.personDict objectForKey:key] length]<1) {
            
            isFull = NO;
            return NO;
        }
    }
    
    return isFull;
}

-(void)clickSaveButton
{
    
    if ([self checkPersonMessage]) {
        
        NSString *userName = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
        NSDictionary *dictresume = [NSDictionary dictionaryWithObjectsAndKeys:self.personDict,KEY_PERSON,userName,@"username", nil];
        
        [HttpRequest httpRequestForSaveResume:dictresume];
        
        [[DataModel shareData].resumeDict setObject:self.personDict forKey:KEY_PERSON];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:@"您的信息不完整!" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alertview show];
    }
    
   
}
#pragma mark- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.personArr count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * indexCell = @"cellLab";
    self.customCell = [tableView dequeueReusableCellWithIdentifier:indexCell];
    if (self.customCell == nil) {
        self.customCell = [[PersonMessageCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexCell];
        [self.customCell initViewsForLable];
        [self.customCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    self.customCell.label.text = [self.personDict objectForKey:[self.personDict_key objectAtIndex:indexPath.row]];
    self.customCell.textLabel.text = [self.personArr objectAtIndex:indexPath.row];
    
    return self.customCell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0 ||indexPath.row ==1 || indexPath.row ==4 ||indexPath.row ==5) {
        
        InputViewController *input = [[InputViewController alloc]initWithNibName:nil bundle:nil];
        
        input.mutableDict = self.personDict;
        input.delegate = self;
        [self.navigationController pushViewController:input animated:YES];
    }
    else{
        [self showPickerView];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//#pragma mark- EditDiplomaTableViewControllerDelegate
//-(void)EditDiplomaTableViewController:(NSString *)string
//{
//    [self.navigationController popViewControllerAnimated:YES];
//
//    [self.mutableArr replaceObjectAtIndex:2 withObject:string];
//    NSLog(@"%@",string);
//    
//    [self.PersonTableView reloadData];
//    NSLog(@"%@",_mutableArr);
//}

#pragma mark - UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return self.pickerData.count;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self.pickerData objectAtIndex:component]count];
}

#pragma mark -UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    return [[self.pickerData objectAtIndex:component]objectAtIndex:row];

}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%i__%i",component,row);
    if (component == 0) {
        
        [self.personDict setObject:[[self getDiplomaData]objectAtIndex:row] forKey:KEY_DIPLOMA];
        
    }else if (component == 1)
    {
         [self.personDict setObject:[[self getAgeData]objectAtIndex:row] forKey:KEY_AGE];
    }
    else if (component == 2){
        
         [self.personDict setObject:[[self getWorkTimeData]objectAtIndex:row] forKey:KEY_WORK];
    }
    [self.PersonTableView reloadData];
}


#pragma mark - initData

-(NSArray*)getDiplomaData{
    NSArray *arr = @[@"初中",
                 @"高中",
                 @"大专",
                 @"本科",
                 @"硕士",
                 @"博士",
                 @"其它",
                 ];
    return arr;

}
-(NSArray*)getAgeData
{
    NSMutableArray * muArr = [NSMutableArray arrayWithCapacity:10];
    for (int i = 18; i<51; i++)
    {
        [muArr addObject:[NSString stringWithFormat:@"%i岁",i]];
    }
    return muArr;
}
-(NSArray*)getWorkTimeData
{
    NSArray *arr = @[@"在校生",
                     @"应届生",
                     @"一年以上",
                     @"二年以上",
                     @"三年以上",
                     @"五年以上",
                     @"八年以上",
                     @"十年以上"
                    ];
    return arr;
}
-(NSDictionary*)getDefaultPersonData
{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                       @"李某某",KEY_NAME,
                       @"ios开发工程师",KEY_POSITION,
                       @"本科",KEY_DIPLOMA,
                       @"22岁", KEY_AGE,
                       @"1388888888",KEY_TEL,
                       @"xxxx@163.com",KEY_EMAIL,
                       @"三年以上",KEY_WORK,
                       nil];
    return dict;
}
#pragma mark - InputViewControllerDelegate
-(void)returnPersonmessgae:(NSMutableDictionary *)mutableDict
{
    self.personDict = mutableDict;
    [self.PersonTableView reloadData];
}
//-(float)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
//    return 44.0f;
//}
//-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
//{
//    
//    float width = 0.0f;
//    if (component == 0 ||component == 2) {
//        width = 35.0f;
//    }else if (component == 4 || component == 3)
//    {
//        width = 80.0f;
//    }else if (component == 1){
//        width= 60.0f;
//    }
//    
//    return width;
//}
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
