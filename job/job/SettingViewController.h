//
//  SettingViewController.h
//  job
//
//  Created by caiming on 13-12-11.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SettingViewControllerDelegate <NSObject>

-(void)cancelUser;

@end
@interface SettingViewController : UIViewController
@property(nonatomic  ,weak)id<SettingViewControllerDelegate> delegate;
@end



