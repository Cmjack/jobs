//
//  EditDiplomaTableViewController.h
//  job
//
//  Created by impressly on 13-12-4.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EditDiplomaTableViewControllerDelegate <NSObject>

-(void)EditDiplomaTableViewController:(NSString*)string;

@end
@interface EditDiplomaTableViewController : UITableViewController
@property(nonatomic,weak)id<EditDiplomaTableViewControllerDelegate> delegate;

@end
