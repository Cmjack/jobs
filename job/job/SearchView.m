//
//  SearchView.m
//  job
//
//  Created by caiming on 13-12-11.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import "SearchView.h"
#import "HttpRequest.h"
@interface SearchView ()<UITextFieldDelegate,HttpRequestDelegate>
@property(nonatomic,strong)NSArray *positionTypeArr;
@property(nonatomic,strong)UILabel *searchLab;
@property(nonatomic,strong)UITextField *searchTextField;
@property(nonatomic,strong)UIButton *searchButton;
@property(nonatomic,strong)NSString *searchString;

@end
@implementation SearchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    [self initViews];
    return self;
}
-(void)initViews
{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.90f];
    self.positionTypeArr = @[@"iOS",@"Android",@"JAVA",@"PHP",@"web前端",@"c++"];
    for (int i = 0; i< [self.positionTypeArr count]; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1000+i;
        if (i<3) {
            button.frame = CGRectMake(30+90*i, 100, 80, 40);
        }else
        {
            button.frame = CGRectMake(30+90*(i-3), 170, 80, 40);
        }
        button.backgroundColor = [UIColor clearColor];
        button.layer.borderWidth = 0.5f;
        button.layer.borderColor = [[UIColor grayColor]CGColor];
        button.layer.cornerRadius = 15.0f;
        [button setTitle:[self.positionTypeArr objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchDown];
        
        [button addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchUpOutside];
        [self addSubview:button];
    }
    
    self.searchLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 230, 260, 40)];
    self.searchLab.layer.borderColor = [[UIColor grayColor]CGColor];
    self.searchLab.layer.borderWidth = 0.5;
    self.searchLab.layer.cornerRadius = 15.0f;
    self.searchLab.backgroundColor = [UIColor clearColor];
    self.searchLab.userInteractionEnabled = YES;
    [self addSubview:self.searchLab];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 3, 30, 30)];
    imageview.image = [UIImage imageNamed:@"SearchIcon"];
    [self.searchLab addSubview:imageview];
    
    self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 5, 160, 30)];
    self.searchTextField.textColor = [UIColor whiteColor];
    self.searchTextField.backgroundColor = [UIColor clearColor];
    self.searchTextField.delegate = self;
    [self.searchLab addSubview:self.searchTextField];
    [self.searchTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.tag = 1314;
    searchButton.backgroundColor = [UIColor clearColor];
    searchButton.frame = CGRectMake(220, 5, 30, 30);
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [searchButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    searchButton.enabled = NO;
    self.searchButton = searchButton;
    [self.searchLab addSubview:searchButton];
    
}
-(void)textFieldChange:(UITextField*)sender
{
    if (sender.text.length>0) {
        self.searchButton.enabled = YES;
    }
    else
    {
        self.searchButton.enabled = NO;

    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.searchLab.layer.borderColor = [[UIColor whiteColor]CGColor];

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.searchLab.layer.borderColor = [[UIColor grayColor]CGColor];

}
-(void)touchCancel:(id)sender
{
    UIButton *button = (UIButton*)sender;
    button.layer.borderColor = [[UIColor grayColor]CGColor];

}

-(void)touchButton:(id)sender
{
    UIButton *button = (UIButton*)sender;
    button.layer.borderColor = [[UIColor whiteColor]CGColor];

}
-(void)clickButton:(id)sender
{
    UIButton *button = (UIButton*)sender;
    
    HttpRequest *http =  [[HttpRequest alloc]init];
    http.delegate = self;
    
    if (button.tag == 1314) {
        
        self.searchString = self.searchTextField.text;
    }
    else
    {
        self.searchString = [self.positionTypeArr objectAtIndex:button.tag - 1000];

    }
    [http httpRequestForGetSearch:self.searchString withPage:@"1"];

    //[self popView];
}
-(void)popView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, -self.bounds.size.height, 320, self.bounds.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)getDataSucess:(NSDictionary *)dataDict
{
    if ([self.delegate respondsToSelector:@selector(searchDataGetSuccess:withSearchString:)]) {
        [self popView];
        [self.delegate searchDataGetSuccess:dataDict withSearchString:self.searchString];
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
