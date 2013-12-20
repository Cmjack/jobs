//
//  EditJITBC.h
//  job
//
//  Created by caiming on 13-12-18.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EditJITBCDelegate <NSObject>

-(void)retuanChoose:(NSString*)str;

@end
@interface EditJITBC : UITableViewController

@property(nonatomic,weak)id<EditJITBCDelegate> delegate;

@property(nonatomic,strong)NSArray * myArray;
@end

