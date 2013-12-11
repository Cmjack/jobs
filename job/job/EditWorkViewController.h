//
//  EditWorkViewController.h
//  job
//
//  Created by impressly on 13-12-9.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditWorkViewController;
@protocol EditWorkViewControllerDelegate <NSObject>

-(void)EditWorkViewControllerAddOrAmend:(BOOL)isAdd withData:(NSDictionary*)dict;

@end
@interface EditWorkViewController : UIViewController
@property(nonatomic ,strong)NSArray *lablesTextArray;
@property(nonatomic ,strong)NSDictionary *textsDict;
@property(nonatomic ,weak)id<EditWorkViewControllerDelegate>  delegate;

@end
