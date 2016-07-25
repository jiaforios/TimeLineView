//
//  TimelineView.m
//  TimeLineView
//
//  Created by foscom on 16/7/23.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "TimelineView.h"
#import "lineView.h"
#define ktimelineOffSet ([UIScreen mainScreen].bounds.size.width/2.f)

@interface TimelineView ()<UIScrollViewDelegate>
@property(nonatomic,strong)UILabel *label;
@end

@implementation TimelineView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        
        self.contentSize = CGSizeMake(144*20+ktimelineOffSet*2, 0);
        
        lineView *line = [[lineView alloc] initWithFrame:CGRectMake(0, 0, 144*20+ktimelineOffSet*2, 200)];
        line.backgroundColor =[UIColor blackColor];
        [self addSubview:line];
        [self makeTimeMiddleLabel];

    }
    return self;
}
- (void)makeTimeMiddleLabel
{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(ktimelineOffSet-0.5, CGRectGetHeight(self.frame)/2 - 20/* 刻度条的高度*/ - 20, 1, 20+20)];
    _label.backgroundColor = [UIColor redColor];
    
    [self addSubview:_label];
    
    
}


- (void)setTimeValue:(NSString *)timeValue
{
    NSArray *arr = [timeValue componentsSeparatedByString:@":"];
    
    NSInteger offsetX =  ([arr[0] intValue] *60 +[arr[1] intValue]) *2;
    
    [self setContentOffset:CGPointMake(offsetX, self.contentOffset.y)];
}
// 计算时间点 ： 20个点等于10分钟 1分钟 2 个点

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSInteger SumMin = self.contentOffset.x/2; // 根据时间点计算分钟
    
    NSInteger hour = SumMin/60;
    NSInteger min = SumMin%60;
    
    NSString *time = [NSString stringWithFormat:@"%02ld:%02ld",(long)hour,(long)min];
    _timeblock(time);
    
    _label.frame = CGRectMake(self.contentOffset.x+self.frame.size.width/2.f-0.5, _label.frame.origin.y, 1, 40);
    
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
//    NSInteger SumMin = self.contentOffset.x/2; // 根据时间点计算分钟
//    
//    NSInteger hour = SumMin/60;
//    NSInteger min = SumMin%60;
//    
//    NSLog(@"%02d:%02d",hour,min);
}

/*
 
 // if use scrollview  method drawRect may also be work,but must use the method of setNeedDisplay in scrollViewDidScroll.and this method have a problem is that may cause a big occppy of CPU, so we can make a view before,in this view we can draw what we want ,and then we just use this view maybe ok .the reason is that we just need draw once ,but the method before we need to draw many times. so use the second method we just occupy a little CPU
 
 
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext(); // 获取到当前上下文
   
//    CGContextFillRect(context, rect);
    CGContextSetLineWidth(context, 1.0);// 设置线宽
    // 设置线的起始位置
    CGFloat start_x = self.contentOffset.x;
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
    
    NSInteger xplace = self.contentOffset.x;
    
        for (int i=0; i<1000; i++) {
            
            if (i%10==0) {
                
                CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
                CGContextMoveToPoint(context, i, start_y);
                CGContextAddLineToPoint(context, i, start_y-20);
                CGContextStrokePath(context);
                
            }
            
        }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setNeedsDisplay];
}
 
 */

@end
