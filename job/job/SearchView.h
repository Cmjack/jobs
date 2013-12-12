//
//  SearchView.h
//  job
//
//  Created by caiming on 13-12-11.
//  Copyright (c) 2013年 impressly. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchViewDelegate <NSObject>

-(void)searchDataGetSuccess:(NSArray*)arr withSearchString:(NSString*)searchString;

@end

@interface SearchView : UIView
@property(nonatomic ,weak)id<SearchViewDelegate>  delegate;
@end
