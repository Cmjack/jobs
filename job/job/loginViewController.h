//
//  loginViewController.h
//  job
//
//  Created by impressly on 13-12-5.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol loginViewControllerDelegate <NSObject>

-(void)loginSuccess:(NSDictionary*)userInfo;


@end
@interface loginViewController : UIView
@property(nonatomic,weak)id<loginViewControllerDelegate> delegate;
@end
