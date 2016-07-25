//
//  TimelineView.h
//  TimeLineView
//
//  Created by foscom on 16/7/23.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^timeBlock)(NSString *time);
@interface TimelineView : UIScrollView

@property(nonatomic,copy)timeBlock timeblock;
@property(nonatomic,copy)NSString *timeValue; // 根据输入的时间滑动时间轴到指定位置

@end
