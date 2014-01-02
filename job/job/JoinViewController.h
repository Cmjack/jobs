//
//  JoinViewController.h
//  job
//
//  Created by impressly on 13-12-10.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JoinViewControllerDelegate <NSObject>

-(void)JoinViewControllerSuccessRefreshData;

@end
@interface JoinViewController : UIViewController
@property(nonatomic, strong)NSDictionary *dictMessage;
@property(nonatomic, weak)id<JoinViewControllerDelegate> delegate;
@end


