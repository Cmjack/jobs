//
//  InputViewController.h
//  job
//
//  Created by impressly on 13-12-5.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol InputViewControllerDelegate <NSObject>

-(void)returnPersonmessgae:(NSMutableDictionary*)mutableDict;

@end
@interface InputViewController : UIViewController
@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *telTextField;
@property(nonatomic,strong)UITextField *emailTextField;
@property(nonatomic,strong)UITextField *positionTextField;
@property(nonatomic,strong)NSMutableDictionary * mutableDict;
@property(nonatomic,weak)id<InputViewControllerDelegate> delegate;
@end
