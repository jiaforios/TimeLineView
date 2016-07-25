//
//  ViewController.m
//  TimeLineView
//
//  Created by foscom on 16/7/23.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "ViewController.h"
#import "TimelineView.h"
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)TimelineView *timeLineView;
@property(nonatomic,strong)UITextField *textfield;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _timeLineView = [[TimelineView alloc] initWithFrame:CGRectMake(0, 100, screen_width, 200)];
    [self.view addSubview:_timeLineView];
    
    __block ViewController *blockSelf = self;
    _timeLineView.timeblock = ^(NSString *time){
    
        if (!blockSelf.textfield.isEditing) {
            
            blockSelf.textfield.text = time;
        }
    };
    
    _textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 320, 200, 30)];
    _textfield.borderStyle = UITextBorderStyleBezel;
    _textfield.textAlignment = NSTextAlignmentCenter;
    _textfield.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changevalue:) name:UITextFieldTextDidChangeNotification object:nil];

    [self.view addSubview:_textfield];
    
}

- (void)changevalue:(NSNotification *)center
{
    
    UITextField *tf = center.object;
    
    NSString *str = @"\\d{1,2}.\\d{1,2}";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",str];
    
    if( [pre evaluateWithObject:tf.text])
    {
        if (_textfield.editing) {
            
            _timeLineView.timeValue = tf.text;
            NSLog(@"符合时间格式");
        }
        
    }else
    {
        NSLog(@"不符合时间格式");
    }

}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
