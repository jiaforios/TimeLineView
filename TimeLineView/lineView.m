//
//  lineView.m
//  TimeLineView
//
//  Created by foscom on 16/7/23.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "lineView.h"

/**
 *  间隔时间设置为 10 分钟 一天时间24*6*10 即 分 144 段
 */

#define ktimeCount 144 // 显示时间段数
#define ktimeGap 20   // 时间间隔距离
#define ktimelineOffSet [UIScreen mainScreen].bounds.size.width/2 // 时间轴起始位置偏移
#define kFontSize 8  // 时间字体大小
#define ktimelocation ktimelineOffSet-12   // 文字的位置
@implementation lineView

// 中间时间标
- (void)makeTimeMiddleLabel
{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(ktimelineOffSet, CGRectGetHeight(self.frame)/2 - 20/* 刻度条的高度*/ - 20, 1, 20+20)];
    
    lable.backgroundColor = [UIColor redColor];
    
    [self addSubview:lable];
    
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext(); // 获取到当前上下文
    //    CGContextFillRect(context, rect);
    CGContextSetLineWidth(context, 1.0);// 设置线宽
    // 设置线的起始位置
    CGFloat start_x = 0;
    CGFloat start_y = rect.size.height/2.f;
    
    // 设置线的结束位置
    
    CGFloat end_x = start_x + rect.size.width;
    CGFloat end_y = rect.size.height/2.f;
    
    // 设置线的颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    // 移到起始点
    CGContextMoveToPoint(context, start_x, start_y);
    // 开始画线
    CGContextAddLineToPoint(context, end_x, end_y);
    
    CGContextStrokePath(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextMoveToPoint(context, ktimelineOffSet, start_y);
    CGContextAddLineToPoint(context,ktimelineOffSet, start_y-20);
    CGContextStrokePath(context);

    [@"00:00" drawAtPoint:CGPointMake(ktimelocation, start_y+10) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:kFontSize]}];
    // 绘制刻度
    for (int i=1; i<=ktimeCount; i++) {
        
            CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
            CGContextMoveToPoint(context, (i*ktimeGap) +ktimelineOffSet, start_y);
        
        if ((i%3 == 0) && (i%6 != 0)) {
            CGContextAddLineToPoint(context, (i*ktimeGap) +ktimelineOffSet, start_y-15);
 
        }else if (i % 6 == 0)
        {
            CGContextAddLineToPoint(context, (i*ktimeGap) +ktimelineOffSet, start_y-20);

        }else
        {
            CGContextAddLineToPoint(context,  (i*ktimeGap) + ktimelineOffSet, start_y-10);
        }
            CGContextStrokePath(context);
        
    }
    
    // 绘制文字
    
    for (int i=1; i<=ktimeCount; i++) {
        
        if ((i%3 == 0)&&(i%6 != 0)) {
            NSString *timeText = [self makeHalfHourTimeFromIndex:i];
            
            [timeText drawAtPoint:CGPointMake((i*ktimeGap) +ktimelocation, start_y+10) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:kFontSize]}];
            
            
        }else if (i%6 == 0)
        {
            NSString *timeText = [self makeHourTimeFromIndex:i];
            [timeText drawAtPoint:CGPointMake((i*ktimeGap) +ktimelocation, start_y+10) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:kFontSize]}];
        }
    }
    

}


- (NSString *)makeHalfHourTimeFromIndex:(NSInteger)index{
    NSString *time = nil;
    NSInteger hour =  index/6;
    
    time = [NSString stringWithFormat:@"%02d:30",(int)hour];
    return time;
}
- (NSString *)makeHourTimeFromIndex:(NSInteger)index
{
    NSString *time = nil;
    NSInteger hour =  index/6;
    time = [NSString stringWithFormat:@"%02d:00",(int)hour];
    return time;

}

@end






