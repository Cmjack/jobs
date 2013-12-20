//
//  JIInputView.h
//  job
//
//  Created by caiming on 13-12-18.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JIInputViewDelegate <NSObject>

-(void)retuanSelfCaption:(NSString*)str;

@end
@interface JIInputView : UIViewController
@property(nonatomic,weak)id<JIInputViewDelegate> degate;
@property(nonatomic,strong)NSString *textViewString;
@end
