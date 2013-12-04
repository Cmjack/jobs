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

@interface PersonMessageViewController ()<UITableViewDelegate,
                                          UITableViewDataSource,
                                          UIActionSheetDelegate,
                                          EditDiplomaTableViewControllerDelegate,
                                          UIPickerViewDataSource,
                                          UIPickerViewDelegate>
@property(nonatomic,strong)UITableView *PersonTableView;
@property(nonatomic,strong)NSArray *personArr;
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)NSMutableArray *mutableArr;
@property(nonatomic,strong)NSMutableArray *pickerData;
@property(nonatomic,strong)PersonMessageCustomCell *customCell;
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
        // Do any additional setup after loading the view.
}
-(void)initDatas{

    self.personArr = @[@"姓       名",
                       @"性       别",
                       @"最高学历",
                       @"年       龄",
                       @"手机号码",
                       @"Email",
                       @"工作年限",
                       @"证       件",
                       @"证件号码"
                       ];
    self.mutableArr = [NSMutableArray arrayWithObjects:
                       @"李某某",
                       @"男",
                       @"本科",
                       @"22",
                       @"1388888888",
                       @"xxxx@163.com",
                       @"3年以上",
                       @"身份证",
                       @"360199633567894",
                       nil];
    self.pickerData = [NSMutableArray arrayWithObjects:[self getSexData],[self getDiplomaData],[self getAgeData],[self getWorkTimeData],[self getCardTypeData], nil];
}

-(void)initViews{
    self.PersonTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.PersonTableView.delegate = self;
    self.PersonTableView.dataSource = self;
    [self.view addSubview:self.PersonTableView];
    float screen_height = [[UIScreen mainScreen]bounds].size.height;
    
    UIImageView *pickerBackGroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, screen_height-216, 320, 216)];
    pickerBackGroundImage.backgroundColor = [UIColor whiteColor];
    pickerBackGroundImage.userInteractionEnabled = YES;
    [self.view addSubview:pickerBackGroundImage];
    
    UIPickerView * pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 216)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    [pickerBackGroundImage addSubview:pickerView];
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
    
//    if (indexPath.row == 0 ||indexPath.row ==3||indexPath.row ==4 ||indexPath.row ==5||indexPath.row ==8) {
//        static NSString * indexCell = @"cellTextField";
//        self.customCell = [tableView dequeueReusableCellWithIdentifier:indexCell];
//        if (self.customCell == nil) {
//            self.customCell = [[PersonMessageCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexCell];
//            [self.customCell initViewsForTextField];
//            self.customCell.selectionStyle = UITableViewCellSelectionStyleNone;
//            
//        }
//        self.customCell.textLabel.text = [self.personArr objectAtIndex:indexPath.row];
//        self.customCell.textField.text = [self.mutableArr objectAtIndex:indexPath.row];
//        self.customCell.textField.tag = 1000+indexPath.row;
//        return self.customCell;
//        
//    }else{
//        
//        
//    
//    }
    static NSString * indexCell = @"cellLab";
    self.customCell = [tableView dequeueReusableCellWithIdentifier:indexCell];
    if (self.customCell == nil) {
        self.customCell = [[PersonMessageCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexCell];
        [self.customCell initViewsForLable];
        [self.customCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    self.customCell.label.text = [self.mutableArr objectAtIndex:indexPath.row];
    self.customCell.textLabel.text = [self.personArr objectAtIndex:indexPath.row];
    return self.customCell;
    
//    return NULL;
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
        
        [actionSheet setActionSheetStyle:UIActionSheetStyleAutomatic];
        [actionSheet showInView:self.view];
    }
    else if (indexPath.row == 2)
    {
        EditDiplomaTableViewController *editDiploma = [[EditDiplomaTableViewController alloc]initWithNibName:nil bundle:nil];
        editDiploma.delegate = self;
        [self.navigationController pushViewController:editDiploma animated:YES];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.mutableArr replaceObjectAtIndex:1 withObject:@"男"];

    }else if(buttonIndex ==1){
        [self.mutableArr replaceObjectAtIndex:1 withObject:@"女"];
        
    }
    [self.PersonTableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- EditDiplomaTableViewControllerDelegate
-(void)EditDiplomaTableViewController:(NSString *)string
{
    [self.navigationController popViewControllerAnimated:YES];

    [self.mutableArr replaceObjectAtIndex:2 withObject:string];
    NSLog(@"%@",string);
    
    [self.PersonTableView reloadData];
    NSLog(@"%@",_mutableArr);
}

#pragma mark - UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    
    return 5;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self.pickerData objectAtIndex:component]count];
}
#pragma mark -UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    return [[self.pickerData objectAtIndex:component]objectAtIndex:row];

}
-(NSArray*)getSexData{

    NSArray *arr = @[@"男",@"女"];
    return arr;
}
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
        [muArr addObject:[NSString stringWithFormat:@"%i",i]];
    }
    return muArr;
}
-(NSArray*)getWorkTimeData
{
    NSArray *arr = @[@"在校生",
                     @"应届生",
                     @"一年",
                     @"二年",
                     @"三年",
                     @"五年",
                     @"八年",
                     @"十年"
                    ];
    return arr;
}
-(NSArray*)getCardTypeData
{
    NSArray *arr = @[@"身份证",
                     @"护照",
                     @"军人",
                     @"其他",
                     ];
    return arr;
}

//-(float)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
//    return 44.0f;
//}
-(float)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    float width = 0.0f;
    if (component == 0 ||component == 2) {
        width = 35.0f;
    }else if (component == 4 || component == 3)
    {
        width = 80.0f;
    }else if (component == 1){
        width= 60.0f;
    }
    
    return width;
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
